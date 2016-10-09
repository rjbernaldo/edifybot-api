import { REQUEST_DATA, RECEIVE_DATA, UPDATE_DATA, DELETE_DATA } from '../actions';
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
    case DELETE_DATA:
      let index = state.data.findIndex((x) => x.id === action.expense.id);

      return Object.assign({}, state, {
        data: [
          ...state.data.slice(0, index),
          ...state.data.slice(index + 1)
        ]
      });
    default:
      return state;
  }
}
