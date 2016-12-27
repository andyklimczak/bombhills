class CommentBox extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      body: ''
    }
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }
  handleChange(e) {
    this.setState({body: e.target.value});
  }
  handleSubmit(e) {
    const data = { comment: { commentable_id: this.props.commentableId, body: this.state.body, commentable_type: this.props.commentableType } }
    $.ajax({
      method: 'POST',
      url: '/comments',
      dataType: 'JSON',
      contentType: 'application/json',
      data: JSON.stringify(data)
    }).done((comment) => {
      this.props.handleSubmit(comment);
      this.setState({body: ''});
    });
  }
  render () {
    return (
      <div className="comment-box">
        <textarea className="comment-textarea form-control" rows="5" cols="50" type="text" ref="body" value={this.state.body} onChange={this.handleChange} />
        <div className="btn-submit-container">
          <button className="btn btn-primary btn-submit" onClick={this.handleSubmit} disabled={!this.state.body.length > 0}>
            Comment
          </button>
        </div>
      </div>
    );
  }
}

CommentBox.propTypes = {
  commentableId: React.PropTypes.number,
  commentableType: React.PropTypes.string
};
