window.ReapitVendor =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Template: {}
  init: (args) ->
    ReapitVendor.Models.Auth.clearInstance()
    @auth = ReapitVendor.Models.Auth.getInstance(args.wsdl, args.property_id, args.password)
    @

  login: ->
    @auth.login()

  getMarketingStats: ->
    if @_marketing_stats?
      promise = new jQuery.Deferred()
      promise.resolve(@_marketing_stats)
      return promise
    @auth.marketingStats().done (stat) =>
      @_marketing_stats = stat

  getMarketingStatsView: ->
    promise = new jQuery.Deferred()
    @getMarketingStats().done (marketing_stats) =>
      _marketing_stats_view = new ReapitVendor.Views.MarketingStats(model: marketing_stats)
      promise.resolve(_marketing_stats_view)
    return promise

  getViewings: ->
    if @_viewings?
      promise = new jQuery.Deferred()
      promise.resolve(@_viewings)
      return promise
    @auth.viewings().done (viewing) =>
      @_viewings = viewing

  getViewingsView: ->
    promise = new jQuery.Deferred()
    @getViewings().done (viewings) =>
      _viewings_view = new ReapitVendor.Views.Viewings(collection: viewings)
      promise.resolve(_viewings_view)
    return promise

  getProperty: ->
    if @_property?
      promise = new jQuery.Deferred()
      promise.resolve(@_property)
      return promise
    @auth.property().done (property) =>
      console.log(property.toJSON())
      @_property = property

  getPropertyView: ->
    promise = new jQuery.Deferred()
    @getProperty().done (property) =>
      _vendor_view = new ReapitVendor.Views.Property(model: property)
      promise.resolve(_vendor_view)
    return promise

  getVendor: ->
    promise = new jQuery.Deferred()
    if @_vendor?
      promise.resolve(@_vendor)
      return promise

    @auth.vendor().done ( vendor) =>
     @_vendor = vendor
     promise.resolve(vendor)
    return promise

  getVendorView: ->
    promise = new jQuery.Deferred()
    @getVendor().done (vendor) =>
      _vendor_view = new ReapitVendor.Views.Vendor(model: vendor)
      promise.resolve(_vendor_view)
    return promise


  getOfficesViews: ->
    promise = new jQuery.Deferred()

    _get_offices = =>
      @auth.offices().done (offices) =>
        o_call = =>
         offices = _.map offices.models, (office) ->
           new ReapitVendor.Views.Office(model: office)
        @_offices ||= o_call()
        promise.resolve(@_offices)

    if @_office_views?
      promise.resolve(@_office_views)
    else
      _get_offices().done (offices)=>
        @_office_views = offices

    return promise

class ReapitVendor.Template extends Backbone.View

  setTemplate: (template) ->
    @template = $(template)

  render : () ->
    if @template.html()?
      @template = Liquid.parse(@template.html())
    console.log(@template.render(@args()))
    @$el.html @template.render(@args())
    @
