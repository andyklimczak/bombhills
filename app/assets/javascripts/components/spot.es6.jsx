class Spot extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      edit: false,
    }
    this.handleToggle = this.handleToggle.bind(this);
    this.handleEdit = this.handleEdit.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
    console.log(props);
  }
  handleToggle () {
    this.setState({edit: !this.state.edit});
  }
  handleEdit (e) {
    const data = {title: this.refs.title.value, description: this.refs.description.value, difficulty: this.refs.difficulty.value, traffic: this.refs.traffic.value};
    $.ajax({
      method: 'PUT',
      url: `/spots/${this.props.spot.id}`,
      dataType: 'JSON',
      contentType: 'application/json',
      data: JSON.stringify(data)
    }).done((data) => {
      this.setState({edit: false});
      this.props.handleEditSpot(this.props.spot, data);
    });
  }
  handleDelete (e) {
    $.ajax({
      method: 'DELETE',
      url: `/spots/${this.props.spot.id}`,
      dataType: 'JSON',
      contentType: 'application/json'
    }).done(() => {
      this.props.handleDeleteSpot(this.props.spot);
    });
  }
  spotRowCurrentUser () {
    const href = `/spots?id=${this.props.spot.id}`;
    return (
      <tr>
        <td>{this.props.spot.title}</td>
        <td className='hidden-sm hidden-xs'>
          {this.props.spot.description}
        </td>
        <td className='hidden-sm hidden-xs'>
          {this.props.spot.difficulty}
        </td>
        <td className='hidden-sm hidden-xs'>
          {this.props.spot.traffic}
        </td>
        <td>
          <a className='btn btn-info btn-view' href={href}>
            View
          </a>
        </td>
        <td>
          <a className='btn btn-default btn-edit' onClick={this.handleToggle}>
            Edit
          </a>
        </td>
      </tr>
    );
  }
  spotRow () {
    const href = `/spots?id=${this.props.spot.id}`;
    return (
      <tr>
        <td>{this.props.spot.title}</td>
        <td className='hidden-sm hidden-xs'>
          {this.props.spot.description}
        </td>
        <td className='hidden-sm hidden-xs'>
          {this.props.spot.difficulty}
        </td>
        <td className='hidden-sm hidden-xs'>
          {this.props.spot.traffic}
        </td>
        <td>
          <a className='btn btn-info btn-view' href={href}>
            View
          </a>
        </td>
      </tr>
    );
  }
  spotForm () {
    return (
      <tr>
        <td>
          <input className='form-control' type='text' defaultValue={this.props.spot.title} ref='title' />
        </td>
        <td>
          <textarea className='form-control' rows='5' cols='100' type='text' defaultValue={this.props.spot.description} ref='description'/>
        </td>
        <td>
          <select className='form-control' defaultValue={this.props.spot.difficulty} ref='difficulty'>
            <option value="Beginner">Beginner</option>
            <option value="Intermediate">Intermediate</option>
            <option value="Professional">Professional</option>
          </select>
        </td>
        <td>
          <input className='form-control' type='text' defaultValue={this.props.spot.traffic} ref='traffic'/>
        </td>
        <td>
          <a className='btn btn-danger btn-delete' onClick={this.handleDelete}>
            Delete
          </a>
        </td>
        <td>
          <a className='btn btn-primary btn-update' onClick={this.handleEdit}>
            Update
          </a>
          <a className='btn btn-default btn-cancel' onClick={this.handleToggle}>
            Cancel
          </a>
        </td>
      </tr>
    )
  }
  render () {
    if (this.state.edit) {
      return this.spotForm();
    } else {
      if (this.props.currentUser === this.props.spot.user_id) {
        return this.spotRowCurrentUser();
      } else {
        return this.spotRow();
      }
    }
  }
}

Spot.propTypes = {
  title: React.PropTypes.string,
  description: React.PropTypes.string,
  difficulty: React.PropTypes.string,
  traffic: React.PropTypes.string,
  user: React.PropTypes.node
};
