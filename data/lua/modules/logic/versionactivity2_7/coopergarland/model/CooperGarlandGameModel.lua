module("modules.logic.versionactivity2_7.coopergarland.model.CooperGarlandGameModel", package.seeall)

local var_0_0 = class("CooperGarlandGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearAllData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearAllData()
end

function var_0_0.clearAllData(arg_3_0)
	arg_3_0:setEpisodeId()
	arg_3_0:setGameId()
	arg_3_0:setGameRound()
	arg_3_0:setMapId()
	arg_3_0:setRemoveCount()
	arg_3_0:setRemoveMode()
	arg_3_0:setBallHasKey(false)
	arg_3_0:setIsStopGame(false)
	arg_3_0:setSceneOpenAnimShowBall(false)
end

function var_0_0.enterGameInitData(arg_4_0, arg_4_1)
	arg_4_0:setEpisodeId(arg_4_1)

	local var_4_0 = CooperGarlandModel.instance:getAct192Id()
	local var_4_1 = CooperGarlandConfig.instance:getGameId(var_4_0, arg_4_1)

	arg_4_0:setGameId(var_4_1)

	local var_4_2 = CooperGarlandModel.instance:getEpisodeProgress(var_4_0, arg_4_1)

	arg_4_0:changeRound(var_4_2)
	arg_4_0:setSceneOpenAnimShowBall(false)
end

function var_0_0.changeRound(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getGameId()

	if not var_5_0 then
		return
	end

	arg_5_0:setGameRound(arg_5_1)

	local var_5_1 = CooperGarlandConfig.instance:getMapId(var_5_0, arg_5_1)

	arg_5_0:setMapId(var_5_1)

	local var_5_2 = CooperGarlandConfig.instance:getRemoveCount(var_5_0, arg_5_1)

	arg_5_0:setRemoveCount(var_5_2)
	arg_5_0:setBallHasKey(false)
	arg_5_0:setRemoveMode(false)
	arg_5_0:setIsStopGame(false)
end

function var_0_0.resetGameData(arg_6_0)
	local var_6_0 = arg_6_0:getGameRound()

	arg_6_0:changeRound(var_6_0)
end

function var_0_0.setEpisodeId(arg_7_0, arg_7_1)
	arg_7_0._episodeId = arg_7_1
end

function var_0_0.setGameId(arg_8_0, arg_8_1)
	arg_8_0._gameId = arg_8_1
end

function var_0_0.setGameRound(arg_9_0, arg_9_1)
	arg_9_0._gameRound = arg_9_1
end

function var_0_0.setMapId(arg_10_0, arg_10_1)
	arg_10_0._mapId = arg_10_1
end

function var_0_0.setRemoveCount(arg_11_0, arg_11_1)
	arg_11_0._removeCount = arg_11_1
end

function var_0_0.setRemoveMode(arg_12_0, arg_12_1)
	arg_12_0._isRemoveMode = arg_12_1
end

function var_0_0.setBallHasKey(arg_13_0, arg_13_1)
	arg_13_0._hasKey = arg_13_1
end

function var_0_0.setControlMode(arg_14_0, arg_14_1)
	arg_14_0._controlMode = arg_14_1

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.CooperGarlandControlMode, arg_14_1)
end

function var_0_0.setIsStopGame(arg_15_0, arg_15_1)
	arg_15_0._isStopGame = arg_15_1
end

function var_0_0.setSceneOpenAnimShowBall(arg_16_0, arg_16_1)
	arg_16_0._openAnimShowBall = arg_16_1
end

function var_0_0.getEpisodeId(arg_17_0)
	return arg_17_0._episodeId
end

function var_0_0.getGameId(arg_18_0)
	return arg_18_0._gameId
end

function var_0_0.getGameRound(arg_19_0)
	return arg_19_0._gameRound
end

function var_0_0.getMapId(arg_20_0)
	return arg_20_0._mapId
end

function var_0_0.getRemoveCount(arg_21_0)
	return arg_21_0._removeCount or 0
end

function var_0_0.getIsRemoveMode(arg_22_0)
	return arg_22_0._isRemoveMode
end

function var_0_0.getBallHasKey(arg_23_0)
	return arg_23_0._hasKey
end

function var_0_0.getControlMode(arg_24_0)
	if not arg_24_0._controlMode then
		arg_24_0._controlMode = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.CooperGarlandControlMode, CooperGarlandEnum.Const.JoystickModeRight)
	end

	return arg_24_0._controlMode
end

function var_0_0.getIsJoystick(arg_25_0)
	local var_25_0 = arg_25_0:getControlMode()

	return var_25_0 == CooperGarlandEnum.Const.JoystickModeRight or var_25_0 == CooperGarlandEnum.Const.JoystickModeLeft
end

function var_0_0.isFinishedStoryComponent(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = false
	local var_26_1 = CooperGarlandConfig.instance:getMapComponentType(arg_26_1, arg_26_2)
	local var_26_2 = CooperGarlandConfig.instance:getMapComponentExtraParams(arg_26_1, arg_26_2)
	local var_26_3 = var_26_2 and tonumber(var_26_2)

	if var_26_1 == CooperGarlandEnum.ComponentType.Story and var_26_3 then
		var_26_0 = GuideModel.instance:isGuideFinish(var_26_3)
	end

	return var_26_0
end

function var_0_0.getIsStopGame(arg_27_0)
	return arg_27_0._isStopGame
end

function var_0_0.getSceneOpenAnimShowBall(arg_28_0)
	return arg_28_0._openAnimShowBall
end

var_0_0.instance = var_0_0.New()

return var_0_0
