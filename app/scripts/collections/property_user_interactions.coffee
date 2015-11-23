'use strict';

class ReapitVendor.Collections.PropertyUserInteractions extends Backbone.Collection

  @newFromXML:(xml) ->
    xmlDoc = $($.parseXML( xml ))
    offices = _.map xmlDoc.find('PropertyUserInteractionss>item'), (property_user_interaction) ->
      ReapitVendor.Models.PropertyUserInteraction.newFromXMLSegment(property_user_interaction)
    $.when(property_user_interactions...).then (mods...) ->
      new ReapitVendor.Collections.PropertyUserInteractions(mods)
