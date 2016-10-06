import { REQUEST_DATA, RECEIVE_DATA, UPDATE_DATA, INVALIDATE_DATA } from '../actions';

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
      var data = state.data;

      return Object.assign({}, state, {
        data: data.map(expense => {
          if (expense.id == action.id) {
            return expense.update(action.expense);
          } else {
            return expense;
          }
        })
      });
    case INVALIDATE_DATA:
      return Object.assign({}, state, initialState);
    default:
      return state;
  }
}
