% Library Book Recommendation System

% ---------------- FACTS ----------------

% book(Title, Genre, Pages, Author, Rating, Year)

book(atomic_habits, self_help, 320, clear, 5, 2018).
book(deep_work, self_help, 296, newport, 4, 2016).
book(power_of_habit, self_help, 371, duhigg, 4, 2012).

book(sapiens, history, 443, harari, 5, 2011).
book(guns_germs_steel, history, 480, diamond, 4, 1997).
book(silk_roads, history, 522, frankopan, 3, 2015).

book(clean_code, tech, 464, martin, 5, 2008).
book(pragmatic_programmer, tech, 352, hunt, 4, 1999).
book(refactoring, tech, 448, fowler, 4, 1999).

book(harry_potter1, fiction, 309, rowling, 5, 1997).
book(hobbit, fiction, 310, tolkien, 5, 1937).
book(1984, fiction, 328, orwell, 5, 1949).
book(animal_farm, fiction, 112, orwell, 4, 1945).

book(rich_dad_poor_dad, finance, 336, kiyosaki, 3, 1997).
book(psychology_of_money, finance, 256, housel, 5, 2020).
book(intelligent_investor, finance, 623, graham, 4, 1949).


% Author countries

author_country(clear, usa).
author_country(newport, usa).
author_country(duhigg, usa).
author_country(harari, israel).
author_country(diamond, usa).
author_country(frankopan, uk).
author_country(martin, usa).
author_country(hunt, usa).
author_country(fowler, uk).
author_country(rowling, uk).
author_country(tolkien, uk).
author_country(orwell, uk).
author_country(kiyosaki, usa).
author_country(housel, usa).
author_country(graham, uk).


% Page limits for each genre

limit(self_help, 350).
limit(history, 500).
limit(tech, 400).
limit(fiction, 350).
limit(finance, 300).


% Favourite genres

favourite(self_help).
favourite(fiction).
favourite(tech).


% ---------------- RULES ----------------

% Checks if the book is within the page limit

quick_read(Book) :-
    book(Book, Genre, Pages, _, _, _),
    limit(Genre, MaxPages),
    Pages =< MaxPages.


% Rating of 4 or 5

well_rated(Book) :-
    book(Book, _, _, _, Rating, _),
    Rating >= 4.


% Books published before 2000

classic(Book) :-
    book(Book, _, _, _, _, Year),
    Year < 2000.


% Books published in 2000 or later

recent(Book) :-
    book(Book, _, _, _, _, Year),
    Year >= 2000.


% Rating is 5

masterpiece(Book) :-
    book(Book, _, _, _, 5, _).


% Books written by British authors

british_author_book(Book) :-
    book(Book, _, _, Author, _, _),
    author_country(Author, uk).


% Books from favourite genres

in_favourite_genre(Book) :-
    book(Book, Genre, _, _, _, _),
    favourite(Genre).


% Suggested if it is short enough and has a good rating

suggested(Book) :-
    quick_read(Book),
    well_rated(Book).


% Top pick if it is suggested and from a favourite genre

top_pick(Book) :-
    suggested(Book),
    in_favourite_genre(Book).


% Books which are not well rated

skippable(Book) :-
    book(Book, _, _, _, _, _),
    \+ well_rated(Book).


% Books which are over the page limit

long_read(Book) :-
    book(Book, Genre, Pages, _, _, _),
    limit(Genre, MaxPages),
    Pages > MaxPages.


% Get books from a particular genre

genre_books(Book, Genre) :-
    book(Book, Genre, _, _, _, _).


% Get books written by an author

author_books(Book, Author) :-
    book(Book, _, _, Author, _, _).


% Count books in a genre

genre_count(Genre, Count) :-
    findall(B, genre_books(B, Genre), List),
    length(List, Count).


% ---------------- DISPLAY ----------------

% Show details of a book

show_book(Book) :-
    book(Book, Genre, Pages, Author, Rating, Year),
    write('Title   : '), write(Book), nl,
    write('Genre   : '), write(Genre), nl,
    write('Pages   : '), write(Pages), nl,
    write('Author  : '), write(Author), nl,
    write('Rating  : '), write(Rating), write('/5'), nl,
    write('Year    : '), write(Year), nl,
    write('-----------------------------'), nl.


% Show all suggested books

show_suggestions :-
    write('====================================='), nl,
    write(' SUGGESTED BOOKS FOR YOU'), nl,
    write('====================================='), nl,
    suggested(Book),
    show_book(Book),
    fail.

show_suggestions :-
    write('Done going through suggestions.'), nl.


% Show all top picks

show_top_picks :-
    write('====================================='), nl,
    write(' TOP PICKS (favourite genre + suggested)'), nl,
    write('====================================='), nl,
    top_pick(Book),
    show_book(Book),
    fail.

show_top_picks :-
    write('Done going through top picks.'), nl.
