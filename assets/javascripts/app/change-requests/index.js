import $ from 'jquery';
import runInitializer from 'lib/run-initializer';

runInitializer('.change_requests.index', () => {
  $('.tiles .tile-status').click(function(evt) {
    evt.preventDefault();
    $(this).closest('.tiles').toggleClass('active');
  });

  $('.tile .toggle-more-actions').click(function(evt) {
    evt.preventDefault();
    $(this).closest('.tile').find('.more-actions').toggleClass('active');
  });

  $('.tile .toggle').click(function(evt) {
    evt.preventDefault();
    let $tile = $(this).closest('.tile');
    [
      $tile,
      $tile.find('.more-actions')
    ].forEach($el => $el.toggleClass('active'));
  });
});
