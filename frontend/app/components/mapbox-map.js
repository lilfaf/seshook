import Ember from 'ember';
import EmberLeafletComponent from 'ember-leaflet/components/leaflet-map';
import TileLayer from 'ember-leaflet/layers/tile';
import MarkerCollectionLayer from 'ember-leaflet/layers/marker-collection';
import CollectionBoundsMixin from 'ember-leaflet/mixins/collection-bounds';
import Config from '../config/environment';

var tileLayer = TileLayer.extend({
  tileUrl: Config.mapBox.tileUrl,
  options: {
    accessToken: Config.mapBox.accessToken,
    mapId: Config.mapBox.mapId
  },
  subdomains: 'abcd',
  minZoom: 0,
  maxZoom: 20
});

var markerCollectionLayer = MarkerCollectionLayer.extend(CollectionBoundsMixin, {
  content: Ember.computed.alias('controller.markers'),

  // used by bounds property from CollectionBoundsMixin
  locations: Ember.computed(function() {
    return this.get('content').mapProperty('latlon');
  }).property('content'),

  // observe content property and refresh map bounds to fit markers
  _contentDidChange: Ember.observer(function() {
    var bounds = this.get('bounds');
    if (!Ember.isEmpty(bounds)) { this.get('parentLayer').get('layer').fitBounds(bounds); }
    this._super();
  }, 'content'),
});

export default EmberLeafletComponent.extend({
  childLayers: [
    tileLayer,
    markerCollectionLayer
  ]
});
