import React from 'react';

class StepListItem extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <li>
        {this.props.step.title}<br />
        {this.props.step.body}<br />
      <button onClick={this.props.receiveStep.bind(
          null,
          Object.assign(
            {},
            this.props.step,
            { done: !this.props.step.done}
          ))}>
          {this.props.step.done ? "Undo" : "Done"}
        </button>

        <button onClick={this.props.removeStep.bind(
            null,
            this.props.step
          )}>
          Delete Step
        </button>
      </li>
    );
  }
}

export default StepListItem;
