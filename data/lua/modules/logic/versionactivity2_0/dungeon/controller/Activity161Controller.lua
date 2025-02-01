module("modules.logic.versionactivity2_0.dungeon.controller.Activity161Controller", package.seeall)

slot0 = class("Activity161Controller", BaseController)

function slot0.onInit(slot0)
	slot0.actId = Activity161Model.instance:getActId()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	TaskDispatcher.cancelTask(slot0.refreshGraffitiCdInfo, slot0)

	slot0.isRunCdTask = false
end

function slot0.initAct161Info(slot0, slot1, slot2, slot3, slot4)
	if ActivityModel.instance:isActOnLine(Activity161Model.instance:getActId()) then
		Activity161Rpc.instance:sendAct161RefreshElementsRequest(slot0.actId)
		Activity161Rpc.instance:sendAct161GetInfoRequest(slot5, slot3, slot4)
	else
		if slot1 then
			GameFacade.showToast(ToastEnum.ActivityNotOpen)
		end

		if slot2 and slot3 then
			slot3(slot4)
		end
	end
end

function slot0.openGraffitiEnterView(slot0)
	Activity161Config.instance:initGraffitiPicMap(slot0.actId)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
end

function slot0.openGraffitiView(slot0, slot1)
	Activity161Config.instance:initGraffitiPicMap(slot0.actId)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonGraffitiView, slot1 or {
		actId = Activity161Model.instance:getActId()
	})
end

function slot0.openGraffitiDrawView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonGraffitiDrawView, slot1)
end

function slot0.checkGraffitiCdInfo(slot0)
	slot0.inCdMoList = Activity161Model.instance:getInCdGraffiti()
	slot0.isRunCdTask = slot0.isRunCdTask or false

	if #slot0.inCdMoList > 0 and not slot0.isRunCdTask then
		TaskDispatcher.cancelTask(slot0.refreshGraffitiCdInfo, slot0)
		TaskDispatcher.runRepeat(slot0.refreshGraffitiCdInfo, slot0, 1)

		slot0.isRunCdTask = true
	elseif #slot0.inCdMoList == 0 and slot0.isRunCdTask then
		TaskDispatcher.cancelTask(slot0.refreshGraffitiCdInfo, slot0)

		slot0.isRunCdTask = false
	end
end

function slot0.refreshGraffitiCdInfo(slot0)
	slot1 = Activity161Model.instance:getInCdGraffiti()
	slot0.inCdMoList = slot1

	if #Activity161Model.instance:getArriveCdGraffitiList(slot0.inCdMoList, slot1) > 0 then
		for slot6, slot7 in pairs(slot2) do
			Activity161Model.instance:setGraffitiState(slot7.id, Activity161Enum.graffitiState.ToUnlock)
			uv0.instance:dispatchEvent(Activity161Event.ToUnlockGraffiti, slot7)
		end

		Activity161Model.instance:setNeedRefreshNewElementsState(true)
		Activity161Rpc.instance:sendAct161RefreshElementsRequest(slot0.actId)
	elseif #slot1 == 0 then
		TaskDispatcher.cancelTask(slot0.refreshGraffitiCdInfo, slot0)

		slot0.isRunCdTask = false
		slot0.inCdMoList = {}

		Activity161Model.instance:setNeedRefreshNewElementsState(false)
	elseif #slot1 > 0 then
		uv0.instance:dispatchEvent(Activity161Event.GraffitiCdRefresh, slot1)
	end
end

function slot0.jumpToElement(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_0DungeonGraffitiView) then
		ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonGraffitiView)
		ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
		slot0:dispatchEvent(Activity161Event.CloseGraffitiEnterView)
		VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, slot1.config.mainElementId)
	end
end

function slot0.getRecentFinishGraffiti(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(Activity161Model.instance.graffitiInfoMap) do
		if slot7.config.dialogGroupId > 0 and slot7.state == Activity161Enum.graffitiState.IsFinished then
			table.insert(slot2, slot7)
		end
	end

	if #slot2 > 0 then
		return slot2[#slot2]
	end
end

function slot0.getLocalKey(slot0)
	return "GraffitiFinishDialog" .. "#" .. tostring(slot0.actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function slot0.checkRencentGraffitiHasDialog(slot0)
	slot1 = PlayerPrefsHelper.getNumber(slot0:getLocalKey(), 0)

	if slot0:getRecentFinishGraffiti() and slot1 ~= 0 and slot1 == slot2.config.id then
		return true
	end

	return false, slot2
end

function slot0.saveRecentGraffitiDialog(slot0)
	slot1, slot2 = slot0:checkRencentGraffitiHasDialog()

	if not slot1 and slot2 then
		PlayerPrefsHelper.setNumber(slot0:getLocalKey(), slot2.config.id)
	end
end

function slot0.checkHasUnDoElement(slot0)
	RedDotRpc.instance:clientAddRedDotGroupList({
		{
			uid = 0,
			id = RedDotEnum.DotNode.V2a0DungeonHasUnDoElement,
			value = VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement() and slot1 > 0 and 1 or 0
		}
	}, true)
end

slot0.instance = slot0.New()

return slot0
