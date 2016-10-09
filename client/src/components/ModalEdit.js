import React, { Component } from 'react';
import { hideModal, updateExpense, deleteExpense } from '../actions';
import { connect } from 'react-redux';

const ModalEdit = ({ expense, dispatch }) => (
  <div className="modal-box">
    <div className="modal" style={{ margin: '16px', borderRadius: '0' }}>
      <span className="close" onClick={() => { dispatch(hideModal()) }}></span>
      <div className="modal-header">Modal Edit</div>
      <div className="modal-body">
        <ul>
          <input className="form-expense-item" type="text" defaultValue={ expense.item }></input>
          <input className="form-expense-location" type="text" defaultValue={ expense.location }></input>
          <input className="form-expense-category" type="text" defaultValue={ expense.category }></input>
          <input className="form-expense-amount" type="text" defaultValue={ expense.amount }></input>
        </ul>
        <button className="button primary" onClick={() => {
          expense.item = document.querySelector('.form-expense-item').value;
          expense.location = document.querySelector('.form-expense-location').value;
          expense.category = document.querySelector('.form-expense-category').value;
          expense.amount = document.querySelector('.form-expense-amount').value;

          dispatch(updateExpense(expense)).then(() => {
            dispatch(hideModal());
          });
        }}>Save</button>
        <button className="button outline" onClick={() => {
          dispatch(deleteExpense(expense)).then(() => {
            dispatch(hideModal());
          });
        }}>Delete</button>
      </div>
    </div>
  </div>
);

export default connect(
  (state, ownProps) => ({
    expense: ownProps.expense
  })
)(ModalEdit)
