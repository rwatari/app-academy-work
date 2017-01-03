import { connect } from 'react-redux';
import StepListItem from './_step_list_item';
import { receiveStep, removeStep } from '../../actions/step_actions';

const mapDispatchToProps = dispatch => ({
  receiveStep: step => dispatch(receiveStep(step)),
  removeStep: step => dispatch(removeStep(step))
});

export default connect(
  null,
  mapDispatchToProps
)(StepListItem);
