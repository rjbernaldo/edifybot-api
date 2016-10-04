import React, { Component } from 'react';
import { connect } from 'react-redux';
import ModalEdit from '../components/ModalEdit';

const MODAL_COMPONENTS = {
  'EDIT_EXPENSE': ModalEdit
}

const ModalRoot = ({ modalType, modalProps }) => {
  if (!modalType) {
    return <span />
  }

  const SpecificModal = MODAL_COMPONENTS[modalType]
  return <SpecificModal {...modalProps} />
}

function mapStateToProps(state) {
  return state.modal;
}

export const ModalContainer = connect(mapStateToProps)(ModalRoot);
