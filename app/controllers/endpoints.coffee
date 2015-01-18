`import Ember from 'ember'`

EndpointsController = Ember.ArrayController.extend
  itemController: 'endpoint'

  pollingInterval: 10000

  isPolling: false

  maximumTime: 3000

  actions:
    addEndPoint: ->
      newEndpoint = @store.createRecord 'endpoint',
        uri: @get('newEndPoint')

      newEndpoint.save()

    ping: ->
      @toArray().forEach (endpoint) ->
        endpoint.pingUrl()

    togglePolling: ->
      @toggleProperty('isPolling')
      return

`export default EndpointsController`
