module("modules.logic.versionactivity2_7.lengzhou6.model.mo.EliminateChessCellMO", package.seeall)

local var_0_0 = class("EliminateChessCellMO", EliminateChessMO)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._status = {}
end

function var_0_0.setChessId(arg_2_0, arg_2_1)
	var_0_0.super.setChessId(arg_2_0, arg_2_1)
	arg_2_0:setEliminateID()
end

function var_0_0.setEliminateID(arg_3_0)
	arg_3_0._eliminateID = EliminateEnum_2_7.ChessIndexToType[arg_3_0.id] or ""
end

function var_0_0.canMove(arg_4_0)
	return arg_4_0:haveStatus(EliminateEnum.ChessState.Frost)
end

function var_0_0.getEliminateID(arg_5_0)
	if arg_5_0._eliminateID == nil then
		logNormal("EliminateChessCellMO:getEliminateID() self._eliminateID == nil")
	end

	return arg_5_0._eliminateID
end

function var_0_0.setStatus(arg_6_0, arg_6_1)
	if arg_6_1 == EliminateEnum.ChessState.Normal or arg_6_1 == EliminateEnum.ChessState.Die then
		tabletool.clear(arg_6_0._status)
	end

	arg_6_0:addStatus(arg_6_1)
end

function var_0_0.haveStatus(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0._status do
		if arg_7_0._status[iter_7_0] == arg_7_1 then
			return true
		end
	end

	return false
end

function var_0_0.addStatus(arg_8_0, arg_8_1)
	if arg_8_1 == EliminateEnum.ChessState.Normal or arg_8_1 == EliminateEnum.ChessState.Die then
		tabletool.clear(arg_8_0._status)
	end

	if not arg_8_0:haveStatus(arg_8_1) then
		table.insert(arg_8_0._status, arg_8_1)
	end
end

function var_0_0.unsetStatus(arg_9_0, arg_9_1)
	for iter_9_0 = 1, #arg_9_0._status do
		if arg_9_0._status[iter_9_0] == arg_9_1 then
			table.remove(arg_9_0._status, iter_9_0)

			break
		end
	end
end

function var_0_0.clear(arg_10_0)
	if arg_10_0._status then
		tabletool.clear(arg_10_0._status)
	end

	var_0_0.super.clear(arg_10_0)
end

return var_0_0
