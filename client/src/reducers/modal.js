import { SHOW_MODAL, HIDE_MODAL } from '../actions';

const initialState = {
  isOpen: false,
  options: null
};

export default function modal(state = initialState, action) {
  switch(action.type) {
    case SHOW_MODAL:
      return Object.assign({}, state, {
        isOpen: action.isOpen,
        options: {
          type: action.options.type,
          props: action.options.props
        }
      });
    case HIDE_MODAL:
      return Object.assign({}, state, initialState);
    default:
      return state;
  }
}
