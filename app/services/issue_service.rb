class IssueService

  ISSUES = [
    {
      id: 1,
      ticket_id: 2172,
      specification: "TS 102 687",
      branch: "master",
      summary: "There are lots of typos",
      associated_contributions: ["CR2-v1"],
      status: :assigned
    },
    {
      id: 2,
      ticket_id: 2375,
      specification: "TS 102 687",
      branch: "CR2-v1",
      summary: "There are still typos",
      associated_contributions: ["CR2-v2"],
      status: :assigned
    },
    {
      id: 3,
      ticket_id: 3476,
      specification: "TS 102 688",
      branch: "master",
      summary: "Add a chapter on channel configuration",
      associated_contributions: ["CR7"],
      status: :assigned
    },
    {
      id: 4,
      ticket_id: 1345,
      specification: "TS 102 686",
      branch: "master",
      summary: "Harmonize with IEEE1609.2",
      associated_contributions: ["CR1"],
      status: :workspace
    },
    {
      id: 5,
      ticket_id: 2172,
      specification: "TS 102 687",
      branch: "master",
      summary: "There are lots of typos",
      associated_contributions: ["CR2-v1"],
      status: :workspace
    },
    {
      id: 6,
      ticket_id: 2375,
      specification: "TS 102 687",
      branch: "CR2-v1",
      summary: "There are still typos",
      associated_contributions: ["CR2-v2"],
      status: :workspace
    },
    {
      id: 7,
      ticket_id: 3476,
      specification: "TS 102 688",
      branch: "master",
      summary: "Add a chapter on channel configuration",
      associated_contributions: ["CR7"],
      status: :workspace
    }
  ].map { |attrs| Issue.new(attrs) }

  def all
    ISSUES.tap do |result|
      def result.group(key)
        group_by { |issue| issue.send(key) }
      end
    end
  end

end
