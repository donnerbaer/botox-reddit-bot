

# install

    pip install sqlite3
    pip install requests
    pip install bottle

1. run `python create_database.py`
2. [optional] using `.tsv`-files
    1. put your `.tsv`-files in `/tsv`
    2. open jupyter notebook `transform.ipynb`, change your `.tsv`-file
    3. run `transform.ipynb`


# run website

1. run `python webserver.py`
2. open `localhost` in your browser

# annotation

1. click on `annotate` in menu 
2. click `fetch now` (button yellow) after fetch it becomes grey (refetch is possible)
3. type your name in Annotator (name will pre-fill for functions `next entry` / `add new entry` after `save`, but will not saved automatically for the next annotations)
    1. if json is empty: account is does not exists 
    2. if json is there, but only username is there and the other key/values are null: accout is bannend
    3. rest has data
4. is duplicate is active, the user_id (account name) was more than once in the `.tsv`-file

+ click `save`
+ after save you can goto `next entry` or `add new entry`

# after manuel classification

your json file are in `/data`
your sqlite3 database file is in `/database`


# TODO (future me problems)

+ write documentation
+ implement search function (for the template)
+ add pagenation for `/database`-sites
+ make the image on `/annotation` pretty (html/css)
+ add dashboard (`chart.js`?)
+ add `.json`-file preview on `/annotation` (using columns [form / json-preview])
