import React, { Component } from 'react';
import ExpenseItem from './ExpenseItem';
import ExpenseTotal from './ExpenseTotal';

export default class ExpenseList extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { handleOpenModal } = this.props.handlers;
    let expenses = this.props.expenses;

    return (
      <section>
        <table>
          <thead>
            <tr>
              <th>Item</th>
              <th>Location</th>
              <th>Category</th>
              <th>Amount</th>
            </tr>
          </thead>
          <tbody>
            {expenses.map(expense =>
              <ExpenseItem key={ expense.id } expense={ expense } handleOpenModal={ handleOpenModal } />
            )}
          </tbody>
          <tfoot>
            <ExpenseTotal amount={ expenses.reduce((a,b) => {
              return a + parseInt(b.amount);
            }, 0)}></ExpenseTotal>
          </tfoot>
        </table>
      </section>
    );
  }
}
