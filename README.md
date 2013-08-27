The Tramp
=========

Chaplin.js on Node.js. Use it for performance boosts, SEO, re-usability.

# Project Status
Pre-Alpha.

It is currently being tested in a Chaplin app. The following work:

- Controllers
- Models (including validation w/ Backbone.validation)
- Views & Sub-views
- Handlebars templates & helpers
- Chaplin routes integrated into Express' router
- Common.js modules using Chaplin's `loader`

Need to implement:

- Tests (that pass on client and server)
- Composition
- Collection View
- Handlebars Partials (they might work, just haven't tested)
- Sub-views that were not marked as DualViews (so they will be rendered on client-side on if they were a part of the initial view)
- Require/AMD support

## Why render on server-side?

A typical single page app will render after the following requests (in descending order) are made:

![requests](https://github.com/chrisabrams/the-tramp/raw/master/images/bon_requests.jpg)

The problem is the last request can become very large over time, especially as back-ends scale. This can result in up to or even more than one second of delay.

By rendering the *initial* page on the server-side, this can greatly reduce the initial page loading time, as the last call made in the previous diagram is now done on the server-side before the site loads.

![fewer requests](https://github.com/chrisabrams/the-tramp/raw/master/images/bon_fewer_requests.jpg)

## How it works

An express app is created on Node and then the Tramp is required. It's designed to be a drop in plugin, but at the moment there are a few changes that have to be made to the Chaplin app:

### Loader

Internally, Chaplin uses `loader` instead of the word `require` for loading modules. In order to get the modules to load in the browser & Node and not change the app's build process, it is necessary to change all instances of `require` in the app to `loader`. The behavior is the same; it is just a syntax change.

You may or may not agree with this approach; as this project aims to be an addon to Chaplin, it tries as much as possible to not introduce anything different than how Chaplin's source handles things.

### Template Helpers

In `application.coffee` a new property needs to be created: `templateHelpers`. This is an array with the path to each template helper file. Each template helper file now needs to be exported.

    module.exports = (Handlebars) ->

The `Handlebars` object is passed in because the Handlebars object that express uses is tied to `hbs.handlebars` and as such needs to be passed into each template when they are required.

### DualViews

The Tramp introduces a new class, `DualView`. It extends Chaplin's View and adds a few pieces of logic to provide support for rendering a view on server-side. If a view is not extended from a DualView, The Tramp will skip it. The same goes for subviews that are not extending from a DualView.

## Example

An example repo has been made to show how to use The Tramp. [View Example](https://github.com/chrisabrams/The-Tramp-example).
