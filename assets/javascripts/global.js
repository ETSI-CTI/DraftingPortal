import $ from 'jquery';

window.$ = window.jQuery = $;
// needs to be required, importing leads to complaints about missing jQuery
require('bootstrap-sass');

import 'app/app';

