module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBuildingClick", package.seeall)

slot0 = class("WaitGuideActionRoomBuildingClick", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	GuideViewMgr.instance:enableHoleClick()
	GuideViewMgr.instance:setHoleClickCallback(slot0._onClickTarget, slot0)
end

function slot0.clearWork(slot0)
	GuideViewMgr.instance:setHoleClickCallback(nil, )
	TaskDispatcher.cancelTask(slot0._onDelayDone, slot0)
end

function slot0._onClickTarget(slot0, slot1)
	if slot1 then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:setHoleClickCallback(nil, )
		TaskDispatcher.runDelay(slot0._onDelayDone, slot0, 0.01)

		if RoomMapBuildingModel.instance:getBuildingMoByBuildingId(tonumber(slot0.actionParam)) then
			RoomMap3DClickController.instance:onBuildingEntityClick(slot3)
		end
	end
end

function slot0._onDelayDone(slot0)
	slot0:onDone(true)
end

return slot0
