module("modules.logic.fight.system.work.FightWorkNormalDialog", package.seeall)

slot0 = class("FightWorkNormalDialog", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._dialogType = slot1
	slot0._param = slot2
end

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, slot0._dialogType, slot0._param)

	if FightViewDialog.showFightDialog then
		slot0._dialogWork = FightWorkWaitDialog.New()

		slot0._dialogWork:registerDoneListener(slot0._onFightDialogEnd, slot0)
		slot0._dialogWork:onStart()

		return
	end

	slot0:onDone(true)
end

function slot0._onFightDialogEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)

	if slot0._dialogWork then
		slot0._dialogWork:unregisterDoneListener(slot0._onFightDialogEnd, slot0)

		slot0._dialogWork = nil
	end
end

return slot0
