-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSetSign.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSetSign", package.seeall)

local FightTLEventSetSign = class("FightTLEventSetSign", FightTimelineTrackItem)

function FightTLEventSetSign:onTrackStart(fightStepData, duration, paramsArr)
	self.fightStepData = fightStepData
	self.duration = duration
	self.paramsArr = paramsArr

	if paramsArr[1] == "1" then
		self.workTimelineItem.skipAfterTimelineFunc = true
	end

	local param2 = paramsArr[2]

	if not string.nilorempty(param2) then
		local arr = string.split(param2, "#")
		local visible = table.remove(arr, 1)

		self:com_sendFightEvent(FightEvent.SetBtnListVisibleWhenHidingFightView, visible == "show", arr)
	end

	local param3 = paramsArr[3]

	if not string.nilorempty(param3) then
		local arr = string.split(param3, "#")
		local targetType = arr[1]
		local visible = arr[2]

		if targetType == "1" then
			local toId = fightStepData.toId
			local entityData = FightDataHelper.entityMgr:getById(toId)
			local isBoss = FightHelper.checkIsBossByMonsterId(entityData.modelId)

			if lua_fight_assembled_monster.configDict[entityData.skin] then
				isBoss = true
			end

			if isBoss then
				self:com_sendFightEvent(FightEvent.SetBossHpVisibleWhenHidingFightView, visible == "show")
			end
		end
	end

	local param4 = paramsArr[4]

	if not string.nilorempty(param4) then
		FightDataHelper.tempMgr.hideNameUIByTimeline = param4 == "hide"
	end

	if paramsArr[5] == "1" then
		fightStepData.forceShowDamageTotalFloat = true
	end

	local param6 = paramsArr[6]

	if param6 == "aiJiAoQteStart" then
		FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.AiJiAoQteIng)

		local entityList = FightHelper.getAllEntitys()

		for _, entity in ipairs(entityList) do
			if entity.nameUI then
				entity.nameUI:setActive(true)
			end
		end
	elseif param6 == "aiJiAoQteEnd" then
		FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.AiJiAoQteIng)
	end
end

function FightTLEventSetSign:onTrackEnd()
	if self.workTimelineItem.skipAfterTimelineFunc then
		local skillMgr = FightSkillMgr.instance

		skillMgr._playingSkillCount = skillMgr._playingSkillCount - 1

		if skillMgr._playingSkillCount < 0 then
			skillMgr._playingSkillCount = 0
		end

		skillMgr._playingEntityId2StepData[self.fightStepData.fromId] = nil
	end
end

function FightTLEventSetSign:onDestructor()
	return
end

return FightTLEventSetSign
