# dwpa-web-docker

Docker containers necessary to run [dwpa](https://github.com/RealEnder/dwpa) locally or publicly.  

To run a worker, please have a look at [dwpa-worker-docker](https://github.com/iganev/dwpa-worker-docker).  

## Setup

Clone the repository:
```shell
git clone --recursive https://github.com/iganev/dwpa-web-docker.git
```

Go inside the folder:
```shell
cd dwpa-web-docker
```

If you forgot `--recursive` during clone:
```shell
git submodule update --init --remote
```

Copy the example env file:
```shell
cp .env.example .env
```

Open the env file and edit all necessary [variables](#variables):
```shell
vim .env
```

Either prepare your own dictionary set as `.txt.gz` files in `dict` or run this to get the official/original instance dictionaries:
```shell
./download_dicts.sh
```

After making sure you have all necessary dictionaries gzipped and ready, run this to generate SQL INSERTS for your specific dictionary setup:
```shell
./gen_dicts_sql.sh
```

Finally, run this to compile a full database migration file that will consist of the base schema, additional stats default data, your dictionaries and your default API key (matches the boss key):
```shell
./prepare_db.sh
```



## Variables

`DWPA_VIRTUAL_HOST`: The virtual host to be used. `localhost` for local deployments. A valid domain pointing to that IP address for public deployments.  
`DWPA_PUBLIC_URL`: The virtual host + protocol to be used for dictionary links. `http://localhost` for local deployments. `https` + valid domain name for public deployments.  

`DWPA_VIRTUAL_HOST_PMA`: The virtual host to be used for PHPMyAdmin. Use `localhost` for local deployments. Use a subdomain for public deployments.  

`DWPA_DB_NAME`: Database name  
`DWPA_DB_USER`: Database user  
`DWPA_DB_PASS`: Database user password  
`DWPA_DB_ROOT`: Database root password  

`DWPA_BOSS_KEY`: DWPA boss key; also used to create a default user for personal use.  

`DWPA_MAIL_HOST`: SMTP hostname. Leave empty for local deployments.  
`DWPA_MAIL_PORT`: SMTP port. `587` by default.  
`DWPA_MAIL_USER`: SMTP username  
`DWPA_MAIL_PASS`: SMTP password  
`DWPA_MAIL_NAME`: Mail from name  
`DWPA_MAIL_FROM`: Mail from email  

`DWPA_RECAPTCHA_PUBLIC_KEY`: Recaptcha public key. Leave empty for local deployments.  
`DWPA_RECAPTCHA_PRIVATE_KEY`: Recaptcha private key. Leave empty for local deployments.  

`DWPA_WIGLE_API_KEY`: Wigle API Key. Optional.  