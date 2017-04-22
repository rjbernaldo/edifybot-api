module ResponseHelper
  def invalid_access_key
    render :json => { 'error': 'Credentials have expired. Please generate a new report and try again.' }
  end
end