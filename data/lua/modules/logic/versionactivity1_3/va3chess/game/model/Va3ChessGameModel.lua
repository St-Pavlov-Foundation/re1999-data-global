module("modules.logic.versionactivity1_3.va3chess.game.model.Va3ChessGameModel", package.seeall)

local var_0_0 = class("Va3ChessGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._mapTileMOList = {}
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.release(arg_3_0)
	arg_3_0.width = nil
	arg_3_0.height = nil
	arg_3_0._mapTileBaseList = nil
	arg_3_0._mapInteractObjs = nil
	arg_3_0._mapInteractObjDict = nil
	arg_3_0._actId = nil
	arg_3_0._mapId = nil
	arg_3_0._optList = nil
	arg_3_0._round = nil
	arg_3_0._result = nil
	arg_3_0._finishInteract = nil
	arg_3_0._allFinishInteract = nil
	arg_3_0.failReason = nil
	arg_3_0.lastMapRound = nil
	arg_3_0._playingStory = nil
end

function var_0_0.initData(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Va3ChessConfig.instance:getMapCo(arg_4_1, arg_4_2)

	arg_4_0._actId = arg_4_1
	arg_4_0._mapId = arg_4_2
	arg_4_0.width = var_4_0.width
	arg_4_0.height = var_4_0.height
	arg_4_0._optList = {}

	arg_4_0:_initTileNum()

	arg_4_0._mapTileBaseList = {}

	local var_4_1 = string.split(var_4_0.tilebase, ",") or {}

	for iter_4_0 = 1, #arg_4_0._mapTileMOList do
		arg_4_0._mapTileMOList[iter_4_0]:setParamStr(var_4_1[iter_4_0])
	end
end

function var_0_0._initTileNum(arg_5_0)
	arg_5_0._mapTileMOList = {}

	local var_5_0 = arg_5_0.width * arg_5_0.height

	for iter_5_0 = 1, var_5_0 do
		local var_5_1 = arg_5_0._mapTileMOList[iter_5_0]

		if not var_5_1 then
			var_5_1 = Va3ChessGameTileMO.New()
			arg_5_0._mapTileMOList[iter_5_0] = var_5_1
		end

		var_5_1:init(iter_5_0)
	end
end

function var_0_0.addInteractData(arg_6_0, arg_6_1)
	table.insert(arg_6_0._mapInteractObjs, arg_6_1)

	arg_6_0._mapInteractObjDict[arg_6_1.id] = arg_6_1
end

function var_0_0.removeInteractData(arg_7_0, arg_7_1)
	tabletool.removeValue(arg_7_0._mapInteractObjs, arg_7_1)

	arg_7_0._mapInteractObjDict[arg_7_1.id] = nil
end

function var_0_0.initObjects(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._mapInteractObjs = {}
	arg_8_0._mapInteractObjDict = {}

	local var_8_0 = #arg_8_2

	for iter_8_0 = 1, var_8_0 do
		local var_8_1 = arg_8_2[iter_8_0]

		if Va3ChessConfig.instance:getInteractObjectCo(arg_8_1, var_8_1.id) then
			local var_8_2 = Va3ChessGameInteractMO.New()

			var_8_2:init(arg_8_1, var_8_1)
			table.insert(arg_8_0._mapInteractObjs, var_8_2)

			arg_8_0._mapInteractObjDict[var_8_2.id] = var_8_2
		end
	end
end

function var_0_0.addObject(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = Va3ChessGameInteractMO.New()

	var_9_0:init(arg_9_1, arg_9_2)
	table.insert(arg_9_0._mapInteractObjs, var_9_0)

	arg_9_0._mapInteractObjDict[var_9_0.id] = var_9_0

	return var_9_0
end

function var_0_0.removeObjectById(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_0._mapInteractObjs do
		if arg_10_0._mapInteractObjs[iter_10_0].id == arg_10_1 then
			local var_10_0 = arg_10_0._mapInteractObjs[iter_10_0]

			table.remove(arg_10_0._mapInteractObjs, iter_10_0)

			arg_10_0._mapInteractObjDict[arg_10_1] = nil

			return var_10_0
		end
	end
end

function var_0_0.syncObjectData(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0
	local var_11_1 = arg_11_0._mapInteractObjDict[arg_11_1]

	if var_11_1 then
		local var_11_2 = var_11_1.data

		var_11_0 = arg_11_0:compareObjectData(var_11_2, arg_11_2)
		var_11_1.data = arg_11_2
	end

	return var_11_0
end

function var_0_0.compareObjectData(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	arg_12_0:compareAlertArea(var_12_0, arg_12_1, arg_12_2)
	arg_12_0:compareValueTypeField(var_12_0, arg_12_1, arg_12_2, "goToObject")
	arg_12_0:compareValueTypeField(var_12_0, arg_12_1, arg_12_2, "lostTarget")
	arg_12_0:compareValueTypeField(var_12_0, arg_12_1, arg_12_2, "status")
	arg_12_0:compareValueTypeField(var_12_0, arg_12_1, arg_12_2, "attributes")
	arg_12_0:compareValueTypeField(var_12_0, arg_12_1, arg_12_2, "pedalStatus")

	return var_12_0
end

function var_0_0.compareAlertArea(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 and arg_13_3 and arg_13_2.alertArea and arg_13_3.alertArea and #arg_13_2.alertArea == #arg_13_3.alertArea then
		for iter_13_0 = 1, #arg_13_2.alertArea do
			if arg_13_2.alertArea[iter_13_0].x ~= arg_13_3.alertArea[iter_13_0].x or arg_13_2.alertArea[iter_13_0].y ~= arg_13_3.alertArea[iter_13_0].y then
				arg_13_1.alertArea = arg_13_3.alertArea

				break
			end
		end
	else
		arg_13_0:compareValueOverride(arg_13_1, arg_13_2, arg_13_3, "alertArea")
	end
end

function var_0_0.compareValueTypeField(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_2 and arg_14_3 then
		if arg_14_2[arg_14_4] ~= arg_14_3[arg_14_4] then
			if arg_14_2[arg_14_4] ~= nil and arg_14_3[arg_14_4] == nil then
				arg_14_1.__deleteFields = arg_14_1.__deleteFields or {}
				arg_14_1.__deleteFields[arg_14_4] = true
			else
				arg_14_1[arg_14_4] = arg_14_3[arg_14_4]
			end
		end
	else
		arg_14_0:compareValueOverride(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	end
end

function var_0_0.compareValueOverride(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if arg_15_2 and arg_15_2[arg_15_4] ~= nil and (arg_15_3 == null or arg_15_3[arg_15_4] == nil) then
		arg_15_1.__deleteFields = arg_15_1.__deleteFields or {}
		arg_15_1.__deleteFields[arg_15_4] = true
	elseif arg_15_3 then
		arg_15_1[arg_15_4] = arg_15_3[arg_15_4]
	end
end

function var_0_0.getObjectDataById(arg_16_0, arg_16_1)
	return arg_16_0._mapInteractObjDict[arg_16_1]
end

function var_0_0.appendOpt(arg_17_0, arg_17_1)
	table.insert(arg_17_0._optList, arg_17_1)
end

function var_0_0.getOptList(arg_18_0)
	return arg_18_0._optList
end

function var_0_0.cleanOptList(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._optList) do
		arg_19_0._optList[iter_19_0] = nil
	end
end

function var_0_0.updateFinishInteracts(arg_20_0, arg_20_1)
	arg_20_0._finishInteract = {}

	if arg_20_1 then
		for iter_20_0 = 1, #arg_20_1 do
			arg_20_0._finishInteract[arg_20_1[iter_20_0]] = true
		end
	end
end

function var_0_0.updateBrokenTilebases(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_2 then
		return
	end

	if Activity142Model.instance:getActivityId() == arg_21_1 then
		for iter_21_0, iter_21_1 in ipairs(arg_21_2) do
			local var_21_0 = Va3ChessEnum.TileTrigger.Broken
			local var_21_1 = Va3ChessEnum.TriggerStatus[var_21_0].Broken

			arg_21_0:updateTileTriggerStatus(iter_21_1.x, iter_21_1.y, var_21_0, var_21_1)
			arg_21_0:addTileFinishTrigger(iter_21_1.x, iter_21_1.y, var_21_0)
		end
	else
		for iter_21_2, iter_21_3 in ipairs(arg_21_2) do
			arg_21_0:addTileFinishTrigger(iter_21_3.x, iter_21_3.y, Va3ChessEnum.TileTrigger.PoSui)
		end
	end
end

function var_0_0.updateLightUpBrazier(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_2 then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_2) do
		local var_22_0 = arg_22_0:getObjectDataById(iter_22_1)

		if var_22_0 then
			var_22_0:setBrazierIsLight(true)
		end
	end
end

function var_0_0.updateFragileTilebases(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_2 then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_2) do
		local var_23_0 = Va3ChessEnum.TileTrigger.Broken
		local var_23_1 = Va3ChessEnum.TriggerStatus[var_23_0].Fragile

		arg_23_0:updateTileTriggerStatus(iter_23_1.x, iter_23_1.y, var_23_0, var_23_1)
	end
end

function var_0_0.updateTileTriggerStatus(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = arg_24_0:getTileMO(arg_24_1, arg_24_2)

	if var_24_0 then
		var_24_0:updateTrigger(arg_24_3, arg_24_4)
	end
end

function var_0_0.addTileFinishTrigger(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_0:getTileMO(arg_25_1, arg_25_2)

	if var_25_0 then
		var_25_0:addFinishTrigger(arg_25_3)
	end
end

function var_0_0.addFinishInteract(arg_26_0, arg_26_1)
	arg_26_0._finishInteract[arg_26_1] = true
end

function var_0_0.isInteractFinish(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_2 and arg_27_0._allFinishInteract then
		return arg_27_0._allFinishInteract[arg_27_1]
	end

	if arg_27_0._finishInteract then
		return arg_27_0._finishInteract[arg_27_1]
	end
end

function var_0_0.findInteractFinishIds(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._finishInteract

	if arg_28_1 then
		var_28_0 = arg_28_0._allFinishInteract
	end

	if not var_28_0 then
		return nil
	end

	local var_28_1 = {}

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		if iter_28_1 == true then
			table.insert(var_28_1, iter_28_0)
		end
	end

	return var_28_1
end

function var_0_0.addAllMapFinishInteract(arg_29_0, arg_29_1)
	arg_29_0._allFinishInteract[arg_29_1] = true
end

function var_0_0.updateAllFinishInteracts(arg_30_0, arg_30_1)
	arg_30_0._allFinishInteract = {}

	if arg_30_1 then
		for iter_30_0 = 1, #arg_30_1 do
			arg_30_0._allFinishInteract[arg_30_1[iter_30_0]] = true
		end
	end
end

function var_0_0.getTileMO(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:getIndex(arg_31_1, arg_31_2)

	return arg_31_0._mapTileMOList[var_31_0]
end

function var_0_0.getBaseTile(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:getTileMO(arg_32_1, arg_32_2)

	return var_32_0 and var_32_0.tileType
end

function var_0_0.setBaseTile(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_0:getTileMO(arg_33_1, arg_33_2)

	if var_33_0 then
		var_33_0.tileType = arg_33_3
	end
end

function var_0_0.setResult(arg_34_0, arg_34_1)
	arg_34_0._isWin = arg_34_1
end

function var_0_0.getResult(arg_35_0)
	return arg_35_0._isWin
end

function var_0_0.setFailReason(arg_36_0, arg_36_1)
	arg_36_0.failReason = arg_36_1
end

function var_0_0.getFailReason(arg_37_0)
	return arg_37_0.failReason
end

function var_0_0.getInteractDatas(arg_38_0)
	return arg_38_0._mapInteractObjs
end

function var_0_0.getIndex(arg_39_0, arg_39_1, arg_39_2)
	return arg_39_2 * arg_39_0.width + arg_39_1 + 1
end

function var_0_0.getGameSize(arg_40_0)
	return arg_40_0.width, arg_40_0.height
end

function var_0_0.getMapId(arg_41_0)
	return arg_41_0._mapId
end

function var_0_0.getActId(arg_42_0)
	return arg_42_0._actId
end

function var_0_0.getRound(arg_43_0)
	return math.max(arg_43_0._round or 1, 1)
end

function var_0_0.setRound(arg_44_0, arg_44_1)
	if arg_44_0.lastMapRound then
		arg_44_0._round = arg_44_1 + arg_44_0.lastMapRound

		return
	end

	arg_44_0._round = arg_44_1
end

function var_0_0.recordLastMapRound(arg_45_0)
	arg_45_0.lastMapRound = arg_45_0._round
end

function var_0_0.clearLastMapRound(arg_46_0)
	arg_46_0.lastMapRound = nil
end

function var_0_0.getHp(arg_47_0)
	return math.max(arg_47_0._hp or 1, 1)
end

function var_0_0.setHp(arg_48_0, arg_48_1)
	arg_48_0._hp = arg_48_1
end

function var_0_0.setPlayingStory(arg_49_0, arg_49_1)
	arg_49_0._playingStory = arg_49_1
end

function var_0_0.isPlayingStory(arg_50_0)
	return arg_50_0._playingStory
end

function var_0_0.isPosInChessBoard(arg_51_0, arg_51_1, arg_51_2)
	return arg_51_1 >= 0 and arg_51_1 < arg_51_0.width and arg_51_2 >= 0 and arg_51_2 < arg_51_0.height
end

function var_0_0.isPosValid(arg_52_0, arg_52_1, arg_52_2)
	return
end

function var_0_0.setFinishedTargetNum(arg_53_0, arg_53_1)
	arg_53_0._finishedTargetNum = arg_53_1
end

function var_0_0.getFinishedTargetNum(arg_54_0)
	return arg_54_0._finishedTargetNum
end

function var_0_0.getFinishGoalNum(arg_55_0)
	if not arg_55_0._actId then
		return 0
	end

	local var_55_0 = Va3ChessModel.instance:getEpisodeId()

	if not var_55_0 then
		return 0
	end

	local var_55_1 = Va3ChessConfig.instance:getEpisodeCo(arg_55_0._actId, var_55_0)
	local var_55_2
	local var_55_3

	if arg_55_0._actId == VersionActivity1_3Enum.ActivityId.Act304 then
		var_55_2 = var_55_1.starCondition
		var_55_3 = var_55_1.extStarCondition
	elseif arg_55_0._actId == VersionActivity1_3Enum.ActivityId.Act306 then
		var_55_2 = var_55_1.mainConfition
		var_55_3 = var_55_1.extStarCondition
	end

	local var_55_4 = {}

	if not string.nilorempty(var_55_2) then
		for iter_55_0, iter_55_1 in ipairs(GameUtil.splitString2(var_55_2, true)) do
			table.insert(var_55_4, iter_55_1)
		end
	end

	if not string.nilorempty(var_55_3) then
		for iter_55_2, iter_55_3 in ipairs(GameUtil.splitString2(var_55_3, true)) do
			table.insert(var_55_4, iter_55_3)
		end
	end

	local var_55_5 = 0

	if arg_55_0:getResult() then
		var_55_5 = var_55_5 + 1
	end

	for iter_55_4, iter_55_5 in ipairs(var_55_4) do
		if Va3ChessMapUtils.isClearConditionFinish(iter_55_5, arg_55_0._actId) then
			var_55_5 = var_55_5 + 1
		end
	end

	return var_55_5
end

function var_0_0.isGoalFinished(arg_56_0, arg_56_1)
	if not arg_56_0._actId then
		return false
	end

	if not string.nilorempty(arg_56_1) then
		local var_56_0 = string.splitToNumber(arg_56_1, "#")

		return Va3ChessMapUtils.isClearConditionFinish(var_56_0, arg_56_0._actId)
	else
		return arg_56_0:getResult() == true
	end
end

function var_0_0.getFireBallCount(arg_57_0)
	return arg_57_0._fireBallCount or 0
end

function var_0_0.setFireBallCount(arg_58_0, arg_58_1, arg_58_2)
	if not arg_58_1 or arg_58_1 < 0 then
		arg_58_1 = 0
	end

	arg_58_0._fireBallCount = arg_58_1

	if not arg_58_2 then
		return
	end

	local var_58_0
	local var_58_1 = Va3ChessGameController.instance.interacts

	if var_58_1 then
		local var_58_2 = var_58_1:getMainPlayer(true)

		var_58_0 = var_58_2 and var_58_2:getHandler() or nil
	end

	if var_58_0 and var_58_0.updateFireBallCount then
		var_58_0:updateFireBallCount()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
