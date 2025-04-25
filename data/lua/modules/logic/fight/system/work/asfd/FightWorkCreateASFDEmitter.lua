module("modules.logic.fight.system.work.asfd.FightWorkCreateASFDEmitter", package.seeall)

slot0 = class("FightWorkCreateASFDEmitter", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.stepMo = slot1
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0.delayDone, slot0, 1)

	if not FightHelper.getASFDMgr() then
		return slot0:onDone(true)
	end

	if slot1:createEmitterWrap(slot0.stepMo) then
		TaskDispatcher.runDelay(slot0.waitDone, slot0, FightASFDConfig.instance.emitterWaitTime)
	else
		return slot0:onDone(true)
	end
end

function slot0.waitDone(slot0)
	return slot0:onDone(true)
end

function slot0.delayDone(slot0)
	logError("创建奥术飞弹发射源，超时了")

	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0.delayDone, slot0)
	TaskDispatcher.cancelTask(slot0.waitDone, slot0)
end

return slot0
