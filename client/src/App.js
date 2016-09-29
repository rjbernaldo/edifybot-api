import React, { Component } from 'react';
import { List, Map } from 'immutable';
import CashmereApp from './components/CashmereApp';
import 'whatwg-fetch'

// const expenses = List.of(
//   Map({ id: 1, item: 'Ramen', location: 'Ramen Underground', category: 'Food', amount: 20 }),
// )

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = { expenses: [] };
  }

  componentDidMount() {
    fetch('http://cashmerebot.herokuapp.com/users/950498005077644/search?from=2016-09-29&to=2016-09-29')
      .then((response) => {
        return response.json()
      }).then((expenses) => {
        this.setState({
          expenses: expenses
        });
      });
  }

  render() {
    return (
      <CashmereApp expenses={ this.state.expenses } />
    )
  }
}
