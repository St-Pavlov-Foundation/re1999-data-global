module("modules.logic.chessgame.model.ChessGameModel", package.seeall)

local var_0_0 = class("ChessGameModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0.nowMapResPath = nil
	arg_1_0.nowMapIndex = 1
end

function var_0_0.clear(arg_2_0)
	arg_2_0.nowMapResPath = nil
	arg_2_0.nowMapIndex = 1
	arg_2_0._completedCount = 1
	arg_2_0._optList = {}
	arg_2_0._catchObj = nil
	arg_2_0._finishInteract = nil
	arg_2_0._operations = {}
	arg_2_0._result = nil
	arg_2_0._isPlayingStory = nil
	arg_2_0._catchList = nil
	arg_2_0._isTalking = nil
end

function var_0_0.initData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = ChessConfig.instance:getEpisodeCo(arg_3_1, arg_3_2).mapIds

	arg_3_0._optList = {}
	arg_3_0.currentmapCo = ChessGameConfig.instance:getMapCo(var_3_0)

	local var_3_1 = arg_3_0.currentmapCo[arg_3_3].path

	arg_3_0:setNowMapResPath(var_3_1)
end

function var_0_0.setNowMapResPath(arg_4_0, arg_4_1)
	arg_4_0.nowMapResPath = arg_4_1
end

function var_0_0.getNowMapResPath(arg_5_0)
	return arg_5_0.nowMapResPath
end

function var_0_0.setNowMapIndex(arg_6_0, arg_6_1)
	arg_6_0.nowMapIndex = arg_6_1
end

function var_0_0.getNowMapIndex(arg_7_0)
	return arg_7_0.nowMapIndex
end

function var_0_0.addOperations(arg_8_0, arg_8_1)
	table.insert(arg_8_0._operations, arg_8_1)
end

function var_0_0.getOperations(arg_9_0)
	return arg_9_0._operations
end

function var_0_0.cleanOperations(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._operations) do
		arg_10_0._operations[iter_10_0] = nil
	end
end

function var_0_0.setResult(arg_11_0, arg_11_1)
	arg_11_0._result = arg_11_1
end

function var_0_0.onInit(arg_12_0)
	arg_12_0._mapTileMOList = {}
end

function var_0_0.appendOpt(arg_13_0, arg_13_1)
	table.insert(arg_13_0._optList, arg_13_1)
end

function var_0_0.getOptList(arg_14_0)
	return arg_14_0._optList
end

function var_0_0.cleanOptList(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._optList) do
		arg_15_0._optList[iter_15_0] = nil
	end
end

function var_0_0.setCompletedCount(arg_16_0, arg_16_1)
	arg_16_0._completedCount = arg_16_1
end

function var_0_0.getCompletedCount(arg_17_0)
	return arg_17_0._completedCount
end

function var_0_0.addRollBackNum(arg_18_0)
	if not arg_18_0._rollbackNum then
		arg_18_0._rollbackNum = 0
	end

	arg_18_0._rollbackNum = arg_18_0._rollbackNum + 1
end

function var_0_0.clearRollbackNum(arg_19_0)
	arg_19_0._rollbackNum = 0
end

function var_0_0.getRollBackNum(arg_20_0)
	return arg_20_0._rollbackNum
end

function var_0_0.getRound(arg_21_0)
	return arg_21_0._round or 0
end

function var_0_0.addRound(arg_22_0)
	arg_22_0._round = arg_22_0._round and arg_22_0._round + 1 or 1
end

function var_0_0.clearRound(arg_23_0)
	arg_23_0._round = 0
end

function var_0_0.setGameState(arg_24_0, arg_24_1)
	arg_24_0._gameState = arg_24_1
end

function var_0_0.getGameState(arg_25_0)
	return arg_25_0._gameState
end

function var_0_0.setPlayingStory(arg_26_0, arg_26_1)
	arg_26_0._isPlayingStory = arg_26_1
end

function var_0_0.getPlayingStory(arg_27_0)
	return arg_27_0._isPlayingStory
end

function var_0_0.setCatchObj(arg_28_0, arg_28_1)
	arg_28_0._catchObj = arg_28_1
end

function var_0_0.getCatchObj(arg_29_0)
	return arg_29_0._catchObj
end

function var_0_0.insertCatchObjCanWalkList(arg_30_0, arg_30_1)
	arg_30_0._catchList = arg_30_0._catchList or {}

	table.insert(arg_30_0._catchList, arg_30_1)
end

function var_0_0.checkPosCatchObjCanWalk(arg_31_0, arg_31_1)
	if not arg_31_0._catchList then
		return false
	end

	for iter_31_0, iter_31_1 in ipairs(arg_31_0._catchList) do
		if arg_31_1.x == iter_31_1.x and arg_31_1.y == iter_31_1.y then
			return true
		end
	end

	return false
end

function var_0_0.cleanCatchObjCanWalkList(arg_32_0)
	arg_32_0._catchList = nil
end

function var_0_0.setTalk(arg_33_0, arg_33_1)
	arg_33_0._isTalking = arg_33_1
end

function var_0_0.isTalking(arg_34_0)
	return arg_34_0._isTalking
end

var_0_0.instance = var_0_0.New()

return var_0_0
