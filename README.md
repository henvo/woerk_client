# WoerkClient
[![Build Status](https://travis-ci.org/henvo/woerk_client.svg?branch=master)](https://travis-ci.org/henvo/woerk_client)
[![Maintainability](https://api.codeclimate.com/v1/badges/32adc598a053cf38024d/maintainability)](https://codeclimate.com/github/henvo/woerk_client/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/32adc598a053cf38024d/test_coverage)](https://codeclimate.com/github/henvo/woerk_client/test_coverage)

WoerkClient is a client for the woerk.net API. It allows you to start
and stop working shifts via command line.

## Requirements

* Ruby 2.1+

## Installation

Install the gem from rubygems:

    $ gem install woerk_client

## Installation/Setup

You need to create a global config file `.woerk.yml` in your home directory:

    # /home/user/.woerk.yml
    ---
    AUTH_TOKEN: '...'

## Usage

Start your working shift

    $ woerk start

And stop your current working shift

    $ woerk stop

Get the current status

    $ woerk status

## Documentation

[here](http://www.rubydoc.info/gems/woerk_client)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
