module("modules.logic.versionactivity2_2.eliminate.model.mo.EliminateChessMO", package.seeall)

local var_0_0 = class("EliminateChessMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.x = 1
	arg_1_0.y = 1
	arg_1_0.startX = 1
	arg_1_0.startY = 1
	arg_1_0.id = -1
	arg_1_0._status = EliminateEnum.ChessState.Normal
	arg_1_0._chessBoardType = EliminateEnum.ChessBoardType.Normal
end

function var_0_0.setXY(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.x = arg_2_1
	arg_2_0.y = arg_2_2
end

function var_0_0.setStartXY(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.startX = arg_3_1
	arg_3_0.startY = arg_3_2
end

function var_0_0.setChessId(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1
end

function var_0_0.setStatus(arg_5_0, arg_5_1)
	arg_5_0._status = arg_5_1
end

function var_0_0.setChessBoardType(arg_6_0, arg_6_1)
	arg_6_0._chessBoardType = arg_6_1
end

function var_0_0.getChessBoardType(arg_7_0)
	return arg_7_0._chessBoardType
end

function var_0_0.getStatus(arg_8_0)
	return arg_8_0._status
end

function var_0_0.getMoveTime(arg_9_0)
	return EliminateEnum.AniTime.Drop
end

function var_0_0.getInitMoveTime(arg_10_0)
	return EliminateEnum.AniTime.InitDrop
end

function var_0_0.clear(arg_11_0)
	arg_11_0.x = 1
	arg_11_0.y = 1
	arg_11_0.startX = 1
	arg_11_0.startY = 1
	arg_11_0.id = -1
	arg_11_0._status = EliminateEnum.ChessState.Normal
	arg_11_0._chessBoardType = EliminateEnum.ChessBoardType.Normal
end

return var_0_0
