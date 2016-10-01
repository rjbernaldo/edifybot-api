import { List, Map, fromJS } from 'immutable';
import { expect } from 'chai';

import reducer from '../src/reducer';

describe('reducer', () => {
  it('handles SET_STATE', () => {
    const initialState = Map();

    const action = {
      type: 'SET_STATE',
      state: Map({
        expenses: List.of(
          Map({ id: 1, item: 'Ramen', location: 'Ramen Underground', category: 'Food', amount: '20' }),
          Map({ id: 2, item: 'Chicken', location: 'Chicken Underground', category: 'Food', amount: '21' }),
          Map({ id: 3, item: 'Pork', location: 'Pork Underground', category: 'Food', amount: '25' })
        )
      })
    };

    const nextState = reducer(initialState, action);

    expect(nextState).to.equal(fromJS({
      expenses: [
        { id: 1, item: 'Ramen', location: 'Ramen Underground', category: 'Food', amount: '20' },
        { id: 2, item: 'Chicken', location: 'Chicken Underground', category: 'Food', amount: '21' },
        { id: 3, item: 'Pork', location: 'Pork Underground', category: 'Food', amount: '25' }
      ]
    }));
  });

  it('handles SET_STATE with plain JS payload', () => {
    const initialState = Map();

    const action = {
      type: 'SET_STATE',
      state: {
        expenses: [
          { id: 1, item: 'Ramen', location: 'Ramen Underground', category: 'Food', amount: '20' },
          { id: 2, item: 'Chicken', location: 'Chicken Underground', category: 'Food', amount: '21' },
          { id: 3, item: 'Pork', location: 'Pork Underground', category: 'Food', amount: '25' }
        ]
      }
    };

    const nextState = reducer(initialState, action);

    expect(nextState).to.equal(fromJS({
      expenses: [
        { id: 1, item: 'Ramen', location: 'Ramen Underground', category: 'Food', amount: '20' },
        { id: 2, item: 'Chicken', location: 'Chicken Underground', category: 'Food', amount: '21' },
        { id: 3, item: 'Pork', location: 'Pork Underground', category: 'Food', amount: '25' }
      ]
    }));
  });

  it('handles SET_STATE without initial state', () => {
    const action = {
      type: 'SET_STATE',
      state: {
        expenses: [
          { id: 1, item: 'Ramen', location: 'Ramen Underground', category: 'Food', amount: '20' },
          { id: 2, item: 'Chicken', location: 'Chicken Underground', category: 'Food', amount: '21' },
          { id: 3, item: 'Pork', location: 'Pork Underground', category: 'Food', amount: '25' }
        ]
      }
    };
  
    const nextState = reducer(undefined, action);

    expect(nextState).to.equal(fromJS({
      expenses: [
        { id: 1, item: 'Ramen', location: 'Ramen Underground', category: 'Food', amount: '20' },
        { id: 2, item: 'Chicken', location: 'Chicken Underground', category: 'Food', amount: '21' },
        { id: 3, item: 'Pork', location: 'Pork Underground', category: 'Food', amount: '25' }
      ]
    }));
  });
});
