class Spots extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      spots: props.spots,
      selectedSpot: null
    }
    this.updateSpot = this.updateSpot.bind(this);
    this.deleteSpot = this.deleteSpot.bind(this);
    this.handleSpotSelect = this.handleSpotSelect.bind(this);
  }
  updateSpot (spot, data) {
    const index = this.state.spots.indexOf(spot);
    const newSpots = React.addons.update(this.state.spots, { $splice: [[index, 1, data]] })
    this.setState({spots: newSpots, selectedSpot: newSpots[index]});
    console.log(this.state);
  }
  deleteSpot(spot) {
    const index = this.state.spots.indexOf(spot);
    const newSpots = React.addons.update(this.state.spots, { $splice: [[index, 1]] })
    this.setState({spots: newSpots, selectedSpot: null});
  }
  handleSpotSelect(e) {
    const newSpot = this.state.spots.filter((spot) => {
      return spot.id == e.target.value;
    }).shift();
    this.setState({selectedSpot: newSpot});
  }
  render () {
    if (this.state.selectedSpot) {
      return (
        <div className='table-responsive spots-table'>
          <select className='form-control spot-select' onChange={this.handleSpotSelect}>
            {this.state.spots.map((spot) => {
              return <option value={spot.id} key={spot.id}>{spot.title}</option>
            })}
          </select>
          <table className='table'>
            <thead className='hidden-sm hidden-xs'>
              <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Difficulty</th>
                <th>Traffic</th>
                <th></th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <Spot spot={this.state.selectedSpot} key={this.state.selectedSpot.id} handleEditSpot={this.updateSpot} handleDeleteSpot={this.deleteSpot} currentUser={this.props.currentUser} />
            </tbody>
          </table>
        </div>
      );
    } else {
      return (
        <div className='table-responsive spots-table'>
          <select className='form-control' onChange={this.handleSpotSelect} value=''>
            <option value=''>Select a spot</option>
            {this.state.spots.map((spot) => {
              return <option value={spot.id} key={spot.id}>{spot.title}</option>
            })}
          </select>
        </div>
      );
    }
  }
}

Spots.propTypes = {
  spots: React.PropTypes.array
};
