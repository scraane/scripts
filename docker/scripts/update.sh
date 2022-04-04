case $1 in
        "")
                echo "Need folder name to update! Or use ALL to update all"
                exit 0
                ;;
        ALL|all)
                for entry in */
                do
                        echo -e "**** \e[1;32m Running update on $entry: \e[0m"
                        set -x
                        cd $entry
                        docker-compose pull
                        docker-compose up -d --remove-orphans
                        cd ..
                        set +x
                done
                docker image prune -f
                exit 0
                ;;
        *)
                if [ -d $1 ]; then
                        echo -e "**** \e[1;32m Running update on $1: \e[0m"
                        cd $1
                        set -x
                        docker-compose pull
                        docker-compose up -d --remove-orphans
                        cd ..
                        docker image prune -f
                        set +x
                        exit 0
                else
                        echo -e "\e[1;31m Folder $1 does not exist. Exiting! \e[0m"
                        exit 0
                fi
                ;;
esac
