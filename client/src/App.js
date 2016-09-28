import React, { Component } from 'react';
import { List, Map } from 'immutable';
import CashmereApp from './components/CashmereApp';

const expenses = List.of(
  Map({ id: 1, item: 'Ramen', location: 'Ramen Underground', category: 'Food', amount: 20 }),
)

export default class App extends Component {
  render() {
    return (
      <CashmereApp expenses={ expenses } />
    )
  }
}
