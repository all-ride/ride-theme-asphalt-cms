# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [1.7.12] - 2020-02-06
### Updated
- Changed breadcrumbs tpl to play well with structured data for Google Breadcrumbs

## [1.7.11] - 2019-01-23
### Updated
- added enctype to entry node form

## [1.7.10] - 2017-07-11
### Fixed
- fix "add section" buttons: append and prepend properly
- implemented locale for js call to retrieve the entries

## [1.7.9] - 2017-05-29
### Fixed
- unavailable widgets (unpublished / not available in current locale) should be opaque. But it's dropdown menu should still be available.

## [1.7.8] - 2017-05-19
### Fixed
- fix error logs being logged to FE console

## [1.7.7] - 2017-05-19
### Fixed
- fix problem where a widget is not draggable right after changing column layout
- added editorconfig file
- added yarn lockfile

## [1.7.6] - 2017-05-16
### Updated
- added tabs to entry page settings view

## [1.7.5] - 2017-05-10
### Added
- home icon for the site tree

## [1.7.4] - 2017-04-12
### Updated
- fixed section layout icons

## [1.7.3] - 2017-04-04
### Updated
- keep alternate names open when setup

## [1.7.2] - 2017-03-27
### Updated
- disable locale mode when there's only one locale specified
- fix some linting errors

## [1.7.1] - 2017-03-24
### Updated
- added missing include to fix node header in backend

## [1.7.0] - 2017-03-24
### Added
- support for home node
- checkbox in node content to hide widgets in another locale

## [1.6.0] - 2017-01-17
### Added
- added template for a widget error

## [1.5.1] - 2017-01-13
### Updated
- fixed composer.json back to asphalt-cms

## [1.5.0] - 2017-01-13
### Removed
- modifier.text: use smarty-cms module for the CMS integration of Smarty

## [1.4.1] - 2016-12-07
### Updated
- updated node.actions template to support cms.url parameters

## [1.4.0] - 2016-12-07
### Updated
- moved view page tab in the backend to a button underneath the page title

## [1.3.0] - 2016-11-15
### Added
- added content mapper field to the properties of a content entry widget

## [1.2.0] - 2016-10-25
### Updated
- added tabs to the properties of title widget
- title widget template to support custom titles with an anchor
- menu widget template to create a menu based on the custom titles with an anchor, usefull for a TOC or one pagers

## [1.1.1] - 2016-10-20
### Added
- CHANGELOG.md file

### Updated
- Permission check for widget actions, set strategy to AND so a user needs access to the permission and the route

## [1.1.0] - 2016-10-18
### Added
- Added icons to the create node dropdown
