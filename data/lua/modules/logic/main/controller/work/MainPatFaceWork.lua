module("modules.logic.main.controller.work.MainPatFaceWork", package.seeall)

slot0 = class("MainPatFaceWork", BaseWork)

function slot0.onStart(slot0, slot1)
	PatFaceController.instance:registerCallback(PatFaceEvent.FinishAllPatFace, slot0._onFinishAllPatFace, slot0)

	slot2 = PatFaceEnum.patFaceType.Login

	if slot1 and slot1.dailyRefresh then
		slot2 = PatFaceEnum.patFaceType.NewDay
	end

	if not PatFaceController.instance:startPatFace(slot2) then
		slot0:onDone(true)
	end
end

function slot0._onFinishAllPatFace(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	PatFaceController.instance:unregisterCallback(PatFaceEvent.FinishAllPatFace, slot0._onFinishAllPatFace, slot0)
end

return slot0
