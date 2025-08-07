module("modules.logic.sp01.act205.model.Act205Model", package.seeall)

local var_0_0 = class("Act205Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.gameInfoMap = {}
end

function var_0_0.getAct205Id(arg_3_0)
	return Act205Enum.ActId
end

function var_0_0.setGameStageId(arg_4_0, arg_4_1)
	arg_4_0.curStageId = arg_4_1
end

function var_0_0.getGameStageId(arg_5_0)
	return arg_5_0.curStageId
end

function var_0_0.isAct205Open(arg_6_0, arg_6_1)
	local var_6_0 = false
	local var_6_1 = arg_6_0:getAct205Id()
	local var_6_2, var_6_3, var_6_4 = ActivityHelper.getActivityStatusAndToast(var_6_1)

	if var_6_2 == ActivityEnum.ActivityStatus.Normal then
		var_6_0 = true
	elseif var_6_3 and arg_6_1 then
		GameFacade.showToastWithTableParam(var_6_3, var_6_4)
	end

	return var_6_0
end

function var_0_0.isGameStageOpen(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getAct205Id()
	local var_7_1 = arg_7_0:getGameInfoMo(var_7_0, arg_7_1)
	local var_7_2 = arg_7_0:isGameTimeOpen(arg_7_1) and var_7_1

	if not var_7_2 and arg_7_2 then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)
	end

	return var_7_2
end

function var_0_0.isGameTimeOpen(arg_8_0, arg_8_1)
	if not arg_8_0:isAct205Open(true) then
		return false
	end

	local var_8_0 = arg_8_0:getAct205Id()
	local var_8_1 = ServerTime.now()
	local var_8_2 = Act205Config.instance:getGameStageOpenTimeStamp(var_8_0, arg_8_1)
	local var_8_3 = Act205Config.instance:getGameStageEndTimeStamp(var_8_0, arg_8_1)

	return var_8_2 <= var_8_1 and var_8_1 < var_8_3
end

function var_0_0.getCurOpenGameStageId(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(Act205Enum.GameStageId) do
		if arg_9_0:isGameStageOpen(iter_9_1) then
			return iter_9_1
		end
	end
end

function var_0_0.setAct205Info(arg_10_0, arg_10_1)
	arg_10_0.gameInfoMap = {}

	local var_10_0 = arg_10_0.gameInfoMap[arg_10_1.activityId]

	if not var_10_0 then
		var_10_0 = {}
		arg_10_0.gameInfoMap[arg_10_1.activityId] = var_10_0
	end

	local var_10_1 = var_10_0[arg_10_1.gameType]

	if not var_10_1 then
		var_10_1 = Act205GameInfoMo.New()

		var_10_1:init(arg_10_1.activityId, arg_10_1.gameType)

		var_10_0[arg_10_1.gameType] = var_10_1
	end

	var_10_1:updateInfo(arg_10_1)
end

function var_0_0.setAct205GameInfo(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.gameInfoMap[arg_11_1.activityId] and arg_11_0.gameInfoMap[arg_11_1.activityId][arg_11_1.gameType]

	if not var_11_0 then
		return
	end

	var_11_0:setGameInfo(arg_11_1.gameInfo)
end

function var_0_0.updateGameInfo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.gameInfoMap[arg_12_1.activityId] and arg_12_0.gameInfoMap[arg_12_1.activityId][arg_12_1.gameType]

	if not var_12_0 then
		return
	end

	var_12_0:updateInfo(arg_12_1)
end

function var_0_0.getGameInfoMo(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0.gameInfoMap[arg_13_1] and arg_13_0.gameInfoMap[arg_13_1][arg_13_2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
