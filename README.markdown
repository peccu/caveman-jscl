# Caveman-Jscl

## Usage

### Launch server

After Installation, exec command below.

```
$ qlot exec clackup app.lisp
```

Now you can access to http://localhost:5000 .

### Write script in Common Lisp

You can write scripts in Common Lisp using [jscl](https://github.com/jscl-project/jscl).

Place some lisp in static/lisp directory with `.lisp` extension,
and load it in HTML with `.js` extension like below.

```html
<!-- this loads compiled static/lisp/log.lisp -->
<script src="/lisp/log.js" type="text/javascript"></script>
```

## Installation

```
$ ros install peccu/caveman-jscl
$ ros install qlot
$ cd ~/.roswell/local-projects/peccu/caveman-jscl
$ qlot install
$ ros install clack
```

## Author

* peccu (peccul@gmail.com)

## Copyright

Copyright (c) 2016 peccu (peccul@gmail.com)

## License

Licensed under the MIT License.
