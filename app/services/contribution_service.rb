class ContributionService

  ContributionResult = Struct.new(:selected, :rest)

  CONTRIBUTIONS = begin
    [
      #{
      #  change_request_id: 1,
      #  status: :drafting,
      #  author: "John Smith",
      #  name: "Review of abbreviations",
      #  date: Date.new(2016, 11, 16),
      #  up_votes: 31,
      #  down_votes: 0,
      #  comment: "Abbreviations changed"
      #},
      {
        change_request_id: 2,
        status: :contributed,
        author: "John Smith",
        name: "Correction of typos",
        date: Date.new(2016, 11, 6),
        up_votes: 2,
        down_votes: 3,
        comment: "English wording"
      },
      {
        change_request_id: 3,
        status: :accepted,
        author: "Bill Gates",
        name: "Enhancement of formula",
        date: Date.new(2015, 10, 1),
        up_votes: 5,
        down_votes: 18,
        comment: "Windows 10 compatibility"
      },
      #{
      #  change_request_id: 4,
      #  status: :implemented,
      #  author: "EditHelp",
      #  name: "Section 10.2 revised",
      #  date: Date.new(2016, 4, 10),
      #  up_votes: 17,
      #  down_votes: 2,
      #  comment: "EditHelp Pre-processing"
      #},
      {
        change_request_id: 5,
        status: :not_accepted,
        author: "John Smith",
        name: "Note added",
        date: Date.new(2016, 4, 10),
        up_votes: 3,
        down_votes: 12,
        comment: "Add something to the spec"
      },
      #{
      #  change_request_id: 6,
      #  status: :drafting,
      #  author: "Bill Gates",
      #  name: "Clause moved",
      #  date: Date.new(2016, 6, 10),
      #  up_votes: 7,
      #  down_votes: 7,
      #  comment: "Remove Google support everywhere"
      #},
      {
        change_request_id: 7,
        status: :contributed,
        author: "Larry Page",
        name: "Table inserted",
        date: Date.new(2016, 5, 10),
        up_votes: 27,
        down_votes: 5,
        comment: "Add Google support"
      }
    ].map { |attrs| Contribution.new(attrs) }
  end

  def contributions_for(change_request_id)
    num_id = change_request_id.to_i
    partitioned = CONTRIBUTIONS.partition { |c| c.change_request_id == num_id }
    selected = partitioned.first.first
    presenter = Contributions::Show

    ContributionResult.new(
      selected ? presenter.new(selected) : nil,
      partitioned.last.map { |c| presenter.new(c) }
    )
  end

end
