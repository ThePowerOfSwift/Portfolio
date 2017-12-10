import React, { Component } from 'react';
import { ScrollView } from 'react-native';
import Axio from 'axios';
import AlbumDetail from './AlbumDetail';

class AlbumList extends Component {

state = {albums: []};

componentWillMount(){
  Axio.get('https://rallycoding.herokuapp.com/api/music_albums')
  .then(response => this.setState({ albums: response.data}));
}

renderAlbums () {
  return this.state.albums.map(albums => <AlbumDetail key={albums.title} albums={albums} />) ;
}

  render() {
    return (
        <ScrollView>
          {this.renderAlbums()}
        </ScrollView>

      );
  }
}
export default AlbumList;
