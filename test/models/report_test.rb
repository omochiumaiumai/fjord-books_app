# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    alice = users(:Alice)
    bob = users(:Bob)

    alice_report = alice.reports.create(title: 'Hi', content: 'My name is Alice.')

    assert_not alice_report.editable?(bob)
    assert alice_report.editable?(alice)
  end

  test '#created_on' do
    travel_to Time.zone.local(2023, 2, 15, 0, 0, 0) do
      alice = users(:Alice)

      report = Report.create(user_id: alice.id, title: 'hi.', content: 'I am glad to meet you.')
      assert_equal 'Wed, 15 Feb 2023'.to_date, report.created_on
    end
  end
end
