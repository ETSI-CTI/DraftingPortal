import $ from 'jquery';
import runInitializer from 'lib/run-initializer';

const showContributeDialog = evt => {
  evt.preventDefault();
  evt.stopPropagation();

  const body = $('body');
  const glassPane = $('.glass-pane');
  const modal = $('.js-modal-contribute').modal();

  body.addClass('modal-open');
  glassPane.addClass('active');
  modal.show();

  modal.one('hidden.bs.modal', () => {
    body.removeClass('modal-open');
    glassPane.removeClass('active');
  });
};

const selectIssue = evt => {
  const $target = $(evt.currentTarget);
  if ($target.hasClass('selected')) {
    $target.removeClass('selected');
  } else {
    $('.js-issue').removeClass('selected');
    $target.addClass('selected');
  }
};

runInitializer('.change_requests.index', () => {
  $('.js-contribute').click(showContributeDialog);
  $('.js-modal-contribute .js-issue').click(selectIssue);
});
