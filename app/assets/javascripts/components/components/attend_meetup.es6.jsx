class AttendMeetup extends React.Component {
  constructor(props) {
    super(props);
    this.joinMeetup = this.joinMeetup.bind(this);
    this.leaveMeetup = this.leaveMeetup.bind(this);
  }
  joinMeetup() {
    const data = { meetup_attendee: { meetup_id: this.props.meetup.id } };
    $.ajax({
      method: 'POST',
      url: '/meetup_attendees',
      dataType: 'JSON',
      contentType: 'application/json',
      data: JSON.stringify(data)
    }).done(data => {
      Turbolinks.visit(window.location, { action: 'replace' });
    });
  }
  leaveMeetup() {
    const data = { meetup_attendee: { meetup_id: this.props.meetup.id } };
    $.ajax({
      method: 'DELETE',
      url: '/meetup_attendees',
      dataType: 'JSON',
      contentType: 'application/json',
      data: JSON.stringify(data)
    }).done(data => {
      Turbolinks.visit(window.location, { action: 'replace' });
    });
  }
  render () {
    if(this.props.attending) {
      return (
        <button type="button" className="btn btn-warning btn-meetup-attendee leave-meetup" onClick={this.leaveMeetup}>
          Leave Meetup
        </button>
      );
    } else {
      return (
        <button type="button" className="btn btn-primary btn-meetup-attendee join-meetup" onClick={this.joinMeetup}>
          Join Meetup
        </button>
      )
    }
  }
}

