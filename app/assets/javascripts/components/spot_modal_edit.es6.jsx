class SpotModalEdit extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      spots: this.props.spots,
      selectedSpot: null
    }
    this.handleSpotSelect = this.handleSpotSelect.bind(this);
    this.handleUpdate = this.handleUpdate.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
  }
  handleSpotSelect(newSpot) {
    this.setState({selectedSpot: newSpot});
  }
  handleUpdate(spot, data) {
    const index = this.state.spots.indexOf(spot);
    const newSpots = React.addons.update(this.state.spots, { $splice: [[index, 1, data]] })
    this.setState({spots: newSpots, selectedSpot: newSpots[index]});
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
          <SpotModalEditForm spot={this.state.selectedSpot} handleUpdate={this.handleUpdate} handleDelete={this.handleDelete} />
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
