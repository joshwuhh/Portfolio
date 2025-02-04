Started with distributions
This area allowed users to enter items into categories along with the amount of money that went towards them each month to see totals
- Began with table that calculated residual income after needs, wants, debts and savings from different tables
- Created pie chart that displayed the share of income that went toward each category
- Seperated user input tables from pre and post tax funds
- Streamlined tables to allow for minimal input from user (Hourly salary and tax rate)
- Expanded on table showing totals for each category. There was now a table that showed amounts to spend biweekly on each category (pay schedule)
- Implemented a table to calculate the relative percentage of post tax income that is being saved each month (sum of all tables that include putting money away like savings, investments, retirement accounts) /(monthly income - tax rate)
      Some use pretax for this calculation but I chose post 
- Created table that took the entered value for Housing and gave you the percent of Pretax income that goes towards it
     (Pre tax income is the standard when calculating housing costs)
- Added conditionally formatted cell which displayed green or red, given the users housing cost is above the reccomended 2.5x housing requirement
      Giving users visual insight into if their spending too much on housing
- Enhanced the 401k table to allow user to simply add their monthly contribution, automatically editing the take home income based on the percent they deduct pretax
- Expanded further on this by adding a cell that calculates total employer match
      At a max of 6% contribution, with an employer match of 50% up to 3%
- Created table which gave total amount saved from all accounts and gave what those amounts could look like in 1 & 5 years, given an average return on investment of 7%


  
Debt projection tab
taught me why coding is so inmportant
on a smaller set of data this is doable but incredibly tedious
Having variables and constants would have made this process far easier
- Difference for the added payments that would have gone towards debt will need it's own if statement to check to ensure the returned value is accurate
        Found that in the case of the first occurence where the leading month is negative and the previous month wasn't (Free 0 balance occurence on the debt)
        the returned value was giving a larger value
              IE: -(300- (-200)) results in
Mock flowchart...


   Is debt negative? -> Yes -> Was it negative last month? -> Yes -> Is car negative? -> Yes -> Savings rate  + Previous Savings + Car rate ( + Debt


   Is debt negative? -> Yes -> Was it negative last month? -> No -> Debt Rate - Previous month ->  Is car negative? -> Yes -> Was it negative last month? -> Y Savings rate  + Previous Savings + Car rate ( + Debt

Moved over to VSCode to write functions
