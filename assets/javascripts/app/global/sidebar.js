import $ from 'jquery';

const ACTIVE_CLASS = 'active';

$(() => {
  let sidebar = $('aside.sidebar');

  let toggle = () => {
    sidebar.toggleClass(ACTIVE_CLASS);
  };

  $('nav .js-sidebar-toggle').click(toggle);
  $('aside.sidebar .js-close').click(toggle);
});
