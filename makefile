VIRTUALENV=virtualenv
NPM=npm
NODE=nodejs
PHP=php

init_virtualenv:
	mkdir -p env
	$(VIRTUALENV) env
	env/bin/pip install -f requirements.txt

# Login protocol. Writes to ~/.boto
init_gsutil_auth:
	env/bin/gsutil config

update_virtualenv:
	env/bin/pip install -f requirements.txt

sync_sound_files:
	mkdir -p sounds
	env/bin/gsutil rsync -d -r gs://malia-speech.appspot.com/ sounds/

update_js_packages:
	$(NPM) install

update_bower_components:
	mkdir -p public_html/lib/bower_components
	$(NODE) node_modules/bower/bin/bower install

run_learn_server:
	env/bin/python learn/server.py

run_php_server:
	cd public_html
	$(PHP) -S localhost:9999
