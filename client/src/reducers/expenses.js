import { REQUEST_DATA, RECEIVE_DATA, INVALIDATE_DATA } from '../actions';

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
    case INVALIDATE_DATA:
      return Object.assign({}, state, initialState);
    default:
      return state;
  }
}
