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


  property: ->
    console.log('property')
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
          vendor =  ReapitVendor.Models.Property.newFromXML(xml)
          propertyRequest.resolve(vendor)

    propertyRequest.promise()



  login:  ->
    loginRequest = new jQuery.Deferred()
    if @token != ""
      loginRequest.resolve()
    else
      request = $.soap
        url: @root_url
        method: "VendorLogin"
        noPrefix: true
        data: {
          'ID': @property_id,
          'Password': @password
        }
        success: (soapResponse) =>
          xml = $.parseXML(soapResponse.toString())
          @token = $(xml).find('AccessToken').text()
          loginRequest.resolve()
        error: (SOAPResponse) =>
          loginRequest.reject()


    return loginRequest.promise()


  vendor: ->
    vendorRequest = new jQuery.Deferred()
    @login().done =>
      $.soap
        url: @root_url
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
