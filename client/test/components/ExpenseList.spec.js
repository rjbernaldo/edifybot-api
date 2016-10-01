import { List, Map } from 'immutable';
import { expect } from 'chai';
import React from 'react';
import TestUtils from 'react-addons-test-utils';
import ExpenseList from '../../src/components/ExpenseList';

const { renderIntoDocument, scryRenderedDOMComponentsWithTag } = TestUtils;

describe('ExpenseList', () => {
  it('renders a list with only the active items if the filter is active');
    // const expenses = List.of(
    //   Map({ id: 1, text: 'React', status: 'active' }),
    //   Map({ id: 2, text: 'Redux', status: 'active' }),
    //   Map({ id: 3, text: 'Immutable', status: 'completed' }),
    // );
    //
    // const filter = 'active';
    //
    // const component = renderIntoDocument(
    //   <ExpenseList filter={ filter } expenses={ expenses } />
    // );
    //
    // const items = scryRenderedDOMComponentsWithTag(component, 'li');
    //
    // expect(items.length).to.equal(3);
    // expect(items[0].textContent).to.equal('React');
    // expect(items[1].textContent).to.equal('Redux');
});
