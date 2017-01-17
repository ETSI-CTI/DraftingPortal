class IssueService

  ISSUES = begin
    change_request_service = ChangeRequestService.new

    [
      {
        id: 1,
        ticket_id: 2172,
        specification: "TS 102 687",
        branch: "master",
        summary: "There are lots of typos",
        associated_contributions: [2],
        status: :assigned
      },
      {
        id: 2,
        ticket_id: 2375,
        specification: "TS 102 687",
        branch: "CR2-v1",
        summary: "There are still typos",
        associated_contributions: [2],
        status: :assigned
      },
      {
        id: 3,
        ticket_id: 3476,
        specification: "TS 102 688",
        branch: "master",
        summary: "Add a chapter on channel configuration",
        associated_contributions: [7],
        status: :assigned
      },
      {
        id: 4,
        ticket_id: 1345,
        specification: "TS 102 686",
        branch: "master",
        summary: "Harmonize with IEEE1609.2",
        associated_contributions: [1],
        status: :workspace
      },
      {
        id: 5,
        ticket_id: 2172,
        specification: "TS 102 687",
        branch: "master",
        summary: "There are lots of typos",
        associated_contributions: [2],
        status: :workspace
      },
      {
        id: 6,
        ticket_id: 2375,
        specification: "TS 102 687",
        branch: "CR2-v1",
        summary: "There are still typos",
        associated_contributions: [2],
        status: :workspace
      },
      {
        id: 7,
        ticket_id: 3476,
        specification: "TS 102 688",
        branch: "master",
        summary: "Add a chapter on channel configuration",
        associated_contributions: [7],
        status: :workspace
      }
    ].map { |attrs| Issue.new(attrs) }
  end

  def all
    issues.tap do |result|
      def result.group(key)
        group_by { |issue| issue.send(key) }
      end
    end
  end

  def find_by_id(id)
    issues[id - 1]
  end

  private

  def issues
    ISSUES.map do |issue|
      issue.tap do |result|
        def result.associated_contributions
          service = ChangeRequestService.new

          @associated_contributions.map { |id|
            service.find_by_id(id)
          }
        end
      end
    end
  end

end
