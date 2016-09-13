import $ from 'jquery';

export default function(selector, initializer) {
  if ($(selector).length > 0) {
    initializer();
  }
}
