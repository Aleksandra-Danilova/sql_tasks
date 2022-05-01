## Problem
Using the data dictionary, get information about the primary keys and child tables of all tables in schema.

In lists, the names of columns and child tables should be separated by commas alphabetically. 

Solve the problem without using the Listagg and Wm_concat functions.

![image](https://user-images.githubusercontent.com/76550825/166145522-7793f3d1-5d98-480a-8b90-6dd2ed9837c0.png)

## Testing

If there are no child tables, then the corresponding message is displayed.

There are totally 64 tables in my current scheme
(
  SELECT COUNT(table_name)
  FROM user_tables;
). In this case, the result is:

![image](https://user-images.githubusercontent.com/76550825/166145585-77c2ff8d-a19d-4d10-af58-7fd4d558bb55.png)

![image](https://user-images.githubusercontent.com/76550825/166145596-436169ef-cd77-413a-ba09-8d7e00716b00.png)

There are 65 tables in the other scheme, so the result is:

![image](https://user-images.githubusercontent.com/76550825/166145634-493f9be8-fa84-4882-a395-f1f605b79bbb.png)

![image](https://user-images.githubusercontent.com/76550825/166145640-e2e22070-5e47-471f-93aa-3796d7460a30.png)



