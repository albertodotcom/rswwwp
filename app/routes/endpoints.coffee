`import Ember from 'ember'`

EndpointsRoute = Ember.Route.extend
  model: ->
    @store.find('endpoint')

`export default EndpointsRoute`
