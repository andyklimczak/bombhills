class PostCommentBox extends React.Component {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
  }
  handleSubmit(e) {
    const data = { comment: { post_id: this.props.postId, body: this.refs.body.value } }
    $.ajax({
      method: 'POST',
      url: '/comments',
      dataType: 'JSON',
      contentType: 'application/json',
      data: JSON.stringify(data)
    }).done((comment) => {
      this.props.handleSubmit(comment);
    });
  }
  render () {
    return (
      <div className="comment-box">
        <textarea rows="5" cols="50" type="text" ref="body" />
        <a className="btn btn-primary btn-submit" onClick={this.handleSubmit}>
          Submit
        </a>
      </div>
    );
  }
}

