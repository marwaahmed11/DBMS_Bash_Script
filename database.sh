export LC_COLLATE=C
shopt -s extglob

if [ -e "Database" ];then  

    echo "Database is already exist " 
    echo "----------------------------"
    cd Database
   
else  

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
        
            if [[ -e $name ]] ; then 
                echo "Error, Database already exists" 
            else
               if [[ -z $name ]] ; then 
                 echo "Error,Database name can't be empty"
                 
               else
                   if [[ $name =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]] ; then 
                    mkdir $name
                    echo $name "is created successfully"
                    # pwd
                   else
                   echo "Invalid database name "
                  
                   fi       
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
                    echo "Welcome from " $name 
                    echo '----------------------'
                    source table.sh
                else 
                  echo "Sorry DataBase is not exist"
                fi
        ;;
        ListDB ) 
            ls -F | grep "/"
        ;;
        DropDB )
                
                read -p "Enter Name of DB you want to drop: " name  #check regex hereeeeeeeeeeeeeeeeeeeee "student meta"
                if [[ -z $name ]] ; then
                  echo "Error,DatabaseName is Empty."
                else
                    if [[ -e $name ]];then 
                        rm -r $name
                        echo $name "is dropped successfully"
                    else
        
                        echo $name "is not found"

                    fi   
                fi
            
        ;;
        exit ) 
          exit
        ;;
        * )
        echo "Choose from Menu List"
        ;;
    esac
done




