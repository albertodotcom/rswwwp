`import DS from 'ember-data'`

Ping = DS.Model.extend
  endpoint: DS.belongsTo('endpoint', async: true)

  date: DS.attr('date')
  pingTime: DS.attr('number')
  dead: DS.attr('boolean'), defaultValue: false

`export default Ping`
