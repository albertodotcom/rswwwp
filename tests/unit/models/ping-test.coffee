`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel 'ping', 'Ping', {
  # Specify the other units that are required for this test.
  needs: ["model:endpoint"]
}

test 'it exists', ->
  model = @subject()
  store = this.store().modelFor('ping')
  ok !!model
  ok !!store

test 'it belongs to an endpoint', ->
  Ping = this.store().modelFor('ping')
  relationship = Ember.get(Ping, 'relationshipsByName').get('endpoint')

  equal(relationship.key, 'endpoint')
  equal(relationship.kind, 'belongsTo')
