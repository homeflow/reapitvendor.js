'use strict';

class ReapitVendor.Models.MarketingStats extends Backbone.Model
  url: '',

  initialize: () ->

  defaults: {}

  @newFromXML:(xml) ->
    xmlDoc = $($.parseXML( xml )).find('MarketingStats')
    _.tap new ReapitVendor.Models.MarketingStats(), (newVendor) =>
      for element in xmlDoc.children()
        element = $(element)
        newVendor.set(element.prop("tagName").toLowerCase(), element.text() )
