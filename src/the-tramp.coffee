TheTramp =
  
  Application: loader 'the-tramp/application'
  DualView: loader 'the-tramp/views/dual_view'

module.exports = TheTramp

if typeof window is 'object'
  window.TheTramp = TheTramp
