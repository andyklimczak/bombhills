class SpotModalView extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedSpot: null
    };
    this.handleSpotSelect = this.handleSpotSelect.bind(this);
    this.viewSpotClick = this.viewSpotClick.bind(this);
  }
  handleSpotSelect(e) {
    const newSpot = this.props.spots.filter((spot) => {
      return spot.id == e.target.value;
    }).shift();
    this.setState({selectedSpot: newSpot});
  }
  viewSpotClick() {
    if($('#map-id').length) {
      $('#spot-modal').modal('toggle');
      mymap.setView([this.state.selectedSpot.latitude, this.state.selectedSpot.longitude], 12); //global var grossness
    } else {
      Turbolinks.visit("/spots?id=" + this.state.selectedSpot.id, { action: 'replace' });
    }
  }
  spotsView() {
    return (
      <div className="user-spots-select-container">
        <div className="form-group">
          <select className="form-control" onChange={this.handleSpotSelect} value=''>
            <option value=''>Select a spot</option>
            {this.props.spots.map((spot) => {
              return <option value={spot.id} key={spot.id}>{spot.title}</option>
            })}
          </select>
        </div>
      </div>
    );
  }
  spotsSelectedView() {
    return (
      <div className="user-spots-select-container">
        <div className="form-group">
          <select className="form-control" onChange={this.handleSpotSelect}>
            {this.props.spots.map((spot) => {
              return <option value={spot.id} key={spot.id}>{spot.title}</option>
            })}
          </select>
        </div>
        <ul>
          <li id="modal-view-spot" onClick={this.viewSpotClick}>view</li>
        </ul>
      </div>
    );
  }
  render () {
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
