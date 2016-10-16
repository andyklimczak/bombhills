class PostComments extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      comments: this.props.resource.comments.reverse()
    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
  }
  handleSubmit(newComment) {
    const comments = [newComment].concat(this.state.comments);
    this.setState({comments: comments});
  }
  handleDelete(deletedCommentId) {
    const comments = this.state.comments.filter((comment) => {
      return comment.id !== deletedCommentId;
    });
    this.setState({comments: comments});
  }
  renderCommentBox() {
    if(this.props.currentUser) {
      return <PostCommentBox commentableId={this.props.resource.id} commentableType={this.props.commentableType} handleSubmit={this.handleSubmit} />
    }
  }
  renderComments() {
    if(this.state.comments.length) {
      return this.state.comments.map((comment) => {
        return <PostComment key={comment.id} commentId={comment.id} body={comment.body} user={comment.user} createdAt={comment.created_at} currentUser={this.props.currentUser} handleDelete={this.handleDelete} />
      });
    } else {
      return <h4>No comments</h4>
    }
  }
  render() {
    return (
      <div className="comment-block">
        { this.renderCommentBox() }
        { this.renderComments() }
      </div>
    );
  }
}

PostComments.propTypes = {
  comments: React.PropTypes.array,
  currentUser: React.PropTypes.object
};
