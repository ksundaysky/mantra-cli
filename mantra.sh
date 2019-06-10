#!/bin/bash

mkdir $1
cd $1

echo "Specify group name:"
read group
echo "Add some description: "
read desc

mkdir -p src/{main,test}/{java/$group,resources}

cp ~/Desktop/bash/pom.xml .
cp ~/Desktop/bash/App.java src/main/java/$group/

sed -i '' "s/#DESC/$desc/g" pom.xml
sed -i '' "s/#GROUP/$group/g" pom.xml
sed -i '' "s/#APP/$1/g" pom.xml 

sed -i ''  "s/#APP/$1/g"  src/main/java/$group/App.java
sed -i ''  "s/#GROUP/$group/g"  src/main/java/$group/App.java

git init

# idea pom.xml #idea is alias to intellij run script

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
 git commit -m "Initialize repository"
 git remote add origin https://github.com/$username/$repo_name.git 
 git push -u origin master
 echo " done."

