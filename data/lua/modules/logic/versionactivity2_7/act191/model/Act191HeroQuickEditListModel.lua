-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191HeroQuickEditListModel.lua

module("modules.logic.versionactivity2_7.act191.model.Act191HeroQuickEditListModel", package.seeall)

local Act191HeroQuickEditListModel = class("Act191HeroQuickEditListModel", ListScrollModel)

function Act191HeroQuickEditListModel:initData()
	self.moList = {}
	self._index2HeroIdMap = {}

	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	for _, heroInfo in ipairs(gameInfo.warehouseInfo.hero) do
		local mo = {}

		mo.heroId = heroInfo.heroId
		mo.star = heroInfo.star
		mo.exp = heroInfo.exp
		mo.config = Activity191Config.instance:getRoleCoByNativeId(mo.heroId, mo.star)

		local battleHeroInfo = gameInfo:getBattleHeroInfoInTeam(mo.heroId)

		if battleHeroInfo then
			self._index2HeroIdMap[battleHeroInfo.index] = mo.heroId
		else
			local subHeroInfo = gameInfo:getSubHeroInfoInTeam(mo.heroId)

			if subHeroInfo then
				self._index2HeroIdMap[subHeroInfo.index + 4] = mo.heroId
			end
		end

		self.moList[#self.moList + 1] = mo
	end

	self:filterData(nil, Activity191Enum.SortRule.Down)

	for _, view in ipairs(self._scrollViews) do
		view:selectCell(1, false)
	end
end

function Act191HeroQuickEditListModel:selectHero(heroId, isSelect)
	if isSelect then
		local emptyPos = self:findEmptyPos()

		if emptyPos ~= 0 then
			self._index2HeroIdMap[emptyPos] = heroId
		end
	else
		local index = self:getHeroTeamPos(heroId)

		self._index2HeroIdMap[index] = nil
	end
end

function Act191HeroQuickEditListModel:getHeroTeamPos(heroId)
	if self._index2HeroIdMap then
		for index, id in pairs(self._index2HeroIdMap) do
			if id == heroId then
				return index
			end
		end
	end

	return 0
end

function Act191HeroQuickEditListModel:findEmptyPos()
	for i = 1, 8 do
		if not self._index2HeroIdMap[i] then
			return i
		end
	end

	return 0
end

function Act191HeroQuickEditListModel:filterData(tag, rule)
	local list

	if tag then
		list = {}

		for _, mo in ipairs(self.moList) do
			local tagArr = string.split(mo.config.tag, "#")

			if tabletool.indexOf(tagArr, tag) then
				list[#list + 1] = mo
			end
		end
	else
		list = tabletool.copy(self.moList)
	end

	table.sort(list, function(a, b)
		local aPos = self:getHeroTeamPos(a.heroId)

		aPos = aPos == 0 and 999 or aPos

		local bPos = self:getHeroTeamPos(b.heroId)

		bPos = bPos == 0 and 999 or bPos

		if aPos == bPos then
			if a.config.quality == b.config.quality then
				if a.config.exLevel == b.config.exLevel then
					return a.config.id < b.config.id
				else
					return a.config.exLevel > b.config.exLevel
				end
			elseif rule == Activity191Enum.SortRule.Down then
				return a.config.quality > b.config.quality
			else
				return a.config.quality < b.config.quality
			end
		else
			return aPos < bPos
		end
	end)
	self:setList(list)
end

function Act191HeroQuickEditListModel:getHeroIdMap()
	return self._index2HeroIdMap or {}
end

Act191HeroQuickEditListModel.instance = Act191HeroQuickEditListModel.New()

return Act191HeroQuickEditListModel
