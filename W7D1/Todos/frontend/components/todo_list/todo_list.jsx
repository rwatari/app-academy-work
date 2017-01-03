import React from 'react';
import TodoListItem from './_todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <h1>Todo:</h1>
        <ul>
          {this.props.todos.map((todo) => {
            return <TodoListItem todo={todo}
                                 key={todo.id}
                                 removeTodo={this.props.removeTodo}
                                 receiveTodo={this.props.receiveTodo}/>;
          })}
        </ul>
        <TodoForm receiveTodo={this.props.receiveTodo} />
      </div>
    );
  }
}

export default TodoList;
