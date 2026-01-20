-- chunkname: @modules/logic/fight/system/work/asfd/FightASFDFlow.lua

module("modules.logic.fight.system.work.asfd.FightASFDFlow", package.seeall)

local FightASFDFlow = class("FightASFDFlow", BaseFlow)

FightASFDFlow.DelayWaitTime = 61

function FightASFDFlow:ctor(fightStepData, nextStepData, curIndex)
	self.fightStepData = fightStepData
	self.curIndex = curIndex
	self.asfdContext = self:getContext(fightStepData)
	self.nextStepData = nextStepData
end

function FightASFDFlow:createNormalSeq()
	local fightStepData = self.fightStepData

	self._sequence = FlowSequence.New()

	self._sequence:addWork(FightWorkCreateASFDEmitter.New(fightStepData))

	local missileFlow = FlowSequence.New()

	missileFlow:addWork(FightWorkMissileASFD.New(fightStepData, self.asfdContext))

	local parallelFlow = FlowParallel.New()
	local needWaitDone = self:checkNeedAddWaitDoneWork(self.nextStepData)

	if needWaitDone then
		missileFlow:addWork(FightWorkMissileASFDDone.New(fightStepData))
		parallelFlow:addWork(FightWorkWaitASFDArrivedDone.New(fightStepData))
	end

	parallelFlow:addWork(missileFlow)
	self._sequence:addWork(parallelFlow)
	self._sequence:addWork(FightWorkASFDEffectFlow.New(fightStepData))

	if needWaitDone then
		self._sequence:addWork(FightWorkASFDDone.New(fightStepData))
	else
		self._sequence:addWork(FightWorkASFDContinueDone.New(fightStepData))
	end
end

function FightASFDFlow:createPullOutSeq()
	self._sequence = FlowSequence.New()

	local parallelFlow = FlowParallel.New()

	parallelFlow:addWork(FightWorkASFDClearEmitter.New(self.fightStepData))
	parallelFlow:addWork(FightWorkASFDPullOut.New(self.fightStepData))
	parallelFlow:addWork(FightWorkASFDEffectFlow.New(self.fightStepData))
	self._sequence:addWork(parallelFlow)
	self._sequence:addWork(FightWorkASFDDone.New(self.fightStepData))
end

function FightASFDFlow:getContext(fightStepData)
	local context = FightASFDHelper.getStepContext(fightStepData, self.curIndex)

	if context then
		return context
	end

	logError("not found EMITTER FIGHT NOTIFY !!!")

	return {
		splitNum = 0,
		emitterAttackNum = 1,
		emitterAttackMaxNum = 2
	}
end

function FightASFDFlow:checkNeedAddWaitDoneWork(nextStepData)
	if self:checkHasMonsterChangeEffectType(self.fightStepData) then
		return true
	end

	if not nextStepData then
		return true
	end

	if FightASFDHelper.isALFPullOutStep(nextStepData, self.curIndex) then
		return true
	end

	if not FightHelper.isASFDSkill(nextStepData.actId) then
		return true
	end

	return false
end

function FightASFDFlow:checkHasMonsterChangeEffectType(fightStepData)
	if not fightStepData then
		return false
	end

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		if actEffectData.effectType == FightEnum.EffectType.MONSTERCHANGE then
			return true
		end

		if actEffectData.effectType == FightEnum.EffectType.FIGHTSTEP and self:checkHasMonsterChangeEffectType(actEffectData.fightStepData) then
			return true
		end
	end

	return false
end

function FightASFDFlow:onStart()
	if FightASFDHelper.isALFPullOutStep(self.fightStepData, self.curIndex) then
		self:createPullOutSeq()
	else
		self:createNormalSeq()
	end

	self._sequence:registerDoneListener(self._flowDone, self)
	self._sequence:start()
end

function FightASFDFlow:hasDone()
	return not self._sequence or self._sequence.status ~= WorkStatus.Running
end

function FightASFDFlow:stopSkillFlow()
	if self._sequence and self._sequence.status == WorkStatus.Running then
		self._sequence:stop()
		self._sequence:unregisterDoneListener(self._flowDone, self)

		self._sequence = nil
	end
end

function FightASFDFlow:_flowDone()
	if self._sequence then
		self._sequence:unregisterDoneListener(self._flowDone, self)

		self._sequence = nil
	end

	self:onDone(true)
end

function FightASFDFlow:clearWork()
	if self._sequence then
		self._sequence:stop()
		self._sequence:unregisterDoneListener(self._flowDone, self)

		self._sequence = nil
	end
end

return FightASFDFlow
