build :
	docker-compose build cabot-app
	docker-compose build cabot-celery
	docker-compose build cabot-beat

dev-migrate :
	docker-compose run cabot-app bash -c "django-admin.py syncdb --noinput && django-admin.py migrate"

dev-run :
	docker-compose up cabot-app

dev-shell :
	docker-compose run cabot-app bash

update-plugins :
	docker-compose run cabot-app bash -c "django-admin.py syncdb && django-admin.py migrate"

create-superuser :
	docker-compose run cabot-app django-admin.py createsuperuser

