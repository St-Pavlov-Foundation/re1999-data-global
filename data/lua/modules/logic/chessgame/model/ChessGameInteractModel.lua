module("modules.logic.chessgame.model.ChessGameInteractModel", package.seeall)

local var_0_0 = class("ChessGameInteractModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._interacts = {}
	arg_1_0._finishInteractMap = {}
	arg_1_0._interactsByMapIndex = {}
	arg_1_0._showEffect = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.setInteractDatas(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._interacts = {}
	arg_3_0._interactsByMapIndex = {}
	arg_3_0._finishInteractMap = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = ChessGameInteractMo.New()
		local var_3_1 = iter_3_1.id
		local var_3_2 = iter_3_1.mapGroupId or ChessGameConfig.instance:getCurrentMapGroupId()
		local var_3_3 = ChessGameConfig.instance:getInteractCoById(var_3_2, var_3_1)

		iter_3_1.mapIndex = arg_3_2

		var_3_0:init(var_3_3, iter_3_1)

		arg_3_0._interacts[var_3_3.id] = var_3_0
		arg_3_0._interactsByMapIndex[arg_3_2] = arg_3_0._interactsByMapIndex[arg_3_2] or {}
		arg_3_0._interactsByMapIndex[arg_3_2][var_3_3.id] = var_3_0
	end

	arg_3_0:setInteractFinishMap()
end

function var_0_0.addInteractMo(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ChessGameInteractMo.New()

	var_4_0:init(arg_4_1, arg_4_2)

	arg_4_0._interacts[arg_4_1.id] = var_4_0

	return var_4_0
end

function var_0_0.getInteractById(arg_5_0, arg_5_1)
	return arg_5_0._interacts[arg_5_1]
end

function var_0_0.deleteInteractById(arg_6_0, arg_6_1)
	arg_6_0._interacts[arg_6_1] = nil

	local var_6_0 = ChessGameModel.instance.nowMapIndex

	arg_6_0._interactsByMapIndex[var_6_0][arg_6_1] = nil
end

function var_0_0.getAllInteracts(arg_7_0)
	return arg_7_0._interacts
end

function var_0_0.getInteractsByMapIndex(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or ChessGameModel.instance.nowMapIndex

	return arg_8_0._interactsByMapIndex[arg_8_1] or {}
end

function var_0_0.getInteractByPos(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {}

	arg_9_3 = arg_9_3 or ChessGameModel.instance.nowMapIndex

	if not arg_9_0._interactsByMapIndex[arg_9_3] then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._interactsByMapIndex[arg_9_3]) do
		local var_9_1, var_9_2 = iter_9_1:getXY()

		if var_9_1 == arg_9_1 and var_9_2 == arg_9_2 then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0.setInteractFinishMap(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._interacts) do
		if iter_10_1:CheckInteractFinish() then
			arg_10_0._finishInteractMap[iter_10_0] = true
		end
	end
end

function var_0_0.checkInteractFinish(arg_11_0, arg_11_1)
	return arg_11_0._finishInteractMap[arg_11_1]
end

function var_0_0.setShowEffect(arg_12_0, arg_12_1)
	arg_12_0._showEffect[arg_12_1] = true
end

function var_0_0.setHideEffect(arg_13_0, arg_13_1)
	arg_13_0._showEffect[arg_13_1] = false
end

function var_0_0.getShowEffects(arg_14_0)
	return arg_14_0._showEffect
end

function var_0_0.clear(arg_15_0)
	arg_15_0._interacts = {}
	arg_15_0._interactsByMapIndex = {}
	arg_15_0._finishInteractMap = {}
	arg_15_0._showEffect = {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
