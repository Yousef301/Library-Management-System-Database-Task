import csv
import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker()


# Generate Books data
def generate_books(num_books):
    books = []
    for _ in range(num_books):
        book = {
            'Title': fake.catch_phrase(),
            'Author': fake.name(),
            'ISBN': fake.isbn13(),
            'PublishedDate': fake.date_between(start_date='-50y', end_date=datetime.now().date()),
            'Genre': random.choice(['Fiction', 'Non-Fiction', 'Science Fiction', 'Mystery', 'Fantasy']),
            'ShelfLocation': 'Shelf ' + str(random.randint(1, 10)),
            'CurrentStatus': 'Available'
        }
        books.append(book)
    return books


# Generate Borrowers data
def generate_borrowers(num_borrowers):
    borrowers = []
    for _ in range(num_borrowers):
        borrower = {
            'FirstName': fake.first_name(),
            'LastName': fake.last_name(),
            'Email': fake.email(),
            'DateOfBirth': fake.date_of_birth(minimum_age=18, maximum_age=90),
            'MembershipDate': fake.date_between(start_date='-10y', end_date=datetime.now().date())
        }
        borrowers.append(borrower)
    return borrowers


# Generate Loans data
def generate_loans(num_loans, books, borrowers):
    loans = []
    # Control the percentage of returned books (change ratio as needed)
    returned_ratio = 0.7  # 70% of loans will have a return date

    for _ in range(num_loans):
        book = random.choice(books)
        borrower = random.choice(borrowers)

        # Random date between -5 years and today for older loans
        older_date = fake.date_between(start_date='-5y', end_date=datetime.now().date())

        # Random date between today and -1 year for newer loans
        newer_date = fake.date_between(start_date='-1y', end_date=datetime.now().date())

        # Choose randomly between older and newer dates
        date_borrowed = random.choice([older_date, newer_date])

        due_date = date_borrowed + timedelta(days=random.randint(14, 44))

        # Generate a random return date within the loan period (based on ratio)
        if random.random() < returned_ratio:  # Generate return date with the set ratio
            max_return_date = min(due_date, datetime.now().date())
            return_date = fake.date_between(start_date=date_borrowed, end_date=max_return_date)
        else:
            return_date = None  # No return date for unreturned books

        loan = {
            'BookID': books.index(book) + 1,
            'BorrowerID': borrowers.index(borrower) + 1,
            'DateBorrowed': date_borrowed,
            'DueDate': due_date,
            'DateReturned': return_date
        }

        # Update book status based on return date
        if return_date:
            books[books.index(book)]['CurrentStatus'] = 'Available'  # Update if returned
        else:
            books[books.index(book)]['CurrentStatus'] = 'Borrowed'  # Update if not returned

        loans.append(loan)
    return loans


# Function to save data to CSV file
def save_to_csv(data, filename):
    with open(filename, 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = data[0].keys()
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()
        for row in data:
            writer.writerow(row)


# Generate datasets
num_books = 1000
num_borrowers = 1000
num_loans = 1000

books = generate_books(num_books)
borrowers = generate_borrowers(num_borrowers)
loans = generate_loans(num_loans, books, borrowers)

# Save data to CSV files
save_to_csv(books, 'books.csv')
save_to_csv(borrowers, 'borrowers.csv')
save_to_csv(loans, 'loans.csv')

print("CSV files generated successfully.")
