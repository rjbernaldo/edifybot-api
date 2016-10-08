require('whatwg-fetch');
require('./lib/kube-6.0.1/dist/css/kube.css');

import 'react-hot-loader/patch';
import React from 'react';
import ReactDOM from 'react-dom';
import thunkMiddleware from 'redux-thunk';
import createLogger from 'redux-logger';
import { compose, createStore, applyMiddleware } from 'redux';
import { fetchData } from './actions';
import { Provider } from 'react-redux';
// import { AppContainer } from 'react-hot-loader';
import { CashmereAppContainer } from './containers/CashmereAppContainer';
import rootReducer from './reducers';

// const createStoreDevTools = compose(
//   window.devToolsExtension ? window.devToolsExtension() : f => f
// )(createStore)
//
// const store = createStoreDevTools(rootReducer);

const loggerMiddleware = createLogger();
const store = createStore(
  rootReducer,
  applyMiddleware(
    thunkMiddleware,
    loggerMiddleware
  )
)

store.dispatch(fetchData())
// .then(() => {
//   console.log(store.getState());
// })

const rootEl = document.getElementById('app');

ReactDOM.render(
  // <AppContainer>
    <Provider store={ store }>
      <CashmereAppContainer />
    </Provider>,
  // </AppContainer>,
  rootEl
);

// if (module.hot) {
//   module.hot.accept('./containers/CashmereAppContainer', () => {
//     const NextCashmereAppContainer = require('./containers/CashmereAppContainer').CashmereAppContainer;
//     ReactDOM.render(
//       // <AppContainer>
//         <Provider store={ store }>
//           <NextCashmereAppContainer />
//         </Provider>,
//       // </AppContainer>,
//       rootEl
//     );
//   });
// }
