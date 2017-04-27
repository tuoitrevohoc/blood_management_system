# BMS DN
Blood Management System Danang

## License

This is an open source project. All source code in this project is available jointly under the MIT License
and the Beerware License. See [LICENSE.md](LICENSE.md) for details.

## See demo here
https://bmsdn.herokuapp.com

## Getting started

This project goes well with `Ruby 2.3.6`, `Rails 5.0.1` and `Mysql 5.17`.
To get started with the app, after clone the repo:

First, you'll need to copy `database.yml` and `.env` to run the app, just copy and rename `config/database.example.yml` and `.env.example`:

```shell
$ mv /config/database.example.yml /config/database.yml
$ mv .env.example .env
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

## Contributing

- Fork the repo on github and send a pull requests with topic branches.
- Send pull requests to `develop`.

## Deploy guideline:

- Server __Staging__: Branch `deploy_heroku`
- Server __Production__: Branch `docker`

### Deploy using docker
Check out branch `docker`

Build the docker image
```sh
sudo docker build . -t sontd/blood_management_system
```
Push the image to dockerhub
```sh
docker push sontd/blood_management_system
```
__Note:__ Docker version 17.09.0-ce, build afdb6d4
