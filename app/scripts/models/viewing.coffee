'use strict';

class ReapitVendor.Models.Viewing extends Backbone.Model
  url: '',

  initialize: () ->

  defaults: {}

  @newFromXMLSegment:(xml) ->
    xmlDoc = $(xml)
    viewing = _.tap new ReapitVendor.Models.Viewing(), (newViewing) =>
      for element in xmlDoc.children()
        element = $(element)
        newViewing.set(element.prop("tagName").toLowerCase(), element.text() )
