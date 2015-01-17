`import { test, moduleFor } from 'ember-qunit'`

moduleFor 'controller:endpoint', 'EndpointController', {
  needs: ['controller:endpoints']
}

# Replace this with your real tests.
test 'it exists', ->
  controller = @subject()
  ok controller

