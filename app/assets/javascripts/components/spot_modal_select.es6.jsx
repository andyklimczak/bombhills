class SpotModalSelect extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedSpot: null
    };
    this.handleSpotSelect = this.handleSpotSelect.bind(this);
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
        <select className="form-control" onChange={this.handleSpotSelect} value=''>
          <option value=''>Select a spot</option>
          {this.props.spots.map((spot) => {
            return <option value={spot.id} key={spot.id}>{spot.title}</option>
          })}
        </select>
      </div>
    );
  }
  spotsSelectedView() {
    return (
      <div className="form-group">
        <select className="form-control" onChange={this.handleSpotSelect}>
          {this.props.spots.map((spot) => {
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

SpotModalView.propTypes = {
  spots: React.PropTypes.array
};
