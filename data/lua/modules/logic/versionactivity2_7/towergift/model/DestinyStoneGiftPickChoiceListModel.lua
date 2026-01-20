-- chunkname: @modules/logic/versionactivity2_7/towergift/model/DestinyStoneGiftPickChoiceListModel.lua

module("modules.logic.versionactivity2_7.towergift.model.DestinyStoneGiftPickChoiceListModel", package.seeall)

local DestinyStoneGiftPickChoiceListModel = class("DestinyStoneGiftPickChoiceListModel", ListScrollModel)

local function sortFunc(a, b)
	local aAestinyStoneMo = a.heroMo.destinyStoneMo
	local bAestinyStoneMo = b.heroMo.destinyStoneMo
	local aUnlockSlot = aAestinyStoneMo:isUnlockSlot() and 1 or 2
	local bUnlockSlot = bAestinyStoneMo:isUnlockSlot() and 1 or 2

	if aUnlockSlot ~= bUnlockSlot then
		return bUnlockSlot < aUnlockSlot
	end

	local aRank = aAestinyStoneMo.rank
	local bRank = bAestinyStoneMo.rank

	if aRank ~= bRank then
		return aRank < bRank
	end

	return a.heroId > b.heroId
end

function DestinyStoneGiftPickChoiceListModel:initList(ignoreIds)
	self._moList = {}

	local heroList = HeroModel.instance:getAllHero()

	for index, heroMo in pairs(heroList) do
		if heroMo and self:checkHeroOpenDestinyStone(heroMo) then
			local destinyStoneMo = heroMo.destinyStoneMo
			local list = destinyStoneMo:getStoneMoList()
			local isSlotMaxLevel = destinyStoneMo:isSlotMaxLevel()

			if isSlotMaxLevel then
				for _, stoneMo in pairs(list) do
					local isIgnore = LuaUtil.tableContains(ignoreIds, stoneMo.stoneId)

					if not stoneMo.isUnlock and not isIgnore then
						local mo = {}

						mo.heroMo = heroMo
						mo.heroId = heroMo.config.id
						mo.stoneMo = stoneMo
						mo.stoneId = stoneMo.stoneId
						mo.isUnLock = false

						table.insert(self._moList, mo)
					end
				end
			else
				for _, stoneMo in pairs(list) do
					local isIgnore = LuaUtil.tableContains(ignoreIds, stoneMo.stoneId)

					if not isIgnore then
						local mo = {}

						mo.isUnLock = stoneMo.isUnlock

						if mo.isUnLock then
							mo.stonelevel = destinyStoneMo.rank
						end

						mo.heroMo = heroMo
						mo.heroId = heroMo.config.id
						mo.stoneMo = stoneMo
						mo.stoneId = stoneMo.stoneId

						table.insert(self._moList, mo)
					end
				end
			end
		end
	end

	table.sort(self._moList, sortFunc)
	self:setList(self._moList)
end

function DestinyStoneGiftPickChoiceListModel:checkHeroOpenDestinyStone(heroMo)
	if not heroMo:isHasDestinySystem() then
		return false
	end

	local rare = heroMo.config.rare or 5
	local constId = CharacterDestinyEnum.DestinyStoneOpenLevelConstId[rare]
	local openLevel = CommonConfig.instance:getConstStr(constId)

	if heroMo.level >= tonumber(openLevel) and not heroMo.destinyStoneMo:checkAllUnlock() then
		return true
	end

	return false
end

function DestinyStoneGiftPickChoiceListModel:setCurrentSelectMo(mo)
	if not self.currentSelectMo then
		self.currentSelectMo = mo
	elseif self:isSelectedMo(mo.stoneId) then
		self:clearSelect()
	else
		self.currentSelectMo = mo
	end

	DestinyStoneGiftPickChoiceController.instance:dispatchEvent(DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged)
end

function DestinyStoneGiftPickChoiceListModel:getCurrentSelectMo()
	return self.currentSelectMo
end

function DestinyStoneGiftPickChoiceListModel:clearSelect()
	self.currentSelectMo = nil
end

function DestinyStoneGiftPickChoiceListModel:isSelectedMo(stoneId)
	return self.currentSelectMo and self.currentSelectMo.stoneId == stoneId
end

DestinyStoneGiftPickChoiceListModel.instance = DestinyStoneGiftPickChoiceListModel.New()

return DestinyStoneGiftPickChoiceListModel
