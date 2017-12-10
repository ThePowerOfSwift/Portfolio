import React from 'react';
import { Text,View } from 'react-native'

const Header  =  (props) => {
  const {textStyle,viewStyle} = Styles;
  return (
    <View style={viewStyle}>
    <Text style={textStyle}>{props.headerText}</Text>
    </View>
  );
}

const Styles = {
  viewStyle: {
    backgroundColor: '#007aff',
    justifyContent: 'center',
    alignItems: 'center',
    height: 60,
    paddingTop: 15,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2},
    shadowOpacity: 0.2,
    elevation: 2,
    position: 'relative'
  },
  textStyle: {
    fontSize: 20,
    color: '#FFF'
  }
};

export default Header;
