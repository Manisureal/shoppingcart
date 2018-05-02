class ConsignmentsController < ApplicationController
  def track
    @consign = current_user.company.consignments.find(params[:id])
    authorize @consign
  end
end
