class PostCommentBox extends React.Component {
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
    const data = { comment: { post_id: this.props.postId, body: this.state.body } }
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
        <textarea rows="5" cols="50" type="text" ref="body" value={this.state.body} onChange={this.handleChange} />
        <a className="btn btn-primary btn-submit" onClick={this.handleSubmit}>
          Submit
        </a>
      </div>
    );
  }
}

