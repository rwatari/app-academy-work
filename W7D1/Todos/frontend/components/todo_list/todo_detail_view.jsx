import React from 'react';
import StepListContainer from '../step_list/step_list_container';

class TodoDetailView extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        {this.props.todo.body}

        <StepListContainer todoId={this.props.todo.id}/>

        <button onClick={this.props.removeTodo.bind(null, this.props.todo)}>
          Delete Todo
        </ button>
      </div>

    );
  }
}

export default TodoDetailView;
