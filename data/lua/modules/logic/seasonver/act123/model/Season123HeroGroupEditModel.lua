-- chunkname: @modules/logic/seasonver/act123/model/Season123HeroGroupEditModel.lua

module("modules.logic.seasonver.act123.model.Season123HeroGroupEditModel", package.seeall)

local Season123HeroGroupEditModel = class("Season123HeroGroupEditModel", ListScrollModel)

function Season123HeroGroupEditModel:init(actId, layer, episodeId, stage)
	self.activityId = actId
	self.layer = layer
	self.episodeId = episodeId
	self.episodeCO = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	self.stage = stage
end

function Season123HeroGroupEditModel:setMoveHeroId(id)
	self._moveHeroId = id
end

function Season123HeroGroupEditModel:getMoveHeroIndex()
	return self._moveHeroIndex
end

function Season123HeroGroupEditModel:copyCharacterCardList(init)
	local moList = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local heroMO = Season123Model.instance:getAssistData(self.activityId, self.stage)

	if heroMO and Season123Controller.isEpisodeFromSeason123(self.episodeId) and Season123HeroGroupModel.instance:isEpisodeSeason123() then
		table.insert(moList, heroMO)
	end

	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUids = {}

	local selectIndex = 0
	local index = 1
	local alreadyList = HeroSingleGroupModel.instance:getList()

	for i, heroSingleGroupMO in ipairs(alreadyList) do
		local heroUid = heroSingleGroupMO.heroUid

		if not heroSingleGroupMO.aid and tonumber(heroUid) > 0 and not repeatHero[heroUid] then
			local tmpMO = Season123HeroUtils.getHeroMO(self.activityId, heroUid, self.stage)

			if self:checkSeasonBox(tmpMO) then
				table.insert(newMOList, tmpMO)

				if self.specialHero == heroUid then
					self._inTeamHeroUids[heroUid] = 2
					selectIndex = index
				else
					self._inTeamHeroUids[heroUid] = 1
					index = index + 1
				end

				repeatHero[heroUid] = true
			end
		end
	end

	for i, mo in ipairs(newMOList) do
		if self._moveHeroId and mo.heroId == self._moveHeroId then
			self._moveHeroId = nil
			self._moveHeroIndex = i

			break
		end
	end

	local groupHeroNum = #newMOList

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] and self:checkSeasonBox(mo) then
			repeatHero[mo.uid] = true

			if self._moveHeroId and mo.heroId == self._moveHeroId then
				self._moveHeroId = nil
				self._moveHeroIndex = groupHeroNum + 1

				table.insert(newMOList, self._moveHeroIndex, mo)
			else
				table.insert(newMOList, mo)
			end
		end
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		self.sortIndexMap = {}

		for i, v in ipairs(newMOList) do
			self.sortIndexMap[v] = i
		end

		table.sort(newMOList, Season123HeroGroupEditModel.sortDead)
	end

	self:setList(newMOList)

	if init and #newMOList > 0 and selectIndex > 0 and #self._scrollViews > 0 then
		for _, view in ipairs(self._scrollViews) do
			view:selectCell(selectIndex, true)
		end

		if newMOList[selectIndex] then
			return newMOList[selectIndex]
		end
	end
end

function Season123HeroGroupEditModel.sortDead(a, b)
	local aIsDead = Season123HeroGroupEditModel.instance:getHeroIsDead(a)
	local bIsDead = Season123HeroGroupEditModel.instance:getHeroIsDead(b)

	if aIsDead ~= bIsDead then
		return bIsDead
	else
		local aIndex = Season123HeroGroupEditModel.instance.sortIndexMap[a]
		local bIndex = Season123HeroGroupEditModel.instance.sortIndexMap[b]

		return aIndex < bIndex
	end
end

function Season123HeroGroupEditModel:getHeroIsDead(mo)
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

function Season123HeroGroupEditModel:checkSeasonBox(heroMO)
	if self.episodeCO then
		if self.episodeCO.type == DungeonEnum.EpisodeType.Season123 then
			return Season123Model.instance:getSeasonHeroMO(self.activityId, self.stage, self.layer, heroMO.uid)
		else
			return true
		end
	end

	return false
end

function Season123HeroGroupEditModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function Season123HeroGroupEditModel:isInTeamHero(uid)
	return self._inTeamHeroUids and self._inTeamHeroUids[uid]
end

function Season123HeroGroupEditModel:setParam(heroUid)
	self.specialHero = heroUid
end

function Season123HeroGroupEditModel:getEquipMOByHeroUid(heroUid)
	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not heroGroupMO then
		return
	end

	local index = tabletool.indexOf(heroGroupMO.heroList, heroUid)

	if index then
		local equip = heroGroupMO:getPosEquips(index - 1)

		if equip and equip.equipUid and #equip.equipUid > 0 then
			local uid = equip.equipUid[1]

			if uid and uid ~= Activity123Enum.EmptyUid then
				return EquipModel.instance:getEquip(uid)
			end
		end
	end
end

function Season123HeroGroupEditModel:getAssistHeroList()
	local heroMOs = {}
	local heroMO = Season123Model.instance:getAssistData(self.activityId, self.stage)

	if heroMO and Season123Controller.isEpisodeFromSeason123(self.episodeId) then
		table.insert(heroMOs, heroMO)
	end

	return heroMOs
end

Season123HeroGroupEditModel.instance = Season123HeroGroupEditModel.New()

return Season123HeroGroupEditModel
