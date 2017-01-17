/**
 * Compiled inline version. (Library mode)
 */

/*jshint smarttabs:true, undef:true, latedef:true, curly:true, bitwise:true, camelcase:true */
/*globals $code */

(function(exports, undefined) {
	"use strict";

	var modules = {};

	function require(ids, callback) {
		var module, defs = [];

		for (var i = 0; i < ids.length; ++i) {
			module = modules[ids[i]] || resolve(ids[i]);
			if (!module) {
				throw 'module definition dependecy not found: ' + ids[i];
			}

			defs.push(module);
		}

		callback.apply(null, defs);
	}

	function define(id, dependencies, definition) {
		if (typeof id !== 'string') {
			throw 'invalid module definition, module id must be defined and be a string';
		}

		if (dependencies === undefined) {
			throw 'invalid module definition, dependencies must be specified';
		}

		if (definition === undefined) {
			throw 'invalid module definition, definition function must be specified';
		}

		require(dependencies, function() {
			modules[id] = definition.apply(null, arguments);
		});
	}

	function defined(id) {
		return !!modules[id];
	}

	function resolve(id) {
		var target = exports;
		var fragments = id.split(/[.\/]/);

		for (var fi = 0; fi < fragments.length; ++fi) {
			if (!target[fragments[fi]]) {
				return;
			}

			target = target[fragments[fi]];
		}

		return target;
	}

	function expose(ids) {
		var i, target, id, fragments, privateModules;

		for (i = 0; i < ids.length; i++) {
			target = exports;
			id = ids[i];
			fragments = id.split(/[.\/]/);

			for (var fi = 0; fi < fragments.length - 1; ++fi) {
				if (target[fragments[fi]] === undefined) {
					target[fragments[fi]] = {};
				}

				target = target[fragments[fi]];
			}

			target[fragments[fragments.length - 1]] = modules[id];
		}

		// Expose private modules for unit tests
		if (exports.AMDLC_TESTS) {
			privateModules = exports.privateModules || {};

			for (id in modules) {
				privateModules[id] = modules[id];
			}

			for (i = 0; i < ids.length; i++) {
				delete privateModules[ids[i]];
			}

			exports.privateModules = privateModules;
		}
	}

// Included from: js/tinymce/plugins/localfile/classes/Plugin.js

/**
 * plugin.js
 *
 * Copyright, Moxiecode Systems AB
 * Released under LGPL License.
 *
 * License: http://www.tinymce.com/license
 * Contributing: http://www.tinymce.com/contributing
 */

/*global tinymce:true */

define("tinymce/plugins/localfile", [
], function() {

tinymce.PluginManager.add('localfile', function(editor) {

	var _file = null;

	function browse(file, handler) {
		var f = document.createElement('input');
		f.id = '__browseFiles';
		f.style.display = "none";
		f.type = 'file';
		f.accept = "text/*";
		f.addEventListener('change', handler, false);
		f.onclick = destroyClickedElement;
		var t = editor.getElement();
		t.parentNode.insertBefore(f, null);
		f.click();
	}

	function destroyClickedElement(event) {
		event.target.parentNode.removeChild(event.target);
	}

	function hOpen() {
		browse(null, handleFileOpen);
	}

	function hSave() {
		if (!_file) {
			hSaveAs();
		} else {
			saveToFile(_file);
		}
	}

	function hSaveAs() {
		editor.windowManager.open({
			title: 'Document Name',
			body: {type: 'textbox', name: 'name', size: 40, label: 'Name', value: _file ? _file : ''},
			onsubmit: function(e) {
				var fname = e.data.name;
				// add .html if necessary
				if (!fname.match(/.*\.html?/i)) {
					fname = fname + '.html';
				}
				saveToFile(fname);
			}
		});
	}


	function handleFileOpen(evt) {
		var files = evt.target.files;
		function _create_f_handler(theFile) {
			return function(e) {
				// decode it
				// search for encoding
				var r = e.target.result;
				if ('TextDecoder' in window) {
					var dataView = new DataView(e.target.result);
					var decoder = new TextDecoder();
					r = decoder.decode(dataView);
					var encs = r.match(/<meta\s+http-equiv=Content-Type.*charset=([\w\-]*)/);
					if (encs && encs[1] && !(encs[1] in ["unicode-1-1-utf-8", "utf-8", "utf8"])) {
						decoder = new TextDecoder(encs[1]);
						r = decoder.decode(dataView);
					}
				}
				editor.setContent(r);
				editor.undoManager.clear();
				_file = theFile.name;
			};
		}
		for (var i = 0, f; (f = files[i]); i++) {
			// Only process text and html files.
			if (!f.type.match('text.*')) {
				continue;
			}
			var reader = new FileReader();
			// Closure to capture the file information.
			reader.onload = _create_f_handler(f);
			// Read in the image file as a data URL.
			reader.readAsArrayBuffer(f);
			break;
		}
	}

	function saveToFile(f) {
		var doc = new Blob([editor.save()], {type: 'text/html'});
		var a = document.createElement('a');
		a.href = URL.createObjectURL(doc);
		a.download = f;
		editor.getElement().parentNode.insertBefore(a, null);
		a.onclick = destroyClickedElement;
		a.click();
		_file = f;
	}

	editor.addCommand('mceLocalOpen', hOpen);
	editor.addCommand('mceLocalSave', hSave);
	editor.addCommand('mceLocalSaveAs', hSaveAs);

	editor.addMenuItem('localOpen', {
		text: 'Open',
		cmd: 'mceLocalOpen',
		icon: 'Open',
		shortcut: 'Meta+O',
		context: 'file'
	});

	editor.addMenuItem('localSave', {
		text: 'Save',
		cmd: 'mceLocalSave',
		icon: 'Save',
		shortcut: 'Meta+S',
		context: 'file'
	});

	editor.addMenuItem('localSaveAs', {
		text: 'SaveAs',
		cmd: 'mceLocalSaveAs',
		icon: 'SaveAs',
		context: 'file'
	});

});
});

expose(["tinymce/plugins/localfile"]);
})(window);