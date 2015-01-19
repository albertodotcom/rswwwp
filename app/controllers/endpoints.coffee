`import Ember from 'ember'`
###*
@class EndpointsController
@extend Ember.ArrayController
###
EndpointsController = Ember.ArrayController.extend
  ###*
  @property itemController
  @type {String}
  @extend Ember.ArrayController
  ###
  itemController: 'endpoint'

  ###*
  @property pollingInterval
  @type {Number}
  ###
  pollingInterval: 10000

  ###*
  @property isPolling
  @type {Boolean}
  ###
  isPolling: false

  ###*
  Maximum time allowed from a service for responding

  @property maximumTime
  @type {Boolean}
  ###
  maximumTime: 3000

  ###*
  New endpoint url

  @property newEndPoint
  @type {String}
  ###
  newEndPoint: ''

  actions:
    ###*
    Add an endpoint to the list and trigger the first ping

    @event addEndPoint
    ###
    addEndPoint: ->
      newEndpoint = @store.createRecord 'endpoint',
        uri: @get('newEndPoint')

      newEndpoint.save().then =>
        @set('newEndPoint', '')

        endpointCtrl = @findBy('id', newEndpoint.get('id'))

        if @get('isPolling')
          endpointCtrl.pingPolling()
        else
          endpointCtrl.pingUrl()

    ###*
    Ping all the endpoints

    @event ping
    ###
    ping: ->
      @toArray().forEach (endpoint) ->
        endpoint.pingUrl()

    ###*
    Switch the polling on/off

    @event togglePolling
    ###
    togglePolling: ->
      @toggleProperty('isPolling')
      return

`export default EndpointsController`
