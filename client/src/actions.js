import fetch from 'isomorphic-fetch'

export const REQUEST_DATA = 'REQUEST_DATA';
export const RECEIVE_DATA = 'RECEIVE_DATA';
export const INVALIDATE_DATA = 'INVALIDATE_DATA';

export function requestData() {
  return {
    type: REQUEST_DATA
  };
}

export function receiveData(data) {
  return {
    type: RECEIVE_DATA,
    data: data
  };
}

export function invalidateData() {
  return {
    type: INVALIDATE_DATA
  };
}

export function fetchData() {
  return function(dispatch) {
    dispatch(requestData())

    var data = [
      { id: 1, item: 'Ramen', location: 'Ramen Underground', category: 'Food', amount: '20' },
      { id: 2, item: 'Chicken', location: 'Chicken Underground', category: 'Food', amount: '21' },
      { id: 3, item: 'Pork', location: 'Pork Underground', category: 'Food', amount: '25' }
    ];

    return dispatch(receiveData(data));

    // return fetch('http://google.com')
    //   // .then(response = response.json())
    //   // .then(json => dispatch(receivePosts(json)));
  }
}

export const SHOW_MODAL = 'SHOW_MODAL';
export const HIDE_MODAL = 'HIDE_MODAL';

export function showModal(options) {
  return {
    type: SHOW_MODAL,
    modalType: options.modalType,
    modalProps: options.modalProps
  };
}

export function hideModal() {
  return {
    type: HIDE_MODAL
  };
}
