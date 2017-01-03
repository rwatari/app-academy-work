export const allTodos = (state) => {
  return Object.keys(state.todos).map((id) => {
    return state.todos[id];
  });
};

export const stepsByTodoId = (state, todoId) => {
  let steps = [];
  Object.keys(state.steps).forEach((id) => {
    if (state.steps[id].todo_id === todoId) {
      steps.push(state.steps[id]);
    }
  });
  return steps;
};
