module("modules.logic.main.controller.work.NewCultivationGiftPatFaceWork", package.seeall)

slot0 = class("NewCultivationGiftPatFaceWork", PatFaceWorkBase)

function slot0._viewName(slot0)
	return PatFaceConfig.instance:getPatFaceViewName(slot0._patFaceId)
end

function slot0._actId(slot0)
	return PatFaceConfig.instance:getPatFaceActivityId(slot0._patFaceId)
end

function slot0.checkCanPat(slot0)
	if not ActivityModel.instance:isActOnLine(slot0:_actId()) then
		return false
	end

	if ActivityModel.instance:getActMO(slot1) == nil then
		return false
	end

	return slot2:isOpen() and not slot2:isExpired()
end

function slot0.startPat(slot0)
	slot0:_startBlock()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	Activity125Controller.instance:getAct125InfoFromServer(slot0:_actId())
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, slot0.onReceiveActivityInfo, slot0)
end

function slot0.clearWork(slot0)
	slot0:_endBlock()

	slot0._needRevert = false

	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, slot0.onReceiveActivityInfo, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.OnGetReward, slot0)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 ~= slot0:_viewName() then
		return
	end

	slot0:_endBlock()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 ~= slot0:_viewName() then
		return
	end

	if ViewMgr.instance:isOpen(slot2) then
		return
	end

	slot0:patComplete()
end

function slot0.onReceiveActivityInfo(slot0)
	slot1 = slot0:_actId()
	slot2 = slot0:_viewName()

	if slot0:isActivityRewardGet() then
		if ViewMgr.instance:isOpen(slot2) then
			return
		end

		slot0:patComplete()

		return
	end

	ViewMgr.instance:openView(slot2, {
		actId = slot1
	})
end

function slot0._endBlock(slot0)
	if not slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function slot0._startBlock(slot0)
	if slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function slot0._isBlock(slot0)
	return UIBlockMgr.instance:isBlock() and true or false
end

function slot0.isActivityRewardGet(slot0)
	if Activity125Model.instance:getById(slot0:_actId()) == nil then
		return true
	end

	return slot2:isEpisodeFinished(1)
end

return slot0
