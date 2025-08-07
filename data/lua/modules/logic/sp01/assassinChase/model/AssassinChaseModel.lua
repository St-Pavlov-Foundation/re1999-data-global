module("modules.logic.sp01.assassinChase.model.AssassinChaseModel", package.seeall)

local var_0_0 = class("AssassinChaseModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curActivityId = nil
	arg_2_0._curDirectionId = nil
	arg_2_0._chaseInfoDic = {}
end

function var_0_0.setCurActivityId(arg_3_0, arg_3_1)
	arg_3_0._curActivityId = arg_3_1
end

function var_0_0.getCurActivityId(arg_4_0)
	return arg_4_0._curActivityId
end

function var_0_0.setCurDirectionId(arg_5_0, arg_5_1)
	if arg_5_0._curDirectionId ~= arg_5_1 then
		arg_5_0._curDirectionId = arg_5_1
	else
		arg_5_0._curDirectionId = nil
	end

	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnSelectDirection, arg_5_0._curDirectionId)
end

function var_0_0.getCurDirectionId(arg_6_0)
	return arg_6_0._curDirectionId
end

function var_0_0.setActInfo(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.activityId
	local var_7_1

	if not arg_7_0._chaseInfoDic[var_7_0] then
		var_7_1 = AssassinChaseInfoMo.New()
		arg_7_0._chaseInfoDic[var_7_0] = var_7_1
	else
		var_7_1 = arg_7_0._chaseInfoDic[var_7_0]
	end

	var_7_1:init(var_7_0, arg_7_1.hasChosenDirection, arg_7_1.chosenInfo, arg_7_1.optionDirections)
	arg_7_0:setCurDirectionId(nil)
	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnInfoUpdate, var_7_0)
end

function var_0_0.onActInfoPush(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.activityId
	local var_8_1

	if not arg_8_0._chaseInfoDic[var_8_0] then
		var_8_1 = AssassinChaseInfoMo.New()
		arg_8_0._chaseInfoDic[var_8_0] = var_8_1
	else
		var_8_1 = arg_8_0._chaseInfoDic[var_8_0]
	end

	var_8_1:init(var_8_0, arg_8_1.hasChosenDirection, arg_8_1.chosenInfo, arg_8_1.optionDirections)
	arg_8_0:setCurDirectionId(nil)
	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnInfoUpdate, var_8_0)
end

function var_0_0.onSelectDirection(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.currentDirection
	local var_9_1 = arg_9_0:getActInfo(arg_9_1)

	if var_9_1 == nil then
		logError("奥德赛 下半活动 追逐游戏活动 信息不存在")

		return
	end

	var_9_1.hasChosenDirection = true
	var_9_1.chosenInfo = arg_9_2

	var_9_1:refreshTime()
	arg_9_0:setCurDirectionId(nil)
	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnInfoUpdate, arg_9_1)
end

function var_0_0.getActInfo(arg_10_0, arg_10_1)
	return arg_10_0._chaseInfoDic[arg_10_1]
end

function var_0_0.getCurInfoMo(arg_11_0)
	return arg_11_0:getActInfo(arg_11_0._curActivityId)
end

function var_0_0.isCurActOpen(arg_12_0, arg_12_1)
	return arg_12_0:isActOpen(arg_12_0._curActivityId, arg_12_1)
end

function var_0_0.isActOpen(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = ActivityModel.instance:getActMO(arg_13_1)

	if var_13_0 == nil then
		return false
	end

	local var_13_1 = var_13_0:getRealEndTimeStamp()
	local var_13_2 = arg_13_3 and var_13_1 or AssassinChaseHelper.getActivityEndTimeStamp(var_13_1)
	local var_13_3 = ServerTime.now()

	if not var_13_0:isOpen() or var_13_2 <= var_13_3 then
		if arg_13_2 then
			GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)
		end

		return false
	end

	return true
end

function var_0_0.isActHaveReward(arg_14_0, arg_14_1)
	local var_14_0 = ActivityModel.instance:getActMO(arg_14_1)

	if var_14_0 == nil then
		return false
	end

	if not var_14_0:isOpen() or var_14_0:getRealEndTimeStamp() - ServerTime.now() <= 0 then
		return false
	end

	local var_14_1 = arg_14_0:getActInfo(arg_14_1)

	if var_14_1 == nil or var_14_1.hasChosenDirection == false or var_14_1.chosenInfo == nil then
		return false
	end

	return var_14_1.chosenInfo.rewardId ~= nil and var_14_1.chosenInfo.rewardId ~= 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
