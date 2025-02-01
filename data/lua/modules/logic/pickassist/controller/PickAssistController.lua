module("modules.logic.pickassist.controller.PickAssistController", package.seeall)

slot0 = class("PickAssistController", BaseController)

function slot0.openPickAssistView(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot1 or not slot2 then
		return
	end

	slot0._actId = slot2
	slot0._assistType = slot1
	slot0._selectedHeroUid = slot3
	slot0._finishCall = slot4
	slot0._finishCallObj = slot5

	if slot6 and slot0:checkCanRefresh() then
		slot0.tmpIsRecordRefreshTime = true

		DungeonRpc.instance:sendRefreshAssistRequest(slot1, slot0._openPickAssistViewAfterRpc, slot0)
	else
		slot0:_openPickAssistViewAfterRpc()
	end
end

function slot0._openPickAssistViewAfterRpc(slot0, slot1, slot2, slot3)
	PickAssistListModel.instance:init(slot0._actId, slot0._assistType, slot0._selectedHeroUid)

	if slot0.tmpIsRecordRefreshTime then
		slot0:recordAssistRefreshTime()
	end

	slot0.tmpIsRecordRefreshTime = nil

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 1)

	if PickAssistListModel.instance:getPickAssistViewName() then
		ViewMgr.instance:openView(slot4)
	end
end

function slot0.manualRefreshList(slot0)
	if slot0:checkCanRefresh() then
		slot0:sendRefreshList()
	else
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)
	end
end

function slot0.sendRefreshList(slot0)
	slot0:setHeroSelect()
	slot0:pickOver()

	if PickAssistListModel.instance:getAssistType() then
		DungeonRpc.instance:sendRefreshAssistRequest(slot1, slot0.onRefreshAssist, slot0)
	end
end

function slot0.onRefreshAssist(slot0, slot1, slot2, slot3)
	slot0:dispatchEvent(PickAssistEvent.BeforeRefreshAssistList)
	slot0:recordAssistRefreshTime()
	PickAssistListModel.instance:updateDatas()
end

function slot0.recordAssistRefreshTime(slot0)
	slot0._refreshUnityTime = Time.realtimeSinceStartup
end

function slot0.getRefreshCDRate(slot0)
	if slot0._refreshUnityTime then
		return 1 - math.max(0, math.min(1, (Time.realtimeSinceStartup - slot0._refreshUnityTime) / CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval)))
	else
		return 0
	end
end

function slot0.checkCanRefresh(slot0)
	return not slot0._refreshUnityTime or CommonConfig.instance:getConstNum(ConstEnum.AssistCharacterUpdateInterval) <= Time.realtimeSinceStartup - slot0._refreshUnityTime
end

function slot0.setCareer(slot0, slot1)
	slot2 = false

	if slot1 ~= PickAssistListModel.instance:getCareer() then
		PickAssistListModel.instance:setCareer(slot1)

		slot2 = true
	end

	return slot2
end

function slot0.setHeroSelect(slot0, slot1, slot2)
	PickAssistListModel.instance:setHeroSelect(slot1, slot2)
	slot0:notifyView()
end

function slot0.pickOver(slot0)
	if slot0._finishCall then
		slot0._finishCall(slot0._finishCallObj, PickAssistListModel.instance:getSelectedMO())
	end
end

function slot0.notifyView(slot0)
	PickAssistListModel.instance:onModelUpdate()
end

function slot0.onCloseView(slot0)
	PickAssistListModel.instance:onCloseView()
end

slot0.instance = slot0.New()

return slot0
