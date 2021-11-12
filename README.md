Клас, за допомогою якого можна залогінитися на сайті 
catalogs.vladloz.pp.ua та зібрати в масив тексти елементів із певним CSS-класом,
наприклад, TeacherContact (контакти викладачів) 
або TeacherSubject (дисципліни, які викладачі ведуть).

# Методи

sign_in(url, login, password, enter)

Для залогінювання на сайті;
повертає false, якщо неможливо відкрити сайт.

parse(class_to_parse, radio)

Для збирання в масив елементів з певним класом
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

signin_parse = SigninParse.new

signin_parse.sign_in url, login, password, enter

p signin_parse.parse 'TeacherSubject', ''
