import React from 'react';
import TodoDetailView from './todo_detail_view_container';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);

    this.state = { detail: false };
    this.toggleDetail = this.toggleDetail.bind(this);
  }

  toggleDetail() {
    this.setState({ detail: !this.state.detail });
  }

  render() {
    let showDetail = () => {
      if (this.state.detail) {
        return <TodoDetailView todo={this.props.todo} />;
      }
    };

    return (
      <li>
        <h3 onClick={this.toggleDetail}>
          {this.props.todo.title}
        </h3>
        <button onClick={this.props.receiveTodo.bind(
            null,
            Object.assign({}, this.props.todo, {done: !this.props.todo.done})
          )}>
          {this.props.todo.done ? "Undo" : "Done"}
        </ button>
        {showDetail()}
      </li>

    );
  }
}

export default TodoListItem;
