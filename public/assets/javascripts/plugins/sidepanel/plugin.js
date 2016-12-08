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

// Included from: js/tinymce/plugins/sidepanel/classes/ui/SidePanelHeader.js

define("tinymce/ui/SidePanelHeader", [
	"tinymce/ui/TabPanel",
	"tinymce/dom/DomQuery"
], function(TabPanel, $) {
	return TabPanel.extend({
		recalc: function(){},
		render: function(){
			var self = this;
			var containerElm = self.getEl('body');
			var tabsElm = self.getEl('head');
			var prefix = self.classPrefix;
		        
			// Render any new items
			self.items().each(function(ctrl, index) {
		        
				ctrl.parent(self);
				
				if (!ctrl.state.get('rendered')) {
					// prepare button
					var btnId = self._id + '-t' + index;
					var btnHtm =	'<div id="' + btnId + '" class="' + prefix + 'tab" ' +
							'unselectable="on" role="tab" aria-controls="' + ctrl._id + '" aria-selected="false" tabIndex="-1">' +
								self.encode(ctrl.settings.title) +
							'</div>'
		        
					ctrl.aria('role', 'tabpanel');
					ctrl.aria('labelledby', btnId);
					// Insert or append the item
					if (containerElm.hasChildNodes() && index <= containerElm.childNodes.length - 1) {
						$(containerElm.childNodes[index]).before(ctrl.renderHtml());
						$(tabsElm.childNodes[index]).before(btnHtm);
					} else {
						$(containerElm).append(ctrl.renderHtml());
						$(tabsElm).append(btnHtm);
					}
					ctrl.on("remove", function(){
						self._elmCache[btnId] = null;
						$('#'+btnId).remove();
					});
		        
					ctrl.postRender();
				}
			});
		}
	});
});

// Included from: js/tinymce/plugins/sidepanel/classes/Plugin.js

/**
 * plugin.js
 *
 * Released under LGPL License.
 * Copyright (c) 1999-2015 Ephox Corp. All rights reserved
 *
 * License: http://www.tinymce.com/license
 * Contributing: http://www.tinymce.com/contributing
 */

/*global tinymce:true */
/*eslint no-nested-ternary:0 */

define("tinymce/plugins/sidepanel/Plugin", [
	"tinymce/ui/SidePanelHeader",
	"tinymce/dom/DomQuery",
	"tinymce/dom/DOMUtils"
], function(SidePanelHeader, $, DOMUtils) {

var getElementSize = function(elm) {
	var width, height;

	if (elm.getBoundingClientRect) {
		var rect = elm.getBoundingClientRect();

		width = Math.max(rect.width || (rect.right - rect.left), elm.offsetWidth);
		height = Math.max(rect.height || (rect.bottom - rect.bottom), elm.offsetHeight);
	} else {
		width = elm.offsetWidth;
		height = elm.offsetHeight;
	}

	return {width: width, height: height};
};

tinymce.PluginManager.add('sidepanel', function(editor, url) {
	var settings = editor.settings;
	var self = this;
	var panels = {};
	var container;
	var area; 

	// We don't support older browsers like IE6/7 and they don't provide prototypes for DOM objects
	if (!window.NodeList) return;

	// load CSS
	tinymce.DOM.styleSheetLoader.load(url + '/css/sidepanel.css');

	// Prepare left and right pannels. Hide it as no pannel will be shown by default
	editor.on("BeforeRenderUI", function() {
		var theme = editor.theme;
		container = theme.panel;

		// rearrange elements in panel items
		container.items().each(function(p){
			if(p.name() === 'iframe'){
				var n = tinymce.ui.Factory.create(
					{type: 'container', name: 'panels-container', style:'position:relative;',layout: 'stack', items: [
						p,
						{type: 'container', name: 'left-panel-container', classes: 'side-panel-container left', laytout:'stack', width:100, hidden:true, items:[
							{type: 'sidepanelheader', name: 'left-panel', layout:'stack', classes:'tabpanel'},
							{type: 'control', name: 'panel-handler', layout: 'stack', classes: 'resize-handler', html:''},
						]},
						{type: 'container', name: 'right-panel-container', classes: 'side-panel-container right', laytout:'stack', width:100, hidden:true, items:[
							{type: 'sidepanelheader', name: 'right-panel', layout: 'stack', classes:'tabpanel'},
							{type: 'control', name: 'panel-handler', layout: 'stack', classes: 'resize-handler', html:''}
						]}
					]}
				);
				container.replace(p, n);
				area = p;
			}
		});
		panels['left']  = container.find('#left-panel')[0];
		panels['right'] = container.find('#right-panel')[0];

		var rhandlers = container.find('#panel-handler');
		rhandlers.on('postrender', function(e){
			var h    = e.control;
			var cntr = h.parent();
			var side;

			side = 'left';
			if(!cntr._name.startsWith(side)){
				side = 'right';
				if(!cntr._name.startsWith(side)){
					return;
				}
			}
			
			h.resizeDragHelper = new tinymce.ui.DragHelper(h._id, {
				start: function() {
					h.resizeDragHelper.startDragW = getElementSize(cntr.getEl()).width;
				},
				drag: function(e) {
					var w, maxWidth, minWidth;
					var side = h.resizeDragHelper.side;
					maxWidth = parseInt(DOMUtils.DOM.getStyle(cntr.getEl(),'max-width', true), 10) || cntr.parent().layoutRect().w;
					minWidth = parseInt(DOMUtils.DOM.getStyle(cntr.getEl(),'min-width', true), 10) || 0;
					w = h.resizeDragHelper.startDragW + e.deltaX;
					if(w < maxWidth && w > minWidth) {
						DOMUtils.DOM.setStyle(cntr.getEl(), 'width', w + 'px');
						DOMUtils.DOM.setStyle(area.getEl(),'margin-'+side, w + 'px');
					}
				},
				stop: function() {}
			});
			h.resizeDragHelper.side = side;
		});
	}); // BeforeRenderUI

	editor.on("AddSidePanel", function(args) {
		var side, panel, cntr;
		side  = (args['side'] && args['side'] == 'right') ? 'right' : 'left';
		panel = args['panel'] || args['item'];
		panel.classes.add('side-panel');

		panels[side].append(panel).reflow();

		// hack to add tabpanel header
		var header = panels[side].getEl('head');
		var h = DOMUtils.DOM.createFragment(panels[side].renderHtml()).firstChild.firstChild;
		if(h.id == header.id){
			header.innerHTML = h.innerHTML;
		}
		panels[side].activateTab(panels[side].items().length-1);

		cntr = panels[side].parent();
		if(!cntr.visible()){
			cntr.show();
			var w = cntr.layoutRect().w;
			DOMUtils.DOM.setStyle(area.getEl(),'margin-'+side, w + 'px');
		}
	});//AddSidePanel
	
	editor.on("DeleteSidePanel", function(args) {
		var name, panel, side;
		if(args['name']) name = args.name;
		else if(args['panel']){
			name = args.panel.name();
		}else if(args['item']){
			name = args.item.name();
		}else return;

		side = 'left';
		panel = panels[side].find('#'+name)[0];
		if(!panel) {
			side = 'right';
			panel = panels[side].find('#'+name)[0];
			if(!panel) return;
		}
		panel.remove();
		if(panels[side].items().length == 0){
			panels[side].parent().hide();
			DOMUtils.DOM.setStyle(area.getEl(),'margin-'+side, '0px');
		}
	});//DeleteSidePanel
}); // tinymce.PluginManager.add
}); // define

expose(["tinymce/ui/SidePanelHeader","tinymce/plugins/sidepanel/Plugin"]);
})(window);