class ReapitVendor.Views.PropertyUserInteractions extends ReapitVendor.Template

  args: () ->
    return {property_user_interactions: @collection.toJSON()}
