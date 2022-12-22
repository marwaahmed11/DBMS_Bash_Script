export LC_COLLATE=C
shopt -s extglob

if [ -e "Database" ];then  # lw mwgod

    echo "Database is already exist " 
    echo "----------------------------"
    cd Database
   
else  #lw msh mwgod 

   mkdir ./Database
   cd Database
   echo "Database is created successfully"
   echo "---------------------------------"
        
   
fi 

 
echo "Database Menu :"
echo "----------------"
select i in CreateDB ConnectDB ListDB DropDB exit
do 
    case $i in 
    
        CreateDB ) 

            read -p "Enter Name of DB : " name 
        
            if [ -e $name ];then  # lw mwgod
                echo "Error, already exist"
            else
                    
                if [[ $name =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]] ; then 
                    mkdir $name
                    echo $name "is created successfully"
                    # pwd
                else
                   echo "Invalid database name "
                fi        
    
            fi 

        ;;
        ConnectDB )
                read -p "Enter Name of DB you want to connect : " name 
                if [ -d $name ] ; then 
                    echo "DataBase exists "
                    cd $name 
                    pwd
                    # cd ..
                    echo "Welcome from " $name "you can"
                    source table.sh
                else 
                  echo "Sorry DataBase is not exist"
                fi
                # h7ot select tany 
                # hnft7 menu 3shan create,update,delete table ---
        ;;
        ListDB ) 
            ls -F | grep "/"
        ;;
        DropDB )

                read -p "Enter Name of DB you want to drop: " name 
                if [ -e $name ];then  # lw mwgod
                    rm -r $name
                    echo $name "is dropped successfully"
                else
    
                    echo $name "is not found"

                fi 
            
        ;;
        exit ) 
           break
        ;;
    esac
done



