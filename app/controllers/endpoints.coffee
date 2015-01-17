`import Ember from 'ember'`

EndpointsController = Ember.ArrayController.extend
  itemController: 'endpoint'

  pollingInterval: 10000

  isPolling: false

  actions:
    addEndPoint: ->
      newEndpoint = @store.createRecord 'endpoint',
        uri: @get('newEndPoint')

      newEndpoint.save()

    ping: ->
      @toArray().forEach (endpoint) ->
        endpoint.pingUrl()

`export default EndpointsController`
