describe 'ReapitVendor.Models.Vendor', ->
  it "be able to parse a vendor packet", ->
    xml = '<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns="http://webservice.reapit.com/"><SOAP-ENV:Body><ns1:GetVendorResponse xmlns:ns1="http://schemas.xmlsoap.org/soap/envelope/"><Vendor xsi:type="tns:Vendor"><ID xsi:type="xsd:string">ghost-RPW150023</ID><Title xsi:type="xsd:string">Dr</Title><Initials xsi:type="xsd:string">MV</Initials><Surname xsi:type="xsd:string">Brown</Surname><HouseName xsi:type="xsd:string">The Gables</HouseName><HouseNumber xsi:type="xsd:string">24a</HouseNumber><Address1 xsi:type="xsd:string">Park Avenue</Address1><Address2 xsi:type="xsd:string">Allborough</Address2><Address3 xsi:type="xsd:string">Anytown</Address3><Address4 xsi:type="xsd:string">Alltownshire</Address4><Postcode xsi:type="xsd:string">RP24 W01</Postcode><Telephone xsi:type="xsd:string">01632 960024</Telephone><Fax xsi:type="xsd:string">01632 960025</Fax><Email xsi:type="xsd:string">vendor@reapit.com</Email><Mobile xsi:type="xsd:string">07700 900035</Mobile></Vendor></ns1:GetVendorResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>'
    rv = ReapitVendor.Models.Vendor.newFromXML(xml)

    expect(rv.get('id')).to.equal 'ghost-RPW150023'
    expect(rv.get('title')).to.equal 'Dr'
    expect(rv.get('initials')).to.equal 'MV'
    expect(rv.get('surname')).to.equal 'Brown'
