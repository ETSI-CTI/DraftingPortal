# cti-nwm-portal

A Rails 5 application that integrates a gulp-based
asset pipeline by including the final assets in Rails'
own asset pipeline.

## Development

Run

```bash
bundle install
```

to set everything up on the Rails side of things.

Similarly, run

```bash
npm install
```
to set everything up for the asset pipeline. `gulp`
is used to manage SCSS and JavaScript resources.

To develop the app, you will need two shells running,
the first with


```bash
bin/rails s
```
to run the actual Rails app, while the other runs


```bash
gulp
```
to support a BrowserSync session that live reloads
whenever a SCSS, JS or Slim template is changed.

## Production

Run

```bash
npm dist
```

to compile assets and place them in the `public` folder.
Now run

```bash
RAILS_ENV=production bin/rake assets:precompile
```

to integrate the assets with Rails' own asset pipeline.

