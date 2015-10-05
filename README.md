# Reapit Vendor Javascript Client

Allows access to the Reapit Vendor System

## Usage

First set up the reapit vendor client.


### Getting a view
```
reapit_vendor = ReapitVendor.init({
    property_id: 'property_id',
    password: 'password',
    wsdl: 'wsdl_url'
  })
 ```

The client provides methods to get Views of classes, for example - the Vendor Views

```
reapit_vendor.getVendorView().done(function(vendor_view) {
  vendor_view.setTemplate('#vendor_template')
  vendor_view.setElement('#container')
  vendor_view.render()
});
```

Each of these top level methods returns a promise, so 'done', 'failed' and 'pending' functions
should be used to query their state.

Each view returned in an instance of BackBone.View and will render out a liquid template. Both the template and the element
in which to render the template should be set before calling vendor.

### Templates


In the above example the template is contained in the element #vendor_template which is a script tag with the type text/liquid

```
<script id='vendor_template' type="text/liquid">
  test: {{vendor.address1}}
</script>
```

The 'element' is simply a container with the id 'container'

## Building

A recent build of this library is available for Homeflow Ctesius developers and can be included in your theme
by adding 'reapit_vendor' to your included javascript files in the theme's config.yml.

If you wish to build this seperatly, it's a yoeman/backbone project.

Install Node, then in this project's directory:

```
npm install
bower install
grunt serve:watch
```

Included in this repository is a dist directory. If you're unable to build the project you should be able to use that directory to run a prebuild version of the code.

## Reference

An initiated reapit vendor class has the following methods. Methods with a * are yet to be implemented or are not fully implemented

- getVendorView()
- getOfficesView()
- getNegotiatorView()*
- getPropertyView()*
