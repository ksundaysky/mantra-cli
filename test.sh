#!/bin/bash

spring=false;
aruments=$#;

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

        cp ~/Desktop/bash/pom.xml .
        cp ~/Desktop/bash/App.java src/main/java/$2/

        sed -i '' "s/#DESC/$3/g" pom.xml
        sed -i '' "s/#GROUP/$2/g" pom.xml
        sed -i '' "s/#APP/$1/g" pom.xml 

        sed -i ''  "s/#APP/$1/g"  src/main/java/$2/App.java
        sed -i ''  "s/#GROUP/$2/g"  src/main/java/$2/App.java
    fi
    

    git init

    # push $1
}
#push to remote git server github.com
push(){
    repo_name=$1

    dir_name=`basename $(pwd)`

    if [ "$repo_name" = "" ]; then
    echo "Repo name (hit enter to use '$dir_name')?"
    read repo_name
    fi

    if [ "$repo_name" = "" ]; then
    repo_name=$dir_name
    fi

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
    return 1
    fi

    echo -n "Creating Github repository '$repo_name' ..."
    curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
    echo " done."

    echo -n "Pushing local code to remote ..."
    git add .
    git commit -m "Initialize repository of project $repo_name"
    git remote add origin https://github.com/$username/$repo_name.git 
    git push -u origin master
    echo " done."
}

while getopts "s" opt; do
  case ${opt} in
    s ) # spring boot application
        echo "Spring application"
        spring=true;
      ;;
    \? ) echo "Usage: mantra project_name [-s]"
      ;;
  esac
done

if [[ $spring == true ]];then 
    if [[ "$#" == "1" ]]; then
        echo "Usage mantra -s project_name"
    fi

    if [[ "$#" == "2" ]]; then 
        echo "Provide group name:"
        read group
        echo "Provide description: "
        read desc
        create $2 $group $desc

    elif [[ "$#" == "3" ]]; then 
        echo "Provide description: "
        read desc
        create $2 $3 $desc

    elif [[ "$#" == "4" ]]; then 
        create $2 $3 $4
    fi
else
    if [[ "$#" == "0" ]]; then
    echo "Usage mantra project_name"
    fi

    if [[ "$#" == "1" ]]; then 
        echo "Provide group name:"
        read group
        echo "Provide description: "
        read desc
        create $1 $group "$desc"

    elif [[ "$#" == "2" ]]; then 
        echo "Provide description: "
        read desc
        create $1 $2 $desc

    elif [[ "$#" == "3" ]]; then 
        create $1 $2 "$3"
    fi
fi



