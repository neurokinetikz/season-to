class BundlesController < ApplicationController
  before_filter :load_bundle, only: [:show]

  protected
    def load_bundle
      @bundle = Bundle.find params[:id]
    end
end
