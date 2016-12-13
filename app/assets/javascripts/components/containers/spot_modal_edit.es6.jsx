class SpotModalEdit extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      spots: this.props.spots,
      selectedSpot: null
    }
    this.handleSpotSelect = this.handleSpotSelect.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
  }
  handleSpotSelect(newSpot) {
    this.setState({selectedSpot: newSpot});
  }
  handleDelete(oldSpotId) {
    const spots = this.state.spots.filter((spot) => {
      return spot.id !== oldSpotId;
    });
    this.setState({
      selectedSpot: null,
      spots: spots
    });
  }
  render() {
    if(this.state.selectedSpot) {
      return (
        <form id="users-spots-edit-form">
          <div className="form-group">
            <SpotModalSelect spots={this.state.spots} selectedSpot={this.state.selectedSpot} handleSpotSelect={this.handleSpotSelect} />
          </div>
          <SpotModalEditForm spot={this.state.selectedSpot} handleDelete={this.handleDelete} />
        </form>
      );
    } else {
      return (
        <form id="users-spots-edit-form">
          <div className="form-group">
            <SpotModalSelect spots={this.state.spots} selectedSpot={this.state.selectedSpot} handleSpotSelect={this.handleSpotSelect} />
          </div>
        </form>
      );
    }
  }
}

SpotModalEdit.propTypes = {
  spots: React.PropTypes.array
};
