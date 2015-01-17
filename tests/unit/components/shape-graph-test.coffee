`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'shape-graph', 'ShapeGraphComponent', {
}

test 'it renders', ->
  expect 2

  # creates the component instance
  component = @subject()
  equal component._state, 'preRender'

  # appends the component to the page
  @append()
  equal component._state, 'inDOM'

test 'it changes the style to the expected one', ->
  component = @subject()

  Ember.run ->
    component.set('ratio', 70)

  equal(component.get('style'), 'height: 70%; width: 70%;')

  @append()

  debugger
  equal(component.$('.shape').attr('style'), 'height: 70%; width: 70%;')
