import React, { Component } from 'react';
import ExpenseList from './ExpenseList';

export default class CashmereApp extends Component {
  getExpenses() {
    return this.props.expenses || [];
  }
  render() {
    return (
      <div>
        <section className="cashmere-app">
          <ExpenseList expenses={ this.getExpenses() } />
        </section>
      </div>
    );
  }
}
