CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    availability BOOLEAN DEFAULT TRUE
);
INSERT INTO books (title, author, genre, availability) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', TRUE),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', TRUE),
('1984', 'George Orwell', 'Dystopian', TRUE),
('Moby Dick', 'Herman Melville', 'Adventure', TRUE),
('War and Peace', 'Leo Tolstoy', 'Historical', TRUE);

CREATE TABLE borrowers (
    borrower_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);
INSERT INTO borrowers (name, email, phone) VALUES
('John Doe', 'john.doe@example.com', '123-456-7890'),
('Jane Smith', 'jane.smith@example.com', '234-567-8901'),
('Emily Davis', 'emily.davis@example.com', '345-678-9012');

CREATE TABLE transactions(
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    borrower_id INT,
    book_id INT,
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (borrower_id) REFERENCES borrowers(borrower_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO transactions (borrower_id, book_id, issue_date, return_date) VALUES
(1, 1, '2024-10-01', NULL), 
(2, 3, '2024-10-02', '2024-10-05'), 
(3, 2, '2024-10-03', NULL); 

select * from books;
drop table books;
select * from borrowers;
drop table borrowers;
select * from transactions ;
drop table transactions ;

SELECT * FROM books WHERE availability = TRUE;

SELECT b.name, b.email, t.book_id, bk.title, t.issue_date 
FROM transactions t
JOIN borrowers b ON t.borrower_id = b.borrower_id
JOIN books bk ON t.book_id = bk.book_id
WHERE t.return_date IS NULL;

SELECT b.name, bk.title, t.issue_date, t.return_date
FROM transactions t
JOIN borrowers b ON t.borrower_id = b.borrower_id
JOIN books bk ON t.book_id = bk.book_id
WHERE b.name = 'John Doe';

UPDATE transactions 
SET return_date = CURDATE()
WHERE transaction_id = 1; -- Replace with the actual transaction_id

UPDATE books 
SET availability = TRUE
WHERE book_id = (SELECT book_id FROM transactions WHERE transaction_id = 1); -- Replace with the actual transaction_id

SELECT t.transaction_id, b.name, bk.title, t.issue_date, t.return_date
FROM transactions t
JOIN borrowers b ON t.borrower_id = b.borrower_id
JOIN books bk ON t.book_id = bk.book_id;

