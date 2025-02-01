module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomCritterMood", package.seeall)

slot0 = class("WaitGuideActionRoomCritterMood", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	CritterController.instance:registerCallback(CritterEvent.CritterInfoPushUpdate, slot0._onCritterInfoPushUpdate, slot0)

	slot0._moodValue = tonumber(slot0.actionParam)

	slot0:_check()
end

function slot0._check(slot0)
	if #CritterModel.instance:getMoodCritters(slot0._moodValue) > 0 then
		slot0:onDone(true)
	end
end

function slot0._onCritterInfoPushUpdate(slot0)
	slot0:_check()
end

function slot0.clearWork(slot0)
	CritterController.instance:unregisterCallback(CritterEvent.CritterInfoPushUpdate, slot0._onCritterInfoPushUpdate, slot0)
end

return slot0
