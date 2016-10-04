class ExpensesController < ApplicationController
  def search
    user = User.find_by_sender_id(params[:sender_id])
    expenses = user.expenses

    if (params[:from] == '' || params[:from] == nil)
      params[:from] = Chronic.parse('today').midnight.to_s
    end

    if (params[:to] == '' || params[:to] == nil)
      params[:to] = Chronic.parse('today').end_of_day.to_s
    end

    expenses = expenses.where(created_at: Chronic.parse(params[:from]).midnight..Chronic.parse(params[:to]).end_of_day)

    unless (params[:q] == '' || params[:q] == nil)
      expenses = expenses.where('item LIKE :search OR location LIKE :search OR category LIKE :search', search: "%#{params[:q]}%")
    end

    render :json => expenses
  end

  def index
    user = User.find_by_sender_id(params[:sender_id])

    render :json => user.expenses
  end

  def show
    user = User.find_by_sender_id(params[:sender_id])
    expense = user.expenses.where(id: params[:id]).take

    render :json => expense
  end

  # def create
  #   user = User.find_by_sender_id(params[:sender_id])
  #   user.expenses.where(id: params[:id])
  # end

  def update
    user = User.find_by_sender_id(params[:sender_id])
    expense = user.expenses.where(id: params[:id]).take
    byebug
    expense.update_attributes(expense)
    
    render :json => expense
  end

  def destroy
    user = User.find_by_sender_id(params[:sender_id])
    expense = user.expenses.where(id: params[:id]).take
    expense.destroy

    render :json => expense
  end
end
