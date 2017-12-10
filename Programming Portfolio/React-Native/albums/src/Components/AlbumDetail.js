import React from 'react';
import { View, Text, Image, Linking } from 'react-native';
import Card from './Card';
import CardSection from './CardSection';
import Button from './Button';

const AlbumDetail = ({albums}) => {

const {
  title,
  artist,
  thumbnail_image,
  image,
  url
} = albums;

const {
  thumbnailStyle,
  headerContentStyle,
  thumbnailContainerStyle,
  headerTextStyle,
  albumImageStyle
} = styles;

  return (
    <Card>

      <CardSection>
      <View style={thumbnailContainerStyle}>
      <Image source={{uri: "https://www.billboard.com/files/styles/article_main_image/public/media/taylor-swift-2014-sarah-barlow-billboard-650.jpg"}}
       style={thumbnailStyle} />
      </View>
      <View style={headerContentStyle}>
        <Text style={headerTextStyle}>{title}</Text>
        <Text>{artist}</Text>
      </View>

      </CardSection>

      <CardSection>
      <Image source={{uri: image}}
       style={albumImageStyle} />
      </CardSection>

      <CardSection>
      <Button onPress={() => Linking.openURL(url)}>
      BUY NOW
      </Button>
      </CardSection>
    </Card>);

};

const styles = {
  headerContentStyle: {
    flexDirection: 'column',
    justifyContent: 'space-around'
  },
  headerTextStyle: {
    fontSize: 18
  },
  thumbnailStyle: {
    width: 50,
    height: 50,
    borderRadius: 25
  },
  thumbnailContainerStyle: {
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 10,
    marginRight: 10
  },
  albumImageStyle: {
    height: 300,
    flex: 1,
    width: null,
    borderRadius: 20
  }
}
export default AlbumDetail;
