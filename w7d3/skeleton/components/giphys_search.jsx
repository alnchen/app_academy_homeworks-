import React from 'react';

import GiphysIndex from './giphys_index';

class GiphysSearch extends React.Component {
  constructor() {
    super();
    this.state = { searchTerm: 'golden+retriever' };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  componentDidMount() {
    this.props.fetchSearchGiphys('golden+retriever');
  }

  handleChange(e) {
    this.setState({ searchTerm: e.currentTarget.value });
  }

  handleSubmit(e) {
    e.preventDefault();
    let searchTerm = this.state.searchTerm.split(' ').join('+');
    this.props.fetchSearchGiphys(searchTerm);
  }

  render() {
    let { giphys } = this.props;

    return (
      <div>
        <form>
          <label>Gif Search</label>
          <input onChange={this.handleChange}type="text" value={this.state.searchTerm}></input>
          <button type="submit" onClick={this.handleSubmit}>Find my Gifs!</button>
        </form>
        <GiphysIndex giphys={giphys}/>
      </div>
    );
  }
}

export default GiphysSearch;
