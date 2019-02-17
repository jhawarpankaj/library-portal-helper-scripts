import os

books_csv_path = '/home/pankaj/Desktop/Spring2019-Lectures/DatabaseDesign/Assignment/Assignment1/elearing-notes-prof/books.csv'
borrowers_csv_path = '/home/pankaj/Desktop/Spring2019-Lectures/DatabaseDesign/Assignment/Assignment1/elearing-notes-prof/borrowers.csv'
books_table_normalize_data = '/var/lib/mysql-files/assignment1/books_normalized.csv' #SHOW VARIABLES LIKE "secure_file_priv";
authors_table_normalize_data = '/var/lib/mysql-files/assignment1/authors_normalized.csv'
book_authors_table_normalize_data = '/var/lib/mysql-files/assignment1/book_authors_normalized.csv'
borrowers_table_normalize_data = '/var/lib/mysql-files/assignment1/borrowers_normalized.csv'

file_csv_original = open(books_csv_path, "r")

# Normalizing data for books table
if os.path.isfile(books_table_normalize_data):
    os.remove(books_table_normalize_data)

file_books_normalized = open(books_table_normalize_data, "w")
lines=file_csv_original.readlines()
for x in lines:
    file_books_normalized.write(x.split('\t')[0] + "\t" + x.split('\t')[2] + "\n")
file_books_normalized.close()

# Normalizing data for AUTHORS table
file_csv_original.seek(0, 0)
if os.path.isfile(authors_table_normalize_data):
    os.remove(authors_table_normalize_data)

file_authors_normalized = open(authors_table_normalize_data, "w")
lines=file_csv_original.readlines()
author_set = set()
for x in lines:
    temp = x.split('\t')[3]
    for y in temp.split(","):
        if y.upper() not in author_set and y != '':
            author_set.add(y.upper())
for x in author_set:
    file_authors_normalized.write(x + "\n")
file_authors_normalized.close()

# Normalizing data for BOOK_AUTHORS table
file_csv_original.seek(0, 0)
if os.path.isfile(book_authors_table_normalize_data):
    os.remove(book_authors_table_normalize_data)

file_book_authors_normalized = open(book_authors_table_normalize_data, "w")
lines=file_csv_original.readlines()
book_authors_dict = {}

for x in lines:
    isbn = x.split("\t")[0]
    author_name = x.split("\t")[3]
    for name in author_name.split(","):
        if name != '':
            if isbn not in book_authors_dict.keys():
                temp_list1 = list()
                temp_list1.append(name)
                book_authors_dict[isbn] = temp_list1
            else:
                print(book_authors_dict[isbn])
                temp_list2 = book_authors_dict[isbn]
                if name not in temp_list2:
                    temp_list2.append(name)
                    book_authors_dict[isbn] = temp_list2

for isbn, list_of_authors in book_authors_dict.items():
    for name in list_of_authors:
        file_book_authors_normalized.write(isbn + "\t" + name.upper() + "\n")

file_book_authors_normalized.close()
file_csv_original.close()

# Normalizing data for Borrowers table
file_borrowers_original = open(borrowers_csv_path, "r")

if os.path.isfile(borrowers_table_normalize_data):
    os.remove(borrowers_table_normalize_data)

file_borrowers_normalized = open(borrowers_table_normalize_data, "w")
lines=file_borrowers_original.readlines()
for x in lines:
    records = x.split(",")
    card_id = records[0]
    ssn = records[1]
    bname = records[2] + " " + records[3]
    address = records[5] + " " + records[6] + " " + records[7]
    phone = records[8]
    file_borrowers_normalized.write(card_id + "," + ssn + "," + bname.upper()
                                    + "," + address.upper() + "," + phone)
file_borrowers_normalized.close()
file_borrowers_original.close()
