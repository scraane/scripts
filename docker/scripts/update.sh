#!/usr/bin/env bash
case $1 in
        "")
                echo "Need folder name to update! Or use ALL to update all"
                exit 0
                ;;
        ALL|all)
                for entry in */
                do
                        echo "Running update on $entry:"
                        set -x
						cd $entry
                        docker-compose pull
                        docker-compose up -d --remove-orphans
						cd ..
                done
                docker image prune -f
                exit 0
                ;;
        *)
                if [ -d $1 ]; then
                        echo "Running update on $1:"
                        set -x
						cd $1
                        docker-compose pull
                        docker-compose up -d --remove-orphans
                        docker image prune -f
						cd ..
                        exit 0
                else
                        echo "Folder $1 does not exist. Exiting!"
                        exit 0
                fi
                ;;
esac
