# frozen_string_literal: true

module Ashby
  # Ashby::CustomFields manages setting custom field values for objects
  # in the Ashby API, such as jobs or candidates.
  #
  # This class provides a method to assign a specific value to a custom field
  # identified by field ID, for a particular object type and ID.
  #
  # Example:
  #   Ashby::CustomFields.set_field(
  #     object_id: 'job_abc123',
  #     object_type: 'job',
  #     field_id: 'cf_custom_location',
  #     field_value: 'Remote'
  #   )
  #
  class CustomFields < Client
    def self.set_field(object_id: nil, object_type: nil, field_id: nil, field_value: nil)
      raise ArgumentError, '`object_id` is required' if object_id.blank?
      raise ArgumentError, '`object_type` is required' if object_type.blank?
      raise ArgumentError, '`field_id` is required' if field_id.blank?
      raise ArgumentError, '`field_value` is required' if field_value.blank?

      payload = {
        objectId: object_id,
        objectType: object_type,
        fieldId: field_id,
        fieldValue: field_value
      }

      post('customField.setValue', payload)['results']
    end
  end
end
