slot1 = require("protobuf.protobuf")

module("modules.proto.Match3Def_pb", package.seeall)

slot2 = {
	MATCH3CHESSBOARD_MSG = slot1.Descriptor(),
	MATCH3CHESSBOARDROWFIELD = slot1.FieldDescriptor(),
	CHESS_MSG = slot1.Descriptor(),
	CHESSTYPEFIELD = slot1.FieldDescriptor(),
	CHESSIDFIELD = slot1.FieldDescriptor(),
	CHESSCOORDINATEFIELD = slot1.FieldDescriptor(),
	TIDYUPCOL_MSG = slot1.Descriptor(),
	TIDYUPCOLCOLFIELD = slot1.FieldDescriptor(),
	TIDYUPCOLOLDXFIELD = slot1.FieldDescriptor(),
	TIDYUPCOLNEWXFIELD = slot1.FieldDescriptor(),
	MATCH3TIPS_MSG = slot1.Descriptor(),
	MATCH3TIPSFROMFIELD = slot1.FieldDescriptor(),
	MATCH3TIPSTOFIELD = slot1.FieldDescriptor(),
	MATCH3TIPSELIMINATEFIELD = slot1.FieldDescriptor(),
	COORDINATE_MSG = slot1.Descriptor(),
	COORDINATEXFIELD = slot1.FieldDescriptor(),
	COORDINATEYFIELD = slot1.FieldDescriptor(),
	FILLCHESSBOARD_MSG = slot1.Descriptor(),
	FILLCHESSBOARDDIRFIELD = slot1.FieldDescriptor(),
	FILLCHESSBOARDCHESSFIELD = slot1.FieldDescriptor(),
	ELIMINATE_MSG = slot1.Descriptor(),
	ELIMINATECOORDINATEFIELD = slot1.FieldDescriptor(),
	ELIMINATEEXTRADATAFIELD = slot1.FieldDescriptor(),
	ELIMINATETYPEFIELD = slot1.FieldDescriptor(),
	ELIMINATESOURCEFIELD = slot1.FieldDescriptor(),
	TIDYUP_MSG = slot1.Descriptor(),
	TIDYUPCOLFIELD = slot1.FieldDescriptor(),
	TIDYUPROWFIELD = slot1.FieldDescriptor(),
	CHESSBOARDROW_MSG = slot1.Descriptor(),
	CHESSBOARDROWCHESSFIELD = slot1.FieldDescriptor(),
	TIDYUPROW_MSG = slot1.Descriptor(),
	TIDYUPROWROWFIELD = slot1.FieldDescriptor(),
	TIDYUPROWOLDYFIELD = slot1.FieldDescriptor(),
	TIDYUPROWNEWYFIELD = slot1.FieldDescriptor(),
	MATCH3TURN_MSG = slot1.Descriptor(),
	MATCH3TURNELIMINATEFIELD = slot1.FieldDescriptor(),
	MATCH3TURNTIDYUPFIELD = slot1.FieldDescriptor(),
	MATCH3TURNFILLCHESSBOARDFIELD = slot1.FieldDescriptor()
}
slot2.MATCH3CHESSBOARDROWFIELD.name = "row"
slot2.MATCH3CHESSBOARDROWFIELD.full_name = ".Match3ChessBoard.row"
slot2.MATCH3CHESSBOARDROWFIELD.number = 1
slot2.MATCH3CHESSBOARDROWFIELD.index = 0
slot2.MATCH3CHESSBOARDROWFIELD.label = 3
slot2.MATCH3CHESSBOARDROWFIELD.has_default_value = false
slot2.MATCH3CHESSBOARDROWFIELD.default_value = {}
slot2.MATCH3CHESSBOARDROWFIELD.message_type = slot2.CHESSBOARDROW_MSG
slot2.MATCH3CHESSBOARDROWFIELD.type = 11
slot2.MATCH3CHESSBOARDROWFIELD.cpp_type = 10
slot2.MATCH3CHESSBOARD_MSG.name = "Match3ChessBoard"
slot2.MATCH3CHESSBOARD_MSG.full_name = ".Match3ChessBoard"
slot2.MATCH3CHESSBOARD_MSG.nested_types = {}
slot2.MATCH3CHESSBOARD_MSG.enum_types = {}
slot2.MATCH3CHESSBOARD_MSG.fields = {
	slot2.MATCH3CHESSBOARDROWFIELD
}
slot2.MATCH3CHESSBOARD_MSG.is_extendable = false
slot2.MATCH3CHESSBOARD_MSG.extensions = {}
slot2.CHESSTYPEFIELD.name = "type"
slot2.CHESSTYPEFIELD.full_name = ".Chess.type"
slot2.CHESSTYPEFIELD.number = 1
slot2.CHESSTYPEFIELD.index = 0
slot2.CHESSTYPEFIELD.label = 1
slot2.CHESSTYPEFIELD.has_default_value = false
slot2.CHESSTYPEFIELD.default_value = 0
slot2.CHESSTYPEFIELD.type = 5
slot2.CHESSTYPEFIELD.cpp_type = 1
slot2.CHESSIDFIELD.name = "id"
slot2.CHESSIDFIELD.full_name = ".Chess.id"
slot2.CHESSIDFIELD.number = 2
slot2.CHESSIDFIELD.index = 1
slot2.CHESSIDFIELD.label = 1
slot2.CHESSIDFIELD.has_default_value = false
slot2.CHESSIDFIELD.default_value = 0
slot2.CHESSIDFIELD.type = 5
slot2.CHESSIDFIELD.cpp_type = 1
slot2.CHESSCOORDINATEFIELD.name = "coordinate"
slot2.CHESSCOORDINATEFIELD.full_name = ".Chess.coordinate"
slot2.CHESSCOORDINATEFIELD.number = 3
slot2.CHESSCOORDINATEFIELD.index = 2
slot2.CHESSCOORDINATEFIELD.label = 1
slot2.CHESSCOORDINATEFIELD.has_default_value = false
slot2.CHESSCOORDINATEFIELD.default_value = nil
slot2.CHESSCOORDINATEFIELD.message_type = slot2.COORDINATE_MSG
slot2.CHESSCOORDINATEFIELD.type = 11
slot2.CHESSCOORDINATEFIELD.cpp_type = 10
slot2.CHESS_MSG.name = "Chess"
slot2.CHESS_MSG.full_name = ".Chess"
slot2.CHESS_MSG.nested_types = {}
slot2.CHESS_MSG.enum_types = {}
slot2.CHESS_MSG.fields = {
	slot2.CHESSTYPEFIELD,
	slot2.CHESSIDFIELD,
	slot2.CHESSCOORDINATEFIELD
}
slot2.CHESS_MSG.is_extendable = false
slot2.CHESS_MSG.extensions = {}
slot2.TIDYUPCOLCOLFIELD.name = "col"
slot2.TIDYUPCOLCOLFIELD.full_name = ".TidyUpCol.col"
slot2.TIDYUPCOLCOLFIELD.number = 1
slot2.TIDYUPCOLCOLFIELD.index = 0
slot2.TIDYUPCOLCOLFIELD.label = 1
slot2.TIDYUPCOLCOLFIELD.has_default_value = false
slot2.TIDYUPCOLCOLFIELD.default_value = 0
slot2.TIDYUPCOLCOLFIELD.type = 5
slot2.TIDYUPCOLCOLFIELD.cpp_type = 1
slot2.TIDYUPCOLOLDXFIELD.name = "oldX"
slot2.TIDYUPCOLOLDXFIELD.full_name = ".TidyUpCol.oldX"
slot2.TIDYUPCOLOLDXFIELD.number = 2
slot2.TIDYUPCOLOLDXFIELD.index = 1
slot2.TIDYUPCOLOLDXFIELD.label = 3
slot2.TIDYUPCOLOLDXFIELD.has_default_value = false
slot2.TIDYUPCOLOLDXFIELD.default_value = {}
slot2.TIDYUPCOLOLDXFIELD.type = 5
slot2.TIDYUPCOLOLDXFIELD.cpp_type = 1
slot2.TIDYUPCOLNEWXFIELD.name = "newX"
slot2.TIDYUPCOLNEWXFIELD.full_name = ".TidyUpCol.newX"
slot2.TIDYUPCOLNEWXFIELD.number = 3
slot2.TIDYUPCOLNEWXFIELD.index = 2
slot2.TIDYUPCOLNEWXFIELD.label = 3
slot2.TIDYUPCOLNEWXFIELD.has_default_value = false
slot2.TIDYUPCOLNEWXFIELD.default_value = {}
slot2.TIDYUPCOLNEWXFIELD.type = 5
slot2.TIDYUPCOLNEWXFIELD.cpp_type = 1
slot2.TIDYUPCOL_MSG.name = "TidyUpCol"
slot2.TIDYUPCOL_MSG.full_name = ".TidyUpCol"
slot2.TIDYUPCOL_MSG.nested_types = {}
slot2.TIDYUPCOL_MSG.enum_types = {}
slot2.TIDYUPCOL_MSG.fields = {
	slot2.TIDYUPCOLCOLFIELD,
	slot2.TIDYUPCOLOLDXFIELD,
	slot2.TIDYUPCOLNEWXFIELD
}
slot2.TIDYUPCOL_MSG.is_extendable = false
slot2.TIDYUPCOL_MSG.extensions = {}
slot2.MATCH3TIPSFROMFIELD.name = "from"
slot2.MATCH3TIPSFROMFIELD.full_name = ".Match3Tips.from"
slot2.MATCH3TIPSFROMFIELD.number = 1
slot2.MATCH3TIPSFROMFIELD.index = 0
slot2.MATCH3TIPSFROMFIELD.label = 1
slot2.MATCH3TIPSFROMFIELD.has_default_value = false
slot2.MATCH3TIPSFROMFIELD.default_value = nil
slot2.MATCH3TIPSFROMFIELD.message_type = slot2.COORDINATE_MSG
slot2.MATCH3TIPSFROMFIELD.type = 11
slot2.MATCH3TIPSFROMFIELD.cpp_type = 10
slot2.MATCH3TIPSTOFIELD.name = "to"
slot2.MATCH3TIPSTOFIELD.full_name = ".Match3Tips.to"
slot2.MATCH3TIPSTOFIELD.number = 2
slot2.MATCH3TIPSTOFIELD.index = 1
slot2.MATCH3TIPSTOFIELD.label = 1
slot2.MATCH3TIPSTOFIELD.has_default_value = false
slot2.MATCH3TIPSTOFIELD.default_value = nil
slot2.MATCH3TIPSTOFIELD.message_type = slot2.COORDINATE_MSG
slot2.MATCH3TIPSTOFIELD.type = 11
slot2.MATCH3TIPSTOFIELD.cpp_type = 10
slot2.MATCH3TIPSELIMINATEFIELD.name = "eliminate"
slot2.MATCH3TIPSELIMINATEFIELD.full_name = ".Match3Tips.eliminate"
slot2.MATCH3TIPSELIMINATEFIELD.number = 3
slot2.MATCH3TIPSELIMINATEFIELD.index = 2
slot2.MATCH3TIPSELIMINATEFIELD.label = 1
slot2.MATCH3TIPSELIMINATEFIELD.has_default_value = false
slot2.MATCH3TIPSELIMINATEFIELD.default_value = nil
slot2.MATCH3TIPSELIMINATEFIELD.message_type = slot2.ELIMINATE_MSG
slot2.MATCH3TIPSELIMINATEFIELD.type = 11
slot2.MATCH3TIPSELIMINATEFIELD.cpp_type = 10
slot2.MATCH3TIPS_MSG.name = "Match3Tips"
slot2.MATCH3TIPS_MSG.full_name = ".Match3Tips"
slot2.MATCH3TIPS_MSG.nested_types = {}
slot2.MATCH3TIPS_MSG.enum_types = {}
slot2.MATCH3TIPS_MSG.fields = {
	slot2.MATCH3TIPSFROMFIELD,
	slot2.MATCH3TIPSTOFIELD,
	slot2.MATCH3TIPSELIMINATEFIELD
}
slot2.MATCH3TIPS_MSG.is_extendable = false
slot2.MATCH3TIPS_MSG.extensions = {}
slot2.COORDINATEXFIELD.name = "x"
slot2.COORDINATEXFIELD.full_name = ".Coordinate.x"
slot2.COORDINATEXFIELD.number = 1
slot2.COORDINATEXFIELD.index = 0
slot2.COORDINATEXFIELD.label = 1
slot2.COORDINATEXFIELD.has_default_value = false
slot2.COORDINATEXFIELD.default_value = 0
slot2.COORDINATEXFIELD.type = 5
slot2.COORDINATEXFIELD.cpp_type = 1
slot2.COORDINATEYFIELD.name = "y"
slot2.COORDINATEYFIELD.full_name = ".Coordinate.y"
slot2.COORDINATEYFIELD.number = 2
slot2.COORDINATEYFIELD.index = 1
slot2.COORDINATEYFIELD.label = 1
slot2.COORDINATEYFIELD.has_default_value = false
slot2.COORDINATEYFIELD.default_value = 0
slot2.COORDINATEYFIELD.type = 5
slot2.COORDINATEYFIELD.cpp_type = 1
slot2.COORDINATE_MSG.name = "Coordinate"
slot2.COORDINATE_MSG.full_name = ".Coordinate"
slot2.COORDINATE_MSG.nested_types = {}
slot2.COORDINATE_MSG.enum_types = {}
slot2.COORDINATE_MSG.fields = {
	slot2.COORDINATEXFIELD,
	slot2.COORDINATEYFIELD
}
slot2.COORDINATE_MSG.is_extendable = false
slot2.COORDINATE_MSG.extensions = {}
slot2.FILLCHESSBOARDDIRFIELD.name = "dir"
slot2.FILLCHESSBOARDDIRFIELD.full_name = ".FillChessBoard.dir"
slot2.FILLCHESSBOARDDIRFIELD.number = 1
slot2.FILLCHESSBOARDDIRFIELD.index = 0
slot2.FILLCHESSBOARDDIRFIELD.label = 1
slot2.FILLCHESSBOARDDIRFIELD.has_default_value = false
slot2.FILLCHESSBOARDDIRFIELD.default_value = 0
slot2.FILLCHESSBOARDDIRFIELD.type = 5
slot2.FILLCHESSBOARDDIRFIELD.cpp_type = 1
slot2.FILLCHESSBOARDCHESSFIELD.name = "chess"
slot2.FILLCHESSBOARDCHESSFIELD.full_name = ".FillChessBoard.chess"
slot2.FILLCHESSBOARDCHESSFIELD.number = 2
slot2.FILLCHESSBOARDCHESSFIELD.index = 1
slot2.FILLCHESSBOARDCHESSFIELD.label = 3
slot2.FILLCHESSBOARDCHESSFIELD.has_default_value = false
slot2.FILLCHESSBOARDCHESSFIELD.default_value = {}
slot2.FILLCHESSBOARDCHESSFIELD.message_type = slot2.CHESS_MSG
slot2.FILLCHESSBOARDCHESSFIELD.type = 11
slot2.FILLCHESSBOARDCHESSFIELD.cpp_type = 10
slot2.FILLCHESSBOARD_MSG.name = "FillChessBoard"
slot2.FILLCHESSBOARD_MSG.full_name = ".FillChessBoard"
slot2.FILLCHESSBOARD_MSG.nested_types = {}
slot2.FILLCHESSBOARD_MSG.enum_types = {}
slot2.FILLCHESSBOARD_MSG.fields = {
	slot2.FILLCHESSBOARDDIRFIELD,
	slot2.FILLCHESSBOARDCHESSFIELD
}
slot2.FILLCHESSBOARD_MSG.is_extendable = false
slot2.FILLCHESSBOARD_MSG.extensions = {}
slot2.ELIMINATECOORDINATEFIELD.name = "coordinate"
slot2.ELIMINATECOORDINATEFIELD.full_name = ".Eliminate.coordinate"
slot2.ELIMINATECOORDINATEFIELD.number = 1
slot2.ELIMINATECOORDINATEFIELD.index = 0
slot2.ELIMINATECOORDINATEFIELD.label = 3
slot2.ELIMINATECOORDINATEFIELD.has_default_value = false
slot2.ELIMINATECOORDINATEFIELD.default_value = {}
slot2.ELIMINATECOORDINATEFIELD.message_type = slot2.COORDINATE_MSG
slot2.ELIMINATECOORDINATEFIELD.type = 11
slot2.ELIMINATECOORDINATEFIELD.cpp_type = 10
slot2.ELIMINATEEXTRADATAFIELD.name = "extraData"
slot2.ELIMINATEEXTRADATAFIELD.full_name = ".Eliminate.extraData"
slot2.ELIMINATEEXTRADATAFIELD.number = 2
slot2.ELIMINATEEXTRADATAFIELD.index = 1
slot2.ELIMINATEEXTRADATAFIELD.label = 1
slot2.ELIMINATEEXTRADATAFIELD.has_default_value = false
slot2.ELIMINATEEXTRADATAFIELD.default_value = ""
slot2.ELIMINATEEXTRADATAFIELD.type = 9
slot2.ELIMINATEEXTRADATAFIELD.cpp_type = 9
slot2.ELIMINATETYPEFIELD.name = "type"
slot2.ELIMINATETYPEFIELD.full_name = ".Eliminate.type"
slot2.ELIMINATETYPEFIELD.number = 3
slot2.ELIMINATETYPEFIELD.index = 2
slot2.ELIMINATETYPEFIELD.label = 1
slot2.ELIMINATETYPEFIELD.has_default_value = false
slot2.ELIMINATETYPEFIELD.default_value = ""
slot2.ELIMINATETYPEFIELD.type = 9
slot2.ELIMINATETYPEFIELD.cpp_type = 9
slot2.ELIMINATESOURCEFIELD.name = "source"
slot2.ELIMINATESOURCEFIELD.full_name = ".Eliminate.source"
slot2.ELIMINATESOURCEFIELD.number = 4
slot2.ELIMINATESOURCEFIELD.index = 3
slot2.ELIMINATESOURCEFIELD.label = 1
slot2.ELIMINATESOURCEFIELD.has_default_value = false
slot2.ELIMINATESOURCEFIELD.default_value = 0
slot2.ELIMINATESOURCEFIELD.type = 5
slot2.ELIMINATESOURCEFIELD.cpp_type = 1
slot2.ELIMINATE_MSG.name = "Eliminate"
slot2.ELIMINATE_MSG.full_name = ".Eliminate"
slot2.ELIMINATE_MSG.nested_types = {}
slot2.ELIMINATE_MSG.enum_types = {}
slot2.ELIMINATE_MSG.fields = {
	slot2.ELIMINATECOORDINATEFIELD,
	slot2.ELIMINATEEXTRADATAFIELD,
	slot2.ELIMINATETYPEFIELD,
	slot2.ELIMINATESOURCEFIELD
}
slot2.ELIMINATE_MSG.is_extendable = false
slot2.ELIMINATE_MSG.extensions = {}
slot2.TIDYUPCOLFIELD.name = "col"
slot2.TIDYUPCOLFIELD.full_name = ".TidyUp.col"
slot2.TIDYUPCOLFIELD.number = 1
slot2.TIDYUPCOLFIELD.index = 0
slot2.TIDYUPCOLFIELD.label = 3
slot2.TIDYUPCOLFIELD.has_default_value = false
slot2.TIDYUPCOLFIELD.default_value = {}
slot2.TIDYUPCOLFIELD.message_type = slot2.TIDYUPCOL_MSG
slot2.TIDYUPCOLFIELD.type = 11
slot2.TIDYUPCOLFIELD.cpp_type = 10
slot2.TIDYUPROWFIELD.name = "row"
slot2.TIDYUPROWFIELD.full_name = ".TidyUp.row"
slot2.TIDYUPROWFIELD.number = 2
slot2.TIDYUPROWFIELD.index = 1
slot2.TIDYUPROWFIELD.label = 3
slot2.TIDYUPROWFIELD.has_default_value = false
slot2.TIDYUPROWFIELD.default_value = {}
slot2.TIDYUPROWFIELD.message_type = slot2.TIDYUPROW_MSG
slot2.TIDYUPROWFIELD.type = 11
slot2.TIDYUPROWFIELD.cpp_type = 10
slot2.TIDYUP_MSG.name = "TidyUp"
slot2.TIDYUP_MSG.full_name = ".TidyUp"
slot2.TIDYUP_MSG.nested_types = {}
slot2.TIDYUP_MSG.enum_types = {}
slot2.TIDYUP_MSG.fields = {
	slot2.TIDYUPCOLFIELD,
	slot2.TIDYUPROWFIELD
}
slot2.TIDYUP_MSG.is_extendable = false
slot2.TIDYUP_MSG.extensions = {}
slot2.CHESSBOARDROWCHESSFIELD.name = "chess"
slot2.CHESSBOARDROWCHESSFIELD.full_name = ".ChessBoardRow.chess"
slot2.CHESSBOARDROWCHESSFIELD.number = 1
slot2.CHESSBOARDROWCHESSFIELD.index = 0
slot2.CHESSBOARDROWCHESSFIELD.label = 3
slot2.CHESSBOARDROWCHESSFIELD.has_default_value = false
slot2.CHESSBOARDROWCHESSFIELD.default_value = {}
slot2.CHESSBOARDROWCHESSFIELD.message_type = slot2.CHESS_MSG
slot2.CHESSBOARDROWCHESSFIELD.type = 11
slot2.CHESSBOARDROWCHESSFIELD.cpp_type = 10
slot2.CHESSBOARDROW_MSG.name = "ChessBoardRow"
slot2.CHESSBOARDROW_MSG.full_name = ".ChessBoardRow"
slot2.CHESSBOARDROW_MSG.nested_types = {}
slot2.CHESSBOARDROW_MSG.enum_types = {}
slot2.CHESSBOARDROW_MSG.fields = {
	slot2.CHESSBOARDROWCHESSFIELD
}
slot2.CHESSBOARDROW_MSG.is_extendable = false
slot2.CHESSBOARDROW_MSG.extensions = {}
slot2.TIDYUPROWROWFIELD.name = "row"
slot2.TIDYUPROWROWFIELD.full_name = ".TidyUpRow.row"
slot2.TIDYUPROWROWFIELD.number = 1
slot2.TIDYUPROWROWFIELD.index = 0
slot2.TIDYUPROWROWFIELD.label = 1
slot2.TIDYUPROWROWFIELD.has_default_value = false
slot2.TIDYUPROWROWFIELD.default_value = 0
slot2.TIDYUPROWROWFIELD.type = 5
slot2.TIDYUPROWROWFIELD.cpp_type = 1
slot2.TIDYUPROWOLDYFIELD.name = "oldY"
slot2.TIDYUPROWOLDYFIELD.full_name = ".TidyUpRow.oldY"
slot2.TIDYUPROWOLDYFIELD.number = 2
slot2.TIDYUPROWOLDYFIELD.index = 1
slot2.TIDYUPROWOLDYFIELD.label = 3
slot2.TIDYUPROWOLDYFIELD.has_default_value = false
slot2.TIDYUPROWOLDYFIELD.default_value = {}
slot2.TIDYUPROWOLDYFIELD.type = 5
slot2.TIDYUPROWOLDYFIELD.cpp_type = 1
slot2.TIDYUPROWNEWYFIELD.name = "newY"
slot2.TIDYUPROWNEWYFIELD.full_name = ".TidyUpRow.newY"
slot2.TIDYUPROWNEWYFIELD.number = 3
slot2.TIDYUPROWNEWYFIELD.index = 2
slot2.TIDYUPROWNEWYFIELD.label = 3
slot2.TIDYUPROWNEWYFIELD.has_default_value = false
slot2.TIDYUPROWNEWYFIELD.default_value = {}
slot2.TIDYUPROWNEWYFIELD.type = 5
slot2.TIDYUPROWNEWYFIELD.cpp_type = 1
slot2.TIDYUPROW_MSG.name = "TidyUpRow"
slot2.TIDYUPROW_MSG.full_name = ".TidyUpRow"
slot2.TIDYUPROW_MSG.nested_types = {}
slot2.TIDYUPROW_MSG.enum_types = {}
slot2.TIDYUPROW_MSG.fields = {
	slot2.TIDYUPROWROWFIELD,
	slot2.TIDYUPROWOLDYFIELD,
	slot2.TIDYUPROWNEWYFIELD
}
slot2.TIDYUPROW_MSG.is_extendable = false
slot2.TIDYUPROW_MSG.extensions = {}
slot2.MATCH3TURNELIMINATEFIELD.name = "eliminate"
slot2.MATCH3TURNELIMINATEFIELD.full_name = ".Match3Turn.eliminate"
slot2.MATCH3TURNELIMINATEFIELD.number = 1
slot2.MATCH3TURNELIMINATEFIELD.index = 0
slot2.MATCH3TURNELIMINATEFIELD.label = 3
slot2.MATCH3TURNELIMINATEFIELD.has_default_value = false
slot2.MATCH3TURNELIMINATEFIELD.default_value = {}
slot2.MATCH3TURNELIMINATEFIELD.message_type = slot2.ELIMINATE_MSG
slot2.MATCH3TURNELIMINATEFIELD.type = 11
slot2.MATCH3TURNELIMINATEFIELD.cpp_type = 10
slot2.MATCH3TURNTIDYUPFIELD.name = "tidyUp"
slot2.MATCH3TURNTIDYUPFIELD.full_name = ".Match3Turn.tidyUp"
slot2.MATCH3TURNTIDYUPFIELD.number = 2
slot2.MATCH3TURNTIDYUPFIELD.index = 1
slot2.MATCH3TURNTIDYUPFIELD.label = 1
slot2.MATCH3TURNTIDYUPFIELD.has_default_value = false
slot2.MATCH3TURNTIDYUPFIELD.default_value = nil
slot2.MATCH3TURNTIDYUPFIELD.message_type = slot2.TIDYUP_MSG
slot2.MATCH3TURNTIDYUPFIELD.type = 11
slot2.MATCH3TURNTIDYUPFIELD.cpp_type = 10
slot2.MATCH3TURNFILLCHESSBOARDFIELD.name = "fillChessBoard"
slot2.MATCH3TURNFILLCHESSBOARDFIELD.full_name = ".Match3Turn.fillChessBoard"
slot2.MATCH3TURNFILLCHESSBOARDFIELD.number = 3
slot2.MATCH3TURNFILLCHESSBOARDFIELD.index = 2
slot2.MATCH3TURNFILLCHESSBOARDFIELD.label = 1
slot2.MATCH3TURNFILLCHESSBOARDFIELD.has_default_value = false
slot2.MATCH3TURNFILLCHESSBOARDFIELD.default_value = nil
slot2.MATCH3TURNFILLCHESSBOARDFIELD.message_type = slot2.FILLCHESSBOARD_MSG
slot2.MATCH3TURNFILLCHESSBOARDFIELD.type = 11
slot2.MATCH3TURNFILLCHESSBOARDFIELD.cpp_type = 10
slot2.MATCH3TURN_MSG.name = "Match3Turn"
slot2.MATCH3TURN_MSG.full_name = ".Match3Turn"
slot2.MATCH3TURN_MSG.nested_types = {}
slot2.MATCH3TURN_MSG.enum_types = {}
slot2.MATCH3TURN_MSG.fields = {
	slot2.MATCH3TURNELIMINATEFIELD,
	slot2.MATCH3TURNTIDYUPFIELD,
	slot2.MATCH3TURNFILLCHESSBOARDFIELD
}
slot2.MATCH3TURN_MSG.is_extendable = false
slot2.MATCH3TURN_MSG.extensions = {}
slot2.Chess = slot1.Message(slot2.CHESS_MSG)
slot2.ChessBoardRow = slot1.Message(slot2.CHESSBOARDROW_MSG)
slot2.Coordinate = slot1.Message(slot2.COORDINATE_MSG)
slot2.Eliminate = slot1.Message(slot2.ELIMINATE_MSG)
slot2.FillChessBoard = slot1.Message(slot2.FILLCHESSBOARD_MSG)
slot2.Match3ChessBoard = slot1.Message(slot2.MATCH3CHESSBOARD_MSG)
slot2.Match3Tips = slot1.Message(slot2.MATCH3TIPS_MSG)
slot2.Match3Turn = slot1.Message(slot2.MATCH3TURN_MSG)
slot2.TidyUp = slot1.Message(slot2.TIDYUP_MSG)
slot2.TidyUpCol = slot1.Message(slot2.TIDYUPCOL_MSG)
slot2.TidyUpRow = slot1.Message(slot2.TIDYUPROW_MSG)

return slot2
