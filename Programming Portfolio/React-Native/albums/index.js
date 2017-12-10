import React from 'react';
import { View,AppRegistry } from 'react-native';
import Header from './src/Components/header';
import AlbumList from './src/Components/AlbumList';

const App = () => (
  <View style={{flex: 1}}>
  <Header headerText={'Albums'} />
  <AlbumList />
  </View>
);

AppRegistry.registerComponent('albums', () => App);
