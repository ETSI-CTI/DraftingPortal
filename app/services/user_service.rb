class UserService

  USERS = [
    {
      id: :john_smith,
      first_name: "John",
      last_name: "Smith"
    },
    {
      id: :bill_gates,
      first_name: "Bill",
      last_name: "Gates"
    },
    {
      id: :larry_page,
      first_name: "Larry",
      last_name: "Page"
    },
    {
      id: :tb_official,
      first_name: "Teeby",
      last_name: "O'Ficial"
    }
  ].map { |attrs| User.new(attrs) }

  def find(id)
    sym_id = id.to_sym
    USERS.find { |u| u.id == sym_id }
  end

  def all_users(except: nil)
    return USERS unless except

    except_id = except.respond_to?(:id) ? except.id : except

    USERS.select { |u| u.id != except_id }
  end

  def default_user
    find(:john_smith)
  end

end
