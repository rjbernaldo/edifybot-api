import React from 'react';

export default class CashmereApp extends React.Component {
  getExpenses() {
    return this.props.expenses || [];
  }
  render() {
    return <div>
      <section className="cashmereApp">
        <section className="main">
          <ul className="expense-list">
            {this.getExpenses().map(expense =>
              <li className="active" key={expense.get('text')}>
                <div className="view">
                  <input type="checkbox" className="toggle" />
                  <label htmlFor="expense">
                    {expense.get('text')}
                  </label>
                  <button className="destroy"></button>
                </div>
              </li>
            )}
          </ul>
        </section>
      </section>
    </div>
  }
}
