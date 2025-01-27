# Data Development Containers

This is a docker based data development and learn environment.

This repository is made up of three main components - data engineer development container, data science development container & airflow container

**Important**

This build script for both containers leverages docker cache if no changes were made to either `requirements.txt` files, to build the image quickly. 

If the checksum of requirements changes due to any version update or dependency update the build is performed without cache to ensure the update of the requirements in the container.

Both containers are setup with the following terminal commands:

* vim
* sqlite3

## Data Science Development Container

This component is installed with the following python packages:

* pandas
* numpy
* sqlalchemy
* matplotlib
* seaborn
* recordlinkage
* thefuzz
* statsmodels
* requests
* pingouin
* scikit-learn
* kagglehub
* xlrd
* fastparquet
* ucimlrepo

The following python based cli tools are also installed:

* pytest
* flake8
* kaggle
* jupyter
* cookiecutter


To update the following dependencies update the file `data-science/requirements.txt`

### Building

To build the docker image run the following command

```sh
cd build/scripts
chmod 700 build
./build data-science
```

this will build a docker image named `maria-data-science-environment`. The name of this image can be changes in the file `data-science/image-name.dat`


## Data Engineer Development Container

This component is installed with the following python packages:

* pandas
* numpy
* sqlalchemy
* recordlinkage
* requests
* kagglehub
* xlrd
* fastparquet

The following python based cli tools are also installed:

* pytest
* flake8
* kaggle
* jupyter


To update the following dependencies update the file `data-engineer/requirements.txt`

### Building

To build the docker image run the following command

```sh
cd build/scripts
chmod 700 build
./build data-engineer
```

this will build a docker image named `maria-data-engineer-environment`. The name of this image can be changes in the file `data-engineer/image-name.dat`


## Running

To run the either container localy locally it is a requirement that you go through [data science build process first](#building) and/or [data enginner build process first](#building-1).


### Data Science

```sh
docker compose up -d data-science
```

This command runs a container named `data-science-environment` that mounts a two way bind volume locally in `jupyter-science` folder.

For maintainability usage, the `jupyter-science` folder is not versioned. 

By running this container a volume is created with name `aggregate-containers_data-science-backup`. The container runs a cronjob that does a back-up of all of your data from you jupyter folder to this my-de-volume.

### Data Engineer

```sh
docker compose up -d data-engineer
```

This command runs a container named `data-engineer-environment` that mounts a two way bind volume locally in `jupyter-engineer` folder.

For maintainability usage, the `jupyter-engineer` folder is not versioned. 

By running this container a volume is created with name `aggregate-containers_data-engineer-backup`. The container runs a cronjob that does a back-up of all of your data from you jupyter folder to this my-de-volume.

### Both containers

```sh
docker compose up -d
```

This command mounts two volumes that are two way bind: `jupyter-engineer` & `jupyter-science`. 

It also creates two volumes for backup purposes named `aggregate-containers_data-engineer-backup` & `aggregate-containers_data-science-backup`.


## Container Access & Commands

In the following commands replace `<container-name>` with:

* `data-science-environment`
* `data-engineer-environment`

### Using python terminal

To use the installed python environment in a terminal environment run in your terminal the command

```sh
docker exec -it <container-name> python
```

### Helpful commands

**Run bash**

```sh
docker exec -it <container-name> bash
```

**Check backup**

```sh
docker exec -it <container-name> ls /backup-folder
```

**Restore backup**

The following command might be helpful if you delete this repository, kept you local docker volume and want to restore all you jupyter notebooks and related files.

```sh
docker exec -it <container-name> cp -r /backup-folder /jupyter-folder
```

### Using jupyter notebook

To use the jupyter notebook open the following url in your browser

* [Data science jupyter homepage](http://localhost:8888)
* [Data engineer jupyter homepage](http://localhost:8989)

The jupyter password for both jupyter servers is **maria**.

## Airflow Container

This component runs an airflow container with all of its dependencies.


### Running

To run airflow run the command

```sh
cd airflow 
docker compose up -d
```

### Using interface

To use the airflow web interface notebook open the [airflow homepage](http://localhost:8787) in your browser.

The credentials are

* username: maria
* password: mariapassword