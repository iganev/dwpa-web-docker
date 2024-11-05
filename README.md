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

## Running

If you want to run a local instance of [dwpa](https://github.com/RealEnder/dwpa), after completing the [Setup](#setup) steps you need to just:  
```shell
docker compose up -d
```

If you want to run a public instance then you need to override the default `docker-compose.yml` with the provided `docker-compose.proxy.yml` to add TLS (using LetsEncrypt) and prevent auto-login in phpMyAdmin:  
```shell
docker composer -f docker-compose.yml -f docker-compose.proxy.yml up -d
```

## Extras

During first run the database will be created and the file `db.sql` will be imported. This is done only once during first initialization. Therefore if you need to add dictionaries at a later stage, or you want (and you should definitely) to add special dictionary rules to be passed to the worker (hashcat) you need to do that through phpMyAdmin by updating or inserting rows in the `dicts` table.  
By default the setup script inserts all dictionaries with just the `:` rule which means "passthrough". This is usually not enough to perform successful audits! To improve your results, either update the `rules` column of each row in `dicts` or alternatively you setup your [dwpa-worker-docker](https://github.com/iganev/dwpa-worker-docker) to load extra rules from a file. For example, one rule to rule them all, or another good set of hashcat rules.  
The default (original) dwpa public instance as of time of writing uses more or less the following rules:
```
:
$a
^a
u
T0
$0
$1
$3
$7
$9
$6$9
$1$2$3
$2$0$2$4
so0
si1
se3
]
]]
```

Read more here about [hashcat rules](https://hashcat.net/wiki/doku.php?id=rule_based_attack).

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