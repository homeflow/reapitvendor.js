describe 'ReapitVendor.Models.Property', ->
  it "be able to parse a property packet", ->
    xml = '<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns="http://webservice.reapit.com/"><SOAP-ENV:Body><ns1:GetGeneralPropertyResponse xmlns:ns1="http://schemas.xmlsoap.org/soap/envelope/"><Property xsi:type="tns:GeneralProperty"><ID xsi:type="xsd:string">ghost-RPW150001</ID><SalePrice xsi:type="xsd:int">340000</SalePrice><SaleMaxPrice xsi:type="xsd:int">385000</SaleMaxPrice><SalePriceString xsi:type="xsd:string">&amp;#163;340,000</SalePriceString><SaleStatus xsi:type="xsd:string">New Instruction</SaleStatus><WeeklyRent xsi:type="xsd:double">340</WeeklyRent><RentString xsi:type="xsd:string">&amp;#163;340 pw (&amp;#163;1,473 pcm)</RentString><RentalPeriod xsi:type="xsd:string">week</RentalPeriod><LettingStatus xsi:type="xsd:string">New Instruction</LettingStatus><Currency xsi:type="xsd:string">GBP</Currency><PriceReduced xsi:type="xsd:dateTime">2015-09-23T06:28:35+01:00</PriceReduced><Size xsi:type="xsd:int">985</Size><MaxSize xsi:type="xsd:int">0</MaxSize><SizeString xsi:type="xsd:string">985 sq ft / 92 sq m</SizeString><NumPlots xsi:type="xsd:int">0</NumPlots><HouseName xsi:type="xsd:string">The Gables</HouseName><HouseNumber xsi:type="xsd:string">24a</HouseNumber><Address1 xsi:type="xsd:string">Park Avenue</Address1><Address2 xsi:type="xsd:string">Allborough</Address2><Address3 xsi:type="xsd:string">Anytown</Address3><Address4 xsi:type="xsd:string">Alltownshire</Address4><Postcode xsi:type="xsd:string">RP24 W01</Postcode><Country xsi:type="xsd:string">GB</Country><Latitude xsi:type="xsd:double">51.501365661621</Latitude><Longitude xsi:type="xsd:double">-0.14189000427723</Longitude><Available xsi:type="xsd:boolean">true</Available><AvailableFrom xsi:type="xsd:date">2015-09-14</AvailableFrom><TimeAmended xsi:type="xsd:dateTime">2015-09-23T16:28:35+01:00</TimeAmended><Status xsi:type="xsd:string">New Instruction</Status><Tenure xsi:type="xsd:string">Freehold</Tenure><Disposal xsi:type="xsd:string">Private Treaty</Disposal><Furnish xsi:type="xsd:string">Part Furnished</Furnish><AgencyType xsi:type="xsd:string">Sole Agent</AgencyType><Description xsi:type="xsd:string">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean dictum, lectus vitae sollicitudin placerat, eros est rhoncus ligula, et tempor odio sem sit amet eros. Aliquam erat volutpat. Nam semper odio tempus lacus pulvinar congue. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam sit amet ipsum eu est rhoncus blandit eu et ante. Ut viverra turpis eu libero malesuada tristique elementum justo lobortis. Quisque at eros lacus, a scelerisque dolor. Nulla facilisi. Donec sit amet ante elit. Pellentesque sagittis volutpat diam, nec interdum leo accumsan ac. Sed sed vulputate felis. Praesent a odio nec dolor tristique viverra. Praesent fermentum risus sit amet quam ultrices posuere. Donec urna urna, congue ut ultricies id, sagittis ac erat. Proin tempus pulvinar mauris vitae lobortis. Vestibulum elementum justo ac sapien cursus porta ullamcorper libero convallis. Maecenas luctus posuere nisi eu pharetra. Proin egestas nisi eu massa vulputate eu porttitor justo gravida. Cras est felis, molestie sit amet posuere nec, lobortis sit amet sapien. Nulla elementum, tortor vel lobortis blandit, nunc odio convallis ante, eu sagittis est velit ac risus. Ut tristique lacinia justo nec rhoncus. Mauris congue, orci vitae viverra interdum, nulla tellus volutpat nunc, a vehicula mi diam ut lacus. Cras commodo bibendum hendrerit. Proin lorem nunc, porttitor a ultrices id, vulputate sit amet diam. Proin id convallis odio. Curabitur porta est eget diam hendrerit non consectetur sem suscipit. In in tortor eu nisi congue faucibus vitae at mi. Duis egestas placerat elit, sit amet gravida nunc gravida ac. Nulla nisl est, pellentesque id iaculis in, iaculis eu justo. Morbi pretium, sem a fringilla commodo, urna leo egestas lorem, ut bibendum lacus augue condimentum quam. Mauris a lacus vel risus fermentum rhoncus ac in ipsum.</Description><AccommodationSummary xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:string[7]"><item xsi:type="xsd:string">12 Bedrooms</item><item xsi:type="xsd:string">Entrance Vestibule</item><item xsi:type="xsd:string">Lounge</item><item xsi:type="xsd:string">Dining Room</item><item xsi:type="xsd:string">Kitchen/breakfast Room</item><item xsi:type="xsd:string">Scullery/utility Room</item><item xsi:type="xsd:string">En-suite Bathroom</item></AccommodationSummary><Image xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="tns:Image[1]"><item xsi:type="tns:Image"><Filepath xsi:type="xsd:string">lib/Reapit/RPS/Ghost/Images/Property.jpg</Filepath><Caption xsi:type="xsd:string">Front Elevation</Caption><TimeAmended xsi:type="xsd:dateTime">2015-09-23T16:28:35+01:00</TimeAmended></item></Image><PDF xsi:type="xsd:boolean">false</PDF><Office xsi:type="tns:Office"><ID xsi:type="xsd:string">ghost-RPW</ID></Office><Negotiator xsi:type="tns:Negotiator"><ID xsi:type="xsd:string">ghost-RPW</ID></Negotiator><DoubleBedrooms xsi:type="xsd:string">4</DoubleBedrooms><SingleBedrooms xsi:type="xsd:string">4</SingleBedrooms><ReceptionRooms xsi:type="xsd:string">3</ReceptionRooms><Bathrooms xsi:type="xsd:string">3</Bathrooms><TotalBedrooms xsi:type="xsd:string">4</TotalBedrooms><Type xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:string[1]"><item xsi:type="xsd:string">House</item></Type><Style xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:string[1]"><item xsi:type="xsd:string">Terraced</item></Style><Situation xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:string[1]"><item xsi:type="xsd:string">Basement</item></Situation><Special xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:string[1]"><item xsi:type="xsd:string">Retirement</item></Special></Property></ns1:GetGeneralPropertyResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>'
    rv = ReapitVendor.Models.Property.newFromXML(xml)

    expect(rv.get('id')).to.equal 'ghost-RPW150001'

    #does it reach into objects

    expect(rv.get('style')).to.be.instanceof(Array)
    expect(rv.get('style')).to.include('Terraced')

    expect(rv.get('accommodationsummary')).to.include('Lounge')
    expect(rv.get('accommodationsummary')).to.include('12 Bedrooms')