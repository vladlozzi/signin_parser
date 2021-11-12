Клас, за допомогою якого можна залогінитися на сайті 
та зібрати в масив тексти елементів із певним CSS-класом,
наприклад, TeacherContact (контакти викладачів) 
або TeacherSubject (дисципліни, які викладачі ведуть).

# Методи

sign_in(url, sign_options)

Для залогінювання на сайті;
повертає false, якщо неможливо залогінитися з будь-якої
причини.

parse(class_to_parse, parse_options)

Для збирання в масив елементів з певним класом
на веб-сторінці після залогінювання;
повертає масив рядків, якщо зібрано успішно, 
в іншому разі - порожній масив.

sign_out(exit_options)

Для вилогінювання з сайту; 
повертає false, якщо неможливо вилогінитися 
з будь-якої причини.

# Приклад використання

Залогінитися на сайті як викладач і вибрати всі дисципліни, 
які веде його кафедра у весняному семестрі.

url = 'https://catalogs.vladloz.pp.ua'

sign_options = Hash.new

sign_options[:login_field_name] = 'login'

sign_options[:login] = 'teacher_128'

sign_options[:password_field_name] = 'psswd'

sign_options[:password] = 'teacher_128_pass'

sign_options[:submit_name] = 'enter'

sign_options[:submit] = 'Вхід'

signin_parse = SigninParse.new

signin_parse.sign_in url, sign_options

parse_options = Hash.new

parse_options[:radio_id] = 'depart_subj_spring'

p signin_parse.parse "TeacherSubject", parse_options
