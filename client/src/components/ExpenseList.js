import React, { Component } from 'react';
import ExpenseItem from './ExpenseItem';

export default class ExpenseList extends Component {
  render() {
    return (
      <section className="main">
        <ul className="expense-list">
          { 
            this.props.expenses.map(expense =>
              <ExpenseItem key={ expense.get('text') } text={ expense.get('text') } />
            ) 
          }
        </ul>
      </section>
    )
  }
}
