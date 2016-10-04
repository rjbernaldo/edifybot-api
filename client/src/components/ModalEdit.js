import React, { Component } from 'react';
import { hideModal } from '../actions';
import { connect } from 'react-redux';

const ModalEdit = ({ expense, dispatch }) => (
  <div className="modal-box">
    <div className="modal" style={{ margin: '16px', borderRadius: '0' }}>
      <span className="close" onClick={ () => { dispatch(hideModal()) } }></span>
      <div className="modal-header">Modal Edit</div>
      <div className="modal-body">
        <ul>
          <li>{ expense.item }</li>
          <li>{ expense.location }</li>
          <li>{ expense.category }</li>
          <li>{ expense.amount }</li>
        </ul>
        <button className="button primary">Save</button>
        <button className="button">Cancel</button>
      </div>
    </div>
  </div>
);

export default connect(
  (state, ownProps) => ({
    expense: ownProps.expense
  })
)(ModalEdit)
