import React, { Component } from 'react';
import PureRenderMixin from 'react-addons-pure-render-mixin';

export default class ExpenseItem extends Component {
  constructor(props) {
    super(props);
    this.shouldComponentUpdate = PureRenderMixin.shouldComponentUpdate.bind(this);
  }
  render() {
    return (
      <tr>
        <td>{ this.props.expense.get('item') }</td>
        <td>{ this.props.expense.get('location') }</td>
        <td>{ this.props.expense.get('category') }</td>
        <td>{ this.props.expense.get('amount') }</td>
      </tr>
    );
  }
}
