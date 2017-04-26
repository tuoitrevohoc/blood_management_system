# BMS DN
Blood Management System Danang

## License

This is an open source project. All source code in this project is available jointly under the MIT License
and the Beerware License. See [LICENSE.md](LICENSE.md) for details.

## See demo here
https://bmsdn.herokuapp.com

## Getting started

To get started with the app, after clone the repo:

First, you'll need to copy `database.yml` to run the app, just copy and rename `config/database.example.yml`:

```shell
$ mv /config/database.example.yml /config/database.yml
```

Then, the application needs gems:

```shell
$ bundle install --without production
```

Next, migrate the database:

```shell
$ rails db:migrate
```

Then, run the server

```shell
$ rails server
```

You can visit the web page at http://0.0.0.0:3000 or http://localhost:3000.

We’ll be resizing images using the image manipulation program ImageMagick,
which we need to install on the development environment.

```shell
$ sudo apt-get update
$ sudo apt-get install imagemagick --fix-missing
```
