`import { test, moduleFor } from 'ember-qunit'`
`import DS from 'ember-data'`
`import Ember from 'ember'`

moduleFor 'controller:endpoint', 'EndpointController', {
  needs: ['controller:endpoints']
}

test '#performRequest returns a promise', ->
  expect(2)

  ctrl = @subject()

  promise = ctrl.performRequest('http://www.google.com')

  ok(promise instanceof Ember.RSVP.Promise)

  promise.then (pingTime) ->
    ok(typeof pingTime is 'number')

test '#lastPingRatio', ->
  ping = Ember.Object.create
    date: new Date()
    pingTime: 50

  ctrl = @subject(
    pings: [ping]
  )

  ctrl.set('controllers.endpoints.maximumTime', 500)

  lastPingRatio = ctrl.get('lastPingRatio')

  ok(typeof lastPingRatio is 'number')
  equal(lastPingRatio, 10)
