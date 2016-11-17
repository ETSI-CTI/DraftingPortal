class ContributionService

  CONTRIBUTIONS = begin
    [
      {
        status: :accepted,
        author: "John Smith (ETSI)",
        date: Date.new(2015, 5, 12),
        up_votes: 31,
        down_votes: 0
      },
      {
        status: :noted,
        author: "Bill Gates (Microsoft)",
        date: Date.new(2015, 5, 12),
        up_votes: 5,
        down_votes: 18
      },
      {
        status: nil,
        author: "Denis Filatov",
        date: Date.new(2016, 5, 12),
        up_votes: 0,
        down_votes: 0
      }
    ].map { |attrs| Contribution.new(attrs) }
  end

  def contributions_for(specification:)
    CONTRIBUTIONS
  end

end
