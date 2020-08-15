SimpleForm.setup do |config|
  config.wrappers :radio_list_group, item_label_class: 'mb-0', item_wrapper_tag: 'label', item_wrapper_class: 'list-group-item list-group-item-action mb-0 pl-5', tag: 'div', class: 'list-group' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label
    b.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid', label: false
  end
end
