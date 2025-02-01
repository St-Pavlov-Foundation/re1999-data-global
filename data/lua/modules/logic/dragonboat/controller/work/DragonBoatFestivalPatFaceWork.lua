module("modules.logic.dragonboat.controller.work.DragonBoatFestivalPatFaceWork", package.seeall)

slot0 = class("DragonBoatFestivalPatFaceWork", PatFaceWorkBase)

function slot0.onStart(slot0, slot1)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.DragonBoatFestival) then
		slot0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onShowFinish, slot0)

	if DragonBoatFestivalModel.instance:hasRewardNotGet() then
		DragonBoatFestivalController.instance:openDragonBoatFestivalView()
	else
		slot0:onDone(true)
	end
end

function slot0._onShowFinish(slot0, slot1)
	if slot1 == ViewName.DragonBoatFestivalView then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onShowFinish, slot0)
end

return slot0
