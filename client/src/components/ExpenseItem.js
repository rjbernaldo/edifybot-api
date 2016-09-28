import React, { Component } from 'react';
import ExpenseInput from './ExpenseInput';

export default class ExpenseItem extends Component {
  render() {
    return (
      <li className="expense">
        <div className="view">
          <input type="checkbox" className="toggle" />
          <label htmlFor="expense">
            { this.props.text }
          </label>
          <button className="destroy"></button>
        </div>
        <ExpenseInput />
      </li>
    )
  }
}