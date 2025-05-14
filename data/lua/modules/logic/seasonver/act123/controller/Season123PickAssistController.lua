module("modules.logic.seasonver.act123.controller.Season123PickAssistController", package.seeall)

local var_0_0 = class("Season123PickAssistController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	Season123PickAssistListModel.instance:init(arg_1_1, arg_1_4)

	arg_1_0._finishCall = arg_1_2
	arg_1_0._finishCallObj = arg_1_3
end

function var_0_0.manualRefreshList(arg_2_0)
	if arg_2_0:checkCanRefresh() then
		arg_2_0:sendRefreshList()
	else
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)
	end
end

function var_0_0.sendRefreshList(arg_3_0)
	arg_3_0:setHeroSelect()
	arg_3_0:pickOver()
	DungeonRpc.instance:sendRefreshAssistRequest(DungeonEnum.AssistType.Season123, arg_3_0.onRefreshAssist, arg_3_0)
end

function var_0_0.onRefreshAssist(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	Season123Controller.instance:dispatchEvent(Season123Event.BeforeRefreshAssistList)
	arg_4_0:recordAssistRefreshTime()
	Season123PickAssistListModel.instance:updateDatas()
end

function var_0_0.recordAssistRefreshTime(arg_5_0)
	arg_5_0._refreshUnityTime = Time.realtimeSinceStartup
end

function var_0_0.getRefreshCDRate(arg_6_0)
	if arg_6_0._refreshUnityTime then
		local var_6_0 = CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval)
		local var_6_1 = (Time.realtimeSinceStartup - arg_6_0._refreshUnityTime) / var_6_0

		return 1 - math.max(0, math.min(1, var_6_1))
	else
		return 0
	end
end

function var_0_0.checkCanRefresh(arg_7_0)
	local var_7_0 = CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval)

	return not arg_7_0._refreshUnityTime or var_7_0 <= Time.realtimeSinceStartup - arg_7_0._refreshUnityTime
end

function var_0_0.setCareer(arg_8_0, arg_8_1)
	local var_8_0 = false

	if arg_8_1 ~= Season123PickAssistListModel.instance:getCareer() then
		Season123PickAssistListModel.instance:setCareer(arg_8_1)

		var_8_0 = true
	end

	return var_8_0
end

function var_0_0.setHeroSelect(arg_9_0, arg_9_1, arg_9_2)
	Season123PickAssistListModel.instance:setHeroSelect(arg_9_1, arg_9_2)
	arg_9_0:notifyView()
end

function var_0_0.pickOver(arg_10_0)
	local var_10_0 = Season123PickAssistListModel.instance:getSelectedMO()

	if arg_10_0._finishCall then
		arg_10_0._finishCall(arg_10_0._finishCallObj, var_10_0)
	end
end

function var_0_0.notifyView(arg_11_0)
	Season123PickAssistListModel.instance:onModelUpdate()
end

function var_0_0.onCloseView(arg_12_0)
	Season123PickAssistListModel.instance:release()
end

var_0_0.instance = var_0_0.New()

return var_0_0
