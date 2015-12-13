QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema"

  field :node, field: NodeIdentification.field

  field :root, ViewerType do
    resolve -> (obj, args, ctx) { Viewer::STATIC }
  end

  field :current_user, UserType do
    description  "Returns current signed in user object"
    resolve -> (obj, args, ctx) {
      User.first
    }
  end

  field :user_signed_in, types.Boolean do
    description  "Returns if a user is signed in"
    resolve -> (obj, args, ctx) {
      return false unless cookies.signed['user.id'].present?
      true
    }
  end

end
