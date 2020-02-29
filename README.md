# Docker Compose for DOMjudge

This repository contains scripts and compose files to build up docker containers for DOMjudge.


# Usage

## `build.sh`

`build.sh` generates configurations of password and timezone for containers.

If the script runs directly, it will additionally dump the generated password into a shell script `vars-*.sh`.

You can modify `vars-*.sh` to suit your needs and run `build.sh` with the path to `vars-*.sh` as the argument.
`build.sh` will use the variables defined in the file `vars-*.sh` to generate configurations.

## `judgehost/generate.sh`

This script generates `judgehost/docker-compose.yml` taking the number of judgehosts as the argument.

Please **make sure** that the generated `RUN_USER_UID_GID`s are not used on host.


# Cautions

- MariaDB needs to initialize files when first startup. After the initialization of mariadb, you can restart the domserver.
- Remember to modify `<cid>` in `cds/cdsConfig.xml`.
- If domserver is build up with a project name, please change the network section in `docker-compose.yml` for judgehost and cds.

