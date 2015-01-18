`import Ember from 'ember'`

###*
Create and animate the a shape based on a percentage

@class ShapeGraphComponent
@extend Ember.Component
@example
  {{shape-graph ratio=lastPingRatio}}
###
ShapeGraphComponent = Ember.Component.extend
  ###*
  Compute and hsl color based on a percentage

  @property color
  @type {String}
  ###
  color: (->
    ratio =
      if @get('ratio')?
        # ratio is 100 based
        ratio = @get('ratio') / 100
      else
        0

    hue = parseInt(((1 - ratio) * 120).toString(10))
    ["hsl(#{hue}, 100%, 75%)"].join("")
  ).property('ratio')

  ###*
  set style attribute

  @property style
  @type {String}
  ###
  style: (->
    ratio = @get('ratio') || 0

    "height: #{ratio}%; width: #{ratio}%; background-color: #{@get('color')}"
  ).property('ratio')

`export default ShapeGraphComponent`
