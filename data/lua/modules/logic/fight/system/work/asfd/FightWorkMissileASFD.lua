module("modules.logic.fight.system.work.asfd.FightWorkMissileASFD", package.seeall)

slot0 = class("FightWorkMissileASFD", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	uv0.super.ctor(slot0, slot1)

	slot0.stepMo = slot1
	slot0._fightStepMO = slot1
	slot0.curIndex = slot2
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0.delayDone, slot0, 1)

	if not FightHelper.getASFDMgr() then
		return slot0:onDone(true)
	end

	slot1:emitMissile(slot0.stepMo, slot0.curIndex)
	TaskDispatcher.runDelay(slot0.waitDone, slot0, FightASFDConfig.instance:getMissileInterval(slot0.curIndex) / FightModel.instance:getUISpeed())
end

function slot0.delayDone(slot0)
	logError("发射奥术飞弹 超时了")

	return slot0:onDone(true)
end

function slot0.waitDone(slot0)
	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0.delayDone, slot0)
	TaskDispatcher.cancelTask(slot0.waitDone, slot0)
end

return slot0
