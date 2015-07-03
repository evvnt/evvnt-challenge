class EventSerializer < ActiveModel::Serializer
  attributes \
    :id,
    :title,
    :summary,
    :start_time,
    :end_time,
    :keywords
end
