-- chunkname: @modules/logic/fight/system/work/FightWorkStartBorn.lua

module("modules.logic.fight.system.work.FightWorkStartBorn", package.seeall)

local FightWorkStartBorn = class("FightWorkStartBorn", BaseWork)
local BornTime = 10

function FightWorkStartBorn:onStart()
	self.playedVoice = false
	FightAudioMgr.instance.enterFightVoiceHeroID = nil
	self._flowParallel = FlowParallel.New()

	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	for _, entity in ipairs(entityList) do
		local entityMo = entity:getMO()
		local continue = false

		if entityMo:isAssistBoss() then
			continue = true
		end

		if entityMo:isAct191Boss() then
			continue = true
		end

		if entity.spine and not entity.spine:hasAnimation(SpineAnimState.born) then
			continue = true
		end

		if not continue then
			if not self.playedVoice then
				self.playedVoice = true

				self:_playEnterVoice()
			end

			local bornWork = FightWorkStartBornNormal.New(entity, true)

			bornWork.dontDealBuff = true

			if FightDataHelper.entityMgr:isSub(entity.id) then
				bornWork:onStart()
			else
				self._flowParallel:addWork(bornWork)
			end
		else
			if entity.nameUI then
				entity.nameUI:setActive(true)
			end

			entity:setAlpha(1, 0)
		end
	end

	TaskDispatcher.runDelay(self._onBornTimeout, self, BornTime)
	FightController.instance:dispatchEvent(FightEvent.OnStartFightPlayBorn)
	self._flowParallel:registerDoneListener(self._onBornEnd, self)
	self._flowParallel:start()
end

function FightWorkStartBorn:_playEnterVoice()
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	local entityNoSubList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)

	if entityNoSubList and #entityNoSubList > 0 then
		local randomEntity = entityNoSubList[math.random(#entityNoSubList)]
		local heroId = randomEntity:getMO().modelId

		FightAudioMgr.instance:playHeroVoiceRandom(heroId, CharacterEnum.VoiceType.EnterFight)

		FightAudioMgr.instance.enterFightVoiceHeroID = heroId
	end
end

function FightWorkStartBorn:_onBornEnd()
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	self:onDone(true)
end

function FightWorkStartBorn:_onBornTimeout()
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	logError("播放出生效果时间超过" .. BornTime .. "秒")
	self:onDone(true)
end

function FightWorkStartBorn:clearWork()
	if self._flowParallel then
		self._flowParallel:stop()
		self._flowParallel:unregisterDoneListener(self._onBornEnd, self)
	end

	TaskDispatcher.cancelTask(self._onBornTimeout, self)
end

return FightWorkStartBorn
