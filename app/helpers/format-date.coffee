`import Ember from 'ember'`

formatDate = (value) ->
  value?.toLocaleString()

FormatDateHelper = Ember.Handlebars.makeBoundHelper formatDate

`export { formatDate }`

`export default FormatDateHelper`
