class MeetupAttendeesDropdown extends React.Component {
  constructor(props) {
    super(props);
    this.handleAttendeeSelect = this.handleAttendeeSelect.bind(this);
  }
  handleAttendeeSelect(e) {
    e.target.value && Turbolinks.visit(`/users/${e.target.value}`, { action: 'replace' });
  }
  render() {
    return (
      <p className="form-group">
        <strong>Attendees:</strong>
        <select name="attendees-dropdown" className="form-control attendees-dropdown" onChange={this.handleAttendeeSelect}>
          <option value=''>---</option>
          {this.props.attendees.map((attendee, index) => {
            return <option value={attendee} key={index}>{attendee}</option>
          })}
        </select>
      </p>
    );
  }
}

