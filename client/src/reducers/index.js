import { combineReducers } from 'redux';
import expenses from './expenses';
import modal from './modal';

export default combineReducers({
  expenses,
  modal
})
