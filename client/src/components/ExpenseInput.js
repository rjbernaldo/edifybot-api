import React, { Component } from 'react';

export default class ExpenseInput extends Component {
  render() {
    return (
      <input className="edit" autoFocus={ true } type="text" />
    );
  }
}