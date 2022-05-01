## Problem

Display all foreign key relationships between schema tables along with the number of users who have privileges to delete rows from the main table, and the rule for deleting rows from the child table when deleting rows of the main table.

The result should contain 4 columns:

1) the name of the child table, connected through a dot with the name of the column of the foreign key of the child table;
2) the name of the main table, connected through a dot with the name of the column of the primary key of the main table;
3) the number of users who have privileges to delete rows from the main table;
4) the rule of deleting rows.

Example of the result:

<img src="https://user-images.githubusercontent.com/76550825/166147383-5fe11aa1-9d62-4fd3-be7a-ada304634205.png" width="495" height="114">

## Testing

Foreign key relationship:

![image](https://user-images.githubusercontent.com/76550825/166147448-07a3712a-e78a-4048-b906-112c86e8fef0.png)

With recursive relationship (cust.fk and supp.pk: employees.director and employees.id):

![image](https://user-images.githubusercontent.com/76550825/166147463-9dcc238f-156f-4eb4-9b49-71bd10c894ca.png)

