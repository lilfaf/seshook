/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'frontend',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    apiNamespace: 'api',
    apiHost: '',
    contentSecurityPolicy: {
      'img-src': "'self' https://seshook-development.s3-us-west-2.amazonaws.com/ https://*.tiles.mapbox.com/",
    },

    mapBox: {
      tileUrl: 'https://{s}.tiles.mapbox.com/v4/{mapId}/{z}/{x}/{y}.png?access_token={accessToken}',
      accessToken: 'pk.eyJ1IjoibGlsZmFmIiwiYSI6InY2TUktVkUifQ.eVZ3ivj1dlTxTAsJYRQI3g',
      mapId: 'lilfaf.l26132mi'
    },

    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };

  ENV['torii'] = {
    providers: {
      'facebook-oauth2': {
        apiKey: '1085559301459225',
        redirectUri: 'http://localhost:4200',
        scope: 'email,user_birthday'
      }
    }
  };

  ENV['simple-auth'] = {
    authorizer: 'simple-auth-authorizer:oauth2-bearer'
  };

  ENV['simple-auth-oauth2'] = {
    serverTokenEndpoint: '/oauth/token',
    serverTokenRevocationEndpoint: '/oauth/revoke',
  };

  if (environment === 'development') {
    //ENV.APP.LOG_RESOLVER = true;
    //ENV.APP.LOG_ACTIVE_GENERATION = true;
    //ENV.APP.LOG_TRANSITIONS = true;
    //ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    //ENV.APP.LOG_VIEW_LOOKUPS = true;

    ENV.apiHost = 'http://localhost:4200';
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';

    ENV['simple-auth'].store = 'simple-auth-session-store:ephemeral';
  }

  if (environment === 'production') {

  }

  return ENV;
};
