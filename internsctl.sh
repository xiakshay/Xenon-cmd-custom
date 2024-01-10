#!/bin/bash

# internsctl script

# Section A
case $1 in
  "man")
    echo "internsctl(1) - Custom Linux command"
    echo " "
    echo "NAME"
    echo "       internsctl - Custom Linux command for operations"
    echo " "
    echo "SYNOPSIS"
    echo "       internsctl [OPTION]... [COMMAND] [USERNAME] [FILE]"
    echo " "
    echo "DESCRIPTION"
    echo "       Custom Linux command for performing various operations."
    echo " "
    echo "OPTIONS"
    echo "       --help          Show this help message and exit"
    echo "       --version       Show command version"
    echo " "
    echo "COMMANDS"
    echo "       cpu getinfo            Get CPU information"
    echo "       memory getinfo         Get memory information"
    echo "       user create <username> Create a new user"
    echo "       user list              List all users"
    echo "       user list --sudo-only  List users with sudo permissions"
    echo "       file getinfo <file>    Get information about a file"
    echo " "
    ;;
  "--help")
    echo "Usage: internsctl [OPTION]... [COMMAND] [USERNAME] [FILE]"
    echo "Try 'internsctl man' for more information."
    ;;
  "--version")
    echo "internsctl v0.1.0"
    ;;
  "cpu")
    case $2 in
      "getinfo")
        lscpu
        ;;
      *)
        echo "Invalid cpu command."
        ;;
    esac
    ;;
  "memory")
    case $2 in
      "getinfo")
        free
        ;;
      *)
        echo "Invalid memory command."
        ;;
    esac
    ;;
  "user")
    case $2 in
      "create")
        adduser $3
        ;;
      "list")
        if [ "$4" == "--sudo-only" ]; then
          cut -d: -f1 /etc/passwd | xargs -I {} sudo -l -U {} | grep 'may run the following commands'
        else
          cut -d: -f1 /etc/passwd
        fi
        ;;
      *)
        echo "Invalid user command."
        ;;
    esac
    ;;
  "file")
    case $2 in
      "getinfo")
        file=$3
        case $4 in
          "--size" | "-s")
            stat -c%s "$file"
            ;;
          "--permissions" | "-p")
            stat -c%a "$file"
            ;;
          "--owner" | "-o")
            stat -c%U "$file"
            ;;
          "--last-modified" | "-m")
            stat -c%y "$file"
            ;;
          *)
            echo "Invalid file option."
            ;;
        esac
        ;;
      *)
        echo "Invalid file command."
        ;;
    esac
    ;;
  *)
    echo "Invalid command."
    ;;
esac
