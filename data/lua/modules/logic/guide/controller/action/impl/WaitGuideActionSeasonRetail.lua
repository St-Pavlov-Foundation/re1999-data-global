module("modules.logic.guide.controller.action.impl.WaitGuideActionSeasonRetail", package.seeall)

slot0 = class("WaitGuideActionSeasonRetail", BaseGuideAction)
slot1 = nil

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot0._viewName = ViewName[slot2[1]]
	slot0._conditionParam = slot2[3]
	slot0._conditionCheckFun = slot0[slot2[2]]

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
	Activity104Controller.instance:registerCallback(Activity104Event.RefreshRetail, slot0._refreshRetail, slot0)
end

function slot0._checkOpenView(slot0, slot1, slot2)
	if slot0._viewName == slot1 and slot0._conditionCheckFun(slot0._conditionParam) then
		uv0 = uv0 or {}

		if not tabletool.indexOf(uv0, slot0.guideId) then
			table.insert(uv0, slot0.guideId)
		end

		TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.01)
	end
end

function slot0._refreshRetail(slot0)
	if ViewMgr.instance:isOpen(slot0._viewName) and slot0._conditionCheckFun(slot0._conditionParam) then
		uv0 = uv0 or {}

		if not tabletool.indexOf(uv0, slot0.guideId) then
			table.insert(uv0, slot0.guideId)
		end

		TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.01)
	end
end

function slot0._delayDone(slot0)
	if uv0 and GuideConfig.instance:getHighestPriorityGuideId(uv0) == slot0.guideId then
		uv0 = nil

		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
	Activity104Controller.instance:unregisterCallback(Activity104Event.RefreshRetail, slot0._refreshRetail, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

function slot0.seasonRetailRare(slot0)
	for slot6, slot7 in pairs(Activity104Model.instance:getAct104Retails()) do
		if tabletool.indexOf(string.splitToNumber(slot0, "_"), slot7.position) and slot7.advancedId ~= 0 and slot7.advancedRare ~= 0 then
			return true
		end
	end

	return false
end

return slot0
