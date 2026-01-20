-- chunkname: @modules/logic/bossrush/model/v3a2/V3a2_BossRushModel.lua

module("modules.logic.bossrush.model.v3a2.V3a2_BossRushModel", package.seeall)

local V3a2_BossRushModel = class("V3a2_BossRushModel", BaseModel)

function V3a2_BossRushModel:init()
	self._config = BossRushConfig.instance
	self._gainMilestoneLevel = 0
end

function V3a2_BossRushModel:onRefresh128InfosReply(msg)
	self:initRankInfo(msg)
end

function V3a2_BossRushModel:onReceiveAct128GetExpReply(msg)
	local mo = self:getHandBookMo(msg.type)

	if mo then
		mo:setAcceptExp(msg.acceptExpPoint)
	end

	self._rank = msg.playerLevel
end

function V3a2_BossRushModel:_onReceiveAct128GetMilestoneBonusReply(msg)
	self._gainMilestoneLevel = msg.gainMilestoneLevel

	self:_refreshGainMilestoneLevel()
end

function V3a2_BossRushModel:getSortStages()
	local lockInfoList = {}
	local unlockInfoList = {}
	local infoList = BossRushModel.instance:getStagesInfo()
	local newOpenStage

	for _, info in ipairs(infoList) do
		local isOpen = BossRushModel.instance:isBossOnline(info.stage) and BossRushModel.instance:isBossOpen(info.stage)

		if isOpen then
			newOpenStage = info

			table.insert(unlockInfoList, info)
		else
			table.insert(lockInfoList, info)
		end
	end

	local _infoList = {}

	table.insert(_infoList, newOpenStage)

	for _, info in ipairs(unlockInfoList) do
		if newOpenStage ~= info then
			table.insert(_infoList, info)
		end
	end

	for _, info in ipairs(lockInfoList) do
		table.insert(_infoList, info)
	end

	return _infoList
end

function V3a2_BossRushModel:getRank()
	return self._rank
end

function V3a2_BossRushModel:initRankInfo(info)
	self._rank = info.playerLevel or 0
	self._gainMilestoneLevel = info.gainMilestoneLevel

	self:_refreshGainMilestoneLevel()
end

function V3a2_BossRushModel:_refreshGainMilestoneLevel()
	local mos = self:getRankMos()

	for _, mo in pairs(mos) do
		mo:setInfo(self._rank, self._gainMilestoneLevel)
	end
end

function V3a2_BossRushModel:getRankExpCurrency()
	return self._expCurrency
end

function V3a2_BossRushModel:getRankExp()
	if not self._expCurrency then
		local _, value = self._config:getConst(V3a2BossRushEnum.BossRankExpCurrencyConst)

		if string.nilorempty(value) then
			return 0
		end

		self._expCurrency = string.splitToNumber(value, "#")
	end

	local num = ItemModel.instance:getItemQuantity(self._expCurrency[1], self._expCurrency[2])

	return num
end

function V3a2_BossRushModel:getRankExpProgress()
	local rankMo = self:getRankMo(self._rank + 1)
	local exp = self:getRankExp()

	if rankMo then
		return exp - rankMo.preExp, rankMo.config.needExp
	end

	rankMo = self:getRankMo(self._rank)

	return 0, rankMo.config.needExp
end

function V3a2_BossRushModel:getRankMos()
	if not self._rankMOs then
		self._rankMOs = {}

		local needExp = 0
		local cos = self._config:getAllLevelCos()

		if cos then
			for i, co in ipairs(cos) do
				local mo = V3a2_BossRush_RankMO.New()
				local preExp = needExp

				needExp = needExp + co.needExp

				mo:initMO(co, preExp, needExp)

				self._rankMOs[co.playerLevel] = mo
			end
		end
	end

	return self._rankMOs
end

function V3a2_BossRushModel:refreshRankMos()
	self:_refreshGainMilestoneLevel()
end

function V3a2_BossRushModel:isCanClaimRankBonus()
	return self._gainMilestoneLevel < self._rank
end

function V3a2_BossRushModel:getRankMo(level)
	local mos = self:getRankMos()

	return mos and mos[level]
end

function V3a2_BossRushModel:getRankLevelBg(rank)
	local rankMo = self:getRankMo(rank) or self:getRankMo(1)

	return rankMo.config.levelBg
end

function V3a2_BossRushModel:getRankSpLevelBg(rank)
	local rankMo = self:getRankMo(rank) or self:getRankMo(1)

	return rankMo.config.spLevelBg
end

function V3a2_BossRushModel:onRefreshHandBookInfo(info)
	for _, v in ipairs(info.galleryDetail) do
		local mo = self:getHandBookMo(v.type)

		mo:setInfo(v)
	end
end

function V3a2_BossRushModel:getHandBookMos()
	if not self._handbookMOs then
		self._handbookMOs = {}

		local cos = self._config:getAllGalleryBossCos()

		if cos then
			for i, co in ipairs(cos) do
				local mo = V3a2_BossRush_HandBookMO.New()

				mo:initMO(co)

				self._handbookMOs[co.type] = mo
			end
		end
	end

	return self._handbookMOs
end

function V3a2_BossRushModel:getHandBookMo(bossType)
	local mos = self:getHandBookMos()

	return mos and mos[bossType]
end

function V3a2_BossRushModel:getHandBookMoByStage(stage)
	local bossType = self._config:getV3a2BossTypeByStage(stage)
	local mo = bossType and self:getHandBookMo(bossType)

	return mo
end

function V3a2_BossRushModel:getStrategyByStage(stage)
	local bossType = self._config:getV3a2BossTypeByStage(stage)
	local mo = self:getHandBookMoByStage(bossType)

	if mo then
		return mo:getStrategy()
	end
end

function V3a2_BossRushModel:setScore(extra)
	local baseScore = extra and extra.baseScore or 0
	local ruleScore = extra and extra.ruleScore or 0

	self._score = {
		baseScore = baseScore,
		ruleScore = ruleScore
	}
end

function V3a2_BossRushModel:getScore()
	return self._score
end

V3a2_BossRushModel.instance = V3a2_BossRushModel.New()

return V3a2_BossRushModel
