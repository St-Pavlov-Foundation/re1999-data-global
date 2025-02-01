module("modules.logic.fight.system.work.FightWorkWaveEndDialog", package.seeall)

slot0 = class("FightWorkWaveEndDialog", BaseWork)

function slot0.onStart(slot0)
	slot1 = FightModel.instance:getCurWaveId()
	FightWorkStepChangeWave.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEnd, slot1)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEndAndCheckBuffId, slot1)

	if FightWorkStepChangeWave.needStopMonsterWave then
		slot0._dialogWork = FightWorkWaitDialog.New()

		slot0._dialogWork:registerDoneListener(slot0._onFightDialogEnd, slot0)
		slot0._dialogWork:onStart()
	else
		slot0:_onFightDialogEnd()
	end
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
