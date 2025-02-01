module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenViewWithEpisode", package.seeall)

slot0 = class("WaitGuideActionOpenViewWithEpisode", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot0._viewName = ViewName[slot2[1]]
	slot0._targetEposideId = tonumber(slot2[2])

	if ViewMgr.instance:isOpen(slot0._viewName) and slot0._targetEposideId == DungeonModel.instance.curLookEpisodeId then
		slot0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
end

function slot0._checkOpenView(slot0, slot1, slot2)
	if slot0._viewName == slot1 and slot0._targetEposideId == DungeonModel.instance.curLookEpisodeId then
		slot0:clearWork()
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
end

return slot0
