import $ from 'jquery';
import runInitializer from 'lib/run-initializer';

runInitializer('.change_requests.index', () => {
  $('.tiles .tile-status').click(function() {
    $(this).closest('.tiles').toggleClass('active');
  });
});