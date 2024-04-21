CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    MembershipDate DATE NOT NULL
)

CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(100) NOT NULL,
    ISBN VARCHAR(100) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    ShelfLocation VARCHAR(100) NOT NULL,
	PublishedDate Date NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    CurrentStatus VARCHAR(100) NOT NULL DEFAULT 'Available' CHECK (CurrentStatus IN ('Available', 'Borrowed'))
)

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY IDENTITY(1,1),
    BookID INT NOT NULL,
    BorrowerID INT NOT NULL,
    DueDate DATE NOT NULL,
    DateReturned DATE DEFAULT NULL,
    DateBorrowed DATE NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
)
