# URI parser
#### Description
The goal of this program is to represent an input URI string in easily readable structures.

The URI is broken down into the following fields:
- Scheme
- Userinfo
- Host
- Port
- Path
- Query
- Fragment

Il parser supporta anche le seguenti sintassi speciali:
- **mailto** supporta un indirizzo e-mail composto da: [userinfo ['@' host] ]
- **news** composta da: [host]
- **tel/fax** supporta un numero di telefono composto da: [userinfo]
- **zos scheme** supporta i nomi di data-sets su mainframes IBM.

## Lisp
Il **parser** è stato sviluppato in **Lisp** utilizzando esclusivamente la ricorsione, senza l'utilizzo di "Substring" o simili e rispettando la trasparenza referenziale.

La **sintassi** per utilizzare il programma  è la seguente:

```lisp
(uri-parse "URIstring")
```

Se la stringa passata in input è accettata, l'output sarà stampato nel seguente modo:

```lisp
#S(URI :SCHEME-CAMPO SCHEME :USERINFO-CAMPO USERINFO :HOST-CAMPO HOST :PORT-CAMPO PORT :PATH-CAMPO PATH :QUERY-CAMPO QUERY :FRAGMENT-CAMPO FRAGMENT)
```

Tutti i campi ritornati sono **stringhe**, tranne **port** che è gestito come **numero**.

Se alcuni **campi opzionali** non sono presenti nella stringa URI passata in input, verranno rappresentati con `NIL`. Eccezion fatta per la porta che ha 80 come **default value**.

Se la stringa URI passata in input **non è sintatticamente corretta**, verrà ritornato `NIL`.
Se, invece, la stringa in input **non è di tipo URI** verrà ritornato un `error`.

Esempio:
```lisp
(uri-parse "https://www.google.com")
#S(URI :SCHEME-CAMPO "https" :USERINFO-CAMPO NIL :HOST-CAMPO "www.google.com" :PORT-CAMPO 80 :PATH-CAMPO NIL :QUERY-CAMPO NIL :FRAGMENT-CAMPO NIL)
```



Un possibile metodo stampare l'URI su uno Stream:

```
(with-open-file (stream Percorso
                        :direction :output
                        :if-exists :supersede
                        :if-does-not-exist :create)
  (uri-display (uri-parse stringaURI) stream))
```

Per stampare l'URI su **standard output**:

```lisp
(uri-display (uri-parse stringaURI))
```
## Prolog
Il **parser** è stato sviluppato in **Prolog** utilizzando esclusivamente la ricorsione, senza l'utilizzo di "Substring" o simili.

La **sintassi** è la seguente:

```prolog
uri_parse("stringaURI", URI).
```

Se la stringa passata in input è una **URI** ed è corretta, verrà ritornato:

```prolog
URI = uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment).
```

Tutti i campi ritornati sono **atomi**, tranne **port** che è un **numero**.

Il **campo host** cerca, inizialmente, un **indirizzo IP** composto da **quattro terne di digit** comprese tra 0 e 255, se non viene trovato, procede con il verificare che ci sia un **identificatore-host**. Nel caso in cui non venga rispettatta nemmeno questa sintassi, verrà ritornato `false`.

Se alcuni **campi opzionali** non sono presenti nella stringa URI passata in input, verranno rappresentati con **[]**. Eccezion fatta per la porta che ha come **default value** 80.

Se la stringa URI passata in input non è corretta, verrà ritornato `false`.

Esempio:
```prolog
uri_parse("https://www.google.com", URI).
URI = uri(https, [], 'www.google.com', 80, [], [], []).
```

Per stampare l'URI su uno **Stream**:

```prolog
 open('destinazione', 'mode', Stream),
 uri_parse("stringaURI", URI),
 uri_display(URI, Stream),
 close(Stream).
```

Per stampare l'URI su **standard output**:

```prolog
 uri_parse("stringaURI", URI),
 uri_display(URI).
```
