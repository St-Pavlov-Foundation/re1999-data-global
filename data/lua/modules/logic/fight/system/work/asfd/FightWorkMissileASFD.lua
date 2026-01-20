-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkMissileASFD.lua

module("modules.logic.fight.system.work.asfd.FightWorkMissileASFD", package.seeall)

local FightWorkMissileASFD = class("FightWorkMissileASFD", BaseWork)

function FightWorkMissileASFD:ctor(fightStepData, asfdContext)
	FightWorkMissileASFD.super.ctor(self, fightStepData)

	self.fightStepData = fightStepData
	self.asfdContext = asfdContext
end

function FightWorkMissileASFD:onStart()
	TaskDispatcher.runDelay(self.delayDone, self, 1)

	local asfdMgr = FightHelper.getASFDMgr()

	if not asfdMgr then
		return self:onDone(true)
	end

	asfdMgr:emitMissile(self.fightStepData, self.asfdContext)

	local missInterval = FightASFDConfig.instance:getMissileInterval(self.asfdContext.emitterAttackNum)

	missInterval = missInterval / FightModel.instance:getUISpeed()

	TaskDispatcher.runDelay(self.waitDone, self, missInterval)
end

function FightWorkMissileASFD:delayDone()
	logError("发射奥术飞弹 超时了")

	return self:onDone(true)
end

function FightWorkMissileASFD:waitDone()
	return self:onDone(true)
end

function FightWorkMissileASFD:clearWork()
	TaskDispatcher.cancelTask(self.delayDone, self)
	TaskDispatcher.cancelTask(self.waitDone, self)
end

return FightWorkMissileASFD
