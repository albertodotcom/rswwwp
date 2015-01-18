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

test 'color returns hsl(120, 100%, 75%) if ratio is undefined', ->
  component = @subject()

  Ember.run ->
    component.set('ratio', undefined)

  color = component.get('color')

  equal(color, 'hsl(120, 100%, 75%)')

test 'it changes the style to the expected one. Ratio is undefined', ->
  component = @subject()

  Ember.run ->
    component.set('ratio', undefined)

  color = component.get('color')
  expectedResult = "height: 0%; width: 0%; background-color: #{color}"

  equal(component.get('style'), expectedResult)

  @append()

  equal(component.$('.shape').attr('style'), expectedResult)

test 'it changes the style to the expected one', ->
  component = @subject()

  Ember.run ->
    component.set('ratio', 70)

  color = component.get('color')
  expectedResult = "height: 70%; width: 70%; background-color: #{color}"

  equal(component.get('style'), expectedResult)

  @append()

  equal(component.$('.shape').attr('style'), expectedResult)
