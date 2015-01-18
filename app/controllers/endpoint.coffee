`import config from '../config/environment'`
`import Ember from 'ember'`

###*
@class EndpointController
@extend Ember.ObjectController
###
EndpointController = Ember.ObjectController.extend
  ###*
  @property needs
  @type {Array<Strings>}
  @extend Ember.ObjectController
  ###
  needs: ['endpoints']

  ###*
  Send and ajax request and return a promise which resolves
  with the number of milliseconds

  @method performRequest
  @param url {String}
  @return {Promise}
    @fulfill {Integer} time in milliseconds
  ###
  performRequest: (uri) ->
    if config.APP.PROXYSERVER?
      uri = "#{config.APP.PROXYSERVER}?url=#{uri}"

    new Ember.RSVP.Promise (resolve, reject) =>

      sendTime = (new Date()).getTime()

      Ember.$.ajax
        type: 'GET'
        url: uri
        cache: false
      .always (data, status) =>
        receiveTime = (new Date()).getTime()

        # the local proxy server return 404 if the website is not responding
        if data.statusCode is 404
          return reject()

        if data.statusCode is 200 or status is 'success' or data.status is 0
          # data.statusCode this value comes from my proxy server
          # status is 'success' this comes from a domain that allows cors
          # data.status this comes from a domain that doesn't allow cors
          resolve(receiveTime - sendTime)
        else
          reject()

  ###*
  Ping the endpoint and then create a ping instance
  that belongs to this endpoint

  @method pingUrl
  ###
  pingUrl: ->
    uri = @get('uri')

    endpoint = @get('model')

    ping = @store.createRecord 'ping',
      date: new Date()

    @performRequest(uri)
    .then (pingTime) =>
      ping.set('pingTime', pingTime)

    .catch =>
      ping.set('dead', true)

    .finally ->
      if ping.save()
        endpoint.get('pings').pushObject(ping)
        endpoint.save()

  ###*
  Interval to the next ping

  @property runInterval
  @type {Ember.Interval}
  ###
  runInterval: null

  ###*
  Get the last ping from the pings array

  @property lastPingRatio
  @type {Integer}
  ###
  lastPingRatio: (->
    maximumTime = @get('controllers.endpoints.maximumTime')

    lastPing = @get('pings.lastObject.pingTime')

    pingRatio = parseInt(lastPing / maximumTime * 100)

    if pingRatio >= 100
      100
    else
      pingRatio
  ).property('pings.@each', 'controllers.endpoints.maximumTime')

  ###*
  Execute a ping after a certain amount of time

  @method pingPolling
  ###
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
  )

  ###*
  Maximum Number of pings stored

  @property maxPings
  @type {Integer}
  ###
  maxPings: 10

  ###*
  Check the number of pings and delete the oldest one

  @method deleteOldPings
  ###
  deleteOldPings: (->
    pingsCount = @get('pings.length')

    if pingsCount > @get('maxPings')
      endpoint = @get('model')
      ping = @get('pings.firstObject')

      endpoint.get('pings').removeObject(ping)
      endpoint.save()

      ping.destroyRecord()

  ).observes('pings.[]')

  ###*
  Average ping time

  @property maxPings
  @type {Integer}
  ###
  avgPingTime: (->
    totalPingTime = @get('pings').reduce (prev = 0, ping) ->
      prev + ping.get('pingTime')

    totalPingTime / @get('pings.length')
  ).property('maxPings', 'pings.@each')

  actions:
    ###*
    Delete an endpoint and all its pings

    @event delete
    ###
    delete: ->
      endpoint = @get('model')
      pings = @get('pings')

      endpoint.destroyRecord()
      pings.forEach (ping) ->
        ping.destroyRecord()

`export default EndpointController`
