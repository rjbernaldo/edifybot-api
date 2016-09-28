import React, { Component } from 'react';
import PureRenderMixin from 'react-addons-pure-render-mixin';
import ExpenseInput from './ExpenseInput';

export default class ExpenseItem extends Component {
  constructor(props) {
    super(props);
    this.shouldComponentUpdate = PureRenderMixin.shouldComponentUpdate.bind(this);
  }
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