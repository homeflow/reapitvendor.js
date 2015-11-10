class ReapitVendor.Views.Viewings extends ReapitVendor.Template

  args: () ->
    return {viewings: @collection.toJSON()}
