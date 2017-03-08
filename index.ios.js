/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
} from 'react-native';
import { NativeModules } from 'react-native';
const { PaymentManager } = NativeModules;


export default class NativeView extends Component {
  handlePress(e) {
    PaymentManager.showPaymentViewController()
      .then(res => {
        console.group('resolved');
        console.log(res);
        console.groupEnd();
      })
      .catch(err => {
        console.group('rejected');
        console.log(err);
        console.groupEnd();
      });
  }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity
          activeOpacity={0.5}
          style={{
            backgroundColor: 'green',
            padding: 10,
          }}
          onPress={this.handlePress}
        >
          <Text style={{ color: '#fff'}}>Go to payments</Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('NativeView', () => NativeView);
