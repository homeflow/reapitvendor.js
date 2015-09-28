class ReapitVendor.Views.Vendor extends ReapitVendor.Template

  args: () ->
    return {vendor: @model.toJSON()}
