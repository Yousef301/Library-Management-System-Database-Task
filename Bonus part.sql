-- Query for -> Weekly peak days: The library is planning to employ a new part-time worker.
-- This worker will work 3 days weekly in the library. From the data you have, determine the
-- most 3 days in the week that have the most share of the loans and display the result of 
-- each day as a percentage of all loans. Sort the results from the highest percentage to 
-- the lowest percentage. (e.g. 25.18% of the loans happen on Monday...)


SELECT DATENAME(dw, DateBorrowed) DayName,
  COUNT(*) TotalBorrowed,
  FORMAT((COUNT(*) * 100.0)/ (SELECT COUNT(*) FROM Loans), 'N2') AS Percentage FROM Loans
GROUP BY DATENAME(dw, DateBorrowed)
ORDER BY Percentage DESC
