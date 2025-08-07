module("modules.logic.sp01.assassinChase.controller.AssassinChaseController", package.seeall)

local var_0_0 = class("AssassinChaseController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openGameStartView(arg_5_0, arg_5_1)
	if not AssassinChaseModel.instance:isActOpen(arg_5_1, true, true) then
		return
	end

	if AssassinChaseModel.instance:isActOpen(arg_5_1, false, false) and AssassinChaseModel.instance:getActInfo(arg_5_1):isSelect() == false then
		local var_5_0 = {
			activityId = arg_5_1,
			gameStageId = Act205Enum.GameStageId.Chase
		}

		ViewMgr.instance:openView(ViewName.Act205GameStartView, var_5_0)

		return
	end

	arg_5_0:openAssassinChaseView(arg_5_1)
end

function var_0_0.openAssassinChaseView(arg_6_0, arg_6_1)
	if not AssassinChaseModel.instance:isActOpen(arg_6_1, true, true) then
		return
	end

	AssassinChaseModel.instance:setCurActivityId(arg_6_1)
	arg_6_0:getAct206GetInfo(arg_6_1, arg_6_0.onGetAssassinChaseInfo, arg_6_0)
end

function var_0_0.getAct206GetInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	AssassinChaseRpc.instance:sendAct206GetInfoRequest(arg_7_1, arg_7_2, arg_7_3)
end

function var_0_0.onGetAssassinChaseInfo(arg_8_0)
	local var_8_0 = AssassinChaseModel.instance:getCurActivityId()

	if var_8_0 == nil then
		logError("奥德赛 下半活动 追逐游戏活动id不存在")
		AssassinChaseModel.instance:setCurActivityId(nil)

		return
	end

	local var_8_1 = AssassinChaseModel.instance:getActInfo(var_8_0)

	if var_8_1 == nil then
		logError("奥德赛 下半活动 追逐游戏活动数据不存在 id:" .. var_8_0)
		AssassinChaseModel.instance:setCurActivityId(nil)

		return
	end

	if (var_8_1.hasChosenDirection == false or var_8_1.chosenInfo == nil or var_8_1.chosenInfo.rewardId == nil or var_8_1.chosenInfo.rewardId == 0) and not AssassinChaseModel.instance:isActOpen(var_8_0, true, false) then
		return
	end

	ViewMgr.instance:openView(ViewName.AssassinChaseGameView)
end

function var_0_0.selectionDirection(arg_9_0, arg_9_1, arg_9_2)
	AssassinChaseRpc.instance:sendAct206ChooseDirectionRequest(arg_9_1, arg_9_2)
end

function var_0_0.getReward(arg_10_0, arg_10_1)
	AssassinChaseRpc.instance:sendAct206GetBonusRequest(arg_10_1)
end

function var_0_0.openDialogueView(arg_11_0, arg_11_1)
	local var_11_0 = {
		actId = arg_11_1
	}

	ViewMgr.instance:openView(ViewName.AssassinChaseChatView, var_11_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
