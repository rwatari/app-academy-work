import React from 'react';
import ReactDOM from 'react-dom';
import Store from './store/store.js';
import Root from './components/root';

const store = Store();

window.store = store;

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Root store={store} />,
    document.getElementById('root')
  );
});
