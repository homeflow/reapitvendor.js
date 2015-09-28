class ReapitVendor.Models.Vendor extends Backbone.Model
  url: '',

  initialize: () ->

  defaults: {}

  @newFromXML:(xml) ->
    xmlDoc = $($.parseXML( xml ))
    _.tap new ReapitVendor.Models.Vendor(), (newVendor) =>
      for element in xmlDoc.find('Vendor').children()
        element = $(element)
        newVendor.set(element.prop("tagName").toLowerCase(), element.text() )
