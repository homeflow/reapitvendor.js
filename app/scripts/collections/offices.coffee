'use strict';

class ReapitVendor.Collections.Offices extends Backbone.Collection

    @newFromXML:(xml) ->
      xmlDoc = $($.parseXML( xml ))
      offices = _.map xmlDoc.find('Offices>item'), (office) ->
        ReapitVendor.Models.Office.newFromXMLSegment(office)
      $.when(offices...).then (mods...) ->
        new ReapitVendor.Collections.Offices(mods)
