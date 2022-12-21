: '
if (( $# != 0 )) ; then
    if [[ -f $1 && -x $1 ]] ;then #3shan at2kd en 3ndo execute w kman 7tet[[]]
    #3shan &&
        echo "File Exist "
    elif [ -d $1 ];then
        echo "Folder Exist "
    else
        echo "not File & Folder"
    fi
else 
 echo "Error "
fi
'

: '
if (( $# != 0 )) ; then
    if [[ -f $1 ]] ;then 
        echo "File Exist "
	cat $1
    elif [ -d $1 ];then
        echo "Folder Exist "
    else
        echo "not File & Folder"
    fi
else 
 echo "Error "
fi 
'

# -e -> mfesh folder wla file bl2sm dah 




if [ -e "Database" ];then  # lw mwgod
    echo "Database is already exist " 
    cd Database
   
   

else  #lw msh mwgod 
   mkdir ./Database
   cd Database
   echo "Database is created successfully"
        
   
fi 

 

select i in CreateDB ConnectDB ListDB CreateTable ListTable exit
do 
    case $i in 
    
        CreateDB ) 

            read -p "Enter Name of DB : " name 
            if [ -e $name ];then  # lw mwgod
                echo "Error, already exist"
            else
        
                mkdir $name
                echo $name "is created successfully"
            fi 

        ;;
        ConnectDB )
                read -p "Enter Name of DB " name 
                if [ -d $name ] ; then 
                    cd $name 
                    pwd
                    cd ..
                else 
                  echo "Sorry DataBase Not Exit"
                fi
                # h7ot select tany 
                # hnft7 menu 3shan create,update,delete table ---
        ;;
        ListDB) 
            ls -F | grep "/"
        ;;
        CreateTable)
            read -p "Enter Name of Table : " name 
            if [ -e $name ];then 
                echo "Error"
            else
                touch $name
            fi 
        ;;
        ListTable) 
            ls -F | grep -v "/"
        ;;
        exit) 
           break
        ;;
    esac
done


















