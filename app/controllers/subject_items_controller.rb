class SubjectItemsController < ApplicationController
  def index
    @subject_items = SubjectItem.all
  end

  def show
    @subject_item = SubjectItem.find(params.expect(:id))
  end
end
