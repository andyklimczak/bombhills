class SpotModalSelect extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedSpot: this.props.selectedSpot,
      spots: this.props.spots
    };
    this.handleSpotSelect = this.handleSpotSelect.bind(this);
  }
  componentWillReceiveProps(newProps) {
    this.setState({
      selectedSpot: newProps.selectedSpot,
      spots: newProps.spots
    });
  }
  handleSpotSelect(e) {
    const newSpot = this.props.spots.filter((spot) => {
      return spot.id == e.target.value;
    }).shift();
    this.setState({selectedSpot: newSpot});
    this.props.handleSpotSelect(newSpot);
  }
  spotsView() {
    return (
      <div className="form-group">
        <select className="form-control" name="spot_select" onChange={this.handleSpotSelect} value=''>
          <option value=''>Select a spot</option>
          {this.state.spots.map((spot) => {
            return <option value={spot.id} key={spot.id}>{spot.title}</option>
          })}
        </select>
      </div>
    );
  }
  spotsSelectedView() {
    return (
      <div className="form-group">
        <select className="form-control spot-select" onChange={this.handleSpotSelect}>
          {this.state.spots.map((spot) => {
            return <option value={spot.id} key={spot.id}>{spot.title}</option>
          })}
        </select>
      </div>
    );
  }
  render() {
    if(this.state.selectedSpot) {
      return this.spotsSelectedView();
    } else {
      return this.spotsView()
    }
  }
}

SpotModalSelect.propTypes = {
  spots: React.PropTypes.array,
  selectedSpot: React.PropTypes.object
};
