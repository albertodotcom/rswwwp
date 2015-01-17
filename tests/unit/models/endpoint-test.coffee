`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel 'endpoint', 'Endpoint', {
  # Specify the other units that are required for this test.
  needs: ["model:ping"]
}

test 'it exists', ->
  model = @subject()
  store = @store().modelFor('endpoint')
  ok !!model
  ok !!store

test 'it has many pings', ->
  Endpoint = this.store().modelFor('endpoint')
  relationship = Ember.get(Endpoint, 'relationshipsByName').get('pings')

  equal(relationship.key, 'pings')
  equal(relationship.kind, 'hasMany')
