`import Ember from 'ember'`

ShapeGraphComponent = Ember.Component.extend
  color: (->
    # ratio is 100 based
    ratio = @get('ratio') / 100

    hue = parseInt(((1 - ratio) * 120).toString(10))
    ["hsl(#{hue}, 100%, 75%)"].join("")
  ).property('ratio')

  style: (->
    "height: #{@get('ratio')}%; width: #{@get('ratio')}%; background-color: #{@get('color')}"
  ).property('ratio')

`export default ShapeGraphComponent`
