module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaDialogStep", package.seeall)

slot0 = class("TianShiNaNaDialogStep", TianShiNaNaStepBase)

function slot0.onStart(slot0, slot1)
	if TianShiNaNaEntityMgr.instance:getEntity(slot0._data.interactId) and slot2.checkActive then
		slot2._unitMo:setActive(true)
		slot2:checkActive()
	end

	if slot0._data.dialogueId == 0 then
		return slot0:onDone(true)
	end

	slot0:beginPlayDialog()
end

function slot0.beginPlayDialog(slot0)
	if not TianShiNaNaConfig.instance:getBubbleCo(VersionActivity2_2Enum.ActivityId.TianShiNaNa, slot0._data.dialogueId) then
		logError("天使娜娜对话配置不存在" .. slot0._data.dialogueId)
		slot0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onViewClose, slot0)
	ViewMgr.instance:openView(ViewName.TianShiNaNaTalkView, slot1)
end

function slot0._onViewClose(slot0, slot1)
	if slot1 == ViewName.TianShiNaNaTalkView then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onViewClose, slot0)
end

return slot0
