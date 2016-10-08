import fetch from 'isomorphic-fetch'

export const REQUEST_DATA = 'REQUEST_DATA';
export const RECEIVE_DATA = 'RECEIVE_DATA';
export const UPDATE_DATA = 'UPDATE_DATA';
export const INVALIDATE_DATA = 'INVALIDATE_DATA';
// const apiUrl = 'http://localhost:3000';
const apiUrl = 'https://cashmerebot.herokuapp.com';

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
  console.log('API URL': apiUrl);
  const url = `${apiUrl}/users/950498005077644/expenses`;

  return function(dispatch) {
    dispatch(requestData())

    return fetch(url)
      .then(response => response.json())
      .then(json => dispatch(receiveData(json)));
  }
}

export function updateData(expense) {
  return {
    type: UPDATE_DATA,
    expense: expense
  }
}

export function updateExpense(expense) {
  console.log('API URL': apiUrl);
  const url = `${apiUrl}/users/950498005077644/expenses/${expense.id}`;

  return function(dispatch) {
    return fetch(url, {
      method: 'PATCH',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        expense: expense
      })
    })
    .then(response => response.json())
    .then((json) => {
      dispatch(updateData(json))
    });
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
