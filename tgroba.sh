
CreateTable ()
{
    echo 'create table'
}
ListTable()
{
    echo 'list tables'
}
DropTable ()
{
    echo 'drop table '
}
InsertInTable ()
{
    echo 'insert'
}
UpdateTable()
{
    echo 'update '
}
SelectFromTable ()
{
    echo 'select '
}
DeleteFromTable ()
{
    echo 'ldelete'
}
MainMenu ()
{
    echo 'Welcome back to main menu'
}
select i in  "Create Table" "List Table"  "Drop Table" "Insert In To Table" "Select From Table" "Delete From Table" "Update Table"  "Main Menu" exit
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
        exit ) 
           break
        ;;
    esac
done




