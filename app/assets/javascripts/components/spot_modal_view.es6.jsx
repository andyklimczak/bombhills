class SpotModalView extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedSpot: null
    };
    this.handleSpotSelect = this.handleSpotSelect.bind(this);
    this.viewSpotClick = this.viewSpotClick.bind(this);
  }
  handleSpotSelect(newSpot) {
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
        <SpotModalSelect spots={this.props.spots} handleSpotSelect={this.handleSpotSelect} />
      </div>
    );
  }
  spotsSelectedView() {
    return (
      <div className="user-spots-select-container">
        <SpotModalSelect spots={this.props.spots} handleSpotSelect={this.handleSpotSelect} />
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
      return this.spotsView();
    }
  }
}

SpotModalView.propTypes = {
  spots: React.PropTypes.array
};
