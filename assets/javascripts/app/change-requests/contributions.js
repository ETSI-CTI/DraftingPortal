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

function updateContribution(evt, contributionClass, iconClass) {
  const $contribution = $(evt.target).closest('.contribution');
  ['contributed', 'drafting'].forEach(cls => {
    $contribution.removeClass(cls);
  });
  $contribution.addClass(contributionClass);
  $contribution.find('.status .fa').addClass(iconClass);
  $contribution.find('.fa').off('click');
}

function handleAccept(evt) {
  updateContribution(evt, 'accepted', 'fa-check-circle');
}

function handleNotAccept(evt) {
  updateContribution(evt, 'not-accepted', 'fa-times-circle');
}

function handleVote(evt, increment) {
  const span = $(evt.target).siblings('span');
  span.html(
    Math.max(0, parseInt(span.html(), 10) + 1)
  );
}

runInitializer('.change_requests.contributions', () => {
  $('.contribution .toggle').click(handleToggle);
  $('.accept').click(handleAccept);
  $('.not-accept').click(handleNotAccept);
  ['drafting', 'contributed'].forEach(state => {
    $(`.${state} .fa-thumbs-up`).click(handleVote);
    $(`.${state} .fa-thumbs-down`).click(handleVote);
  });

  // show contributions for selected, use timeout to give respec time to render
  window.setTimeout(() => {
    toggleContributionsFor($('.selected .toggle').prop('checked', true));
  }, 100);
});
