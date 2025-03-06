%Долбня Н.
% студент(ID-студента, прізвище, рік вступу)
студент(1, пертенко, 2019).
студент(2, мельник, 2019).
студент(3, сидоренко, 2021).
студент(4, іванов, 2021).
студент(5, прохорова, 2022).
студент(6, коваленко, 2024).
студент(7, ятенко, 2024).

% сорт(ID-сорта, назва, вартість за кг)
сорт(1, семеренко, 25).
сорт(2, сортове, 30).
сорт(3, джонотан, 40).
сорт(4, голден, 40).
сорт(5, слава, 40).
сорт(6, червоне, 55).
сорт(7, мілке, 55).

% купив(ID-студента, ID-сорта)
купив(1,1).
купив(1,2).
купив(1,3).
купив(2,6).
купив(2,7).
купив(3,1).
купив(3,3).
купив(3,5).
купив(3,7).
купив(4,1).
купив(5,3).
купив(5,4).
купив(5,5).
купив(6,6).
купив(6,7).

%Вивести студентів, які купила усі сорти певної ціни N
купили_усі_за_ціною(N, Прізвище, Рік) :-
    студент(StudentID, Прізвище, Рік),
    findall(AppleID, (сорт(AppleID, _, N)), СписокСортів),
    findall(AppleID, купив(StudentID, AppleID), СписокКуплених),
    subset(СписокСортів, СписокКуплених).

купив_усі_за_ціною_без_певних_предикатів(N, Прізвище, Рік) :-
    студент(СтудентID, Прізвище, Рік),
    \+ (сорт(СортID, _, N), \+ купив(СтудентID, СортID)).


% Знаходить студентів, які купили всі сорти певної ціни N і тільки їх
купили_і_тільки_за_ціною_setof(N, Прізвище, Рік) :-
    студент(СтудентID, Прізвище, Рік),
    setof(СортID, сорт(СортID, _, N), УсіСорти), 
    setof(КупленийСорт, купив(СтудентID, КупленийСорт), КупленіСорти), 
    УсіСорти == КупленіСорти. 

купив_і_тільки_за_ціною_без_певних_предикатів(N, Прізвище, Рік) :-
    студент(СтудентID, Прізвище, Рік),
    купив_усі_за_ціною_без_певних_предикатів(N, Прізвище, Рік),
    \+ (купив(СтудентID, ІншийСорт), \+ сорт(ІншийСорт, _, N)). 



% Знаходить студентів, які купили сорти, дешевші або рівні N.
купили_дешевші_рівні_за_N_bagof(N, Прізвище, Рік) :-
    студент(СтудентID, Прізвище, Рік),
    bagof(СортID, (сорт(СортID, _, Ціна), Ціна =< N), УсіДешевшіСорти),  
    bagof(КупленийСорт, купив(СтудентID, КупленийСорт), КупленіСорти), 
    subset(УсіДешевшіСорти, КупленіСорти).

купили_дешевші_рівні_за_N(N, Прізвище, Рік) :-
    студент(СтудентID, Прізвище, Рік),
    сорт(СортID, _, Ціна), Ціна =< N,  
    купив(СтудентID, СортID). 












