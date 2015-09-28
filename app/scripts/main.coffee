window.ReapitVendor =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: (args) ->
    console.log('init')
    ReapitVendor.Models
    @auth = ReapitVendor.Models.Auth.getInstance('http://localhost:4567/reapit/', args.property_id, args.password)
    #@auth.vendor().done (vendor) ->
    #  new ReapitVendor.Views.Vendor(model: vendor)
    Backbone.history.start()
    @


  getVendorView: ->
    promise = new jQuery.Deferred()
    @auth.vendor().done (vendor) =>
      @_vendor ||= new ReapitVendor.Views.Vendor(model: vendor)
      promise.resolve(@_vendor)
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

$ ->
  window.reapit_vendor = ReapitVendor.init({property_id: 'guest', password: 'password'});
  window.reapit_vendor.getVendorView().done (vendor_view) ->
    vendor_view.setTemplate('#vendor_template')
    vendor_view.setElement('#container')
    vendor_view.render()


class ReapitVendor.Template extends Backbone.View

  setTemplate: (template) ->
    @template = $(template)

  render : () ->
    if @template.html()?
      @template = Liquid.parse(@template.html())
    @$el.html @template.render(@args())
    @
