from bottle import route, run, default_app, debug
from bottle import get, static_file, template, error, redirect, request
from helper import fetch_user_metadata
import sqlite3
import configparser


config = configparser.ConfigParser()
config.read('config.ini')
database_path = config['DATABASE']['FILE']


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


def is_in_database(annotator:str, user_id:str) -> bool:
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    result = cursor.execute("""SELECT annotator FROM reddit_bots WHERE annotator = ? and user_id = ?""", (annotator, user_id)).fetchone()
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
    user_id = cursor.execute("""
        SELECT 
	        user_id
        FROM reddit_bots 
        WHERE 
            user_id NOT IN(
                SELECT DISTINCT user_id 
                FROM reddit_bots 
                WHERE annotator IS NOT NULL
                ) LIMIT 1
        """).fetchone()
    user_id = user_id[0]
    cursor.close()
    connection.close()
    redirect('/annotation/{}'.format(user_id))


@route('/next')
def next():
    parameter = parameter_split(request.query_string)
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    annotator, user_id = cursor.execute("""                        
        SELECT 
            annotator,
            user_id
        FROM reddit_bots 
        WHERE 
            user_id NOT IN(
                SELECT DISTINCT user_id 
                FROM reddit_bots 
                WHERE annotator IS NOT NULL
                )
        """).fetchone()
    cursor.close()
    connection.close()
    if parameter.get('annotator') is not None:
        redirect(f'/annotation/{user_id}?annotator={parameter.get('annotator')}')
    redirect(f'/annotation/{user_id}')



@route('/save', method="post")
def save():
    insert_data = [
        request.forms.get('annotator'),
        request.forms.get('user_id'),
        request.forms.get('was_fetched'),
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

    for i in range(2,len(insert_data)-1):
        if insert_data[i] == 'on':
            insert_data[i] = 1
        else:
            insert_data[i] = 0

    annotator = request.forms.get('annotator')
    user_id = request.forms.get('user_id')

    query_insert = """
            INSERT OR REPLACE INTO reddit_bots VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
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

    redirect('/annotation/{}/{}{}'.format(user_id, annotator, parameter))


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


@route('/database/has_fetched')
def database():
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    data = cursor.execute('''
                SELECT * FROM reddit_bots WHERE 
                was_fetched = 1
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



@route('/annotation/<user_id>')
@route('/annotation/<user_id>/<annotator>')
def annotation(user_id:str = '', annotator = None):
    parameter = parameter_split(request.query_string)
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    if annotator is not None and annotator != 'None':
        data = cursor.execute("""SELECT * FROM reddit_bots WHERE user_id = ? and annotator = ? LIMIT 1""",(user_id, annotator)).fetchone()
    else:
        data = cursor.execute("""SELECT * FROM reddit_bots WHERE user_id = ? LIMIT 1""",(user_id, )).fetchone()
    cursor.close()
    connection.close()
    annotation_maker = parameter.get('annotator')
    return template('annotation', data=data, annotator_marker=annotation_maker, anno_type='annotation')


@route('/fetch/<user_id>')
@route('/fetch/<user_id>/<annotator>')
def fetch(user_id:str, annotator:str = None):
    parameter = parameter_split(request.query_string)

    user_metadata = fetch_user_metadata.fetch_user_metadata(user_id)
    success = False
    if user_metadata != -1:
        success = fetch_user_metadata.save_metadata_to_json(user_id, user_metadata)
    
    connection = sqlite3.connect("database/database.db")
    cursor = connection.cursor()
    query = """
                UPDATE reddit_bots 
                SET 
                    was_fetched = ?
                WHERE
                    user_id = ?
            """
    cursor.execute(query, (success, user_id))
    connection.commit()
    cursor.close()
    connection.close()
    redirect('/annotation/{}?annotator={}'.format(user_id, parameter.get('annotator')))



@route('/search')
def search():
    return template('search', activeNav="search")


@route('/search_result', method=['post','get'])
def search_result():
    # TODO: implement
    
    # search_parameter = [
    #     request.forms.get('annotator'),
    #     request.forms.get('user_id'),
    #     request.forms.get('was_fetched'),
    #     request.forms.get('is_deleted'),
    #     request.forms.get('is_banned'),
    #     request.forms.get('human'),
    #     request.forms.get('bot'),
    #     request.forms.get('like'),
    #     request.forms.get('repost'),
    #     request.forms.get('derived_content'),
    #     request.forms.get('repeated_posts'),
    #     request.forms.get('fluent_content'),
    #     request.forms.get('active_inactivity_period'),
    #     request.forms.get('high_frequency_activity'),
    #     request.forms.get('note')
    # ]

    # print(search_parameter)

    # connection = sqlite3.connect(database_path)
    # cursor = connection.cursor()
    # data = cursor.execute("""
    #                       SELECT * 
    #                       FROM reddit_bots 
    #                       WHERE annotator IS NULL 
                          
    #                       """,search_parameter).fetchall()
    # cursor.close()
    # connection.close()
    
    # return template('database', data=data, activeNav="database")
    redirect('/database')






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


@get("/json/<filepath:re:.*\\.json>")
def json(filepath):
    return static_file(filepath, root="json")



if __name__ == '__main__':
    run(host="localhost", port="80", reloader=True, debug=True)
