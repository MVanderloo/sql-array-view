db_file := 'array.db'
sql_file := 'array.sql'

_default:
	just --list --unsorted

edit: && clean create query
	nvim {{ sql_file }}

refresh: clean create

query:
	sqlite3 {{ db_file }}
    
create:
	sqlite3 {{ db_file }} < {{ sql_file }}

clean:
	rm {{ db_file }}

