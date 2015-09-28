'use strict';

class ReapitVendor.Models.Office extends Backbone.Model
  url: '',

  initialize: () ->

  defaults: {}

  @newFromXMLSegment:(xml) ->
    officeParse = new jQuery.Deferred()
    negFetch = new jQuery.Deferred()
    xmlDoc = $(xml)

    office = _.tap new ReapitVendor.Models.Office(), (newVendor) =>
      for element in xmlDoc.children()
        element = $(element)
        if element.prop("tagName").toLowerCase() == 'negotiator'
          newVendor.set('negotiators', new ReapitVendor.Collections.Negotiators())
          negotiators = []
          for id in element.children()
            id = $(id)
            negotiators.push ReapitVendor.Models.Auth.getInstance().negotiator(id.text())
          $.when(negotiators...).done (negs...) =>
            newVendor.set('negotiators', newVendor.get('negotiators').add(negs))
            negFetch.resolve()
        else
          newVendor.set(element.prop("tagName").toLowerCase(), element.text() )
    negFetch.done =>
      officeParse.resolve(office)
    officeParse
