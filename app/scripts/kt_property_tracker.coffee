$ ->

  actions ={

    overview: ->
      render_property()
      render_stats()

    viewings: ->
      window.reapit_vendor.getViewingsView().done (viewings_view) ->
        viewings_view.setTemplate '#viewings-template'
        viewings_view.setElement '#viewings-view'
        viewings_view.render()

    marketing: ->
      window.reapit_vendor.getMarketingStatsView().done (stats_view) ->
        stats_view.setTemplate '#marketing-tab-template'
        stats_view.setElement '#marketing-tab'
        stats_view.render()

    profile: ->
  }


  $('ul.tabs li').click (event)->
    $('ul.tabs li').each (i, el) ->
      el = $(el)
      el.removeClass('t-active')
      container = el.attr('id').replace('-btn', '-cont')
      $('#' + container).hide()
    el = $(event.target)
    container = el.attr('id').replace('-btn', '-cont')
    el.addClass('t-active')
    actions[el.attr('id').replace('-btn', '')].call()
    $('#' + container).show()


  logged_in = ->
    actions.overview()

  render_vendor = ->
    window.reapit_vendor.getVendorView().done (vendor_view) ->
      vendor_view.setTemplate '#tracker-intro-template'
      vendor_view.setElement '#tracker-intro'
      vendor_view.render()

  render_property = ->
    window.reapit_vendor.getPropertyView().done (property_view) ->
      property_view.setTemplate '#tracker-intro-template'
      property_view.setElement '#tracker-intro'
      property_view.render()

  render_stats = ->
    window.reapit_vendor.getMarketingStatsView().done (stats_view) ->
      stats_view.setTemplate '#marketing-stats-template'
      stats_view.setElement '#marketing-stats'
      stats_view.render()



  $('#tracker-login form').submit (event) ->



    property_id = $('#property_id').val()
    password= $('#password').val()

    window.reapit_vendor = ReapitVendor.init(
      wsdl: 'http://karltatler.reapitcloud.com/webservice/index.php/'
      property_id: property_id
      password: password)
    window.reapit_vendor.login().fail(->
      alert 'could not log you in'
      return
    ).done ->
      $('#tracker-login').hide()
      $('#tracker-body').show()
      logged_in()
    event.preventDefault()
    return
  return
