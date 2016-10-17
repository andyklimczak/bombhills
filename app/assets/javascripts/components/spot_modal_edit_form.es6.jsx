class SpotModalEditForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      id: this.props.spot.id,
      difficulty: this.props.spot.difficulty,
      title: this.props.spot.title,
      description: this.props.spot.description,
      traffic: this.props.spot.traffic
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleUpdate = this.handleUpdate.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
  }
  componentWillReceiveProps(newProps) {
    this.setState({
      id: newProps.spot.id,
      difficulty: newProps.spot.difficulty,
      title: newProps.spot.title,
      description: newProps.spot.description,
      traffic: newProps.spot.traffic
    });
  }
  handleChange(e) {
    const name = e.target.name
    this.setState({[e.target.name]: e.target.value})
  }
  handleUpdate(e) {
    const data = {
      title: this.refs.title.value,
      description: this.refs.description.value,
      difficulty: this.refs.difficulty.value,
      traffic: this.refs.traffic.value
    };
    $.ajax({
      method: 'PUT',
      url: `/spots/${this.props.spot.id}`,
      dataType: 'JSON',
      contentType: 'application/json',
      data: JSON.stringify(data)
    }).done((data) => {
      this.props.handleUpdate(this.props.spot, data);
    });
  }
  handleDelete(e) {
    if(confirm('Delete spot?')) {
      $.ajax({
        method: 'DELETE',
        url: `/spots/${this.state.id}.json`,
        dateType: 'JSON',
        contentType: 'application/json'
      }).done(() => {
        this.props.handleDelete(this.state.id);
      });
    }
  }
  render() {
    return (
      <div>
        <div className="form-group">
          <input className="form-control" type="text" value={this.state.title} ref="title" name="title" onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <select className="form-control" value={this.state.difficulty} ref="difficulty" name="difficulty" onChange={this.handleChange}>
            <option value="Beginner">Beginner</option>
            <option value="Intermediate">Intermediate</option>
            <option value="Professional">Professional</option>
          </select>
        </div>
        <div className="form-group">
          <textarea className="form-control" rows="1" cols="100" type="text" value={this.state.description} ref="description" name="description" onChange={this.handleChange} />
        </div>
        <div className="form-group">
          <input className="form-control" type="text" value={this.state.traffic} ref="traffic" name="traffic" onChange={this.handleChange} />
        </div>
        <div className="edit-buttons">
          <button type="button" className="btn btn-success" id="modal-update-btn" onClick={this.handleUpdate}>Update</button>
          <button type="button" className="btn btn-warning" id="modal-delete-btn" onClick={this.handleDelete}>Delete</button>
        </div>
      </div>
    );
  }
}

SpotModalEditForm.propTypes = {
  id: React.PropTypes.number,
  difficulty: React.PropTypes.string,
  title: React.PropTypes.string,
  description: React.PropTypes.string,
  traffic: React.PropTypes.string
};
