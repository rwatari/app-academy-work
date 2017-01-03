import { combineReducers } from 'redux';
import todoReducer from './todos_reducer';
import stepsReducer from './steps_reducer';


const rootReducer = combineReducers({
  todos: todoReducer,
  steps: stepsReducer
});

export default rootReducer;
