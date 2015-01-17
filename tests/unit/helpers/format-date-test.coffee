`import { formatDate } from 'rswwwp/helpers/format-date'`

module 'FormatDateHelper'

test 'it returns a date in toLocaleString', ->
  date = new Date()
  result = formatDate date
  equal(result, date.toLocaleString())

test 'it returns null if the input is undefined', ->
  result = formatDate null
  equal(result, null)
