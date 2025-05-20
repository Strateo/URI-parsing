# URI Parser
### Description
The goal of this program is to parse an input URI string and represent it in a clear, structured format.

The URI is broken down into the following fields:
- **Scheme**
- **Userinfo**
- **Host**
- **Port**
- **Path**
- **Query**
- **Fragment**

The parser also supports the following special URI schemes:
- **mailto** — supports an email address composed of: `[userinfo ['@' host]]`
- **news** — composed of: `[host]`
- **tel/fax** — supports a phone number composed of: `[userinfo]`
- **zos** — supports data-set names on IBM mainframes


## Lisp
The **parser** is implemented in **Lisp**, using only recursion, without relying on functions like `substring`, and adhering to **referential transparency**.

### Syntax
To use the parser, call:
```lisp
(uri-parse "URIstring")
```

If the input string is valid, the output will be displayed as:
```lisp
#S(URI :SCHEME-FIELD SCHEME :USERINFO-FIELD USERINFO :HOST-FIELD HOST :PORT-FIELD PORT :PATH-FIELD PATH :QUERY-FIELD QUERY :FRAGMENT-FIELD FRAGMENT)
```


> ⚠️ Note: The original field names such as `:SCHEME-CAMPO` (italian) have been translated to `:SCHEME-FIELD` for clarity.

- All fields are returned as **strings**, except for the **port**, which is returned as a **number**.
- If optional fields are not present in the URI, they will be set to `NIL`.
- The **default port** is `80` if not explicitly specified.
- If the input string is **not syntactically valid**, `NIL` is returned.
- If the input is **not a URI**, an **error** is raised.

#### Example:
```lisp
(uri-parse "https://www.google.com")
#S(URI :SCHEME-FIELD "https" :USERINFO-FIELD NIL :HOST-FIELD "www.google.com" :PORT-FIELD 80 :PATH-FIELD NIL :QUERY-FIELD NIL :FRAGMENT-FIELD NIL)
```

### Writing to a File
To write the parsed URI to a file:
```lisp
(with-open-file (stream "Path/to/file.txt"
                        :direction :output
                        :if-exists :supersede
                        :if-does-not-exist :create)
  (uri-display (uri-parse "URIstring") stream))
```

### Printing to Standard Output
```lisp
(uri-display (uri-parse "URIstring"))
```


## Prolog
The **parser** is also implemented in **Prolog**, using only recursion and avoiding the use of string manipulation predicates like `substring`.

### Syntax
To parse a URI in Prolog:
```prolog
uri_parse("URIstring", URI).
```

If the input string is a valid URI, the result will be unified as:
```prolog
URI = uri(Scheme, Userinfo, Host, Port, Path, Query, Fragment).
```

- All fields are returned as **atoms**, except for the **port**, which is a **number**.
- The **host field** first attempts to match an **IP address** consisting of **four octets** (values from 0 to 255). If not found, it checks for a valid **host identifier**.
- If this structure is not respected, `false` is returned.
- Optional fields not present in the input will be represented as empty lists `[]`, except for **port**, which defaults to `80`.
- If the URI is not valid, the result will be `false`.

#### Example:
```prolog
uri_parse("https://www.google.com", URI).
```
