/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 225);
/******/ })
/************************************************************************/
/******/ ({

/***/ 150:
/*!************************************************************************!*\
  !*** ./app/javascript/packs/store/modules/dashboard/mutation-types.js ***!
  \************************************************************************/
/*! exports provided: STATISTICS_FETCHED, GENDERS_FETCHED, TOP_USERS_FETCHED, default */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "STATISTICS_FETCHED", function() { return STATISTICS_FETCHED; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "GENDERS_FETCHED", function() { return GENDERS_FETCHED; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "TOP_USERS_FETCHED", function() { return TOP_USERS_FETCHED; });
var STATISTICS_FETCHED = 'STATISTICS_FETCHED';
var GENDERS_FETCHED = 'GENDERS_FETCHED';
var TOP_USERS_FETCHED = 'TOP_USERS_FETCHED';

/* harmony default export */ __webpack_exports__["default"] = ({
  STATISTICS_FETCHED: STATISTICS_FETCHED,
  GENDERS_FETCHED: GENDERS_FETCHED,
  TOP_USERS_FETCHED: TOP_USERS_FETCHED
});

/***/ }),

/***/ 225:
/*!*******************************************************************!*\
  !*** ./app/javascript/packs/store/modules/dashboard/mutations.js ***!
  \*******************************************************************/
/*! exports provided: default */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__mutation_types__ = __webpack_require__(/*! ./mutation-types */ 150);
var _mutations$STATISTICS;

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }



/* harmony default export */ __webpack_exports__["default"] = (_mutations$STATISTICS = {}, _defineProperty(_mutations$STATISTICS, __WEBPACK_IMPORTED_MODULE_0__mutation_types__["STATISTICS_FETCHED"], function (state, statistics) {
  state.statistics = statistics;
}), _defineProperty(_mutations$STATISTICS, __WEBPACK_IMPORTED_MODULE_0__mutation_types__["GENDERS_FETCHED"], function (state, genderPie) {
  state.genderPieData.labels = genderPie.labels;
  state.genderPieData.datasets.data = genderPie.values;
}), _defineProperty(_mutations$STATISTICS, __WEBPACK_IMPORTED_MODULE_0__mutation_types__["TOP_USERS_FETCHED"], function (state, payload) {
  state.newUsers = payload.new_users;
  state.recentDonors = payload.recent_donors;
  state.topDonors = payload.top_donors;
  state.top_value = payload.top_value;
}), _mutations$STATISTICS);

/***/ })

/******/ });
//# sourceMappingURL=mutations-39bb7a1d984990499017.js.map