'use strict';

class ReapitVendor.Models.Negotiator extends Backbone.Model
  url: '',

  initialize: () ->

  defaults: {}

  @newFromXML:(xml) ->
    xmlDoc = $($.parseXML( xml )).find('Negotiator')
    _.tap new ReapitVendor.Models.Negotiator(), (newVendor) =>
      for element in xmlDoc.children()
        element = $(element)
        newVendor.set(element.prop("tagName").toLowerCase(), element.text() )
