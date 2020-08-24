SimpleForm.setup do |config|
  config.wrappers :radio_list_group, error_class: 'is-invalid', item_label_class: 'mb-0', item_wrapper_tag: 'label', item_wrapper_class: 'list-group-item list-group-item-action mb-0 pl-5', tag: 'div', class: 'list-group' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label
    b.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid', label: false
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
  end
end
