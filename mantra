#!/bin/bash

spring=false;
local_repo=false;
private_repository=false;
aruments=$#;
artifactId="";
groupId="";
description="";

#creates maven java application
create(){

    if [[ $spring == true ]];then 
        echo "spring app"

        curl https://start.spring.io/starter.tgz -d dependencies=web -d name="$1" -d bootVersion=2.1.5.RELEASE -d baseDir="$1" -d packageName="$2" -d version="1.0.0" -d description="$3" -d groupId="$2" -d artifactId="$3" -d javaVersion=11 | tar -xzvf -
        cd $1
    else
        mkdir $1
        cd $1

        mkdir -p src/{main,test}/{java/$2,resources}

        curl -s -o pom.xml https://gist.githubusercontent.com/ksundaysky/bf41f95c6c9be0c299a97ce24d429e18/raw/9d429aad5acfad7c280c0139776c16893043ee2b/pom.xml
        curl -s -o src/main/java/$2/App.java https://gist.githubusercontent.com/ksundaysky/0ec8f534a374d713f16143e0e742f02e/raw/160c0d856134758ae6525223f9e02598d9415384/App.java

        sed -i '' "s/#DESC/$3/g" pom.xml
        sed -i '' "s/#GROUP/$2/g" pom.xml
        sed -i '' "s/#APP/$1/g" pom.xml 

        sed -i ''  "s/#APP/$1/g"  src/main/java/$2/App.java
        sed -i ''  "s/#GROUP/$2/g"  src/main/java/$2/App.java
    fi
    

    git init

    if [[ $local_repo = false ]]; then
        push $1
    fi
}
#push to remote git server github.com
push(){
    repo_name=$project_name

    username=`git config github.user`
    if [ "$username" = "" ]; then
        echo "Could not find username, run 'git config --global github.user <username>'"
        invalid_credentials=1
    fi

    token=`git config github.token`
    if [ "$token" = "" ]; then
        echo "Could not find token, run 'git config --global github.token <token>'"
        invalid_credentials=1
    fi

    if [ "$invalid_credentials" == "1" ]; then
        echo "Something went wrong, sorry!"
        return 1
    fi

    echo -n "Creating Github repository '$repo_name' ..."

    # To make it simpler 
    # curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'", "private":"'$private_repository'"}' > /dev/null 2>&1
    # but... request with private:false doesnt work :(

    if [[ $private_repository = true ]]; then
        curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'", "private":"'$private_repository'"}' > /dev/null 2>&1
    else 
        curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
    fi

    echo " done."

    echo -n "Pushing local code to remote ..."
    git add .
    git commit -m "Initialize repository of project $repo_name"
    git remote add origin https://github.com/$username/$repo_name.git 
    git push -u origin master
    echo " done."
}

# parse parameters 
while getopts "slp" opt; do
  case ${opt} in
    s ) # spring boot application
        echo "Spring application"
        spring=true;
      ;;
    l ) # spring boot application
        echo "Only local repository"
        local_repo=true;
      ;;
    p ) # spring boot application
        echo "Private git repository"
        private_repository=true;
      ;;
    \? ) echo "Usage: mantra project_name [-s | -n | -p ]"
      ;;
  esac
done

# ask for details
echo "Project name: "
read project_name;
echo "Group ID: "
read groupId;
echo "Description: "
read description;

create $project_name $groupId $description;



# if [[ $spring == true ]];then 
#     if [[ "$#" == "1" ]]; then
#         echo "Usage mantra -s project_name"
#     fi

#     if [[ "$#" == "2" ]]; then 
#         echo "Provide group name:"
#         read group
#         echo "Provide description: "
#         read desc
#         create $2 $group $desc

#     elif [[ "$#" == "3" ]]; then 
#         echo "Provide description: "
#         read desc
#         create $2 $3 $desc

#     elif [[ "$#" == "4" ]]; then 
#         create $2 $3 $4
#     fi
# else
#     if [[ "$#" == "0" ]]; then
#     echo "Usage mantra project_name"
#     fi

#     if [[ "$#" == "1" ]]; then 
#         echo "Provide group name:"
#         read group
#         echo "Provide description: "
#         read desc
#         create $1 $group "$desc"

#     elif [[ "$#" == "2" ]]; then 
#         echo "Provide description: "
#         read desc
#         create $1 $2 $desc

#     elif [[ "$#" == "3" ]]; then 
#         create $1 $2 "$3"
#     fi
# fi



