'use strict';

class ReapitVendor.Collections.Viewings extends Backbone.Collection

    @newFromXML:(xml) ->
      xmlDoc = $($.parseXML( xml ))
      offices = _.map xmlDoc.find('Viewings>item'), (office) ->
        ReapitVendor.Models.Viewing.newFromXMLSegment(office)
      new ReapitVendor.Collections.Viewings(offices)
