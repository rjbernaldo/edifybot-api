import { SHOW_MODAL, HIDE_MODAL } from '../actions';

const initialState = {
  modalType: null,
  modalProps: {}
};

export default function modal(state = initialState, action) {
  switch(action.type) {
    case SHOW_MODAL:
      return Object.assign({}, state, {
        modalType: action.modalType,
        modalProps: action.modalProps
      });
    case HIDE_MODAL:
      return Object.assign({}, state, initialState);
    default:
      return state;
  }
}
