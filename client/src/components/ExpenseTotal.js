import React, { Component } from 'react';

export default class ExpenseTotal extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <tr>
        <td>Total</td>
        <td></td>
        <td></td>
        <td>{ this.props.amount }</td>
      </tr>
    );
  }
}
