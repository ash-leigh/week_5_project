require('pg')
require_relative('../db/sql_runner')
require_relative('athlete')
require_relative('event')

class AthletesEvents

  attr_reader :id, :athlete_id, :event_id, :athlete_finishing_position

  def initialize(options)
    @id = options['id'].to_i
    @athlete_id = options['athlete_id'].to_i
    @event_id = options['event_id'].to_i
    @athlete_finishing_position = options['athlete_finishing_position'].to_i
  end

  def save()
    sql = "INSERT INTO athletes_events (athlete_id, event_id, athlete_finishing_position) VALUES (#{@athlete_id}, #{@event_id}, #{@athlete_finishing_position}) RETURNING *"
    athlete_event = run(sql).first
    return AthletesEvents.new(athlete_event)
  end

  def self.map_items(sql)
    athletes_events_data = run(sql)
    result = athletes_events_data.map { |athletes_events| AthletesEvents.new(athletes_events)}
    return result
  end

  def self.map_item(sql)
    result = AthletesEvents.map_items(sql)
    return result.first
  end

end