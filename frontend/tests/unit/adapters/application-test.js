/* jshint expr:true */
import { expect } from 'chai';
import {
  describeModule,
  it
} from 'ember-mocha';

describeModule(
  'adapter:application',
  'ApplicationAdapter',
  {
    // Specify the other units that are required for this test.
    // needs: ['serializer:foo']
  },
  function() {
    // Replace this with your real tests.
    it('exists', function() {
      var adapter = this.subject();
      expect(adapter).to.be.ok;
    });

    it('config namespace', function() {
      expect(this.subject().namespace).to.equal('api');
    });

    it('config host', function() {
      expect(this.subject().host).to.equal('');
    });
  }
);
