class GameSerializer < ActiveModel::Serializer
  attributes :id, :board

  def board
    object.board.map do |row|
      row.map { |cell| cell.status }
    end
  end
end
