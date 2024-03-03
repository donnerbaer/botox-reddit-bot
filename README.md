

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

# after manuel classification

your json file are in `/data`
your sqlite3 database file is in `/database`

# TODO (future me problems)

+ implement search function (for the template)
+ add pagenation for `/database`-sites
+ make the image on `/annotation` pretty (html/css)
+ add dashboard (`chart.js`?)
+ add `.json`-file preview on `/annotation` (using columns [form / json-preview])
