#!/bin/sh

#
#   Automated script version based on InstallDatabases.sh
#   from mangoszero/database project
#

RELEASE="Rel21"
UPDATES="Rel20_to_BaseRel21_Updates"

user="root"
port="3306"
wdb="mangos0"
cdb="character0"
rdb="realmd"

printBanner()
{
	printf " #     #     #    #   #  ###   ###   ####  \n"
	printf " ##   ##    # #   ##  # #     #   # #      \n"
	printf " # # # #   #   #  # # # # ### #   #  ###   \n"
	printf " #  #  #  ####### #  ## #   # #   #     #  \n"
	printf " #     #  #     # #   #  ###   ###  ####   \n"
	printf "\n"
	printf " Database Setup and World Loader v0.01 	\n"
	printf " ---------------------------------------------- \n"
	printf "  Website / Forum / Wiki : https://getmangos.eu \n"
	printf " ---------------------------------------------- \n"
	printf "\n"
	printf "\n"
}

createCharDB()
{
	printf "Creating Character database ${cdb}\n"
	mysql -u ${user} -p$MYSQL_ROOT_PASSWORD -e "Create database ${cdb}"

	printf "Loading data into character database ${cdb}\n"
	mysql -u ${user} -p$MYSQL_ROOT_PASSWORD ${cdb} < \
            ./src/database/Character/Setup/characterLoadDB.sql
}

createWorldDB()
{
	printf "Creating World database ${wdb}\n"
	mysql -u ${user} -p$MYSQL_ROOT_PASSWORD -e "Create database ${wdb}"
        
	printf "Loading data into world database ${wdb}\n"
	mysql -u ${user} -p$MYSQL_ROOT_PASSWORD ${wdb} < \
            ./src/database/World/Setup/mangosdLoadDB.sql

	printf "Importing World database ${wdb}\n"
	for file in $(ls ./src/database/World/Setup/FullDB/*.sql \
                        | tr ' ' '|' | tr '\n' ' ')
	do
		file=$(echo ${file} | tr '|' ' ')
		printf "Importing file ${file}\n"
		mysql -u ${user} -p$MYSQL_ROOT_PASSWORD ${wdb} < ${file}
		printf "File ${file} imported\n"
	done

}

createRealmDB()
{
	printf "Creating realm database ${rdb}\n"
	mysql -u ${user} -p$MYSQL_ROOT_PASSWORD -e "Create database ${rdb}"

	printf "Loading data into realm database ${rdb}\n"	
	mysql -u ${user} -p$MYSQL_ROOT_PASSWORD ${rdb} < \
            ./src/database/Realm/Setup/realmdLoadDB.sql

	printf "Adding realm list entries\n"
	mysql -u ${user} -p$MYSQL_ROOT_PASSWORD ${rdb} < \
            ./src/database/Tools/updateRealm.sql
}

createCharDB
createWorldDB
createRealmDB
        
printBanner
printf "Database creation and load complete :-)\n"
printf "\n"
