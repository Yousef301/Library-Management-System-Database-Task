-- Indexing Loans table
CREATE NONCLUSTERED INDEX FK_book_id ON Loans(BookID);
CREATE NONCLUSTERED INDEX FK_borrower_id ON Loans(BorrowerID);
CREATE NONCLUSTERED INDEX IDX_date_returned ON Loans(DateReturned);
CREATE NONCLUSTERED INDEX IDX_date_borrowed ON Loans(DateBorrowed);

-- Indexing Books table
CREATE NONCLUSTERED INDEX IDX_author ON Books(Author);