class ReapitVendor.Models.Property extends Backbone.Model

    @newFromXML:(xml) ->
      deffered = new jQuery.Deferred()
      xmlDoc = $($.parseXML( xml ))
      console.log(@parseFragment(xmlDoc.find('Property')))
      post_processing_steps = @postProcess(new ReapitVendor.Models.Property(@parseFragment(xmlDoc.find('Property'))))
      $.when(post_processing_steps...).done ->
        deffered.resolve()
      deffered


    @postProcess:(model)->
      promises = []
      ReapitVendor.Models.Auth.getInstance().negotiator(model.get('negotiator').id).done (neg) =>
        model.set(negotiator, neg)


    @parseFragment:(xmlDoc) ->
      output = {}
      for ele in $(xmlDoc).contents()
        if ele.nodeType == 3
          return $(ele).text()
        else
          if ele.nodeName.toLowerCase() == 'item'
            return @parseFragment(ele)
          if $(ele).children()[0] && $(ele).children()[0].nodeName == 'item'
            output[ele.nodeName.toLowerCase()] = _.map $(ele).children(), (e) =>
              @parseFragment(e)
          else
            output[ele.nodeName.toLowerCase()] = @parseFragment(ele)
      output
