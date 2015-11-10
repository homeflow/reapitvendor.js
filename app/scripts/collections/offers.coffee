'use strict';

class ReapitVendor.Collections.Offers extends Backbone.Collection

    @newFromXML:(xml) ->
      xmlDoc = $($.parseXML( xml ))
      offices = _.map xmlDoc.find('Offers>item'), (office) ->
        ReapitVendor.Models.Offer.newFromXMLSegment(office)
      $.when(offices...).then (mods...) ->
        new ReapitVendor.Collections.Offers(mods)
