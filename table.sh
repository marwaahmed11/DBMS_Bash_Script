CreateTable ()
{
    echo 'Create table'
    echo '-------------'
    read -p "Enter Name of Table: " table_name 
        
    if [[ $table_name  =  $name ]] ; then 
      echo "Error,this table name same as database name"

    else
        if [[ -e $table_name ]] ; then  # lw mwgod
             echo "Error,this table is already exist"
        else
        
            if [[ $table_name =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]] ; then 
                touch $table_name $table_name"_metadata"
                echo $table_name" is created successfully"
                read -p "How Many Columns you want to create?" num_of_fields
                count=0
               while (( $count < $num_of_fields))
               do
                  ((m=$count+1))
                  read -p "Enter column name $m :" column_name
                  while [[ -z $column_name ]] 
                  do
                    echo "Error,Column Name is empty"
                    read -p "Enter column name again $m:" column_name
                  done
                      while (( `head -1 $table_name"_metadata" | grep $column_name | wc -l`  > 0 ))
                      do
                         echo "Error,this column is already exist"
                         read -p "Enter column name again $m:" column_name
                      done
                       while ! [[ $column_name =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]]
                       do
                         echo "Error,Invalid column name"
                         read -p "Enter column name again $m:" column_name
                        done
                        if (( count == 0)) ; then 
                          echo -n $column_name":" >>  $table_name"_metadata"
                          echo $column_name "is added in " $table_name"_metadata" "and this is primary key"
          
                        else
                           echo -n $column_name":" >>  $table_name"_metadata"
                           echo $column_name "is added in " $table_name"_metadata"
                        fi
                    ((count=$count+1))
               done 
                noOfColumn=`head -1 $table_name"_metadata"| tr ':' ' ' | wc -w`
                sum=0
                echo >>  $table_name"_metadata"
                echo "Type of column :"
                echo "-----------------"  
               while (( $sum < $noOfColumn))
               do
                  ((j=$sum+1))
                   nameOfColumn=`head -n1 $table_name"_metadata" | cut -d: -f $j`
                   echo "Enter datatype of $nameOfColumn column:" 
                    select x in int string 
                    do 
                    case $x in 
                    int ) 
                      echo -n "int:" >>  $table_name"_metadata"
                      break
                    ;;
                    string )
                      echo -n "string:" >>  $table_name"_metadata"
                      break
                    ;;
                    * )
                      echo "Error,choose from list "
                    ;;
                    esac
                    done
                  ((sum=$sum+1))
               done 
               echo "Return to Table Menu" 
            else
                echo "Invalid table name "     
            fi  
        fi
    fi                    
}
ListTable()
{
    echo "Tables:"
    echo "--------"
    ls -F | grep -v "/"
    echo "------------------"
    echo "Return to Table Menu" 
}
DropTable ()
{
    read -p "Enter Name of Table you want to drop: " name 

    if [[ -z $name ]] ; then 
     echo "Error,Table name is Empty and Return to Table Menu."
    else
      if [ -e $name ];then  # lw mwgod
        rm $name
        echo $name "is dropped successfully and Return to Table Menu"
      else
    
        echo $name "is not found and Return to Table Menu"
      fi 
    fi
}
InsertInTable ()
{
   echo 'insert'
   pwd
  read -p "Enter Name of Table you want to insert in: " table_name 
  if [[ -e $table_name  ]] ; then 
    #   echo "mwgod"
      noOfColumn=`head -1 $table_name"_metadata"| tr ':' ' ' | wc -w`
      #echo $noOfColumn
      i=0
     
      while (( $i < $noOfColumn ))
      do 
        
        if (( $i==0 )) ; then
            firstColumn=`head -n1 $table_name"_metadata" | cut -d: -f 1`
            read -p "Enter data of primary key column $firstColumn: " data
            while [[ -z $data  ]]
            do
                echo "Sorry,First column can't be null " 
                read -p "Enter again data of primary key : " data
            done
            datatype=`tail -n1 $table_name"_metadata" | cut -d: -f 1`

            if [[ $datatype == "string" ]]; then # empty
                    while ! [[ $data =~ [a-zA-Z] ]]
                    do
                      read -p "Enter again data of type string : " data
                    done
                    while (( `cut -d: -f 1 $table_name | grep $data | wc -l` > 0))
                    do
                      echo "error,repeated"
                      read -p "Enter again data of type int: " data   
                    done   
                    echo -n $data":">> $table_name
                    echo "string entered successfully"
                
            elif [[ $datatype == "int" ]]; then
                    while ! [[ $data =~ [1-9] ]] 
                    do
                      read -p "Enter again data of type int: " data
                    done
                    while (( `cut -d: -f 1 $table_name | grep $data | wc -l` > 0))
                    do
                      echo "error,repeated"
                      read -p "Enter again data of type int: " data   
                    done   
                    echo -n $data":">> $table_name
                    echo "int entered successfully"
                      
            fi
        else
           ((var=$i+1))
           #echo $var
           columnName=`head -n1 $table_name"_metadata" | cut -d: -f $var`
           read -p "Enter data of column $columnName: " data
           datatype=`tail -n1 $table_name"_metadata" | cut -d: -f $var`

           if [[ $datatype == "string" ]]  ; then 
              while ! [[ $data =~ [a-zA-Z] ]]
                do 
                  echo "unmatched datatype"
                  read -p "Enter again data of type string: " data
                done
                 echo -n $data":" >> $table_name
           elif [[ $datatype == "int" ]]; then
                while ! [[ $data =~ [1-9] ]]
                do 
                  echo "unmatched datatype"
                  read -p "Enter again data of type int: " data
                done
                 echo -n $data":" >> $table_name
           fi  
        fi
        ((i=$i+1))
      done
      echo >> $table_name
      echo "Return to Table Menu" 
  else
    echo "Error,this table is not exist"
  fi

 
}
UpdateTable()
{

    echo 'update '
    read -p "Enter Name of Table you want to update in: " table_name
    if [[ -e $table_name  ]] ; then 
          echo "Column Names"
          i=1
          num_of_fields=`head -1 $table_name"_metadata" | tr ':' ' ' | wc -w`
          
          while (( $i <= $num_of_fields ))
          do
            columnName=`head -1 $table_name"_metadata"| cut -d: -f $i `
            echo $i"-" $columnName 
            ((i=$i+1))
          done  
          read -p "Enter the number of column you want to update: " num

          while (( $num <= $num_of_fields ))
          do
            if (( $num == 1 )) ; then 
                column_type=`tail -1 $table_name"_metadata" | cut -d: -f $num`
                read -p "Enter the word you want to update: " old
                if [[ $column_type == "string" ]] ; then
                  if [[ $old =~ [a-zA-Z] ]] ; then 
                    if (( `awk -F : 'BEGIN{ count=0 }{ if ( $1 == "'$old'" ){ count++ } } END { print count}' $table_name` > 0 )) ; then  # old mwgoda wla l2
                          read -p "Enter the new word : " new
                          if (( `awk -F : 'BEGIN{ count=0 }{ if ( $1 == "'$new'" ){ count++ } } END { print count}' $table_name` > 0 )) ; then
                            echo "Error, repeated in primary key column"
                          else
                              if [[ $new =~ [a-zA-Z] ]] ; then 
                              sed -i 's/'$old'/'$new'/g' $table_name
                              echo "New word is updated successfully"
                              break
                            else
                            echo "Data type not matched"
                            fi   
                          fi 
                    else
                      echo "Word doesn't exist in the column"
                    fi
                  else
                      echo "datatype must be string"
                  fi
                else
                  if [[ $column_type == "int" ]] ; then
                      if [[ $old =~ [0-9] ]] ; then 
                        if (( `awk -F : 'BEGIN{ count=0 }{ if ( $'$num' == "'$old'" ){ count++ } } END { print count}' $table_name` > 0 )) ; then
                            read -p "Enter the new word : " new 
                            if (( `awk -F : 'BEGIN{ count=0 }{ if ( $1 == "'$new'" ){ count++ } } END { print count}' $table_name` > 0 )) ; then
                              echo "Error, repeated in primary key column"
                            else
                              if [[ $new =~ [0-9] ]] ; then 
                                sed -i 's/'$old'/'$new'/g' $table_name
                                echo "New word is updated successfully"
                                break
                              else
                                echo "Data type not matched"
                              fi
                            fi
                        else
                          echo "Word doesn't exist in the column"
                        fi
                      else
                        echo "datatype must be int"
                      fi
                  else
                    echo "Invalid data type not int or string"
                  fi
                fi  
            else
                column_type=`tail -1 $table_name"_metadata" | cut -d: -f $num`
                read -p "Enter the word you want to update: " old
                if [[ $column_type == "string" ]] ; then
                  if [[ $old =~ [a-zA-Z] ]] ; then 
                    if (( `awk -F : 'BEGIN{ count=0 }{ if ( $'$num' == "'$old'" ){ count++ } } END { print count}' $table_name` > 0 )) ; then  # old mwgoda wla l2
                          read -p "Enter the new word : " new
                          if [[ $new =~ [a-zA-Z] ]] ; then 
                              sed -i 's/'$old'/'$new'/g' $table_name
                              echo "New word is updated successfully"
                              break
                          else
                            echo "Data type not matched"
                          fi    
                    else
                      echo "Word doesn't exist in the column"
                    fi
                  else
                      echo "datatype must be string"
                  fi
                else
                  if [[ $column_type == "int" ]] ; then
                      if [[ $old =~ [0-9] ]] ; then 
                        if (( `awk -F : 'BEGIN{ count=0 }{ if ( $'$num' == "'$old'" ){ count++ } } END { print count}' $table_name` > 0 )) ; then
                          read -p "Enter the new word : " new
                            if [[ $new =~ [0-9] ]] ; then 
                              sed -i 's/'$old'/'$new'/g' $table_name
                              echo "New word is updated successfully"
                              break
                          else
                            echo "Data type not matched"
                          fi
                        else
                          echo "Word doesn't exist in the column"
                        fi
                      else
                        echo "datatype must be int"
                      fi
                  else
                    echo "Invalid data type not int or string"
                  fi
                fi  
            fi
          done
    else
      echo "Error,this table doesn't exist"
    fi
    
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
          echo "Return to Select Menu" 
        ;;
        selectColumn )
          
          i=1
          num_of_fields=`head -1 $table_name"_metadata" | tr ':' ' ' | wc -w`
          echo "Column name:"
          while (( $i <= $num_of_fields ))
          do
            columnName=`head -1 $table_name"_metadata"| cut -d: -f $i `
            echo $i"-" $columnName 

            ((i=$i+1))
          done  

          read -p 'Enter number of column:' num
          if [[ $num =~ [1-9] ]]  ; then
            if (( $num <= $num_of_fields )) ; then

                head -1 $table_name"_metadata"| cut -d: -f $num
                echo "-----"
                cut -d : -f $num $table_name
                echo "Return to Select Menu" 
                
            else
                echo "Invalid column number"
            fi 
          else
             echo "Error, Invalid number"
          fi
              
        ;;
        selectRow ) 
          i=1
          num_of_fields=`head -1 $table_name"_metadata" | tr ':' ' ' | wc -w`
          echo "Column name:"
          while (( $i <= $num_of_fields ))
          do
            columnName=`head -1 $table_name"_metadata"| cut -d: -f $i `
            echo $i"-" $columnName 

            ((i=$i+1))
          done 
          read -p 'Enter number of column name:' input
          while ! [[ $input =~ [1-9] ]]
          do
           echo "Error,column name must be int"
           read -p 'Enter number of column name again:' input
          done
          
          if (( $input <= $num_of_fields )) ; then 
            read -p 'Enter data :' data
            newvar=`cut -d: -f $input $table_name|grep -x $data | wc -l `
            if (( $newvar > 0 )) ; then 
              grep $data $table_name 
               echo "Return to Select Menu" 
            else
              echo "Error,Data doesn't exist"
            fi
          else
              echo "Error,choose number from list"
          fi

        ;;
        exit ) 
          echo "Return to Table Menu" 
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
         if  [[ $data =~ [1-9] ]]  ; then
            newvar=`cut -d : -f 1 $table_name| grep $data| wc -l `
            if (( $newvar > 0 )) ; then 
                record_num=`awk -F':' '{if($1=='$data'){print NR}}' "$table_name"`
                sed -i ''$record_num'd' $table_name #override modification in file
                echo "This record is deleted successfully"
                echo "Return to Delete Menu" 
            else
                echo "Error, data doesn't exist"
            fi
         elif [[ $data =~ [a-zA-Z] ]] ; then 
              newvar=`cut -d : -f 1 $table_name| grep $data| wc -l `
              if (( $newvar > 0 )) ; then 
                  record_num=`awk -F':' '{if($1=="'$data'"){print NR}}' "$table_name"`
                  sed -i ''$record_num'd' $table_name #override modification in file
                  echo "This record is deleted successfully"
                  echo "Return to Delete Menu" 
              else
                  echo "Error, data doesn't exist"
              fi
         else
              echo "Error,data is not string or int"
            # echo "ID must be int"
         fi
        ;;
        exit ) 
          echo "Return to Table Menu" 
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







