# dwpa-web-docker

`git clone https://github.com/iganev/dwpa-web-docker.git`

`cd dwpa-web-docker`

`git submodule update --init --remote`

`./download_dicts.sh`

`cp .env.example .env`

`vim .env`

`./gen_dicts_sql.sh`

`./prepare_db.sh`

