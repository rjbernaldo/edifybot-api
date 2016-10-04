import React, { Component } from 'react';
import ExpenseList from './ExpenseList';
import { showModal } from '../actions';
import { ModalContainer } from '../containers/ModalContainer';

let createHandlers = function(dispatch) {
  let handleOpenModal = function(data) {
    dispatch(showModal(data));
  };

  let handleCloseModal = function(data) {
    dispatch(hideModal(data));
  };

  return {
    handleOpenModal,
    handleCloseModal
  };
}

export default class CashmereApp extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    let handlers = createHandlers(this.props.dispatch);
    let expenses = this.props.expenses.data;

    return (
      <div style={{padding: '10px'}}>
        <div className="row right">
          <div className="col">
            <h2>Today</h2>
          </div>
        </div>
        <div className="row">
          <div className="col">
            <ExpenseList handlers={ handlers } expenses={ expenses } />
          </div>
        </div>
        <ModalContainer handlers={ handlers } />
      </div>
    );
  }
}
