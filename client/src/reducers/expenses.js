import { REQUEST_DATA, RECEIVE_DATA, UPDATE_DATA, INVALIDATE_DATA } from '../actions';
import expense from './expense';

const initialState = {
  isFetching: false,
  data: []
};

export default function expenses(state = initialState, action) {
  switch(action.type) {
    case REQUEST_DATA:
      return Object.assign({}, state, {
        isFetching:  true
      });
    case RECEIVE_DATA:
      return Object.assign({}, state, {
        isFetching: false,
        data: action.data 
      });
    case UPDATE_DATA:
      return Object.assign({}, state, {
        data: state.data.map(e => expense(e, action))
      });
    case INVALIDATE_DATA:
      return Object.assign({}, state, initialState);
    default:
      return state;
  }
}
