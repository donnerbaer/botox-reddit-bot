from bottle import route, run, default_app, debug
from bottle import get, static_file, template, error, redirect, request
import fetch_user_metadata
import sqlite3
import re

database_path = "database/database.db"

# #####################   HELPER   #####################

def parameter_split(parameter:str) -> dict:
    parameter = parameter.replace("?","")
    dictionary = {'annotator': '', 'anno_type': 'new'}
    
    if parameter is not None:
        pairs = parameter.split('&')
        for pair in pairs:
            try:
                key, value = pair.split('=')
                dictionary[key] = value
            except:
                pass
    return dictionary


def is_in_database(unnamed:int, user_id:str) -> bool:
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    result = cursor.execute("""SELECT unnamed FROM reddit_bots WHERE unnamed = ? and user_id = ?""", (unnamed, user_id)).fetchone()
    cursor.close()
    connection.close()
    if result is None:
        return False
    return True




# #####################   ROUTING   #####################

@route('/')
def index():
    return template('index')


@route('/random')
def random():
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    unnamed, user_id = cursor.execute("""SELECT unnamed, user_id FROM reddit_bots WHERE annotator IS NULL ORDER BY RANDOM() LIMIT 1""").fetchone()
    cursor.close()
    connection.close()
    redirect('/annotation/{}/{}'.format(unnamed, user_id))


@route('/next')
def next():
    parameter = parameter_split(request.query_string)
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    unnamed, user_id = cursor.execute("""SELECT unnamed, user_id FROM reddit_bots WHERE annotator IS NULL LIMIT 1""").fetchone()
    cursor.close()
    connection.close()
    if parameter.get('annotator') is not None:
        redirect(f'/annotation/{unnamed}/{user_id}?annotator={parameter.get('annotator')}')
    redirect(f'/annotation/{unnamed}/{user_id}')



@route('/save', method="post")
def save():
    insert_data = [
        request.forms.get('id'),
        request.forms.get('unnamed'),
        request.forms.get('annotator'),
        request.forms.get('user_id'),
        request.forms.get('was_fetched'),
        request.forms.get('is_duplicate'),
        request.forms.get('is_deleted'),
        request.forms.get('is_banned'),
        request.forms.get('human'),
        request.forms.get('bot'),
        request.forms.get('like'),
        request.forms.get('repost'),
        request.forms.get('derived_content'),
        request.forms.get('repeated_posts'),
        request.forms.get('fluent_content'),
        request.forms.get('active_inactivity_period'),
        request.forms.get('high_frequency_activity'),
        request.forms.get('note')
    ]

    for i in range(4,len(insert_data)-1):
        if insert_data[i] == 'on':
            insert_data[i] = 1
        else:
            insert_data[i] = 0

    unnamed = request.forms.get('unnamed')
    user_id = request.forms.get('user_id')

    # ? TODO: differentiate between "INSERT OR REPLACE "  and "REPLACE", "UPDATE"
    # if is_in_database(unnamed, user_id):
    #     query= """ UPDATE"""

    query_insert = """
            INSERT OR REPLACE INTO reddit_bots VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    """

    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    cursor.execute(query_insert, insert_data)
    connection.commit()
    cursor.close()
    connection.close()

    annotator = request.forms.get('annotation_marker')
    if request.forms.get('annotator') is not None:
        annotator = request.forms.get('annotator')

    anno_type = request.forms.get('anno_type')
    parameter = f"?annotator={annotator}&anno_type={anno_type}"

    redirect('/annotation/{}/{}{}'.format(unnamed, user_id, parameter))


@route('/database')
def database():
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    data = cursor.execute("""SELECT * FROM reddit_bots""").fetchall()
    cursor.close()
    connection.close()
    return template('database', data=data, activeNav="database")


@route('/database/not_annotated')
def database():
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    data = cursor.execute("""SELECT * FROM reddit_bots WHERE annotator IS NULL""").fetchall()
    cursor.close()
    connection.close()
    return template('database', data=data, activeNav="database/not_annotated")


@route('/database/has_annotation')
def database():
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    data = cursor.execute('''
                SELECT * FROM reddit_bots WHERE 
                annotator IS NOT NULL
                OR
                annotator != ""
            ''').fetchall()
    cursor.close()
    connection.close()
    return template('database', data=data, activeNav="database/has_annotation")


@route('/annotation')
@route('/annotation/')
@route('/new')
@route('/new/')
def new():
    parameter = parameter_split(request.query_string)
    return template('annotation', data=None, annotator_marker=parameter.get('annotator'), anno_type=parameter.get('anno_type') )



@route('/annotation/<unnamed:int>/<user_id>')
def annotation(unnamed:int = '', user_id:str = ''):
    parameter = parameter_split(request.query_string)

    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    data = cursor.execute("""SELECT * FROM reddit_bots WHERE unnamed = ? and user_id = ? LIMIT 1""",(unnamed, user_id)).fetchone()
    cursor.close()
    connection.close()

    annotation_maker = parameter.get('annotator')
    return template('annotation', data=data, annotator_marker=annotation_maker, anno_type='annotation')


@route('/fetch/<unnamed:int>/<user_id>')
def fetch(unnamed:int, user_id:str):
    user_metadata = fetch_user_metadata.fetch_user_metadata(user_id)
    success = None
    if user_metadata != -1:
        success = fetch_user_metadata.save_metadata_to_json(user_id, user_metadata)
    
    connection = sqlite3.connect("database/database.db")
    cursor = connection.cursor()
    query = """
                UPDATE reddit_bots 
                SET 
                    was_fetched = ?
                WHERE
                    unnamed = ?
                AND
                    user_id = ?
            """
    cursor.execute(query, (success, unnamed, user_id))
    connection.commit()
    cursor.close()
    connection.close()
    redirect('/annotation/{}/{}'.format(unnamed, user_id))



@route('/search')
def search():
    return template('search', activeNav="search")


@route('/search_result', method=['post','get'])
def search_result():
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    data = cursor.execute("""
                          SELECT * 
                          FROM reddit_bots 
                          WHERE annotator IS NULL 
                          
                          """).fetchall()
    cursor.close()
    connection.close()
    return template('database', data=data, activeNav="database")






# #####################   ERROR   #####################

@error(404)
def error404(error):
    return template('error', errorCode="404", errorMsg='Page not found')


@error(500)
def error500(error):
    return template('error', errorCode="500", errorMsg='Internal Server Error')





# #####################   RESOURCES   #####################

@get("/static/css/<filepath:re:.*\\.css>")
def css(filepath):
    return static_file(filepath, root="static/css")


@get("/static/img/<filepath:re:.*\\.(jpg|jpeg|png|gif|ico|svg)>")
def img(filepath):
    return static_file(filepath, root="static/img")


@get("/static/js/<filepath:re:.*\\.js>")
def js(filepath):
    return static_file(filepath, root="static/js")


@get("/data/<filepath:re:.*\\.json>")
def json(filepath):
    return static_file(filepath, root="data")



if __name__ == '__main__':
    run(host="localhost", port="80", reloader=True, debug=True)
