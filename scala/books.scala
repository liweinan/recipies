val books = List(Book("PT", "Jim"), Book("UN", "Tom", "Jack"))
books.map { book => { val desc = book.title + "-" ;  desc + book.authors } }
