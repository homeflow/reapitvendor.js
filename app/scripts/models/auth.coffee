'use strict';

class Singleton
  @getInstance: ->
    @_instance ||= new ReapitVendor.Models.Auth(arguments...)

  @clearInstance: ->
    @_instance = null

class ReapitVendor.Models.Auth extends Singleton

  constructor: (root_url, property_id, password) ->
    @root_url = root_url
    @property_id = property_id
    @password = password
    @token = ""
    @session_id = ''

  isLoggedIn: ->
    @token != ""

  negotiator: (id)->
    negotiatorRequest = new jQuery.Deferred()

    @login().done =>
      $.soap
        url: @root_url
        method: "GetNegotiator"
        noPrefix: true
        data: {
          'ID': id
          'AccessToken': @token
        }
        success: (soapResponse) =>
          xml = soapResponse.toString()
          vendor =  ReapitVendor.Models.Negotiator.newFromXML(xml)
          negotiatorRequest.resolve(vendor)

    negotiatorRequest.promise()


  marketingStats: ->
    defferedRequest = new jQuery.Deferred()
    @login().done =>
      $.soap
        url: @root_url
        method: "GetMarketingStats"
        SOAPHeader: {
          'SessionID': @session_id
        }
        noPrefix: true
        data: {
          'ID': @property_id
          'AccessToken': @token,
        }
        success: (soapResponse) =>
          xml = soapResponse.toString()
          defferedRequest.resolve ReapitVendor.Models.MarketingStats.newFromXML(xml)

    defferedRequest.promise()


  viewings: ->
    defferedRequest = new jQuery.Deferred()
    @login().done =>
      $.soap
        url: @root_url
        method: "GetViewings"
        SOAPHeader: {
          'SessionID': @session_id
        }
        noPrefix: true
        data: {
          'ID': @property_id
          'AccessToken': @token,
        }
        success: (soapResponse) =>
          xml = soapResponse.toString()
          defferedRequest.resolve ReapitVendor.Collections.Viewings.newFromXML(xml)

    defferedRequest.promise()


  offers: ->
    defferedRequest = new jQuery.Deferred()
    @login().done =>
      $.soap
        url: @root_url
        method: "GetOffers"
        SOAPHeader: {
          'SessionID': @session_id
        }
        noPrefix: true
        data: {
          'ID': @property_id
          'AccessToken': @token,
        }
        success: (soapResponse) =>
          xml = soapResponse.toString()
          ReapitVendor.Collections.Offers.newFromXML(xml).done (offers)->
            defferedRequest.resolve(offers)
    defferedRequest.promise()



  property: ->
    propertyRequest = new jQuery.Deferred()
    @login().done =>
      $.soap
        url: @root_url
        method: "GetGeneralProperty"
        noPrefix: true
        data: {
          'ID': @property_id
          'FieldList': ['ID, Price, PriceString, Strapline, HouseName, HouseNumber, Address1, Address2, Address3, Address4, Postcode, Latitude, Longitude, AvailableFrom, Status, Tenure, Description, AccommodationSummary, Bedrooms, Receptions, Bathrooms, Room, Type, Style, Situation, Special, Image, Floorplan, EPC, PrintableDetails, Office, Negotiator']
        }
        success: (soapResponse) =>
          xml = soapResponse.toString()
          ReapitVendor.Models.Property.newFromXML(xml).done (property) =>
            propertyRequest.resolve(property)

    propertyRequest.promise()



  login:  ->
    loginRequest = new jQuery.Deferred

    @session().done =>
      if @token != ""
        loginRequest.resolve()
      else
        request = $.soap
          url: @root_url
          SOAPHeader: {
            'SessionID': @session_id
          }
          method: "VendorLogin"
          noPrefix: true
          data: {
            'ID': @property_id,
            'Password': @password
          }
          success: (soapResponse) =>
            xml = $.parseXML(soapResponse.toString())
            response = $(xml).find('AccessToken').text()
            @token = response
            loginRequest.resolve()
          error: (SOAPResponse) =>
            loginRequest.reject()


    return loginRequest.promise()

  session: ->
    deffered = new jQuery.Deferred()
    if @session_id != ''
      deffered.resolve()
      return deffered.promise()

    request = $.soap
      url: @root_url
      method: "GetSessionID"
      noPrefix: true
      data : {}
      success: (soapResponse) =>
        xml = $.parseXML(soapResponse.toString())
        @session_id = $(xml).find('ID').text()
        deffered.resolve()
      error: (SOAPResponse) =>
        deffered.reject()

    return deffered.promise()

  vendor: ->
    vendorRequest = new jQuery.Deferred()
    @login().done =>
      $.soap
        url: @root_url
        SOAPHeader: {
          'SessionID': @session_id
        }
        method: "GetVendor"
        noPrefix: true
        data: {
          'ID': @property_id
          'AccessToken': @token
        }
        success: (soapResponse) =>
          xml = soapResponse.toString()
          vendor =  ReapitVendor.Models.Vendor.newFromXML(xml)
          vendorRequest.resolve(vendor)

    vendorRequest.promise()


  offices: ->
    officeRequest = new jQuery.Deferred()
    @login().done =>
      request = $.soap (
        url: @root_url
        method: "GetOffices"
        noPrefix: true
        data: {"Fields": "ID, Name, HouseName, HouseNumber, Address1, Address2, Address3, Address4, Postcode, Latitude, Longitude, Telephone, Fax, Email, Image, Negotiator"}
      )

      request.done (data, textStatus, jqXHR) =>
        xml = jqXHR.responseText
        ReapitVendor.Collections.Offices.newFromXML(xml).done (offices)->
          officeRequest.resolve(offices)

    return officeRequest.promise()
