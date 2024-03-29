# traceindex

A Rake task that helps you find missing indexes in your Rails app.

## Install

Put this line in your Gemfile:
```
gem 'traceindex'
```

Then bundle:
```
% bundle
```


## Usage

Just run the following command in your Rails app directory.

```
% rake traceindex
```

If you want the rake task to fail when errors are found.

```
% FAIL_ON_ERROR=1 rake traceindex
```

If you want the rake task to ignore foreign_keys.

```
% IGNORE_FOREIGN_KEY=1 rake traceindex
```

## How do I tell it to ignore columns?

Create a .traceindex.yaml or .traceindex.yml file in your root directory.

```yaml
ignore_tables:
  - action_mailbox_inbound_emails
  - action_text_rich_texts
  - active_storage_attachments
  - active_storage_blobs
  - active_storage_variant_records
ignore_columns:
  - users.created_user_id
ignore_foreign_keys:
  - users.created_user_id
```

## Copyright

Copyright (c) 2020 Akira Kusumoto. See MIT-LICENSE file for further details.
