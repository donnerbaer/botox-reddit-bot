#

+ Install
+ Insert data
+ Run Website
+ Annotation
+ Patchnotes
+ TODO
+ After manuel classificiation


# Install

Jupyter Notebook required for transform & load `.tsv` into database

    pip install sqlite3
    pip install requests
    pip install bottle



1. run `python create_database.py`

# Insert data

2. [optional] using `.tsv`-files
    1. put your `.tsv`-files in `/tsv`
    2. open jupyter notebook `transform.ipynb`, change your `.tsv`-file
    3. run Jupyter Notebook `transform.ipynb`

3. run `fetch_json.py`  (Saves all jsons from existing accounts in your database)
4. run `update_fetched.py` (Updates fetch status in your database, if json file is in `/json`)


# Run website

5. run `python webserver.py`
6. open `localhost` in your browser

# Annotation

7. click on `annotate` in menu 
8. click `fetch now` (button yellow) after fetch it becomes grey (refetch is possible)
9. type your name in Annotator (name will pre-fill for functions `next entry` / `add new entry` after `save`, but will not saved automatically for the next annotations)
    1. if json is empty: account is does not exists 
    2. if json is there, but only username is there and the other key/values are null: accout is bannend
    3. rest has data
10. is duplicate is active, the user_id (account name) was more than once in the `.tsv`-file

+ click `save`
+ after save you can goto `next entry` or `add new entry`

# After manuel classification

your json file are in `/json`
your sqlite3 database file is in `/database`




# TODO (future me problems)

+ write documentation
+ implement search function (for the template)
+ add pagenation for `/database`-sites
+ add dashboard (`chart.js`?)
+ add `.json`-file preview on `/annotation` (using columns [form / json-preview])
+ add database migration script for `v0.1.0a` to `v0.2.0a`
+ add configuration .json for database & annotation form

