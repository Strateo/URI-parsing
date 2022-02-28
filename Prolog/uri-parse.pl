check([]).

verifica(['/' | _]).

is_not_alpha(X) :-
    is_alpha(X),
    !, fail.

is_not_alpha(_) :-
    true, !.

alnum_or_point(X) :-
    char_type(X, alpha),
    true, !.

alnum_or_point(X) :-
    member(X, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']),
    true, !.

alnum_or_point(X) :-
    X = '.',
    true, !.

alnum_id8(X) :-
    char_type(X, alpha),
    true, !.

alnum_id8(X) :-
    member(X, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']),
    true, !.

appendi_par1(ID44, ['(' | RsID44], RisConcat, RsID44) :-
    atom_concat(ID44, '(', RisConcat).

appendi_par2(ID8, [')' | RsID8], RisConcat, RsID8) :-
    atom_concat(ID8, ')', RisConcat).

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsS),
    Scheme = mailto,
    userinfo(RsS, Userinfo, RsU),
    ip(RsU, Host, RsOp),
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsS),
    Scheme = mailto,
    userinfo(RsS, Userinfo, RsU),
    host(RsU, Host, RsOp),
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsS),
    Scheme = mailto,
    identif(RsS, Userinfo, RsOp),
    Host = [],
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsOp),
    Scheme = mailto,
    Userinfo = [],
    Host = [],
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsS),
    Scheme = news,
    host(RsS, Host, RsOp),
    Userinfo = [],
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsS),
    Scheme = news,
    host(RsS, Host, RsOp),
    Userinfo = [],
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsOp),
    Scheme = news,
    Userinfo = [],
    Host = [],
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsS),
    Scheme = tel,
    identif(RsS, Userinfo, RsOp),
    Host = [],
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsOp),
    Scheme = tel,
    Userinfo = [],
    Host = [],
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsS),
    Scheme = fax,
    identif(RsS, Userinfo, RsOp),
    Host = [],
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsOp),
    Scheme = fax,
    Userinfo = [],
    Host = [],
    Port = 80,
    Path = [],
    Query = [],
    Fragment = [],
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsS),
    Scheme = zos,
    authority(RsS, Userinfo, Host, Port, RsUI),
    opzionale_zos(RsUI, Host, Path, Query, Fragment, RsOp),
    check(RsOp), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsS),
    Scheme = zos,
    authority(RsS, Userinfo, Host, Port, RsUI),
    Path = [],
    Query = [],
    Fragment = [],
    check(RsUI), !.

uri_parse(S, uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)):-
    string_chars(S, URI),
    scheme(URI, Scheme, RsS),
    Scheme \= 'mailto',
    Scheme \= 'news',
    Scheme \= 'tel',
    Scheme \= 'fax',
    Scheme \= 'zos',
    authority(RsS, Userinfo, Host, Port, RsUI),
    opzionale(RsUI,Host,Path, Query, Fragment, RsOp),
    check(RsOp), !.

controllo_elementi(' ', _).
controllo_elementi(_,[]).

controllo_elementi(Car, [Car | _]) :-
    !, fail.

controllo_elementi(Car, [_ | Tail]) :-
    controllo_elementi(Car, Tail).

identif([X | Xs], Y, R) :-
    controllo_elementi(X, [':', '?', '#', '/', '@']),
    identif(Xs, Z, R), !,
    atom_concat(X, Z, Y).

identif([X | Xs], X, Xs) :-
    controllo_elementi(X, [':', '?', '#', '/', '@']), !.

identport([X | Xs], Y, R) :-
    member(X, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']),
    identport(Xs, Z, R), !,
    atom_concat(X, Z, Y).

identport([X | Xs], X, Xs):-
    member(X, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']), !.

identifquery([X | Xs], Y, R) :-
    controllo_elementi(X, ['#']),
    identifquery(Xs, Z, R), !,
    atom_concat(X, Z, Y).

identifquery([X | Xs], X, Xs) :-
    controllo_elementi(X, ['#']), !.

identifrag([X | Xs], Y, R) :-
    identifrag(Xs, Z, R), !,
    atom_concat(X, Z, Y).

identifrag([X | Xs], X, Xs) :-
    true, !.

controllo_host(['.' | _], _, _) :-
    !, fail.

controllo_host(X, Y, R) :-
    identificatorehost(X, Y, R).

identificatorehost(['.', '.' | _], _, _) :-
    !, fail.

identificatorehost(['.' | []], _, _) :-
    !, fail.

identificatorehost([X | Xs], Y, R) :-
    controllo_elementi(X, [':', '?', '#', '/', '@']),
    identificatorehost(Xs, Z, R), !,
    atom_concat(X, Z, Y).

identificatorehost([X | Xs], X, Xs) :-
    controllo_elementi(X, [':', '?', '#', '/', '@']), !.

controllo_path(['/' | _], _, _) :-
    !, fail.

controllo_path(X, Y, R) :-
    identificatorepath(X, Y, R).

identificatorepath(['/', '/' | _], _, _) :-
    !, fail.

identificatorepath(['/' | []], _, _) :-
    !, fail.

identificatorepath([X | Xs], Y, R) :-
    controllo_elementi(X, [':', '?', '#', '@']),
    identificatorepath(Xs, Z, R), !,
    atom_concat(X, Z, Y).

identificatorepath([X | Xs], X, Xs) :-
    controllo_elementi(X, [':', '?', '#', '@']), !.

ip(X, IP, R) :-
    terna(X, Terna1, ['.' | R1]),
    terna(R1, Terna2, ['.' | R2]),
    terna(R2, Terna3, ['.' | R3]),
    terna(R3, Terna4, R),
    atom_concat(Terna1, '.', TernaPunto1),
    atom_concat(Terna2, '.', TernaPunto2),
    atom_concat(Terna3, '.', TernaPunto3),
    atom_concat(TernaPunto1, TernaPunto2, PrimiDueOttetti),
    atom_concat(TernaPunto3, Terna4, UltimiDueOttetti),
    atom_concat(PrimiDueOttetti, UltimiDueOttetti, IP), !.

terna([D1, D2, D3 | R], Terna, R) :-
    member(D1, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']),
    member(D2, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']),
    member(D3, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']),
    atom_concat(D1, D2, Q),
    atom_concat(Q, D3, Terna).

controllo_id44([X | _], _, _) :-
    is_not_alpha(X),
    !, fail.

controllo_id44(X, Y, R) :-
    identificatoreid44(X, Y, R), !.

identificatoreid44(['.' | []], _, _) :-
    !, fail.

identificatoreid44([X | Xs], Y, R) :-
    alnum_or_point(X),
    identificatoreid44(Xs, Z, R), !,
    atom_concat(X, Z, Y).

identificatoreid44([X | Xs], X, Xs) :-
    alnum_or_point(X).

controllo_id8([X | _], _, _) :-
    is_not_alpha(X),
    !, fail.

controllo_id8(X, Y, R) :-
    identificatoreid8(X, Y, R), !.

identificatoreid8([X | Xs], Y, R) :-
    alnum_id8(X),
    identificatoreid8(Xs, Z, R), !,
    atom_concat(X, Z, Y).

identificatoreid8([X | Xs], X, Xs) :-
    alnum_id8(X).

id44(X, Y, R) :-
    controllo_id44(X, Y, R),
    atom_chars(Y, Z),
    length(Z, Len),
    Len < 45.

id8(X, Y, R) :-
    controllo_id8(X, Y, R),
    atom_chars(Y, Z),
    length(Z, Len),
    Len < 9.

scheme(X, Y, Rs) :- identif(X, Y, [':' | Rs]).
userinfo(X, Y, Rs) :- identif(X, Y, ['@' | Rs]).
host(X, Y, R) :- controllo_host(X, Y, R).
port([':' | X], Y, R) :- identport(X, Y, R).
path(X, Y, R) :- controllo_path(X, Y, R).
query(['?' | X], Y, R) :- identifquery(X, Y, R).
fragment(['#' | X], Y, R) :- identifrag(X, Y, R).

zos_path(X, Zos_path, Resto) :-
    id44(X, ID44, RsID44),
    appendi_par1(ID44, RsID44, Ris_ID44, RisID44New),
    id8(RisID44New, ID8, RsID8),
    appendi_par2(ID8, RsID8, Ris_ID8, Resto),
    atom_concat(Ris_ID44, Ris_ID8, Zos_path), !.

zos_path(X, Zos_path, Resto) :- id44(X, Zos_path, Resto), !.

authority(['/', '/' | Rs], Userinfo, Host, Port, Resto) :-
    userinfo(Rs, Userinfo, RestoUser),
    ip(RestoUser, Host, RestoHost),
    port(RestoHost, Atom_Port, Resto),
    atom_number(Atom_Port, Port),
    !.

authority(['/', '/' | Rs], Userinfo, Host, Port, Resto) :-
    userinfo(Rs, Userinfo, RestoUser),
    host(RestoUser, Host, RestoHost),
    port(RestoHost, Atom_Port, Resto),
    atom_number(Atom_Port, Port),
    !.

authority(['/', '/' | Rs], Userinfo, Host, Port, Resto) :-
    userinfo(Rs, Userinfo, R),
    ip(R, Host, Resto),
    verifica(Resto),
    Port = 80, !.

authority(['/', '/' | Rs], Userinfo, Host, Port, Resto) :-
    userinfo(Rs, Userinfo, R),
    host(R, Host, Resto),
    Port = 80, !.

authority(['/', '/' | Rs], Userinfo, Host, Port, Resto) :-
    Userinfo = [],
    ip(Rs, Host, RestoHost),
    port(RestoHost, Atom_Port, Resto),
    atom_number(Atom_Port, Port),
    !.

authority(['/', '/' | Rs], Userinfo, Host, Port, Resto) :-
    Userinfo = [],
    host(Rs, Host, RestoHost),
    port(RestoHost, Atom_Port, Resto),
    atom_number(Atom_Port, Port),
    !.

authority(['/', '/' | Rs ], Userinfo, Host, Port, Resto) :-
    ip(Rs, Host, Resto),
    Userinfo = [],
    verifica(Resto),
    Port = 80, !.

authority(['/', '/' | Rs ], Userinfo, Host, Port, Resto) :-
    host(Rs, Host, Resto),
    Userinfo = [],
    Port = 80, !.

authority(R, Userinfo, Host, Port, R) :-
    Host = [],
    Userinfo = [],
    Port = 80, !.

opzionale(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    path(R, Path, RsP),
    query(RsP, Query, RsQ),
    fragment(RsQ, Fragment, Resto).

opzionale(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    path(R, Path, RsP),
    Query = [],
    fragment(RsP, Fragment, Resto).

opzionale(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    path(R, Path, RsP),
    query(RsP, Query, Resto),
    Fragment = [].

opzionale(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    path(R, Path, Resto),
    Query = [],
    Fragment = [].

opzionale(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    Path = [],
    query(R, Query, Resto),
    Fragment = [].

opzionale(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    Path = [],
    Query = [],
    fragment(R, Fragment, Resto).

opzionale(['/'], Host, Path, Query, Fragment, Resto):-
    Host = [],
    Path = [],
    Query = [],
    Fragment = [],
    Resto = [].

opzionale(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    path(Rs, Path, RsP),
    query(RsP, Query, RsQ),
    fragment(RsQ, Fragment, Resto).

opzionale(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    path(Rs, Path, RsP),
    query(RsP, Query, Resto),
    Fragment = [].

opzionale(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    path(Rs, Path, RsP),
    Query = [],
    fragment(RsP, Fragment, Resto).

opzionale(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    Path = [],
    query(Rs, Query, RsQ),
    fragment(RsQ, Fragment, Resto).

opzionale(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    path(Rs, Path, Resto),
    Query = [],
    Fragment = [].

opzionale(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    Path = [],
    query(Rs, Query, Resto),
    Fragment = [].

opzionale(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    Path = [],
    Query = [],
    fragment(Rs, Fragment, Resto).

opzionale(Rs, _, Path, Query, Fragment, Rs) :-
    Path = [],
    Query = [],
    Fragment = [].

opzionale_zos(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    zos_path(R, Path, RsP),
    query(RsP, Query, RsQ),
    fragment(RsQ, Fragment, Resto).

opzionale_zos(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    zos_path(R, Path, RsP),
    Query = [],
    fragment(RsP, Fragment, Resto).

opzionale_zos(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    zos_path(R, Path, RsP),
    query(RsP, Query, Resto),
    Fragment = [].

opzionale_zos(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    Path = [],
    query(R, Query, RsP),
    fragment(RsP, Fragment, Resto).

opzionale_zos(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    zos_path(R, Path, Resto),
    Query = [],
    Fragment = [].

opzionale_zos(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    Path = [],
    query(R, Query, Resto),
    Fragment = [].

opzionale_zos(R, Host, Path, Query, Fragment, Resto):-
    Host = [],
    Path = [],
    Query = [],
    fragment(R, Fragment, Resto).

opzionale_zos(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    zos_path(Rs, Path, RsP),
    query(RsP, Query, RsQ),
    fragment(RsQ, Fragment, Resto).

opzionale_zos(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    zos_path(Rs, Path, RsP),
    query(RsP, Query, Resto),
    Fragment = [].

opzionale_zos(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    zos_path(Rs, Path, RsP),
    Query = [],
    fragment(RsP, Fragment, Resto).

opzionale_zos(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    Path = [],
    query(Rs, Query, RsP),
    fragment(RsP, Fragment, Resto).

opzionale_zos(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    zos_path(Rs, Path, Resto),
    Query = [],
    Fragment = [].

opzionale_zos(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    Path = [],
    query(Rs, Query, Resto),
    Fragment = [].

opzionale_zos(['/' | Rs], _, Path, Query, Fragment, Resto) :-
    Path = [],
    Query = [],
    fragment(Rs, Fragment, Resto).

opzionale_zos(['/' | Rs], _, Path, Query, Fragment, Rs) :-
    Path = [],
    Query = [],
    Fragment = [].

uri_display(uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment),
            Stream) :-
    set_output(Stream),
    write('Scheme:     '),
    writeln(Scheme),
    write('Userinfo:   '),
    writeln(Userinfo),
    write('Host:       '),
    writeln(Host),
    write('Port:       '),
    writeln(Port),
    write('Path:       '),
    writeln(Path),
    write('Query:      '),
    writeln(Query),
    write('Fragment:   '),
    writeln(Fragment), !.

uri_display(uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment)) :-
    write('Scheme:     '),
    writeln(Scheme),
    write('Userinfo:   '),
    writeln(Userinfo),
    write('Host:       '),
    writeln(Host),
    write('Port:       '),
    writeln(Port),
    write('Path:       '),
    writeln(Path),
    write('Query:      '),
    writeln(Query),
    write('Fragment:   '),
    writeln(Fragment).
