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
      <section className="main">
        <ul className="expense-list">
          { 
            this.props.expenses.map(expense =>
              <ExpenseItem key={ expense.get('text') } text={ expense.get('text') } />
            ) 
          }
        </ul>
      </section>
    );
  }
}
