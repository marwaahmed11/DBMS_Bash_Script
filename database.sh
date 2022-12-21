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
               
                case $name in 
                +([a-z]) )
                    mkdir $name
                    echo $name "is created successfully"
                    # pwd
                ;;
                +([A-Z]) ) 
                    mkdir $name
                    echo $name "is created successfully"
                   
                ;;
                +([a-zA-Z]) ) 
                    mkdir $name
                    echo $name "is created successfully"
                   
                ;;
                +([_a-z_A-Z]) ) 

                    mkdir $name
                    echo $name "is created successfully"
                ;;
                * )
                echo "Invalid database name "
                esac                
    
            fi 

        ;;
        ConnectDB )
                read -p "Enter Name of DB you want to connect : " name 
                if [ -d $name ] ; then 
                    cd $name 
                    pwd
                    cd ..
                    echo "DataBase exists "
                    echo "Welcome from " $name " ,you can"
                    
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



