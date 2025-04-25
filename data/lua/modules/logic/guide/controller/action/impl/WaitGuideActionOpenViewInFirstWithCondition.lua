module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenViewInFirstWithCondition", package.seeall)

slot0 = class("WaitGuideActionOpenViewInFirstWithCondition", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot0._viewName = ViewName[slot2[1]]
	slot0._conditionParam = slot2[3]
	slot0._delayTime = slot2[4] and tonumber(slot2[4]) or 0.2
	slot0._conditionCheckFun = slot0[slot2[2]]

	if slot0:checkDone() then
		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, slot0._checkOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._checkOpenView, slot0)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, slot0._checkOpenView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._checkOpenView, slot0)
end

function slot0._checkOpenView(slot0, slot1, slot2)
	if slot1 == ViewName.CharacterView then
		uv0.heroMo = slot2
	end

	slot0:checkDone()
end

function slot0.checkDone(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)

	if slot0:_check() then
		if slot0._delayTime and slot0._delayTime > 0 then
			TaskDispatcher.runDelay(slot0._delayDone, slot0, slot0._delayTime)
		else
			slot0:onDone(true)
		end
	end

	return slot1
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._check(slot0)
	if #ViewMgr.instance:getOpenViewNameList() > 0 then
		return slot0:isFirstView(slot1, slot0._viewName) and (slot0._conditionCheckFun == nil or slot0._conditionCheckFun(slot0._conditionParam))
	else
		return false
	end
end

function slot0.isFirstView(slot0, slot1, slot2)
	if not uv0.excludeView then
		uv0.excludeView = {
			[ViewName.GMGuideStatusView] = 1,
			[ViewName.GMToolView2] = 1,
			[ViewName.GMToolView] = 1,
			[ViewName.ToastView] = 1
		}
	end

	slot3 = false
	slot4 = nil

	for slot8 = #slot1, 1, -1 do
		if not uv0.excludeView[slot1[slot8]] then
			slot3 = slot4 == slot2

			break
		end
	end

	if not slot3 then
		logNormal(string.format("<color=#FFA500>guide_%d_%d %s not is first view! %s</color>", slot0.guideId, slot0.stepId, slot2, table.concat(slot1, "#")))
	end

	return slot3
end

slot1 = 8

function slot0.activity109ChessOpenNextStage()
	if not (Activity109ChessModel.instance:getActId() and Activity109Config.instance:getEpisodeCo(slot0, uv0)) then
		return false
	end

	if not ActivityModel.instance:getActivityInfo() then
		return false
	end

	if not slot2[slot0] then
		return false
	end

	if ServerTime.now() < slot3:getRealStartTimeStamp() + (slot1.openDay - 1) * 24 * 60 * 60 then
		return false
	end

	return true
end

function slot0.checkDestinyStone()
	if uv0.heroMo and slot0:isOwnHero() and slot0:isCanOpenDestinySystem() then
		return true
	end
end

return slot0
