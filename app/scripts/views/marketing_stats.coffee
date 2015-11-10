class ReapitVendor.Views.MarketingStats extends ReapitVendor.Template

  args: () ->
    return {marketing_stats: @model.toJSON()}
