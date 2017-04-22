class ExpensesController < ApplicationController
  include ResponseHelper
  
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
    user = User.find_by_access_key(params[:access_key])
    return invalid_access_key unless user
    
    render :json => user.expenses.order(created_at: :desc)
  end

  def show
    user = User.find_by_access_key(params[:access_key])
    return invalid_access_key unless user
    
    expense = user.expenses.where(id: params[:id]).take

    render :json => expense
  end

  def update
    user = User.find_by_access_key(params[:access_key])
    return invalid_access_key unless user
    
    expense = user.expenses.where(id: params[:id]).take
    updated_expense = params[:expense]
    expense.update_attributes(
      amount: updated_expense[:amount],
      item: updated_expense[:item],
      location: updated_expense[:location],
      category: updated_expense[:category],
    )

    render :json => expense
  end

  def destroy
    user = User.find_by_access_key(params[:access_key])
    return invalid_access_key unless user
    
    expense = user.expenses.where(id: params[:id]).take
    expense.destroy

    render :json => expense
  end
end
