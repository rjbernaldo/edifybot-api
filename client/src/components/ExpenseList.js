import React, { Component } from 'react';
import PureRenderMixin from 'react-addons-pure-render-mixin';
import ExpenseItem from './ExpenseItem';

export default class ExpenseList extends Component {
  constructor(props) {
    super(props);
    this.shouldComponentUpdate = PureRenderMixin.shouldComponentUpdate.bind(this);
  }
  render() {
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
            {
              this.props.expenses.map(expense =>
                <ExpenseItem key={ expense.id } expense={ expense } />
              )
            }
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
