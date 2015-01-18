`import Ember from 'ember'`

EndpointController = Ember.ObjectController.extend
  needs: ['endpoints']

  pingUrl: (->
    uri = @get('uri')

    sendTime = (new Date()).getTime()

    if uri?
      Ember.$.ajax
        type: 'GET'
        url: "http://localhost:4200/ping?url=#{uri}"
        cache: false
      .always (data, textStatus, error) =>
        receiveTime = (new Date()).getTime()

        pingTime = if data.statusCode isnt 404
          receiveTime - sendTime
        else
          @get('controllers.endpoints.maximumTime')

        ping = @store.createRecord 'ping',
          date: new Date()
          pingTime: pingTime

        endpoint = @get('model')

        if ping.save()
          endpoint.get('pings').pushObject(ping)
          endpoint.save()
  ).on('init')

  runInterval: null

  lastPingRatio: (->
    maximumTime = @get('controllers.endpoints.maximumTime')

    lastPing = @get('pings.lastObject.pingTime')

    pingRatio = lastPing / maximumTime * 100

    if pingRatio >= 100
      100
    else
      pingRatio
  ).property('pings.@each', 'controllers.endpoints.maximumTime')

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
