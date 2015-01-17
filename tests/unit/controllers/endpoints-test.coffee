`import { test, moduleFor } from 'ember-qunit'`

moduleFor 'controller:endpoints', 'EndpointsController', {
}

test 'it exists', ->
  controller = @subject()
  ok controller

test 'has defaults properties', ->
  ctrl = @subject()

  equal(ctrl.get('pollingInterval'), 10000)
  equal(ctrl.get('isPolling'), false)
  equal(ctrl.get('maximumTime'), 3000)
