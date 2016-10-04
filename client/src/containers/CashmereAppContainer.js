import { connect } from 'react-redux';
import { requestData, receiveData, invalidateData, showModal, hideModal } from '../actions';
import CashmereApp from '../components/CashmereApp';

function mapStateToProps(state) {
  return state;
}

export const CashmereAppContainer = connect(mapStateToProps)(CashmereApp);
