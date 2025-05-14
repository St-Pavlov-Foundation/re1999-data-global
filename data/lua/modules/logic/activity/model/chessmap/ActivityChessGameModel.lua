module("modules.logic.activity.model.chessmap.ActivityChessGameModel", package.seeall)

local var_0_0 = class("ActivityChessGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
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
end

function var_0_0.initData(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Activity109Config.instance:getMapCo(arg_4_1, arg_4_2)

	arg_4_0._actId = arg_4_1
	arg_4_0._mapId = arg_4_2
	arg_4_0.width = var_4_0.width
	arg_4_0.height = var_4_0.height
	arg_4_0._mapTileBaseList = string.splitToNumber(var_4_0.tilebase, ",")
	arg_4_0._optList = {}
end

function var_0_0.addInteractData(arg_5_0, arg_5_1)
	table.insert(arg_5_0._mapInteractObjs, arg_5_1)

	arg_5_0._mapInteractObjDict[arg_5_1.id] = arg_5_1
end

function var_0_0.removeInteractData(arg_6_0, arg_6_1)
	tabletool.removeValue(arg_6_0._mapInteractObjs, arg_6_1)

	arg_6_0._mapInteractObjDict[arg_6_1.id] = nil
end

function var_0_0.initObjects(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._mapInteractObjs = {}
	arg_7_0._mapInteractObjDict = {}

	local var_7_0 = #arg_7_2

	for iter_7_0 = 1, var_7_0 do
		local var_7_1 = arg_7_2[iter_7_0]

		if Activity109Config.instance:getInteractObjectCo(arg_7_1, var_7_1.id) then
			local var_7_2 = ActivityChessGameInteractMO.New()

			var_7_2:init(arg_7_1, var_7_1)
			table.insert(arg_7_0._mapInteractObjs, var_7_2)

			arg_7_0._mapInteractObjDict[var_7_2.id] = var_7_2
		end
	end
end

function var_0_0.addObject(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = ActivityChessGameInteractMO.New()

	var_8_0:init(arg_8_1, arg_8_2)
	table.insert(arg_8_0._mapInteractObjs, var_8_0)

	arg_8_0._mapInteractObjDict[var_8_0.id] = var_8_0

	return var_8_0
end

function var_0_0.removeObjectById(arg_9_0, arg_9_1)
	for iter_9_0 = #arg_9_0._mapInteractObjs, 1, -1 do
		if arg_9_0._mapInteractObjs[iter_9_0].id == arg_9_1 then
			local var_9_0 = arg_9_0._mapInteractObjs[iter_9_0]

			table.remove(arg_9_0._mapInteractObjs, iter_9_0)

			arg_9_0._mapInteractObjDict[arg_9_1] = nil

			return var_9_0
		end
	end
end

function var_0_0.syncObjectData(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0
	local var_10_1 = arg_10_0._mapInteractObjDict[arg_10_1]

	if var_10_1 then
		local var_10_2 = var_10_1.data

		var_10_0 = arg_10_0:compareObjectData(var_10_2, arg_10_2)
		var_10_1.data = arg_10_2
	end

	return var_10_0
end

function var_0_0.compareObjectData(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	arg_11_0:compareAlertArea(var_11_0, arg_11_1, arg_11_2)
	arg_11_0:compareValueTypeField(var_11_0, arg_11_1, arg_11_2, "goToObject")
	arg_11_0:compareValueTypeField(var_11_0, arg_11_1, arg_11_2, "lostTarget")

	return var_11_0
end

function var_0_0.compareAlertArea(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 and arg_12_3 and arg_12_2.alertArea and arg_12_3.alertArea and #arg_12_2.alertArea == #arg_12_3.alertArea then
		for iter_12_0 = 1, #arg_12_2.alertArea do
			if arg_12_2.alertArea[iter_12_0].x ~= arg_12_3.alertArea[iter_12_0].x or arg_12_2.alertArea[iter_12_0].y ~= arg_12_3.alertArea[iter_12_0].y then
				arg_12_1.alertArea = arg_12_3.alertArea

				break
			end
		end
	else
		arg_12_0:compareValueOverride(arg_12_1, arg_12_2, arg_12_3, "alertArea")
	end
end

function var_0_0.compareValueTypeField(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_2 and arg_13_3 then
		if arg_13_2[arg_13_4] ~= arg_13_3[arg_13_4] then
			if arg_13_2[arg_13_4] ~= nil and arg_13_3[arg_13_4] == nil then
				arg_13_1.__deleteFields = arg_13_1.__deleteFields or {}
				arg_13_1.__deleteFields[arg_13_4] = true
			else
				arg_13_1[arg_13_4] = arg_13_3[arg_13_4]
			end
		end
	else
		arg_13_0:compareValueOverride(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	end
end

function var_0_0.compareValueOverride(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_2 and arg_14_2[arg_14_4] ~= nil and (arg_14_3 == null or arg_14_3[arg_14_4] == nil) then
		arg_14_1.__deleteFields = arg_14_1.__deleteFields or {}
		arg_14_1.__deleteFields[arg_14_4] = true
	elseif arg_14_3 then
		arg_14_1[arg_14_4] = arg_14_3[arg_14_4]
	end
end

function var_0_0.getObjectDataById(arg_15_0, arg_15_1)
	return arg_15_0._mapInteractObjDict[arg_15_1]
end

function var_0_0.appendOpt(arg_16_0, arg_16_1)
	table.insert(arg_16_0._optList, arg_16_1)
end

function var_0_0.getOptList(arg_17_0)
	return arg_17_0._optList
end

function var_0_0.cleanOptList(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0._optList) do
		arg_18_0._optList[iter_18_0] = nil
	end
end

function var_0_0.updateFinishInteracts(arg_19_0, arg_19_1)
	arg_19_0._finishInteract = {}

	if arg_19_1 then
		for iter_19_0 = 1, #arg_19_1 do
			arg_19_0._finishInteract[arg_19_1[iter_19_0]] = true
		end
	end
end

function var_0_0.addFinishInteract(arg_20_0, arg_20_1)
	arg_20_0._finishInteract[arg_20_1] = true
end

function var_0_0.isInteractFinish(arg_21_0, arg_21_1)
	if arg_21_0._finishInteract then
		return arg_21_0._finishInteract[arg_21_1]
	end
end

function var_0_0.getBaseTile(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getIndex(arg_22_1, arg_22_2)

	return arg_22_0._mapTileBaseList[var_22_0]
end

function var_0_0.setBaseTile(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0:getIndex(arg_23_1, arg_23_2)

	arg_23_0._mapTileBaseList[var_23_0] = arg_23_3
end

function var_0_0.setRound(arg_24_0, arg_24_1)
	arg_24_0._round = arg_24_1
end

function var_0_0.setResult(arg_25_0, arg_25_1)
	arg_25_0._isWin = arg_25_1
end

function var_0_0.getResult(arg_26_0)
	return arg_26_0._isWin
end

function var_0_0.getInteractDatas(arg_27_0)
	return arg_27_0._mapInteractObjs
end

function var_0_0.getIndex(arg_28_0, arg_28_1, arg_28_2)
	return arg_28_2 * arg_28_0.width + arg_28_1 + 1
end

function var_0_0.getGameSize(arg_29_0)
	return arg_29_0.width, arg_29_0.height
end

function var_0_0.getMapId(arg_30_0)
	return arg_30_0._mapId
end

function var_0_0.getActId(arg_31_0)
	return arg_31_0._actId
end

function var_0_0.getRound(arg_32_0)
	return math.max(arg_32_0._round or 1, 1)
end

function var_0_0.isPosInChessBoard(arg_33_0, arg_33_1, arg_33_2)
	return arg_33_1 >= 0 and arg_33_1 < arg_33_0.width and arg_33_2 >= 0 and arg_33_2 < arg_33_0.height
end

function var_0_0.getFinishGoalNum(arg_34_0)
	if not arg_34_0._actId then
		return 0
	end

	local var_34_0 = Activity109ChessModel.instance:getEpisodeId()

	if not var_34_0 then
		return 0
	end

	local var_34_1 = Activity109Config.instance:getEpisodeCo(arg_34_0._actId, var_34_0)
	local var_34_2 = var_34_1.extStarCondition
	local var_34_3 = string.split(var_34_2, "|")
	local var_34_4 = string.split(var_34_1.conditionStr, "|")
	local var_34_5 = 0

	if arg_34_0:isGoalFinished() then
		var_34_5 = var_34_5 + 1
	end

	for iter_34_0, iter_34_1 in ipairs(var_34_3) do
		if arg_34_0:isGoalFinished(iter_34_1) then
			var_34_5 = var_34_5 + 1
		end
	end

	return var_34_5
end

function var_0_0.isGoalFinished(arg_35_0, arg_35_1)
	if not arg_35_0._actId then
		return false
	end

	if not string.nilorempty(arg_35_1) then
		local var_35_0 = string.splitToNumber(arg_35_1, "#")

		return ActivityChessMapUtils.isClearConditionFinish(var_35_0, arg_35_0._actId)
	else
		return arg_35_0:getResult() == true
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
