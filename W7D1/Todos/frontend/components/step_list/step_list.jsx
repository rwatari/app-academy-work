import React from 'react';
import StepListItemContainer from './_step_list_item_container';
import StepForm from './step_form';

class StepList extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <ul>
          {this.props.steps.map(step => {
            return <StepListItemContainer step={step} key={step.id} />;
          })}
        </ul>
        <StepForm
          todoId={this.props.todoId}
          receiveStep={this.props.receiveStep} />
      </div>
    );
  }
}

export default StepList;
