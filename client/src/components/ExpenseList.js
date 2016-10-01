import React, { Component } from 'react';
import ExpenseItem from './ExpenseItem';

export default class ExpenseList extends Component {
  constructor(props) {
    super(props)
  }

  render() {
    const { handleClick } = this.props.handlers;
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
              <ExpenseItem key={ expense.id } expense={ expense } handleClick={ handleClick } />
            )}
          </tbody>
          <tfoot>
            <tr>
              <td>Total</td>
              <td></td>
              <td></td>
              <td>500</td>
            </tr>
          </tfoot>
        </table>
      </section>
    );
  }
}
