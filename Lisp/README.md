# Parsing di stringhe uri

### Descrizione

Lo scopo del programma è quello di rappresentare in strutture, facilmente leggibili, delle stringhe inserite dall'utente che rappresentano URI.
L'URI viene scomposta nei seguenti campi:
- Scheme
- Userinfo
- Host
- Port
- Path
- Query
- Fragment

Il **parser** è stato sviluppato in **Lisp** utilizzando esclusivamente la ricorsione, senza l'utilizzo di "Substring" o simili e rispettando la trasparenza referenziale.

### Utilizzo

La **sintassi** è la seguente:

```lisp
(uri-parse "stringaURI")
```

Se la stringa passata in input è una **URI** ed è corretta, verrà ritornato:

```lisp
#S(URI :SCHEME-CAMPO SCHEME :USERINFO-CAMPO USERINFO :HOST-CAMPO HOST :PORT-CAMPO PORT :PATH-CAMPO PATH :QUERY-CAMPO QUERY :FRAGMENT-CAMPO FRAGMENT)
```

Tutti i campi ritornati sono **stringhe**, tranne **port** che è un **numero**.

Se alcuni **campi opzionali** non sono presenti nella stringa URI passata in input, verranno rappresentati con `NIL`. Eccezion fatta per la porta che ha 80 come **default value**.

```lisp
(uri-parse "https://www.google.com")
#S(URI :SCHEME-CAMPO "https" :USERINFO-CAMPO NIL :HOST-CAMPO "www.google.com" :PORT-CAMPO 80 :PATH-CAMPO NIL :QUERY-CAMPO NIL :FRAGMENT-CAMPO NIL)
```

Se la stringa URI passata in input **non è sintatticamente corretta**, verrà ritornato `NIL`.
Se, invece, la stringa in input **non è di tipo URI** verrà ritornato un `error`.

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

### Autori

- Mauriello Andrea 
- Strada Matteo