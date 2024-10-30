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

