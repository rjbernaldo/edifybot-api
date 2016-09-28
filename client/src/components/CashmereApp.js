import React, { Component } from 'react';
import ExpenseList from './ExpenseList';

export default class CashmereApp extends Component {
  getExpenses() {
    return this.props.expenses || [];
  }
  render() {
    return (
      <div style={{padding: '10px'}}>
        <div className="row right">
          <div className="col">
            <h2>Today</h2>
          </div>
        </div>
        <div className="row">
          <div className="col">
            <ExpenseList expenses={ this.getExpenses() } />
          </div>
        </div>
      </div>
    );
  }
}
