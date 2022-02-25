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

Il **parser** è stato sviluppato in **Prolog** utilizzando esclusivamente la ricorsione, senza l'utilizzo di "Substring" o simili.

### Utilizzo

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

```prolog
uri_parse("https://www.google.com", URI).
URI = uri(https, [], 'www.google.com', 80, [], [], []).
```

Se la stringa URI passata in input non è corretta, verrà ritornato `false`.

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

### Autori

- Mauriello Andrea 
- Strada Matteo


