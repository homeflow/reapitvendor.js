class ReapitVendor.Views.Property extends ReapitVendor.Template

    args: () ->
      output = {property: @model.toJSON()}
      output.property.negotiator = output.property.negotiator.toJSON()
      output
