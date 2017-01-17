import $ from 'jquery';
import runInitializer from 'lib/run-initializer';

function handleToggle(evt) {
  toggleContributionsFor($(evt.target));
}

function toggleContributionsFor($input) {
  const changeRequestId = $input.closest('.contribution').data('change-request-id');
  const checked = $input.prop('checked');
  $('iframe').contents().find(`.ctr-${changeRequestId}`).each((_, contribution) => {
    if (checked) {
      $(contribution).addClass('ctr');
    } else {
      $(contribution).removeClass('ctr');
    }
  });
}

runInitializer('.change_requests.contributions', () => {
  $('.contribution .toggle').click(handleToggle);
  // show contributions for selected, use timeout to give respec time to render
  window.setTimeout(() => {
    toggleContributionsFor($('.selected .toggle').prop('checked', true));
  }, 100);
});
