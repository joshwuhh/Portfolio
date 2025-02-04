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


  
***Account Projection***
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






1. If a Debt or Car Loan balance is **partially paid off** in a month (e.g., only $200 needed instead of the full $500 contribution), the **excess ($300)** is redirected to Savings.
2. If a Debt or Car Loan balance is **fully paid off** (reaches $0), the **entire contribution ($500)** is redirected to Savings in the following month.

---

### Updated Formulas:

#### Savings (`C4:C15`):
In `C4` (starting balance for January):
```excel
= Initial_Savings_Balance + (H5 * H6)
```

In `C5` (February and onward):
```excel
= C4 + (H5 * H6) + IF(F4 < 0, -F4, IF(F4 = 0, H5 * H7, MAX(0, (H5 * H7) - F4))) + IF(F19 < 0, -F19, IF(F19 = 0, H5 * H8, MAX(0, (H5 * H8) - F19)))
```
- `IF(F4 < 0, -F4, IF(F4 = 0, H5 * H7, MAX(0, (H5 * H7) - F4)))`:
  - If Debt balance is **negative**, redirect the excess (`-F4`) to Savings.
  - If Debt balance is **0**, redirect the entire Debt contribution (`H5 * H7`) to Savings.
  - If Debt balance is **positive**, redirect only the excess (`(H5 * H7) - F4`) to Savings.
- `IF(F19 < 0, -F19, IF(F19 = 0, H5 * H8, MAX(0, (H5 * H8) - F19)))`:
  - If Car Loan balance is **negative**, redirect the excess (`-F19`) to Savings.
  - If Car Loan balance is **0**, redirect the entire Car Loan contribution (`H5 * H8`) to Savings.
  - If Car Loan balance is **positive**, redirect only the excess (`(H5 * H8) - F19`) to Savings.

Copy this formula down to `C15`.

---

#### Debt (`F4:F15`):
In `F4` (starting balance for January):
```excel
= Initial_Debt_Balance - (H5 * H7)
```

In `F5` (February and onward):
```excel
= IF(F4 <= 0, 0, MAX(0, F4 - (H5 * H7)))
```
- If Debt balance is **0 or negative**, it remains at `0`.
- If Debt balance is **positive**, it is reduced by the contribution (`H5 * H7`), but never goes below `0`.

Copy this formula down to `F15`.

---

#### Car Loan (`F19:F30`):
In `F19` (starting balance for January):
```excel
= Initial_Car_Loan_Balance - (H5 * H8)
```

In `F20` (February and onward):
```excel
= IF(F19 <= 0, 0, MAX(0, F19 - (H5 * H8)))
```
- If Car Loan balance is **0 or negative**, it remains at `0`.
- If Car Loan balance is **positive**, it is reduced by the contribution (`H5 * H8`), but never goes below `0`.

Copy this formula down to `F30`.

---

### Example Walkthrough:
Let’s assume:
- **Total Funds Available (`H5`)**: $1,000
- **Savings Percentage (`H6`)**: 50% (0.5)
- **Debt Percentage (`H7`)**: 30% (0.3)
- **Car Loan Percentage (`H8`)**: 20% (0.2)

#### September:
- Debt balance at the start of September: $200
- Contribution to Debt: $300 (30% of $1,000)
- Excess from Debt: `MAX(0, 300 - 200) = 100`
- Savings contribution: `500 (normal) + 100 (excess from Debt) = 600`
- Debt balance at the end of September: `MAX(0, 200 - 300) = 0`

#### October:
- Debt balance at the start of October: $0
- Contribution to Debt: $300 (30% of $1,000)
- Redirected to Savings: $300 (entire Debt contribution)
- Savings contribution: `500 (normal) + 300 (redirected from Debt) = 800`
- Debt balance at the end of October: `0`

---

### Key Points:
1. If Debt or Car Loan balances are **partially paid off**, only the **excess contribution** is redirected to Savings.
2. If Debt or Car Loan balances are **fully paid off**, the **entire contribution** is redirected to Savings.
3. Balances for Debt and Car Loan never go below `0`.
