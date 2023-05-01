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

The parser also supports the following special syntax:
- **mailto** supports an email address composed of: [userinfo ['@' host] ]
- **news** composed of: [host]
- **tel/fax** supports a phone number composed of: [userinfo]
- **zos scheme** supports data-set names on IBM mainframes.

## Lisp
The **parser** has been developed in **Lisp** using only recursion, without the use of "Substring" or similar, and respecting referential transparency.

The **syntax** for using the program is as follows:

```lisp
(uri-parse "URIstring")
```

If the input string is accepted, the output will be printed in the following way:

```lisp
#S(URI :SCHEME-CAMPO SCHEME :USERINFO-CAMPO USERINFO :HOST-CAMPO HOST :PORT-CAMPO PORT :PATH-CAMPO PATH :QUERY-CAMPO QUERY :FRAGMENT-CAMPO FRAGMENT)
```

All returned fields are **strings**, except for **port** which is handled as a **number**.

If some **optional fields** are not present in the input URI string, they will be represented with `NIL`. The exception is the port, which has 80 as its **default value**.

If the input URI string **is not syntactically correct**, `NIL` will be returned. If instead, the input string **is not a URI type**, an `error` will be returned.

Example:
```lisp
(uri-parse "https://www.google.com")
#S(URI :SCHEME-CAMPO "https" :USERINFO-CAMPO NIL :HOST-CAMPO "www.google.com" :PORT-CAMPO 80 :PATH-CAMPO NIL :QUERY-CAMPO NIL :FRAGMENT-CAMPO NIL)
```



A possible method to print the URI on a Stream:

```
(with-open-file (stream Path
                        :direction :output
                        :if-exists :supersede
                        :if-does-not-exist :create)
  (uri-display (uri-parse URIstring) stream))
```

To print the URI to **standard output**:

```lisp
(uri-display (uri-parse URIstring))
```
## Prolog
The **parser** has been developed in **Prolog** using only recursion, without the use of "Substring" or similar.

The **syntax** is as follows:

```prolog
uri_parse("URIstring", URI).
```

If the input string is a **URI** and is correct, the following will be returned:

```prolog
URI = uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment).
```

All returned fields are **atoms**, except for **port** which is a **number**.

The **host field** initially looks for an **IP address** composed of **four sets of digits** between 0 and 255. If not found, it proceeds to verify that there is a **host identifier**. If this syntax is not respected, `false` will be returned.

If some **optional fields** are not present in the input URI string, they will be represented with **[]**. The exception is the port, which has a **default value** of 80.

If the input URI string is incorrect, `false` will be returned.

Example:
```prolog
uri_parse("https://www.google.com", URI).
