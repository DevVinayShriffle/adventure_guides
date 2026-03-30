class DestinationDraft < Destination
  # is_draft_of infers destination_id from the association
  is_draft_of :destination
  
  # Ensure images or other attachments are handled
  has_many_attached :images 
end