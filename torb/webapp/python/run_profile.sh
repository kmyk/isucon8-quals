sudo systemctl stop torb.python
/home/isucon/torb/webapp/python/venv/bin/gunicorn -c profiler.py --workers=10 app:app -b '127.0.0.1:8080' --env DB_USER=isucon --env DB_PASS=isucon --env DB_HOST=127.0.0.1 --env DB_PORT=3306 --env DB_DATABASE=torb
