![Ruby](https://github.com/lewisrobbins/aws-sts/workflows/Ruby/badge.svg?branch=master)
[![Gem Version](https://badge.fury.io/rb/aws-sts.svg)](https://badge.fury.io/rb/aws-sts)

aws-sts
==========

[![asciicast](https://asciinema.org/a/324944.svg)](https://asciinema.org/a/324944)

**The problem:** You want to be able to have short term credentials to your AWS account for security

**The solution:** AWS STS and `aws-sts.rb`

Features
---------

This supports `~/.aws/config` making this tool easier to set-up.

How it Works
-------------

Roles are assumed, or session tokens are simply acquired (if `--no-role` is
specified) via the [`AssumeRole`][assume-role] or the
[`GetSessionToken`][get-session-token] AWS STS API calls.  After this, your
command or shell is launched with the standard AWS credential chain environment
variables set:

 * `AWS_ACCESS_KEY_ID`
 * `AWS_SECRET_ACCESS_KEY`
 * `AWS_SESSION_TOKEN`


Usage
------

Install the tool:

1. `gem install aws-sts`
2. `aws-sts <role>`



Configuration
---

Setup a profile for each role you'd like to use in your `~/.aws/config`.

```ini
[profile account]
region = eu-west-2

[profile dev]
region = eu-north-1
role_arn = arn:aws:iam::1999:role/admin
source_profile = account
```

And then in your `~/.aws/credentials`

```ini
[account]
aws_access_key_id=XXXXXX
aws_secret_access_key=XXX
```

Usage
---
```bash
$ ./aws-sts <role>
export AWS_ACCESS_KEY_ID=SXXXX
export AWS_SECRET_ACCESS_KEY=XXXX
export AWS_SESSION_TOKEN=XXXX
export ASSUMED_ROLE=dev
# run eval $(ruby aws-sts.rb <profile>)
```

By default the credentials last for 3600 seconds or 1 hour.