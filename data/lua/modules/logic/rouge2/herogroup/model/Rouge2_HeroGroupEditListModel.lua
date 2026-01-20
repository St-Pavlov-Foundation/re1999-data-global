-- chunkname: @modules/logic/rouge2/herogroup/model/Rouge2_HeroGroupEditListModel.lua

module("modules.logic.rouge2.herogroup.model.Rouge2_HeroGroupEditListModel", package.seeall)

local Rouge2_HeroGroupEditListModel = class("Rouge2_HeroGroupEditListModel", MixScrollModel)

function Rouge2_HeroGroupEditListModel:init(actId, episodeId)
	self.activityId = actId
	self.episodeId = episodeId
	self.episodeCo = DungeonConfig.instance:getEpisodeCO(self.episodeId)
end

function Rouge2_HeroGroupEditListModel:copyCharacterCardList(init)
	local moList

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		moList = {}
	else
		moList = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	end

	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUids = {}

	local selectIndex = 1
	local index = 1
	local alreadyList = HeroSingleGroupModel.instance:getList()
	local assistMO = HeroSingleGroupModel.instance.assistMO

	for i, heroSingleGroupMO in ipairs(alreadyList) do
		if heroSingleGroupMO.trial or not heroSingleGroupMO.aid and tonumber(heroSingleGroupMO.heroUid) > 0 and not repeatHero[heroSingleGroupMO.heroUid] then
			if heroSingleGroupMO.trial then
				table.insert(newMOList, HeroGroupTrialModel.instance:getById(heroSingleGroupMO.heroUid))
			elseif assistMO and heroSingleGroupMO.heroUid == assistMO.heroUid then
				table.insert(newMOList, assistMO:getHeroMO())
			else
				table.insert(newMOList, HeroModel.instance:getById(heroSingleGroupMO.heroUid))
			end

			if self.specialHero == heroSingleGroupMO.heroUid then
				self._inTeamHeroUids[heroSingleGroupMO.heroUid] = 2
				selectIndex = index
			else
				self._inTeamHeroUids[heroSingleGroupMO.heroUid] = 1
				index = index + 1
			end

			repeatHero[heroSingleGroupMO.heroUid] = true
		end
	end

	local trialList = HeroGroupTrialModel.instance:getFilterList()

	for i, heroMo in ipairs(trialList) do
		if not repeatHero[heroMo.uid] then
			table.insert(newMOList, heroMo)
		end
	end

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] then
			repeatHero[mo.uid] = true

			table.insert(newMOList, mo)
		end
	end

	self.sortIndexMap = {}

	for i, v in ipairs(newMOList) do
		self.sortIndexMap[v] = i
	end

	table.sort(newMOList, Rouge2_HeroGroupEditListModel.indexMapSortFunc)
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

function Rouge2_HeroGroupEditListModel.indexMapSortFunc(a, b)
	local aIndex = Rouge2_HeroGroupEditListModel.instance.sortIndexMap[a]
	local bIndex = Rouge2_HeroGroupEditListModel.instance.sortIndexMap[b]

	return aIndex < bIndex
end

function Rouge2_HeroGroupEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function Rouge2_HeroGroupEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUids and self._inTeamHeroUids[uid]
end

function Rouge2_HeroGroupEditListModel:isRepeatHero(heroId, uid)
	if not self._inTeamHeroUids then
		return false
	end

	for inTeamUid in pairs(self._inTeamHeroUids) do
		local mo = self:getById(inTeamUid)

		if mo and mo.heroId == heroId and uid ~= mo.uid then
			return true
		end
	end

	return false
end

function Rouge2_HeroGroupEditListModel:isTrialLimit()
	if not self._inTeamHeroUids then
		return false
	end

	local curNum = 0

	for inTeamUid in pairs(self._inTeamHeroUids) do
		local mo = self:getById(inTeamUid)

		if mo:isTrial() then
			curNum = curNum + 1
		end
	end

	local roleNum = self.episodeCo and self.episodeCo.roleNum or ModuleEnum.MaxHeroCountInGroup

	return roleNum <= curNum
end

function Rouge2_HeroGroupEditListModel:setParam(heroUid)
	self.specialHero = heroUid
end

Rouge2_HeroGroupEditListModel.instance = Rouge2_HeroGroupEditListModel.New()

return Rouge2_HeroGroupEditListModel
