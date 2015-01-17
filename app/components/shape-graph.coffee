`import Ember from 'ember'`

ShapeGraphComponent = Ember.Component.extend
  style: (->
    "height: #{@get('ratio')}%; width: #{@get('ratio')}%;"
  ).property('ratio')

`export default ShapeGraphComponent`
