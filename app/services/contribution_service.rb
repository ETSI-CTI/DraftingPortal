class ContributionService

  CONTRIBUTIONS = begin
    [
      {
        status: :accepted,
        author: "John Smith (ETSI)",
        date: Date.new(2015, 5, 12),
        up_votes: 31,
        down_votes: 0,
        checked: true
      },
      {
        status: :active,
        author: "Martin Boßlet",
        date: Date.new(2016, 11, 23),
        up_votes: 2,
        down_votes: 3,
        checked: true
      },
      {
        status: :noted,
        author: "Bill Gates (Microsoft)",
        date: Date.new(2015, 5, 12),
        up_votes: 5,
        down_votes: 18,
        checked: false
      },
      {
        status: :active,
        author: "Denis Filatov",
        date: Date.new(2016, 5, 12),
        up_votes: 0,
        down_votes: 0,
        checked: true
      }
    ].map { |attrs| Contribution.new(attrs) }
  end

  def contributions_for(specification:)
    CONTRIBUTIONS
  end

end
