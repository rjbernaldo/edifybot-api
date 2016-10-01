import React, { Component } from 'react';
import ExpenseList from './ExpenseList';
import { showModal } from '../actions';

let createHandlers = function(dispatch) {
  let handleClick = function(data) {
    dispatch(showModal(data))
  };

  return {
    handleClick
  };
}

export default class CashmereApp extends Component {
  constructor(props) {
    super(props)
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
      </div>
    );
  }
}
