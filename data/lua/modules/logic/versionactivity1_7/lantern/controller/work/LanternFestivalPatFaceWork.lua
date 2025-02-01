module("modules.logic.versionactivity1_7.lantern.controller.work.LanternFestivalPatFaceWork", package.seeall)

slot0 = class("LanternFestivalPatFaceWork", PatFaceWorkBase)

function slot0.onStart(slot0, slot1)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.LanternFestival) then
		slot0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onShowFinish, slot0)

	if LanternFestivalModel.instance:hasPuzzleCouldGetReward() then
		LanternFestivalController.instance:openLanternFestivalView()
	else
		slot0:onDone(true)
	end
end

function slot0._onShowFinish(slot0, slot1)
	if slot1 == ViewName.LanternFestivalView then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onShowFinish, slot0)
end

return slot0
