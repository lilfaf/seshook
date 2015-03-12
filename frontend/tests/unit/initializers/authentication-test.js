/* jshint expr:true */
import { expect } from 'chai';
import {
  describe,
  it,
  beforeEach
} from 'mocha';
import Ember from 'ember';
import { initialize } from 'frontend/initializers/authentication';

describe('AuthenticationInitializer', function() {
  var container, application;

  beforeEach(function() {
    Ember.run(function() {
      container = new Ember.Container();
      application = Ember.Application.create();
      application.deferReadiness();
    });
  });

  // Replace this with your real tests.
  it('works', function() {
    // initialize(container, application);
    // you would normally confirm the results of the initializer here
    // expect(true).to.be.ok;
  });
});
