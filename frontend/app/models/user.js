import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  username:             DS.attr('string'),
  email:                DS.attr('string'),
  password:             DS.attr('string'),
  passwordConfirmation: DS.attr('string'),
  avatar:               DS.attr('string'),
  avatar_medium:        DS.attr('string'),
  avatar_thumb:         DS.attr('string'),
  createdAt:            DS.attr('date'),
  updatedAt:            DS.attr('date'),

  isntValid: Ember.computed.not('isValid')
});