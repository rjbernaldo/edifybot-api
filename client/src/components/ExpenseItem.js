import React, { Component } from 'react';
import { showModal } from '../actions';

export default class ExpenseItem extends Component {
  constructor(props) {
    super(props);
  }

  handleClick() {
    this.props.handleOpenModal({
      modalType: 'EDIT_EXPENSE',
      modalProps: this.props
    });
  }

  render() {
    var handleClick = this.handleClick.bind(this);

    return (
      <tr onClick={ handleClick }>
        <td>{ this.props.expense.item }</td>
        <td>{ this.props.expense.location }</td>
        <td>{ this.props.expense.category }</td>
        <td>{ this.props.expense.amount }</td>
      </tr>
    );
  }
}
