module("modules.logic.versionactivity2_0.dungeon.controller.Activity161Controller", package.seeall)

local var_0_0 = class("Activity161Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.actId = Activity161Model.instance:getActId()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.refreshGraffitiCdInfo, arg_4_0)

	arg_4_0.isRunCdTask = false
end

function var_0_0.initAct161Info(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity161Model.instance:getActId()

	if ActivityModel.instance:isActOnLine(var_5_0) then
		Activity161Rpc.instance:sendAct161RefreshElementsRequest(arg_5_0.actId)
		Activity161Rpc.instance:sendAct161GetInfoRequest(var_5_0, arg_5_3, arg_5_4)
	else
		if arg_5_1 then
			GameFacade.showToast(ToastEnum.ActivityNotOpen)
		end

		if arg_5_2 and arg_5_3 then
			arg_5_3(arg_5_4)
		end
	end
end

function var_0_0.openGraffitiEnterView(arg_6_0)
	Activity161Config.instance:initGraffitiPicMap(arg_6_0.actId)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
end

function var_0_0.openGraffitiView(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 or {
		actId = Activity161Model.instance:getActId()
	}

	Activity161Config.instance:initGraffitiPicMap(arg_7_0.actId)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonGraffitiView, var_7_0)
end

function var_0_0.openGraffitiDrawView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonGraffitiDrawView, arg_8_1)
end

function var_0_0.checkGraffitiCdInfo(arg_9_0)
	arg_9_0.inCdMoList = Activity161Model.instance:getInCdGraffiti()
	arg_9_0.isRunCdTask = arg_9_0.isRunCdTask or false

	if #arg_9_0.inCdMoList > 0 and not arg_9_0.isRunCdTask then
		TaskDispatcher.cancelTask(arg_9_0.refreshGraffitiCdInfo, arg_9_0)
		TaskDispatcher.runRepeat(arg_9_0.refreshGraffitiCdInfo, arg_9_0, 1)

		arg_9_0.isRunCdTask = true
	elseif #arg_9_0.inCdMoList == 0 and arg_9_0.isRunCdTask then
		TaskDispatcher.cancelTask(arg_9_0.refreshGraffitiCdInfo, arg_9_0)

		arg_9_0.isRunCdTask = false
	end
end

function var_0_0.refreshGraffitiCdInfo(arg_10_0)
	local var_10_0 = Activity161Model.instance:getInCdGraffiti()
	local var_10_1 = Activity161Model.instance:getArriveCdGraffitiList(arg_10_0.inCdMoList, var_10_0)

	arg_10_0.inCdMoList = var_10_0

	if #var_10_1 > 0 then
		for iter_10_0, iter_10_1 in pairs(var_10_1) do
			Activity161Model.instance:setGraffitiState(iter_10_1.id, Activity161Enum.graffitiState.ToUnlock)
			var_0_0.instance:dispatchEvent(Activity161Event.ToUnlockGraffiti, iter_10_1)
		end

		Activity161Model.instance:setNeedRefreshNewElementsState(true)
		Activity161Rpc.instance:sendAct161RefreshElementsRequest(arg_10_0.actId)
	elseif #var_10_0 == 0 then
		TaskDispatcher.cancelTask(arg_10_0.refreshGraffitiCdInfo, arg_10_0)

		arg_10_0.isRunCdTask = false
		arg_10_0.inCdMoList = {}

		Activity161Model.instance:setNeedRefreshNewElementsState(false)
	elseif #var_10_0 > 0 then
		var_0_0.instance:dispatchEvent(Activity161Event.GraffitiCdRefresh, var_10_0)
	end
end

function var_0_0.jumpToElement(arg_11_0, arg_11_1)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_0DungeonGraffitiView) then
		ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonGraffitiView)
		ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
		arg_11_0:dispatchEvent(Activity161Event.CloseGraffitiEnterView)

		local var_11_0 = arg_11_1.config.mainElementId

		VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, var_11_0)
	end
end

function var_0_0.getRecentFinishGraffiti(arg_12_0)
	local var_12_0 = Activity161Model.instance.graffitiInfoMap
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		if iter_12_1.config.dialogGroupId > 0 and iter_12_1.state == Activity161Enum.graffitiState.IsFinished then
			table.insert(var_12_1, iter_12_1)
		end
	end

	if #var_12_1 > 0 then
		return var_12_1[#var_12_1]
	end
end

function var_0_0.getLocalKey(arg_13_0)
	return "GraffitiFinishDialog" .. "#" .. tostring(arg_13_0.actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function var_0_0.checkRencentGraffitiHasDialog(arg_14_0)
	local var_14_0 = PlayerPrefsHelper.getNumber(arg_14_0:getLocalKey(), 0)
	local var_14_1 = arg_14_0:getRecentFinishGraffiti()

	if var_14_1 and var_14_0 ~= 0 and var_14_0 == var_14_1.config.id then
		return true
	end

	return false, var_14_1
end

function var_0_0.saveRecentGraffitiDialog(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0:checkRencentGraffitiHasDialog()

	if not var_15_0 and var_15_1 then
		PlayerPrefsHelper.setNumber(arg_15_0:getLocalKey(), var_15_1.config.id)
	end
end

function var_0_0.checkHasUnDoElement(arg_16_0)
	local var_16_0 = VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement()
	local var_16_1 = var_16_0 and var_16_0 > 0 and 1 or 0
	local var_16_2 = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.V2a0DungeonHasUnDoElement,
			value = var_16_1
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_16_2, true)
end

var_0_0.instance = var_0_0.New()

return var_0_0
