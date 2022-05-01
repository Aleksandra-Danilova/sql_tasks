## Problem

Display the names of employees, their salaries, the department ID and not a dense rank  of salaries within the department, where the employee works.
Rank 1 should be at the maximum salary.

Ranks are assigned according to the position of each unique salary value in the general salary list, therefore, there may be "holes" in the sequence of rank values (a Landry employee has a salary rank of 14, since his salary is in 13th place in the general list of department salaries sorted in ascending order 50, and there is no salary with a rank of 12 at all, so as in the 2nd and 3rd place — the same salaries, which are assigned the rank of 11).

Example of the result:

<img src="https://user-images.githubusercontent.com/76550825/166149084-5705c17b-9bb1-49b5-a619-c46aa318fe60.png" width="553" height="253">

## Testing

107 rows selected

![image](https://user-images.githubusercontent.com/76550825/166149096-df815f69-f8ae-4887-817b-9c31404f0f2c.png)

![image](https://user-images.githubusercontent.com/76550825/166149102-0816df2d-503d-4f5a-baf7-d844c77a481f.png)

![image](https://user-images.githubusercontent.com/76550825/166149104-8b81cf25-bd43-44cf-885b-101e2fd73a2e.png)
