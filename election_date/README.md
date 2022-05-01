## Problem

In 1845, a tradition was established in the United States, according to which presidential elections are held on the Tuesday after the first Monday in November in a year divided by 4 without remainder.
Determine the date of the US presidential election closest to the specified date.

Examples of the result, where the first column contains input date and the second column contains date of elections:

<img src="https://user-images.githubusercontent.com/76550825/166147729-2412b260-f9c6-474b-8d70-90dd5411c446.png" width="451" height="81">

## Testing

1. The year is not a multiple of 4.

![image](https://user-images.githubusercontent.com/76550825/166147797-2f452ca2-120a-4867-9904-e3246b1f1b8f.png)

![image](https://user-images.githubusercontent.com/76550825/166147799-788da741-dfba-47ce-9b7e-0ba26273d9dc.png)

2. The year is a multiple of 4; the date is less than the election day of the specified year.

![image](https://user-images.githubusercontent.com/76550825/166147808-8d36be15-ca23-49ee-ab19-7fa21a8b8588.png)

![image](https://user-images.githubusercontent.com/76550825/166147810-03432591-3067-4eab-9f9d-ee72d179ee14.png)

3. The year is a multiple of 4; election day.

![image](https://user-images.githubusercontent.com/76550825/166147817-8f82a5b7-d00b-467e-b443-12da149dfc9e.png)

![image](https://user-images.githubusercontent.com/76550825/166147819-70f24e28-2fb6-4c95-8f15-25f5090289e2.png)

4. The year is a multiple of 4; after the election day of the given year.

![image](https://user-images.githubusercontent.com/76550825/166147831-72cf3aca-e6ee-4102-bf25-02529dab2dc4.png)

![image](https://user-images.githubusercontent.com/76550825/166147835-b70a37ac-6ae6-44a7-b3a8-cc8e36b085b7.png)

5. The case when the first Monday in November is 01.11.

![image](https://user-images.githubusercontent.com/76550825/166147851-e1f71a11-e693-412c-9318-bb066e856c22.png)

![image](https://user-images.githubusercontent.com/76550825/166147854-645b78c6-7ff4-4446-896a-7c1423576969.png)
