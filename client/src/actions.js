import fetch from 'isomorphic-fetch'

export const REQUEST_DATA = 'REQUEST_DATA';
export const RECEIVE_DATA = 'RECEIVE_DATA';
export const UPDATE_DATA = 'UPDATE_DATA';
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
  const expensesUrl = 'http://localhost:3000/users/950498005077644/expenses';

  return function(dispatch) {
    dispatch(requestData())

    return fetch(expensesUrl)
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
  const expensesUrl = 'http://localhost:3000/users/950498005077644/expenses';

  return function(dispatch) {
    return fetch(`${expensesUrl}/${expense.id}`, {
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
