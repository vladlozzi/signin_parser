Клас, за допомогою якого можна залогінитися на сайті 
catalogs.vladloz.pp.ua та зібрати в масив 
тексти елементів із CSS-класом 
TeacherSubject (дисципліни, які ведуть викладачі кафедри).

# Методи

sign_in(url, login, password, enter, quit)

Для залогінювання на сайті;
повертає рядок повідомлення про помилку, 
якщо неможливо відкрити сайт.

parse_subjects

Для збирання в масив елементів з класом "TeacherSubject"
на веб-сторінці після залогінювання і вибору радіокнопки;
повертає масив рядків, якщо зібрано успішно, 
в іншому разі - порожній масив.

sign_out(quit)

Для вилогінювання з сайту. 

# Приклад використання

Залогінитися на сайті як викладач і вибрати всі дисципліни, 
які веде його кафедра у весняному семестрі.

url = 'https://catalogs.vladloz.pp.ua'

login = 'teacher_128'

password = 'teacher_128_pass'

enter = 'Вхід'

quit = 'Вийти'

signin_parse = SigninParse.new

signin_parse.sign_in url, login, password, enter, quit

p signin_parse.parse_subjects
