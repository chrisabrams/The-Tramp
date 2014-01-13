The Tramp
=========

Chaplin.js on Node.js. Use it for performance boosts, SEO, re-usability.

# Project Status: Alpha
Use at your own risk; API will change.

It is currently being tested in a Chaplin app. The following work:

- Controllers
- Models (including validation w/ Backbone.validation)
- Views, Sub-views, CollectionViews and Composition Views
- Handlebars templates, partials, and helpers
- Chaplin routes integrated into Express' router

Need to implement:

- Require/AMD support

## Why render on server-side?

A typical single page app will render after the following requests (in descending order) are made:

![requests](https://github.com/chrisabrams/the-tramp/raw/master/images/bon_requests.jpg)

The problem is the last request can become very large over time, especially as back-ends scale. This can result in up to or even more than one second of delay.

By rendering the *initial* page on the server-side, this can greatly reduce the initial page loading time, as the last call made in the previous diagram is now done on the server-side before the site loads.

![fewer requests](https://github.com/chrisabrams/the-tramp/raw/master/images/bon_fewer_requests.jpg)

## How it works

An express app is created on Node and then The Tramp is required. It's designed to be a drop in plugin.

## Example
