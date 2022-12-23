CreateTable ()
{
    echo 'create table'
    read -p "Enter Name of Table: " table_name 
        
    if [[ $table_name  =  $name ]] ; then 
      echo "Error,enter another table name"

    else
        if [[ -e $table_name ]] ; then  # lw mwgod
             echo "Error,this table is already exist"
        else
        
            if [[ $table_name =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]] ; then 
                touch $table_name "$table_name metadata"
                echo $table_name" is created successfully"
                read -p "How Many Columns you want to create?" num_of_fields
                count=0
               while (( $count < $num_of_fields))
               do
                  read -p "Enter column name :" column_name
                  ans=`head -1 "$table_name metadata" | grep $column_name | wc -l`  ##############unique
                
                   if (( $ans > 0 )) ; then  # lw mwgod
                      echo "Error,this column is already exist"
                   else
                        if [[ $column_name =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]] ; then 
                           if (( count == 0)) ; then 
                              echo -n $column_name":" >>  "$table_name metadata"
                              echo $column_name "is added in " "$table_name metadata" "and this is primary key"
       
                           else
                               echo -n $column_name":" >>  "$table_name metadata"
                               echo $column_name "is added in " "$table_name metadata"
                           fi

                        else
                        echo "Invalid column name "
                        fi
                   fi

                    ((count=$count+1))
               done 
                noOfColumn=`head -1 "$table_name metadata"| tr ':' ' ' | wc -w`

                sum=0
                echo >>  "$table_name metadata"
               while (( $sum < $noOfColumn))
               do
                 
                   echo "Type of column :"
                   echo "-----------------"  
                   read -p "Enter data type of :" type
                   if [[ $type == "string" ]] ; then
                     
                      echo -n "string:" >>  "$table_name metadata"
                   else
                      if [[ $type == "int" ]] ; then
                         echo -n "int:" >>  "$table_name metadata"
                      else
                         echo "datatype is not correct"
                       fi
                    fi
                    ((sum=$sum+1))
               done 

            else
                echo "Invalid table name "
                
            fi  
        fi
    fi    
       
    
       
                
}
ListTable()
{
    ls -F | grep -v "/"
}
DropTable ()
{
    read -p "Enter Name of Table you want to drop: " name 
    if [ -e $name ];then  # lw mwgod
        rm $name
        echo $name "is dropped successfully"
    else
    
        echo $name "is not found"

    fi 
}
InsertInTable ()
{
    echo 'insert'
    pwd
    read -p "Enter Name of Table you want to insert in: " table_name 
    if [[ -e $table_name  ]] ; then 
    #   echo "mwgod"
      noOfColumn=`head -1 "$table_name metadata"| tr ':' ' ' | wc -w`
      #echo $noOfColumn
      i=0
      while (( $i < $noOfColumn ))
      do
        
        ((var=$i+1))
        read -p "Enter data of column $var: " data
        datatype=`tail -n1 "$table_name metadata" | cut -d: -f $var`
        if [[ $data =~ [a-zA-Z] ]] ; then 
           
            if [[ $datatype == "string" ]] ; then
              echo -n $data":">> $table_name
            else
               echo -n "null:" >> $table_name
               echo "unmatched datatype"
            fi
        else
          if [[ $data =~ [1-9] ]] ; then
            
            if [[ $datatype == "int" ]] ; then
              if [[ $var == 1 ]]; then
                    column1=`cut -d: -f 1 $table_name | grep $data | wc -l`
                    if (( $column1 > 0 )) ; then 
                        echo "error,repeated"
                        echo -n "null:" >>  $table_name 
                    else
                       echo -n $data":" >> $table_name
                    
                    fi
              else
                echo -n $data":" >> $table_name
              fi
            else
               echo -n "null:" >> $table_name
               echo "unmatched datatype"
            fi
          else
             echo "Invalid data"
          fi
          
        fi  
        ((i=$i+1))
      done
      echo >> $table_name

   

    else
        echo "Error,this table is not exist"
    fi
}
UpdateTable()
{
    echo 'update '
}
SelectFromTable ()
{
    echo "Tables:"
    ls -F | grep -v "/"
    read -p "Enter Name of Table you want to select from: " table_name
    if [[ -e $table_name  ]] ; then 
      select i in selectAll selectColumn selectRow exit
      do 
      case $i in 
    
        selectAll ) 
          cat < $table_name
        ;;
        selectColumn )
          
          i=1
          num_of_fields=`head -1 "$table_name metadata" | tr ':' ' ' | wc -w`
          echo "Column name:"
          while (( $i <= $num_of_fields ))
          do
            columnName=`head -1 "$table_name metadata"| cut -d: -f $i `
            echo $i"-" $columnName 

            ((i=$i+1))
          done  

          read -p 'Enter number of column:' num
          if [[ $num =~ [1-9] ]]  ; then
            if (( $num <= $num_of_fields )) ; then

                head -1 "$table_name metadata"| cut -d: -f $num
                echo "-----"
                cut -d : -f $num $table_name
                
            else
                echo "Invalid column number"
            fi 
          else
             echo "Error, Invalid number"
          fi
              
        ;;
        selectRow ) 
         read -p 'Enter column name:' input
         if [[ $input =~ [a-zA-Z] ]] ; then
              var=`grep $input "$table_name metadata" | wc -l `
              if (( $var > 0 )) ; then
                read -p 'Enter data :' data
                newvar=`grep $data $table_name | wc -l `
                if (( $newvar > 0 )) ; then 
                  grep $data $table_name 
                else
                  echo "Error, doesn't exist"
                fi

              else
                echo "Column name doesn't exist"
              fi
         else
           echo "Invalid column name"
         fi    
        ;;
        exit ) 
          break
        ;;
      esac
      done
    else
      echo "Error, table is not exist."
    fi


}
DeleteFromTable ()
{
   echo "Tables:"
    ls -F | grep -v "/"
    read -p "Enter Name of Table you want to delete from: " table_name
    if [[ -e $table_name  ]] ; then 
      select i in deleteAll deleteRow exit
      do 
      case $i in 
    
        deleteAll  ) 
          echo > $table_name
          echo "Data in file is deleted successfully"
          #ls -F | grep -v "/"  # st
        ;;
        deleteRow ) 
         echo 'You will delete by id'
         
         read -p 'Enter value of id you want to delete:' data
         newvar=`grep $data $table_name | wc -l `
         if  [[ $data =~ [1-9] ]]  ; then
            if (( $newvar > 0 )) ; then 
                record_num=`awk -F':' '{if($1=='$data'){print NR}}' "$table_name"`
                sed -i ''$data'd' $table_name #override modification in file
            else
                echo "Error, data doesn't exist"
            fi
         else
           echo "Invalid data "
         fi
        ;;
        exit ) 
          break
        ;;
      esac
      done
    else
      echo "Error, table is not exist."
    fi
}
MainMenu ()
{
    echo "back"
    # break
    cd ../..
    source database.sh
    
    
}

echo "List Table Menu "
echo "----------------"
select i in  "Create Table" "List Table"  "Drop Table" "Insert In To Table" "Select From Table" "Delete From Table" "Update Table"  "Main Menu" 
do 
    case $i in 
    
        "Create Table" ) 
            CreateTable
        ;;
        "List Table"  )
            ListTable       
        ;;
        "Drop Table" ) 
            DropTable
        ;;
        "Insert In To Table") 
           InsertInTable
        ;;
        "Select From Table" ) 
           SelectFromTable
        ;;
         "Delete From Table" ) 
           DeleteFromTable 
        ;;
        "Update Table")
            UpdateTable                 
        ;;
        "Main Menu")
            MainMenu       
        ;;
        
    esac
done







