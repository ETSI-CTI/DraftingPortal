class ChangeRequestService

  CHANGE_REQUESTS = begin
    user_service = UserService.new
    john_smith = user_service.find(:john_smith)
    bill_gates = user_service.find(:bill_gates)
    larry_page = user_service.find(:larry_page)
    tb_official = user_service.find(:tb_official)

    [
      # John Smith
      {
        id: 1,
        user: john_smith,
        author: john_smith,
        specification: "TS 119 612",
        title: "Trusted Lists",
        status: :accepted,
        updated_at: Date.new(2015, 1, 1),
        contributed_at: Date.new(2015, 2, 1)
      },
      {
        id: 2,
        user: john_smith,
        author: john_smith,
        specification: "TS 119 132",
        title: "XAdES digital signatures; Part 2: Extended XAdES signatures",
        status: :contributed,
        updated_at: Date.new(2016, 5, 12),
        contributed_at: Date.new(2016, 5, 12)
      },
      {
        id: 3,
        user: john_smith,
        author: bill_gates,
        specification: "TS 119 122",
        title: "CAdES digital signatures; Part 2: Extended CAdES signatures",
        status: :drafting,
        updated_at: Date.new(2016, 5, 12)
      },
      # Bill Gates
      {
        id: 4,
        user: bill_gates,
        author: john_smith,
        specification: "TS 119 612",
        title: "Trusted Lists",
        status: :accepted,
        updated_at: Date.new(2015, 1, 1),
        contributed_at: Date.new(2015, 2, 1)
      },
      {
        id: 5,
        user: bill_gates,
        author: john_smith,
        specification: "TS 119 132",
        title: "XAdES digital signatures; Part 2: Extended XAdES signatures",
        status: :contributed,
        updated_at: Date.new(2016, 5, 12),
        contributed_at: Date.new(2016, 5, 12)
      },
      {
        id: 6,
        user: bill_gates,
        author: bill_gates,
        specification: "TS 119 122",
        title: "CAdES digital signatures; Part 2: Extended CAdES signatures",
        status: :drafting,
        updated_at: Date.new(2016, 5, 12)
      },
      # Larry Page
      {
        id: 7,
        user: larry_page,
        author: john_smith,
        specification: "TS 119 612",
        title: "Trusted Lists",
        status: :implemented,
        updated_at: Date.new(2015, 1, 1),
        contributed_at: Date.new(2015, 2, 1)
      },
      {
        id: 8,
        user: larry_page,
        author: john_smith,
        specification: "TS 119 132",
        title: "XAdES digital signatures; Part 2: Extended XAdES signatures",
        status: :accepted,
        updated_at: Date.new(2016, 5, 12),
        contributed_at: Date.new(2016, 5, 12)
      },
      {
        id: 9,
        user: larry_page,
        author: larry_page,
        specification: "TS 103 174",
        title: "ASiC Baseline Profile",
        status: :drafting,
        updated_at: Date.new(2016, 5, 12)
      },
      # TB official
      {
        id: 10,
        user: tb_official,
        author: john_smith,
        specification: "TS 119 612",
        title: "Trusted Lists",
        status: :contributed,
        updated_at: Date.new(2015, 1, 1),
        contributed_at: Date.new(2015, 2, 1)
      },
      {
        id: 11,
        user: tb_official,
        author: john_smith,
        specification: "TS 119 122",
        title: "CAdES digital signatures; Part 2: Extended CAdES signatures",
        status: :drafting,
        updated_at: Date.new(2016, 5, 12),
      },
      {
        id: 12,
        user: tb_official,
        author: larry_page,
        specification: "TS 103 174",
        title: "ASiC Baseline Profile",
        status: :drafting,
        updated_at: Date.new(2016, 5, 12)
      }
    ].map { |attrs| ChangeRequest.new(attrs) }
  end

  def find_by_user(user)
    CHANGE_REQUESTS.select { |cr| cr.user.id == user.id }.tap do |result|
      def result.group(key)
        group_by { |cr| cr.status }
      end
    end
  end

end
