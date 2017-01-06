require 'set'

class ChangeRequestService

  SPECIFICATION = "TS 102 687"
  SPECIFICATION_TITLE = "DCC for ITS"

  CHANGE_REQUESTS = begin
    user_service = UserService.new
    john_smith = user_service.find(:john_smith)
    bill_gates = user_service.find(:bill_gates)
    larry_page = user_service.find(:larry_page)
    tb_official = user_service.find(:tb_official)

    [
      {
        id: 1,
        name: "Review of abbreviations",
        author: john_smith,
        specification: SPECIFICATION,
        title: SPECIFICATION_TITLE,
        status: :drafting,
        last_edited_by: john_smith,
        comment: "Abbreviations changed",
        updated_at: Date.new(2016, 11, 16),
        contributed_at: nil
      },
      {
        id: 2,
        name: "Correction of typos",
        author: john_smith,
        specification: SPECIFICATION,
        title: SPECIFICATION_TITLE,
        status: :contributed,
        last_edited_by: john_smith,
        comment: "English wording",
        updated_at: Date.new(2016, 11, 6),
        contributed_at: Date.new(2016, 11, 6)
      },
      {
        id: 3,
        name: "Enhancement of formula",
        author: john_smith,
        specification: SPECIFICATION,
        title: SPECIFICATION_TITLE,
        status: :accepted,
        last_edited_by: bill_gates,
        comment: "Windows 10 compatibility",
        updated_at: Date.new(2015, 10, 1),
        contributed_at: Date.new(2015, 11, 6)
      },
      {
        id: 4,
        name: "Section 10.2 revised",
        author: john_smith,
        specification: SPECIFICATION,
        title: SPECIFICATION_TITLE,
        status: :implemented,
        last_edited_by: bill_gates,
        comment: "Pre-Processing",
        updated_at: Date.new(2016, 3, 1),
        contributed_at: Date.new(2016, 5, 10)
      },
      {
        id: 5,
        name: "Note added",
        author: john_smith,
        specification: SPECIFICATION,
        title: SPECIFICATION_TITLE,
        status: :noted,
        last_edited_by: john_smith,
        comment: "Add something to the spec",
        updated_at: Date.new(2016, 4, 10),
        contributed_at: Date.new(2016, 4, 10)
      },
      {
        id: 6,
        name: "Clause moved",
        author: bill_gates,
        specification: SPECIFICATION,
        title: SPECIFICATION_TITLE,
        status: :drafting,
        last_edited_by: bill_gates,
        comment: "Remove Google support everywhere",
        updated_at: Date.new(2016, 6, 10),
        contributed_at: nil
      },
      {
        id: 7,
        name: "Table inserted",
        author: bill_gates,
        specification: SPECIFICATION,
        title: SPECIFICATION_TITLE,
        status: :contributed,
        comment: "Add Google support",
        updated_at: Date.new(2016, 5, 10),
        contributed_at: Date.new(2016, 5, 10)
      }
    ].map { |attrs| ChangeRequest.new(attrs) }
  end

  CHANGE_REQUESTS_BY_USER = {
    john_smith: {
      ids: 1..7,
      permissions: {
        1 => %i{ edit merge contribute delete hide },
        2 => %i{ edit merge withdraw delete },
        3 => %i{ hide },
        4 => %i{ hide },
        5 => %i{ edit merge recontribute delete },
        6 => %i{ edit merge hide },
        7 => %i{ edit merge hide }
      }
    },
    bill_gates: {
      ids: [1, 2, 3, 5, 6, 7],
      permissions: {
        1 => %i{ edit merge hide },
        2 => %i{ edit merge hide },
        3 => %i{ hide },
        5 => %i{ edit merge recontribute hide },
        6 => %i{ edit merge contribute delete },
        7 => %i{ edit merge withdraw delete hide }
      }
    },
    larry_page: {
      ids: 1..7,
      permissions: {
        1 => %i{ edit merge hide },
        2 => %i{ edit merge hide },
        3 => %i{ hide apply },
        4 => %i{ hide },
        5 => %i{ edit merge recontribute hide },
        6 => %i{ edit merge hide },
        7 => %i{ edit merge hide }
      }
    },
    tb_official: {
      ids: 1..7,
      permissions: {
        1 => %i{ edit merge contribute delete hide },
        2 => %i{ edit merge withdraw delete hide },
        3 => %i{ delete hide apply },
        4 => %i{ delete hide },
        5 => %i{ edit merge recontribute delete hide },
        6 => %i{ edit merge contribute delete hide },
        7 => %i{ eidt merge withdraw delete hide }
      }
    }
  }

  def initialize
    @contribution_service = ContributionService.new
  end

  def find_by_user(user)
    owner = UserService.new.find(:larry_page)
    definition = CHANGE_REQUESTS_BY_USER[user.id]
    definition[:ids].map do |id|
      ChangeRequests::Show.new(
        change_request: CHANGE_REQUESTS[id - 1],
        owner: owner,
        permissions: Set.new(definition[:permissions][id])
      )
    end.tap do |result|
      def result.group(key)
        group_by { |cr| cr.status }
      end
    end
  end

  def contributions_for(specification:)
    @contribution_service.contributions_for(specification: specification)
  end

end
