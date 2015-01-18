`import Ember from 'ember'`
###*
@class EndpointsRoute
@extend Ember.Route
###
EndpointsRoute = Ember.Route.extend
  ###*
  @method model
  @extend Ember.Route
  ###
  model: ->
    @store.find('endpoint')

`export default EndpointsRoute`
