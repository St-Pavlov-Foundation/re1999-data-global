-- chunkname: @modules/logic/seasonver/act123/model/Season123HeroGroupQuickEditModel.lua

module("modules.logic.seasonver.act123.model.Season123HeroGroupQuickEditModel", package.seeall)

local Season123HeroGroupQuickEditModel = class("Season123HeroGroupQuickEditModel", ListScrollModel)

function Season123HeroGroupQuickEditModel:init(actId, layer, episodeId, stage)
	self.activityId = actId
	self.layer = layer
	self.episodeId = episodeId
	self.episodeCO = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	self.stage = stage
end

function Season123HeroGroupQuickEditModel:copyQuickEditCardList()
	local moList = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local heroMO = Season123Model.instance:getAssistData(self.activityId, self.stage)

	if heroMO and Season123Controller.isEpisodeFromSeason123(self.episodeId) and Season123HeroGroupModel.instance:isEpisodeSeason123() then
		table.insert(moList, heroMO)
	end

	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUidMap = {}
	self._inTeamHeroUidList = {}
	self._originalHeroUidList = {}
	self._selectUid = nil

	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()

	for pos, heroUid in ipairs(heroGroupMO.heroList) do
		local posOpen = HeroGroupModel.instance:isPositionOpen(pos)

		if heroUid ~= "0" and not repeatHero[heroUid] then
			local tmpMO = Season123HeroUtils.getHeroMO(self.activityId, heroUid, self.stage)

			if self:checkSeasonBox(tmpMO) then
				table.insert(newMOList, tmpMO)

				if posOpen then
					self._inTeamHeroUidMap[heroUid] = 1
				end

				repeatHero[heroUid] = true
			end
		end

		if posOpen then
			table.insert(self._inTeamHeroUidList, heroUid)
			table.insert(self._originalHeroUidList, heroUid)
		end
	end

	local deathList = {}

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] and self:checkSeasonBox(mo) then
			repeatHero[mo.uid] = true

			table.insert(newMOList, mo)
		end
	end

	if self.adventure then
		tabletool.addValues(newMOList, deathList)
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		self.sortIndexMap = {}

		for i, v in ipairs(newMOList) do
			self.sortIndexMap[v] = i
		end

		table.sort(newMOList, Season123HeroGroupQuickEditModel.sortDead)
	end

	self:setList(newMOList)
end

function Season123HeroGroupQuickEditModel.sortDead(a, b)
	local aIsDead = Season123HeroGroupQuickEditModel.instance:getHeroIsDead(a)
	local bIsDead = Season123HeroGroupQuickEditModel.instance:getHeroIsDead(b)

	if aIsDead ~= bIsDead then
		return bIsDead
	else
		local aIndex = Season123HeroGroupEditModel.instance.sortIndexMap[a]
		local bIndex = Season123HeroGroupEditModel.instance.sortIndexMap[b]

		return aIndex < bIndex
	end
end

function Season123HeroGroupQuickEditModel:getHeroIsDead(mo)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local isDead = false
		local actId = self.activityId
		local stage = self.stage
		local layer = self.layer
		local seasonHeroMO = Season123Model.instance:getSeasonHeroMO(actId, stage, layer, mo.uid)

		if seasonHeroMO ~= nil then
			isDead = seasonHeroMO.hpRate <= 0
		end

		return isDead
	end

	return false
end

function Season123HeroGroupQuickEditModel:checkSeasonBox(heroMO)
	if self.episodeCO then
		if self.episodeCO.type == DungeonEnum.EpisodeType.Season123 then
			return Season123Model.instance:getSeasonHeroMO(self.activityId, self.stage, self.layer, heroMO.uid)
		else
			return true
		end
	end

	return false
end

function Season123HeroGroupQuickEditModel:keepSelect(selectIndex)
	self._selectIndex = selectIndex

	local list = self:getList()

	if #self._scrollViews > 0 then
		for _, view in ipairs(self._scrollViews) do
			view:selectCell(selectIndex, true)
		end

		if list[selectIndex] then
			return list[selectIndex]
		end
	end
end

function Season123HeroGroupQuickEditModel:isInTeamHero(uid)
	return self._inTeamHeroUidMap and self._inTeamHeroUidMap[uid]
end

function Season123HeroGroupQuickEditModel:getHeroTeamPos(uid)
	if self._inTeamHeroUidList then
		for index, heroUid in pairs(self._inTeamHeroUidList) do
			if heroUid == uid then
				return index
			end
		end
	end

	return 0
end

function Season123HeroGroupQuickEditModel:selectHero(uid)
	local index = self:getHeroTeamPos(uid)

	if index ~= 0 then
		self._inTeamHeroUidList[index] = "0"
		self._inTeamHeroUidMap[uid] = nil

		self:onModelUpdate()

		self._selectUid = nil

		return true
	else
		local nextIndex = 0

		for i = 1, #self._inTeamHeroUidList do
			local heroUid = self._inTeamHeroUidList[i]

			if heroUid == 0 or heroUid == "0" then
				self._inTeamHeroUidList[i] = uid
				self._inTeamHeroUidMap[uid] = 1

				self:onModelUpdate()

				return true
			end
		end

		self._selectUid = uid
	end

	return false
end

function Season123HeroGroupQuickEditModel:getHeroUids()
	return self._inTeamHeroUidList
end

function Season123HeroGroupQuickEditModel:getHeroUidByPos(pos)
	return self._inTeamHeroUidList[pos]
end

function Season123HeroGroupQuickEditModel:getIsDirty()
	for i = 1, #self._inTeamHeroUidList do
		if self._inTeamHeroUidList[i] ~= self._originalHeroUidList[i] then
			return true
		end
	end

	return false
end

function Season123HeroGroupQuickEditModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function Season123HeroGroupQuickEditModel:isTeamFull()
	for i = 1, #self._inTeamHeroUidList do
		local posOpen = HeroGroupModel.instance:isPositionOpen(i)

		if self._inTeamHeroUidList[i] == "0" and posOpen then
			return false
		end
	end

	return true
end

function Season123HeroGroupQuickEditModel:setParam(adventure)
	self.adventure = adventure
end

function Season123HeroGroupQuickEditModel:clear()
	self._inTeamHeroUidMap = nil
	self._inTeamHeroUidList = nil
	self._originalHeroUidList = nil
	self._selectIndex = nil
	self._selectUid = nil

	Season123HeroGroupQuickEditModel.super.clear(self)
end

Season123HeroGroupQuickEditModel.instance = Season123HeroGroupQuickEditModel.New()

return Season123HeroGroupQuickEditModel
