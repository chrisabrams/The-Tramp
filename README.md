The Tramp
=========

Chaplin.js on Node.js. Use it for SEO or just because you can ;)

# Project Status
Pre-Alpha.

It is currently being tested in a Chaplin app. The following work:

- Controllers
- Models (including validation w/ Backbone.validation)
- Views & Sub-views
- Handlebars templates & helpers
- Routes
- Common.js modules using Chaplin's `loader`

Need to implement:

- Composition
- CollectionView
- Handlebars Partials (they might work, just haven't tested at all)
- Sub-views that were not marked as DualViews (so they will be rendered on client-side on if they were a part of the initial view)
- Require/AMD support

## How it works
An express app is created on Node and then the Tramp is required. It's designed to be a drop in plugin, but at the moment there are a few changes that have to be made to the Chaplin app:

### Loader
Internally, Chaplin uses `loader` instead of the word `require` for loading modules. In order to get the modules to load in the browser & Node and not change the app's build process, it is necessary to change all instances of `require` in the app to `loader`. The behavior is the same; it is just a syntax change.

### Template Helpers
In `application.coffee` a new property needs to be created: `templateHelpers`. This is an array with the path to each template helper file. Each template helper file now needs to have:

    module.exports = (Handlebars) ->

as the Handlebars object that express uses is tied to `hbs.handlebars` and as such needs to be passed into each template when they are required.

### Views
Views have a new class called "DualView" which simply marks this view as being eligable for rendered on Node. If a view is not a DualView, the Tramp will skip it. The same goes for subviews.
