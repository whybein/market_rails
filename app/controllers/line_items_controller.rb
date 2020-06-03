class LineItemsController < ApplicationController
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    # redirect_back fallback_location: root_path
  end
end
