local var_0_0 = require("protobuf.protobuf")

module("modules.proto.Match3Def_pb", package.seeall)

local var_0_1 = {
	MATCH3CHESSBOARD_MSG = var_0_0.Descriptor(),
	MATCH3CHESSBOARDROWFIELD = var_0_0.FieldDescriptor(),
	CHESS_MSG = var_0_0.Descriptor(),
	CHESSTYPEFIELD = var_0_0.FieldDescriptor(),
	CHESSIDFIELD = var_0_0.FieldDescriptor(),
	CHESSCOORDINATEFIELD = var_0_0.FieldDescriptor(),
	TIDYUPCOL_MSG = var_0_0.Descriptor(),
	TIDYUPCOLCOLFIELD = var_0_0.FieldDescriptor(),
	TIDYUPCOLOLDXFIELD = var_0_0.FieldDescriptor(),
	TIDYUPCOLNEWXFIELD = var_0_0.FieldDescriptor(),
	MATCH3TIPS_MSG = var_0_0.Descriptor(),
	MATCH3TIPSFROMFIELD = var_0_0.FieldDescriptor(),
	MATCH3TIPSTOFIELD = var_0_0.FieldDescriptor(),
	MATCH3TIPSELIMINATEFIELD = var_0_0.FieldDescriptor(),
	COORDINATE_MSG = var_0_0.Descriptor(),
	COORDINATEXFIELD = var_0_0.FieldDescriptor(),
	COORDINATEYFIELD = var_0_0.FieldDescriptor(),
	FILLCHESSBOARD_MSG = var_0_0.Descriptor(),
	FILLCHESSBOARDDIRFIELD = var_0_0.FieldDescriptor(),
	FILLCHESSBOARDCHESSFIELD = var_0_0.FieldDescriptor(),
	ELIMINATE_MSG = var_0_0.Descriptor(),
	ELIMINATECOORDINATEFIELD = var_0_0.FieldDescriptor(),
	ELIMINATEEXTRADATAFIELD = var_0_0.FieldDescriptor(),
	ELIMINATETYPEFIELD = var_0_0.FieldDescriptor(),
	ELIMINATESOURCEFIELD = var_0_0.FieldDescriptor(),
	TIDYUP_MSG = var_0_0.Descriptor(),
	TIDYUPCOLFIELD = var_0_0.FieldDescriptor(),
	TIDYUPROWFIELD = var_0_0.FieldDescriptor(),
	CHESSBOARDROW_MSG = var_0_0.Descriptor(),
	CHESSBOARDROWCHESSFIELD = var_0_0.FieldDescriptor(),
	TIDYUPROW_MSG = var_0_0.Descriptor(),
	TIDYUPROWROWFIELD = var_0_0.FieldDescriptor(),
	TIDYUPROWOLDYFIELD = var_0_0.FieldDescriptor(),
	TIDYUPROWNEWYFIELD = var_0_0.FieldDescriptor(),
	MATCH3TURN_MSG = var_0_0.Descriptor(),
	MATCH3TURNELIMINATEFIELD = var_0_0.FieldDescriptor(),
	MATCH3TURNTIDYUPFIELD = var_0_0.FieldDescriptor(),
	MATCH3TURNFILLCHESSBOARDFIELD = var_0_0.FieldDescriptor()
}

var_0_1.MATCH3CHESSBOARDROWFIELD.name = "row"
var_0_1.MATCH3CHESSBOARDROWFIELD.full_name = ".Match3ChessBoard.row"
var_0_1.MATCH3CHESSBOARDROWFIELD.number = 1
var_0_1.MATCH3CHESSBOARDROWFIELD.index = 0
var_0_1.MATCH3CHESSBOARDROWFIELD.label = 3
var_0_1.MATCH3CHESSBOARDROWFIELD.has_default_value = false
var_0_1.MATCH3CHESSBOARDROWFIELD.default_value = {}
var_0_1.MATCH3CHESSBOARDROWFIELD.message_type = var_0_1.CHESSBOARDROW_MSG
var_0_1.MATCH3CHESSBOARDROWFIELD.type = 11
var_0_1.MATCH3CHESSBOARDROWFIELD.cpp_type = 10
var_0_1.MATCH3CHESSBOARD_MSG.name = "Match3ChessBoard"
var_0_1.MATCH3CHESSBOARD_MSG.full_name = ".Match3ChessBoard"
var_0_1.MATCH3CHESSBOARD_MSG.nested_types = {}
var_0_1.MATCH3CHESSBOARD_MSG.enum_types = {}
var_0_1.MATCH3CHESSBOARD_MSG.fields = {
	var_0_1.MATCH3CHESSBOARDROWFIELD
}
var_0_1.MATCH3CHESSBOARD_MSG.is_extendable = false
var_0_1.MATCH3CHESSBOARD_MSG.extensions = {}
var_0_1.CHESSTYPEFIELD.name = "type"
var_0_1.CHESSTYPEFIELD.full_name = ".Chess.type"
var_0_1.CHESSTYPEFIELD.number = 1
var_0_1.CHESSTYPEFIELD.index = 0
var_0_1.CHESSTYPEFIELD.label = 1
var_0_1.CHESSTYPEFIELD.has_default_value = false
var_0_1.CHESSTYPEFIELD.default_value = 0
var_0_1.CHESSTYPEFIELD.type = 5
var_0_1.CHESSTYPEFIELD.cpp_type = 1
var_0_1.CHESSIDFIELD.name = "id"
var_0_1.CHESSIDFIELD.full_name = ".Chess.id"
var_0_1.CHESSIDFIELD.number = 2
var_0_1.CHESSIDFIELD.index = 1
var_0_1.CHESSIDFIELD.label = 1
var_0_1.CHESSIDFIELD.has_default_value = false
var_0_1.CHESSIDFIELD.default_value = 0
var_0_1.CHESSIDFIELD.type = 5
var_0_1.CHESSIDFIELD.cpp_type = 1
var_0_1.CHESSCOORDINATEFIELD.name = "coordinate"
var_0_1.CHESSCOORDINATEFIELD.full_name = ".Chess.coordinate"
var_0_1.CHESSCOORDINATEFIELD.number = 3
var_0_1.CHESSCOORDINATEFIELD.index = 2
var_0_1.CHESSCOORDINATEFIELD.label = 1
var_0_1.CHESSCOORDINATEFIELD.has_default_value = false
var_0_1.CHESSCOORDINATEFIELD.default_value = nil
var_0_1.CHESSCOORDINATEFIELD.message_type = var_0_1.COORDINATE_MSG
var_0_1.CHESSCOORDINATEFIELD.type = 11
var_0_1.CHESSCOORDINATEFIELD.cpp_type = 10
var_0_1.CHESS_MSG.name = "Chess"
var_0_1.CHESS_MSG.full_name = ".Chess"
var_0_1.CHESS_MSG.nested_types = {}
var_0_1.CHESS_MSG.enum_types = {}
var_0_1.CHESS_MSG.fields = {
	var_0_1.CHESSTYPEFIELD,
	var_0_1.CHESSIDFIELD,
	var_0_1.CHESSCOORDINATEFIELD
}
var_0_1.CHESS_MSG.is_extendable = false
var_0_1.CHESS_MSG.extensions = {}
var_0_1.TIDYUPCOLCOLFIELD.name = "col"
var_0_1.TIDYUPCOLCOLFIELD.full_name = ".TidyUpCol.col"
var_0_1.TIDYUPCOLCOLFIELD.number = 1
var_0_1.TIDYUPCOLCOLFIELD.index = 0
var_0_1.TIDYUPCOLCOLFIELD.label = 1
var_0_1.TIDYUPCOLCOLFIELD.has_default_value = false
var_0_1.TIDYUPCOLCOLFIELD.default_value = 0
var_0_1.TIDYUPCOLCOLFIELD.type = 5
var_0_1.TIDYUPCOLCOLFIELD.cpp_type = 1
var_0_1.TIDYUPCOLOLDXFIELD.name = "oldX"
var_0_1.TIDYUPCOLOLDXFIELD.full_name = ".TidyUpCol.oldX"
var_0_1.TIDYUPCOLOLDXFIELD.number = 2
var_0_1.TIDYUPCOLOLDXFIELD.index = 1
var_0_1.TIDYUPCOLOLDXFIELD.label = 3
var_0_1.TIDYUPCOLOLDXFIELD.has_default_value = false
var_0_1.TIDYUPCOLOLDXFIELD.default_value = {}
var_0_1.TIDYUPCOLOLDXFIELD.type = 5
var_0_1.TIDYUPCOLOLDXFIELD.cpp_type = 1
var_0_1.TIDYUPCOLNEWXFIELD.name = "newX"
var_0_1.TIDYUPCOLNEWXFIELD.full_name = ".TidyUpCol.newX"
var_0_1.TIDYUPCOLNEWXFIELD.number = 3
var_0_1.TIDYUPCOLNEWXFIELD.index = 2
var_0_1.TIDYUPCOLNEWXFIELD.label = 3
var_0_1.TIDYUPCOLNEWXFIELD.has_default_value = false
var_0_1.TIDYUPCOLNEWXFIELD.default_value = {}
var_0_1.TIDYUPCOLNEWXFIELD.type = 5
var_0_1.TIDYUPCOLNEWXFIELD.cpp_type = 1
var_0_1.TIDYUPCOL_MSG.name = "TidyUpCol"
var_0_1.TIDYUPCOL_MSG.full_name = ".TidyUpCol"
var_0_1.TIDYUPCOL_MSG.nested_types = {}
var_0_1.TIDYUPCOL_MSG.enum_types = {}
var_0_1.TIDYUPCOL_MSG.fields = {
	var_0_1.TIDYUPCOLCOLFIELD,
	var_0_1.TIDYUPCOLOLDXFIELD,
	var_0_1.TIDYUPCOLNEWXFIELD
}
var_0_1.TIDYUPCOL_MSG.is_extendable = false
var_0_1.TIDYUPCOL_MSG.extensions = {}
var_0_1.MATCH3TIPSFROMFIELD.name = "from"
var_0_1.MATCH3TIPSFROMFIELD.full_name = ".Match3Tips.from"
var_0_1.MATCH3TIPSFROMFIELD.number = 1
var_0_1.MATCH3TIPSFROMFIELD.index = 0
var_0_1.MATCH3TIPSFROMFIELD.label = 1
var_0_1.MATCH3TIPSFROMFIELD.has_default_value = false
var_0_1.MATCH3TIPSFROMFIELD.default_value = nil
var_0_1.MATCH3TIPSFROMFIELD.message_type = var_0_1.COORDINATE_MSG
var_0_1.MATCH3TIPSFROMFIELD.type = 11
var_0_1.MATCH3TIPSFROMFIELD.cpp_type = 10
var_0_1.MATCH3TIPSTOFIELD.name = "to"
var_0_1.MATCH3TIPSTOFIELD.full_name = ".Match3Tips.to"
var_0_1.MATCH3TIPSTOFIELD.number = 2
var_0_1.MATCH3TIPSTOFIELD.index = 1
var_0_1.MATCH3TIPSTOFIELD.label = 1
var_0_1.MATCH3TIPSTOFIELD.has_default_value = false
var_0_1.MATCH3TIPSTOFIELD.default_value = nil
var_0_1.MATCH3TIPSTOFIELD.message_type = var_0_1.COORDINATE_MSG
var_0_1.MATCH3TIPSTOFIELD.type = 11
var_0_1.MATCH3TIPSTOFIELD.cpp_type = 10
var_0_1.MATCH3TIPSELIMINATEFIELD.name = "eliminate"
var_0_1.MATCH3TIPSELIMINATEFIELD.full_name = ".Match3Tips.eliminate"
var_0_1.MATCH3TIPSELIMINATEFIELD.number = 3
var_0_1.MATCH3TIPSELIMINATEFIELD.index = 2
var_0_1.MATCH3TIPSELIMINATEFIELD.label = 1
var_0_1.MATCH3TIPSELIMINATEFIELD.has_default_value = false
var_0_1.MATCH3TIPSELIMINATEFIELD.default_value = nil
var_0_1.MATCH3TIPSELIMINATEFIELD.message_type = var_0_1.ELIMINATE_MSG
var_0_1.MATCH3TIPSELIMINATEFIELD.type = 11
var_0_1.MATCH3TIPSELIMINATEFIELD.cpp_type = 10
var_0_1.MATCH3TIPS_MSG.name = "Match3Tips"
var_0_1.MATCH3TIPS_MSG.full_name = ".Match3Tips"
var_0_1.MATCH3TIPS_MSG.nested_types = {}
var_0_1.MATCH3TIPS_MSG.enum_types = {}
var_0_1.MATCH3TIPS_MSG.fields = {
	var_0_1.MATCH3TIPSFROMFIELD,
	var_0_1.MATCH3TIPSTOFIELD,
	var_0_1.MATCH3TIPSELIMINATEFIELD
}
var_0_1.MATCH3TIPS_MSG.is_extendable = false
var_0_1.MATCH3TIPS_MSG.extensions = {}
var_0_1.COORDINATEXFIELD.name = "x"
var_0_1.COORDINATEXFIELD.full_name = ".Coordinate.x"
var_0_1.COORDINATEXFIELD.number = 1
var_0_1.COORDINATEXFIELD.index = 0
var_0_1.COORDINATEXFIELD.label = 1
var_0_1.COORDINATEXFIELD.has_default_value = false
var_0_1.COORDINATEXFIELD.default_value = 0
var_0_1.COORDINATEXFIELD.type = 5
var_0_1.COORDINATEXFIELD.cpp_type = 1
var_0_1.COORDINATEYFIELD.name = "y"
var_0_1.COORDINATEYFIELD.full_name = ".Coordinate.y"
var_0_1.COORDINATEYFIELD.number = 2
var_0_1.COORDINATEYFIELD.index = 1
var_0_1.COORDINATEYFIELD.label = 1
var_0_1.COORDINATEYFIELD.has_default_value = false
var_0_1.COORDINATEYFIELD.default_value = 0
var_0_1.COORDINATEYFIELD.type = 5
var_0_1.COORDINATEYFIELD.cpp_type = 1
var_0_1.COORDINATE_MSG.name = "Coordinate"
var_0_1.COORDINATE_MSG.full_name = ".Coordinate"
var_0_1.COORDINATE_MSG.nested_types = {}
var_0_1.COORDINATE_MSG.enum_types = {}
var_0_1.COORDINATE_MSG.fields = {
	var_0_1.COORDINATEXFIELD,
	var_0_1.COORDINATEYFIELD
}
var_0_1.COORDINATE_MSG.is_extendable = false
var_0_1.COORDINATE_MSG.extensions = {}
var_0_1.FILLCHESSBOARDDIRFIELD.name = "dir"
var_0_1.FILLCHESSBOARDDIRFIELD.full_name = ".FillChessBoard.dir"
var_0_1.FILLCHESSBOARDDIRFIELD.number = 1
var_0_1.FILLCHESSBOARDDIRFIELD.index = 0
var_0_1.FILLCHESSBOARDDIRFIELD.label = 1
var_0_1.FILLCHESSBOARDDIRFIELD.has_default_value = false
var_0_1.FILLCHESSBOARDDIRFIELD.default_value = 0
var_0_1.FILLCHESSBOARDDIRFIELD.type = 5
var_0_1.FILLCHESSBOARDDIRFIELD.cpp_type = 1
var_0_1.FILLCHESSBOARDCHESSFIELD.name = "chess"
var_0_1.FILLCHESSBOARDCHESSFIELD.full_name = ".FillChessBoard.chess"
var_0_1.FILLCHESSBOARDCHESSFIELD.number = 2
var_0_1.FILLCHESSBOARDCHESSFIELD.index = 1
var_0_1.FILLCHESSBOARDCHESSFIELD.label = 3
var_0_1.FILLCHESSBOARDCHESSFIELD.has_default_value = false
var_0_1.FILLCHESSBOARDCHESSFIELD.default_value = {}
var_0_1.FILLCHESSBOARDCHESSFIELD.message_type = var_0_1.CHESS_MSG
var_0_1.FILLCHESSBOARDCHESSFIELD.type = 11
var_0_1.FILLCHESSBOARDCHESSFIELD.cpp_type = 10
var_0_1.FILLCHESSBOARD_MSG.name = "FillChessBoard"
var_0_1.FILLCHESSBOARD_MSG.full_name = ".FillChessBoard"
var_0_1.FILLCHESSBOARD_MSG.nested_types = {}
var_0_1.FILLCHESSBOARD_MSG.enum_types = {}
var_0_1.FILLCHESSBOARD_MSG.fields = {
	var_0_1.FILLCHESSBOARDDIRFIELD,
	var_0_1.FILLCHESSBOARDCHESSFIELD
}
var_0_1.FILLCHESSBOARD_MSG.is_extendable = false
var_0_1.FILLCHESSBOARD_MSG.extensions = {}
var_0_1.ELIMINATECOORDINATEFIELD.name = "coordinate"
var_0_1.ELIMINATECOORDINATEFIELD.full_name = ".Eliminate.coordinate"
var_0_1.ELIMINATECOORDINATEFIELD.number = 1
var_0_1.ELIMINATECOORDINATEFIELD.index = 0
var_0_1.ELIMINATECOORDINATEFIELD.label = 3
var_0_1.ELIMINATECOORDINATEFIELD.has_default_value = false
var_0_1.ELIMINATECOORDINATEFIELD.default_value = {}
var_0_1.ELIMINATECOORDINATEFIELD.message_type = var_0_1.COORDINATE_MSG
var_0_1.ELIMINATECOORDINATEFIELD.type = 11
var_0_1.ELIMINATECOORDINATEFIELD.cpp_type = 10
var_0_1.ELIMINATEEXTRADATAFIELD.name = "extraData"
var_0_1.ELIMINATEEXTRADATAFIELD.full_name = ".Eliminate.extraData"
var_0_1.ELIMINATEEXTRADATAFIELD.number = 2
var_0_1.ELIMINATEEXTRADATAFIELD.index = 1
var_0_1.ELIMINATEEXTRADATAFIELD.label = 1
var_0_1.ELIMINATEEXTRADATAFIELD.has_default_value = false
var_0_1.ELIMINATEEXTRADATAFIELD.default_value = ""
var_0_1.ELIMINATEEXTRADATAFIELD.type = 9
var_0_1.ELIMINATEEXTRADATAFIELD.cpp_type = 9
var_0_1.ELIMINATETYPEFIELD.name = "type"
var_0_1.ELIMINATETYPEFIELD.full_name = ".Eliminate.type"
var_0_1.ELIMINATETYPEFIELD.number = 3
var_0_1.ELIMINATETYPEFIELD.index = 2
var_0_1.ELIMINATETYPEFIELD.label = 1
var_0_1.ELIMINATETYPEFIELD.has_default_value = false
var_0_1.ELIMINATETYPEFIELD.default_value = ""
var_0_1.ELIMINATETYPEFIELD.type = 9
var_0_1.ELIMINATETYPEFIELD.cpp_type = 9
var_0_1.ELIMINATESOURCEFIELD.name = "source"
var_0_1.ELIMINATESOURCEFIELD.full_name = ".Eliminate.source"
var_0_1.ELIMINATESOURCEFIELD.number = 4
var_0_1.ELIMINATESOURCEFIELD.index = 3
var_0_1.ELIMINATESOURCEFIELD.label = 1
var_0_1.ELIMINATESOURCEFIELD.has_default_value = false
var_0_1.ELIMINATESOURCEFIELD.default_value = 0
var_0_1.ELIMINATESOURCEFIELD.type = 5
var_0_1.ELIMINATESOURCEFIELD.cpp_type = 1
var_0_1.ELIMINATE_MSG.name = "Eliminate"
var_0_1.ELIMINATE_MSG.full_name = ".Eliminate"
var_0_1.ELIMINATE_MSG.nested_types = {}
var_0_1.ELIMINATE_MSG.enum_types = {}
var_0_1.ELIMINATE_MSG.fields = {
	var_0_1.ELIMINATECOORDINATEFIELD,
	var_0_1.ELIMINATEEXTRADATAFIELD,
	var_0_1.ELIMINATETYPEFIELD,
	var_0_1.ELIMINATESOURCEFIELD
}
var_0_1.ELIMINATE_MSG.is_extendable = false
var_0_1.ELIMINATE_MSG.extensions = {}
var_0_1.TIDYUPCOLFIELD.name = "col"
var_0_1.TIDYUPCOLFIELD.full_name = ".TidyUp.col"
var_0_1.TIDYUPCOLFIELD.number = 1
var_0_1.TIDYUPCOLFIELD.index = 0
var_0_1.TIDYUPCOLFIELD.label = 3
var_0_1.TIDYUPCOLFIELD.has_default_value = false
var_0_1.TIDYUPCOLFIELD.default_value = {}
var_0_1.TIDYUPCOLFIELD.message_type = var_0_1.TIDYUPCOL_MSG
var_0_1.TIDYUPCOLFIELD.type = 11
var_0_1.TIDYUPCOLFIELD.cpp_type = 10
var_0_1.TIDYUPROWFIELD.name = "row"
var_0_1.TIDYUPROWFIELD.full_name = ".TidyUp.row"
var_0_1.TIDYUPROWFIELD.number = 2
var_0_1.TIDYUPROWFIELD.index = 1
var_0_1.TIDYUPROWFIELD.label = 3
var_0_1.TIDYUPROWFIELD.has_default_value = false
var_0_1.TIDYUPROWFIELD.default_value = {}
var_0_1.TIDYUPROWFIELD.message_type = var_0_1.TIDYUPROW_MSG
var_0_1.TIDYUPROWFIELD.type = 11
var_0_1.TIDYUPROWFIELD.cpp_type = 10
var_0_1.TIDYUP_MSG.name = "TidyUp"
var_0_1.TIDYUP_MSG.full_name = ".TidyUp"
var_0_1.TIDYUP_MSG.nested_types = {}
var_0_1.TIDYUP_MSG.enum_types = {}
var_0_1.TIDYUP_MSG.fields = {
	var_0_1.TIDYUPCOLFIELD,
	var_0_1.TIDYUPROWFIELD
}
var_0_1.TIDYUP_MSG.is_extendable = false
var_0_1.TIDYUP_MSG.extensions = {}
var_0_1.CHESSBOARDROWCHESSFIELD.name = "chess"
var_0_1.CHESSBOARDROWCHESSFIELD.full_name = ".ChessBoardRow.chess"
var_0_1.CHESSBOARDROWCHESSFIELD.number = 1
var_0_1.CHESSBOARDROWCHESSFIELD.index = 0
var_0_1.CHESSBOARDROWCHESSFIELD.label = 3
var_0_1.CHESSBOARDROWCHESSFIELD.has_default_value = false
var_0_1.CHESSBOARDROWCHESSFIELD.default_value = {}
var_0_1.CHESSBOARDROWCHESSFIELD.message_type = var_0_1.CHESS_MSG
var_0_1.CHESSBOARDROWCHESSFIELD.type = 11
var_0_1.CHESSBOARDROWCHESSFIELD.cpp_type = 10
var_0_1.CHESSBOARDROW_MSG.name = "ChessBoardRow"
var_0_1.CHESSBOARDROW_MSG.full_name = ".ChessBoardRow"
var_0_1.CHESSBOARDROW_MSG.nested_types = {}
var_0_1.CHESSBOARDROW_MSG.enum_types = {}
var_0_1.CHESSBOARDROW_MSG.fields = {
	var_0_1.CHESSBOARDROWCHESSFIELD
}
var_0_1.CHESSBOARDROW_MSG.is_extendable = false
var_0_1.CHESSBOARDROW_MSG.extensions = {}
var_0_1.TIDYUPROWROWFIELD.name = "row"
var_0_1.TIDYUPROWROWFIELD.full_name = ".TidyUpRow.row"
var_0_1.TIDYUPROWROWFIELD.number = 1
var_0_1.TIDYUPROWROWFIELD.index = 0
var_0_1.TIDYUPROWROWFIELD.label = 1
var_0_1.TIDYUPROWROWFIELD.has_default_value = false
var_0_1.TIDYUPROWROWFIELD.default_value = 0
var_0_1.TIDYUPROWROWFIELD.type = 5
var_0_1.TIDYUPROWROWFIELD.cpp_type = 1
var_0_1.TIDYUPROWOLDYFIELD.name = "oldY"
var_0_1.TIDYUPROWOLDYFIELD.full_name = ".TidyUpRow.oldY"
var_0_1.TIDYUPROWOLDYFIELD.number = 2
var_0_1.TIDYUPROWOLDYFIELD.index = 1
var_0_1.TIDYUPROWOLDYFIELD.label = 3
var_0_1.TIDYUPROWOLDYFIELD.has_default_value = false
var_0_1.TIDYUPROWOLDYFIELD.default_value = {}
var_0_1.TIDYUPROWOLDYFIELD.type = 5
var_0_1.TIDYUPROWOLDYFIELD.cpp_type = 1
var_0_1.TIDYUPROWNEWYFIELD.name = "newY"
var_0_1.TIDYUPROWNEWYFIELD.full_name = ".TidyUpRow.newY"
var_0_1.TIDYUPROWNEWYFIELD.number = 3
var_0_1.TIDYUPROWNEWYFIELD.index = 2
var_0_1.TIDYUPROWNEWYFIELD.label = 3
var_0_1.TIDYUPROWNEWYFIELD.has_default_value = false
var_0_1.TIDYUPROWNEWYFIELD.default_value = {}
var_0_1.TIDYUPROWNEWYFIELD.type = 5
var_0_1.TIDYUPROWNEWYFIELD.cpp_type = 1
var_0_1.TIDYUPROW_MSG.name = "TidyUpRow"
var_0_1.TIDYUPROW_MSG.full_name = ".TidyUpRow"
var_0_1.TIDYUPROW_MSG.nested_types = {}
var_0_1.TIDYUPROW_MSG.enum_types = {}
var_0_1.TIDYUPROW_MSG.fields = {
	var_0_1.TIDYUPROWROWFIELD,
	var_0_1.TIDYUPROWOLDYFIELD,
	var_0_1.TIDYUPROWNEWYFIELD
}
var_0_1.TIDYUPROW_MSG.is_extendable = false
var_0_1.TIDYUPROW_MSG.extensions = {}
var_0_1.MATCH3TURNELIMINATEFIELD.name = "eliminate"
var_0_1.MATCH3TURNELIMINATEFIELD.full_name = ".Match3Turn.eliminate"
var_0_1.MATCH3TURNELIMINATEFIELD.number = 1
var_0_1.MATCH3TURNELIMINATEFIELD.index = 0
var_0_1.MATCH3TURNELIMINATEFIELD.label = 3
var_0_1.MATCH3TURNELIMINATEFIELD.has_default_value = false
var_0_1.MATCH3TURNELIMINATEFIELD.default_value = {}
var_0_1.MATCH3TURNELIMINATEFIELD.message_type = var_0_1.ELIMINATE_MSG
var_0_1.MATCH3TURNELIMINATEFIELD.type = 11
var_0_1.MATCH3TURNELIMINATEFIELD.cpp_type = 10
var_0_1.MATCH3TURNTIDYUPFIELD.name = "tidyUp"
var_0_1.MATCH3TURNTIDYUPFIELD.full_name = ".Match3Turn.tidyUp"
var_0_1.MATCH3TURNTIDYUPFIELD.number = 2
var_0_1.MATCH3TURNTIDYUPFIELD.index = 1
var_0_1.MATCH3TURNTIDYUPFIELD.label = 1
var_0_1.MATCH3TURNTIDYUPFIELD.has_default_value = false
var_0_1.MATCH3TURNTIDYUPFIELD.default_value = nil
var_0_1.MATCH3TURNTIDYUPFIELD.message_type = var_0_1.TIDYUP_MSG
var_0_1.MATCH3TURNTIDYUPFIELD.type = 11
var_0_1.MATCH3TURNTIDYUPFIELD.cpp_type = 10
var_0_1.MATCH3TURNFILLCHESSBOARDFIELD.name = "fillChessBoard"
var_0_1.MATCH3TURNFILLCHESSBOARDFIELD.full_name = ".Match3Turn.fillChessBoard"
var_0_1.MATCH3TURNFILLCHESSBOARDFIELD.number = 3
var_0_1.MATCH3TURNFILLCHESSBOARDFIELD.index = 2
var_0_1.MATCH3TURNFILLCHESSBOARDFIELD.label = 1
var_0_1.MATCH3TURNFILLCHESSBOARDFIELD.has_default_value = false
var_0_1.MATCH3TURNFILLCHESSBOARDFIELD.default_value = nil
var_0_1.MATCH3TURNFILLCHESSBOARDFIELD.message_type = var_0_1.FILLCHESSBOARD_MSG
var_0_1.MATCH3TURNFILLCHESSBOARDFIELD.type = 11
var_0_1.MATCH3TURNFILLCHESSBOARDFIELD.cpp_type = 10
var_0_1.MATCH3TURN_MSG.name = "Match3Turn"
var_0_1.MATCH3TURN_MSG.full_name = ".Match3Turn"
var_0_1.MATCH3TURN_MSG.nested_types = {}
var_0_1.MATCH3TURN_MSG.enum_types = {}
var_0_1.MATCH3TURN_MSG.fields = {
	var_0_1.MATCH3TURNELIMINATEFIELD,
	var_0_1.MATCH3TURNTIDYUPFIELD,
	var_0_1.MATCH3TURNFILLCHESSBOARDFIELD
}
var_0_1.MATCH3TURN_MSG.is_extendable = false
var_0_1.MATCH3TURN_MSG.extensions = {}
var_0_1.Chess = var_0_0.Message(var_0_1.CHESS_MSG)
var_0_1.ChessBoardRow = var_0_0.Message(var_0_1.CHESSBOARDROW_MSG)
var_0_1.Coordinate = var_0_0.Message(var_0_1.COORDINATE_MSG)
var_0_1.Eliminate = var_0_0.Message(var_0_1.ELIMINATE_MSG)
var_0_1.FillChessBoard = var_0_0.Message(var_0_1.FILLCHESSBOARD_MSG)
var_0_1.Match3ChessBoard = var_0_0.Message(var_0_1.MATCH3CHESSBOARD_MSG)
var_0_1.Match3Tips = var_0_0.Message(var_0_1.MATCH3TIPS_MSG)
var_0_1.Match3Turn = var_0_0.Message(var_0_1.MATCH3TURN_MSG)
var_0_1.TidyUp = var_0_0.Message(var_0_1.TIDYUP_MSG)
var_0_1.TidyUpCol = var_0_0.Message(var_0_1.TIDYUPCOL_MSG)
var_0_1.TidyUpRow = var_0_0.Message(var_0_1.TIDYUPROW_MSG)

return var_0_1
