module("modules.logic.pickassist.controller.PickAssistController", package.seeall)

local var_0_0 = class("PickAssistController", BaseController)

function var_0_0.openPickAssistView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	if not arg_1_1 or not arg_1_2 then
		return
	end

	arg_1_0._actId = arg_1_2
	arg_1_0._assistType = arg_1_1
	arg_1_0._selectedHeroUid = arg_1_3
	arg_1_0._finishCall = arg_1_4
	arg_1_0._finishCallObj = arg_1_5

	local var_1_0 = arg_1_0:checkCanRefresh()

	if arg_1_6 and var_1_0 then
		arg_1_0.tmpIsRecordRefreshTime = true

		DungeonRpc.instance:sendRefreshAssistRequest(arg_1_1, arg_1_0._openPickAssistViewAfterRpc, arg_1_0)
	else
		arg_1_0:_openPickAssistViewAfterRpc()
	end
end

function var_0_0._openPickAssistViewAfterRpc(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	PickAssistListModel.instance:init(arg_2_0._actId, arg_2_0._assistType, arg_2_0._selectedHeroUid)

	if arg_2_0.tmpIsRecordRefreshTime then
		arg_2_0:recordAssistRefreshTime()
	end

	arg_2_0.tmpIsRecordRefreshTime = nil

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 1)

	local var_2_0 = PickAssistListModel.instance:getPickAssistViewName()

	if var_2_0 then
		ViewMgr.instance:openView(var_2_0)
	end
end

function var_0_0.manualRefreshList(arg_3_0)
	if arg_3_0:checkCanRefresh() then
		arg_3_0:sendRefreshList()
	else
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)
	end
end

function var_0_0.sendRefreshList(arg_4_0)
	arg_4_0:setHeroSelect()
	arg_4_0:pickOver()

	local var_4_0 = PickAssistListModel.instance:getAssistType()

	if var_4_0 then
		DungeonRpc.instance:sendRefreshAssistRequest(var_4_0, arg_4_0.onRefreshAssist, arg_4_0)
	end
end

function var_0_0.onRefreshAssist(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:dispatchEvent(PickAssistEvent.BeforeRefreshAssistList)
	arg_5_0:recordAssistRefreshTime()
	PickAssistListModel.instance:updateDatas()
end

function var_0_0.recordAssistRefreshTime(arg_6_0)
	arg_6_0._refreshUnityTime = Time.realtimeSinceStartup
end

function var_0_0.getRefreshCDRate(arg_7_0)
	if arg_7_0._refreshUnityTime then
		local var_7_0 = CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval)
		local var_7_1 = (Time.realtimeSinceStartup - arg_7_0._refreshUnityTime) / var_7_0

		return 1 - math.max(0, math.min(1, var_7_1))
	else
		return 0
	end
end

function var_0_0.checkCanRefresh(arg_8_0)
	local var_8_0 = CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval)

	return not arg_8_0._refreshUnityTime or var_8_0 <= Time.realtimeSinceStartup - arg_8_0._refreshUnityTime
end

function var_0_0.setCareer(arg_9_0, arg_9_1)
	local var_9_0 = false

	if arg_9_1 ~= PickAssistListModel.instance:getCareer() then
		PickAssistListModel.instance:setCareer(arg_9_1)

		var_9_0 = true
	end

	return var_9_0
end

function var_0_0.setHeroSelect(arg_10_0, arg_10_1, arg_10_2)
	PickAssistListModel.instance:setHeroSelect(arg_10_1, arg_10_2)
	arg_10_0:notifyView()
end

function var_0_0.pickOver(arg_11_0)
	local var_11_0 = PickAssistListModel.instance:getSelectedMO()

	if arg_11_0._finishCall then
		arg_11_0._finishCall(arg_11_0._finishCallObj, var_11_0)
	end
end

function var_0_0.notifyView(arg_12_0)
	PickAssistListModel.instance:onModelUpdate()
end

function var_0_0.onCloseView(arg_13_0)
	PickAssistListModel.instance:onCloseView()
end

var_0_0.instance = var_0_0.New()

return var_0_0
