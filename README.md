# mantra-cli 💣 👌 👊

mantra-cli is a command line tool that makes creating Java projects faster and easier.

```sh
mantra [OPTIONS]
```

Manual for this script [here](https://ksundaysky.github.io/mantra-page)

## Prerequisites

* git 2.20.0

## How to run

Clone repository 
```sh
git clone https://github.com/ksundaysky/mantra.git
```
Then you should make script executable:
```sh
chmod +x mantra
```
then add directory where script is to PATH variable to execute mantra from anywhere

```sh
PATH=$PATH:~/current/directory
```

## Configuration

Script works properly if all environment variables are set correctly. 
You should set:

1. git config --global github.user \<username>
2. git config --global github.token \<token> [How to generate github token](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line)

## Examples

### Default configuration
Default configuration creates Java project with Maven structure, creates git repository locally and remotely (public repository) on GitHub, and pushes first commit to the server.

To run script with default settings, just type *"mantra"*. While the script is running, you will be asked for your new projects name, packaging and description.

```sh
mantra
```

### Spring Boot project
Script can generate simple Spring Boot project. Other setting sets to default.

```sh
#spring
mantra -s
```

### Private GitHub repository
To create java project and push it to private remote repository just type:

```sh
#private
mantra -p 
```

### Local repository only
Create project but do not push it to remote server.

```sh
#local
mantra -l 
```