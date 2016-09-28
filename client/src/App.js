import React, { Component } from 'react';
import { List, Map } from 'immutable';
import CashmereApp from './components/CashmereApp';

const expenses = List.of(
  Map({ id: 1, text: 'React1', status: 'active', editing: false }),
  Map({ id: 2, text: 'React2', status: 'active', editing: false }),
  Map({ id: 3, text: 'React3', status: 'active', editing: false }),
  Map({ id: 4, text: 'React4', status: 'active', editing: false }),
)

export default class App extends Component {
  render() {
    return (
      <CashmereApp expenses={ expenses } />
    )
  }
}