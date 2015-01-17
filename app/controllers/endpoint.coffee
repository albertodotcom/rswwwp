`import Ember from 'ember'`

EndpointController = Ember.ObjectController.extend
  needs: ['endpoints']

  pingUrl: ->
    uri = @get('uri')

    sendTime = (new Date()).getTime()

    if uri?
      Ember.$.ajax
        type: 'head'
        url: uri
        cache: false
      .always =>
        receiveTime = (new Date()).getTime()

        pingTime = receiveTime - sendTime

        ping = @store.createRecord 'ping',
          date: new Date()
          pingTime: pingTime

        endpoint = @get('model')

        if ping.save()
          endpoint.get('pings').pushObject(ping)
          endpoint.save()

  runInterval: null

  pingPolling: (->
    if @get('controllers.endpoints.isPolling') is true
      @pingUrl()
      pollingInterval = @get('controllers.endpoints.pollingInterval')

      # reset previous interval. This comes in handy when the this
      # function is triggered due to .pollingInterval change
      Ember.run.cancel(@get('runInterval'))

      newRunInterval = Ember.run.later(@, @pingPolling, pollingInterval)
      @set('runInterval', newRunInterval)
  ).observes(
    'controllers.endpoints.pollingInterval',
    'controllers.endpoints.isPolling'
  ).on('init')

`export default EndpointController`
