Togglr
======

Togglr is a vim plugin that toggles values (by pressing `<Leader>tw` in normal mode):

* left &harr; right
* top &harr; bottom
* margin-left &harr; margin-right
* etc...

Customizing
-----------

* Set the toggle key:

  ```vim
  let g:togglr_key = 'put-key-here'
  ```

* Add values to toggle between:

  ```vim
  call togglr#add('value1', 'value2')
  ```
