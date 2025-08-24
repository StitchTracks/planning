class SubjectItemsController < ApplicationController
  def index
    @subject_items = SubjectItem.all
  end

  def show
    @subject_item = SubjectItem.find(params.expect(:id))
  end

  def create
    name = params[:name]
    description = params[:description]
    SubjectItem.create(name: name, description: description, sequence: get_next_sequence, level: 1)
    redirect_to subject_items_path
  end

  def get_next_sequence
    highest_sequence = SubjectItem.all.order(sequence: :asc).last.sequence
    highest_sequence + 1
  end
end
