`import DS from 'ember-data'`

Endpoint = DS.Model.extend
  pings: DS.hasMany('ping', async: true)

  uri: DS.attr()

`export default Endpoint`
