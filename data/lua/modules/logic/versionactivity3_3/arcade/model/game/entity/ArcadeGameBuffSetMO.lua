-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameBuffSetMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameBuffSetMO", package.seeall)

local ArcadeGameBuffSetMO = class("ArcadeGameBuffSetMO")

function ArcadeGameBuffSetMO:ctor(unitMO)
	self.unitMO = unitMO
	self._buffDict = {}
	self._buffList = {}
	self._effectParamDict = {}
end

function ArcadeGameBuffSetMO:getBuffList()
	return self._buffList
end

function ArcadeGameBuffSetMO:hasEffectParamBuff(effectParam)
	local buffDict = self:getBuffDictByEffectParam(effectParam)

	return buffDict and next(buffDict)
end

function ArcadeGameBuffSetMO:getBuffDictByEffectParam(effectParam)
	if not string.nilorempty(effectParam) and self._effectParamDict then
		return self._effectParamDict[effectParam]
	end
end

function ArcadeGameBuffSetMO:checkBuffsReduceInRoundBegin()
	local removeBuffList = {}

	for _, buff in ipairs(self._buffList) do
		local buffId = buff:getId()
		local notSubInRoundBegin = ArcadeConfig.instance:getArcadeBuffIsNotSubInRoundBegin(buffId)

		if not notSubInRoundBegin then
			buff:subLiveRound()

			local remainRound = buff:getRemainLiveRound()

			if remainRound <= 0 then
				removeBuffList[#removeBuffList + 1] = buffId
			end
		end
	end

	return removeBuffList
end

function ArcadeGameBuffSetMO:reduceBuffRoundByEffectParam(effectParam)
	local removeBuffList = {}
	local buffDict = self:getBuffDictByEffectParam(effectParam)

	if buffDict then
		for _, buff in pairs(buffDict) do
			buff:subLiveRound()

			local remainRound = buff:getRemainLiveRound()

			if remainRound <= 0 then
				removeBuffList[#removeBuffList + 1] = buff:getId()
			end
		end
	end

	return removeBuffList
end

function ArcadeGameBuffSetMO:reduceBuffRound(buffId)
	local isCanRemove = false
	local buff = self:getBuffById(buffId)

	if buff then
		buff:subLiveRound()

		local remainRound = buff:getRemainLiveRound()

		if remainRound <= 0 then
			isCanRemove = true
		end
	end

	return isCanRemove
end

function ArcadeGameBuffSetMO:getBuffById(buffId)
	return self._buffDict[buffId]
end

local function _sortBuffList(aBuff, bBuff)
	local aBuffId = aBuff:getId()
	local bBuffId = bBuff:getId()
	local aShowPriority = ArcadeConfig.instance:getArcadeBuffShowPriority(aBuffId)
	local bShowPriority = ArcadeConfig.instance:getArcadeBuffShowPriority(bBuffId)

	if aShowPriority ~= bShowPriority then
		return aShowPriority < bShowPriority
	end

	return aBuffId < bBuffId
end

function ArcadeGameBuffSetMO:addBuffById(buffId)
	if self._buffDict[buffId] then
		self._buffDict[buffId]:resetLiveRound()
	else
		local buff = ArcadeGameBuffMO.New(buffId, self.unitMO)

		self._buffDict[buffId] = buff

		local effectParamList = ArcadeConfig.instance:getArcadeBuffEffectParamList(buffId)

		if effectParamList and #effectParamList > 0 then
			for _, effectParam in ipairs(effectParamList) do
				local buffDict = ArcadeGameHelper.checkDictTable(self._effectParamDict, effectParam)

				buffDict[buffId] = buff
			end
		end

		table.insert(self._buffList, buff)
		table.sort(self._buffList, _sortBuffList)

		local skillList = ArcadeConfig.instance:getArcadeBuffPassiveSkillList(buffId)
		local skillSetMO = self.unitMO:getSkillSetMO()

		for _, skillId in ipairs(skillList) do
			if ArcadeGameHelper.isPassiveSkill(skillId) then
				skillSetMO:addSkillById(skillId)
			end
		end
	end
end

function ArcadeGameBuffSetMO:removeBuffById(buffId)
	if self._buffDict[buffId] then
		local buff = self._buffDict[buffId]

		self._buffDict[buffId] = nil

		local effectParamList = ArcadeConfig.instance:getArcadeBuffEffectParamList(buffId)

		if effectParamList and #effectParamList > 0 then
			for _, effectParam in ipairs(effectParamList) do
				if self._effectParamDict[effectParam] then
					self._effectParamDict[effectParam][buffId] = nil
				end
			end
		end

		tabletool.removeValue(self._buffList, buff)

		local skillSetMO = self.unitMO:getSkillSetMO()
		local skillList = ArcadeConfig.instance:getArcadeBuffPassiveSkillList(buffId)

		for _, skillId in ipairs(skillList) do
			if ArcadeGameHelper.isPassiveSkill(skillId) then
				skillSetMO:removeSkillById(skillId)
			end
		end
	end
end

return ArcadeGameBuffSetMO
