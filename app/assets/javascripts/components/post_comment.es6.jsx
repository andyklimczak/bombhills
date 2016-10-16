class PostComment extends React.Component {
  constructor(props) {
    super(props);
    this.handleDelete = this.handleDelete.bind(this);
  }
  handleDelete(e) {
    if(confirm('Delete message?')) {
      $.ajax({
        method: 'DELETE',
        url: `/comments/${this.props.commentId}`,
        dateType: 'JSON',
        contentType: 'application/json',
      }).done(() => {
        this.props.handleDelete(this.props.commentId);
      })
    }
  }
  renderDelete() {
    if(this.props.currentUser && this.props.currentUser.id === this.props.user.id) {
      return (
        <div className="comment-delete">
          <a className="btn btn-danger btn-delete pull-right" onClick={this.handleDelete}>
            <span className="glyphicon glyphicon-remove" aria-hidden="true"></span>
          </a>
        </div>
      );
    }
  }
  render() {
    const href = `/users/${this.props.user.username}`;
    const relativeDate = moment(this.props.createdAt).fromNow();
    return (
      <div className="comment-panel">
        <div className="comment-user-avatar">

        </div>
        <div className="comment">
          <div className="comment-header">
            <div className="comment-username">
              <a href={href}>
                { this.props.user.username }
              </a>
            </div>
            <div className="comment-date" title={ this.props.createdAt }>
              { relativeDate }
            </div>
          </div>
          <div className="comment-body">
            <div className="comment-body-text">
              { this.props.body }
            </div>
            { this.renderDelete() }
          </div>
        </div>
      </div>
    );
  }
}

PostComment.propTypes = {
  body: React.PropTypes.string,
  user: React.PropTypes.object,
  createdAt: React.PropTypes.string,
  commentId: React.PropTypes.number
}
