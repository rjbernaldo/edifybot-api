import 'react-hot-loader/patch';
import React from 'react';
import ReactDOM from 'react-dom';
import { List, Map } from 'immutable';

import { AppContainer } from 'react-hot-loader';
import CashmereApp from './components/CashmereApp';

const expenses = List.of(
  Map({id: 1, text: 'React1', status: 'active', editing: false}),
  Map({id: 2, text: 'React2', status: 'active', editing: false}),
  Map({id: 3, text: 'React3', status: 'active', editing: false}),
)

ReactDOM.render(
  <CashmereApp expenses={expenses} />,
  documetn.getElementById('app')
);
