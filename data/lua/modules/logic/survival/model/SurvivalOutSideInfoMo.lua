-- chunkname: @modules/logic/survival/model/SurvivalOutSideInfoMo.lua

module("modules.logic.survival.model.SurvivalOutSideInfoMo", package.seeall)

local SurvivalOutSideInfoMo = pureTable("SurvivalOutSideInfoMo")

function SurvivalOutSideInfoMo:init(data)
	self.season = data.season
	self.versions = data.versions
	self.inWeek = data.inWeek

	table.sort(self.versions)
	self:refreshDifficulty(data.unlockDifficulty)
	self:refreshDifficultyMod(data.passHardnessMod)

	self.score = data.score
	self.gain = {}

	for i, v in ipairs(data.gain) do
		self.gain[v] = true
	end

	self.currMod = data.currMod
	self.currDay = data.currDay
	self.equipIds = {}

	for i, v in ipairs(data.equipIds) do
		table.insert(self.equipIds, v)
	end

	self.npcIds = {}

	for i, v in ipairs(data.npcId) do
		table.insert(self.npcIds, v)
	end

	self.endIdDict = {}

	for i, v in ipairs(data.endId) do
		self.endIdDict[v] = true
	end

	self.clientData = self.clientData or SurvivalOutSideClientDataMo.New()

	self.clientData:init(data.clientData)

	local handbookBox = data.handbookBox

	SurvivalHandbookModel.instance:setSurvivalHandbookBox(handbookBox)
end

function SurvivalOutSideInfoMo:refreshDifficulty(difficulty)
	self.difficultyDict = {}

	if not difficulty then
		return
	end

	for i = 1, #difficulty do
		self.difficultyDict[difficulty[i]] = true
	end
end

function SurvivalOutSideInfoMo:refreshDifficultyMod(difficulty)
	self.difficultyModDict = {}

	if not difficulty then
		return
	end

	for i = 1, #difficulty do
		self.difficultyModDict[difficulty[i]] = true
	end
end

function SurvivalOutSideInfoMo:isUnlockDifficultyMod(modId)
	local config = lua_survival_hardness_mod.configDict[modId]

	if not config then
		return false
	end

	if string.nilorempty(config.unlock) then
		return true
	end

	local unlockCondition = string.split(config.unlock, "#")

	if unlockCondition[1] == SurvivalEnum.HardUnlockCondition.overDif then
		local diffId = tonumber(unlockCondition[2])

		return self:isPassDifficultyMod(diffId)
	elseif unlockCondition[1] == SurvivalEnum.HardUnlockCondition.overDifMult then
		local diffIds = string.splitToNumber(unlockCondition[2], ",")

		for i, v in ipairs(diffIds) do
			if self:isPassDifficultyMod(v) then
				return true
			end
		end
	else
		logError(string.format("undefine difficulty mod unlock condition : %s", config.unlock))
	end

	return false
end

function SurvivalOutSideInfoMo:isPassDifficultyMod(difficulty)
	return self.difficultyModDict[difficulty] or false
end

function SurvivalOutSideInfoMo:isUnlockDifficulty(difficulty)
	return self.difficultyDict[difficulty] or false
end

function SurvivalOutSideInfoMo:isFirstPlay()
	return not self:isPassDifficultyMod(SurvivalConst.FirstPlayDifficulty)
end

function SurvivalOutSideInfoMo:isGainReward(rewardId)
	return self.gain[rewardId]
end

function SurvivalOutSideInfoMo:getScore()
	return self.score
end

function SurvivalOutSideInfoMo:getRewardState(rewardId, rewardScore)
	if self:isGainReward(rewardId) then
		return 2
	end

	if rewardScore <= self:getScore() then
		return 1
	end

	return 0
end

function SurvivalOutSideInfoMo:onGainReward(rewardId)
	if rewardId ~= 0 then
		self.gain[rewardId] = true

		return
	end

	local list = SurvivalConfig.instance:getRewardList()

	for i, v in ipairs(list) do
		if self:getRewardState(v.id, v.score) == 1 then
			self.gain[v.id] = true
		end
	end
end

function SurvivalOutSideInfoMo:getEndId()
	local list = lua_survival_end.configList
	local endIds = {}

	for i, v in ipairs(list) do
		if self.endIdDict[v.id] then
			table.insert(endIds, v)
		end
	end

	table.sort(endIds, SortUtil.tableKeyUpper({
		"order",
		"id"
	}))

	return endIds[1] and endIds[1].id or 0
end

function SurvivalOutSideInfoMo:getBootyList()
	local list = {}
	local equipList = self.equipIds
	local npcList = self.npcIds

	for i, v in ipairs(equipList) do
		local mo = SurvivalBagItemMo.New()

		mo:init({
			count = 1,
			id = v
		})

		if mo.co ~= nil then
			table.insert(list, mo)
		end
	end

	for i, v in ipairs(npcList) do
		local mo = SurvivalBagItemMo.New()

		mo:init({
			count = 1,
			id = v
		})

		if mo.co ~= nil then
			table.insert(list, mo)
		end
	end

	return list
end

return SurvivalOutSideInfoMo
