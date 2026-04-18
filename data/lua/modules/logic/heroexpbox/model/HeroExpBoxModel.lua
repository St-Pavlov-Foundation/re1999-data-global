-- chunkname: @modules/logic/heroexpbox/model/HeroExpBoxModel.lua

module("modules.logic.heroexpbox.model.HeroExpBoxModel", package.seeall)

local HeroExpBoxModel = class("HeroExpBoxModel", BaseModel)
local MaterialType = MaterialEnum.MaterialType.Item

function HeroExpBoxModel:onInit()
	self:reInit()
end

function HeroExpBoxModel:reInit()
	self._boxEffectList = {}
	self._selectHeroId = nil
end

function HeroExpBoxModel:_initBox(itemId)
	if not self._boxEffectList then
		self._boxEffectList = {}
	end

	self._boxEffectList[itemId] = {}

	local co = ItemModel.instance:getItemConfig(MaterialType, itemId)

	if not co then
		return
	end

	local item = {}

	item.co = co

	local effect = co.effect

	if string.nilorempty(effect) then
		return
	end

	local split = string.split(effect, "|")

	if split[1] then
		item.needKeyCount = tonumber(split[1])
	end

	if split[2] then
		item.overflowCurrency = string.splitToNumber(split[2], "#")
	end

	if split[3] then
		item.heroMoList = {}

		local heroIdList = string.splitToNumber(split[3], "#")

		for _, hero in ipairs(heroIdList) do
			local mo = HeroExpBoxMO.New(hero)

			table.insert(item.heroMoList, mo)
		end
	end

	self._boxEffectList[itemId] = item
end

function HeroExpBoxModel:getBoxEffect(itemId)
	if not self._boxEffectList then
		self._boxEffectList = {}
	end

	if not self._boxEffectList[itemId] then
		self:_initBox(itemId)
	end

	return self._boxEffectList[itemId]
end

function HeroExpBoxModel:getBoxEffectIncludeItems(itemId)
	local heroList = self:getBoxHeroMoList(itemId)
	local itemList = {}

	for _, heroMo in ipairs(heroList) do
		local heroCo = HeroConfig.instance:getHeroCO(heroMo.heroId)
		local duplicateItem = GameUtil.splitString2(heroCo.duplicateItem, true, "|", "#")
		local item = duplicateItem[1]

		table.insert(itemList, item)
	end

	return itemList
end

function HeroExpBoxModel:getBoxHeroMoList(itemId)
	local effect = self:getBoxEffect(itemId)

	return effect and effect.heroMoList or {}
end

function HeroExpBoxModel:setSelectHeroId(heroId)
	self._selectHeroId = heroId
end

function HeroExpBoxModel:getSelectHeroId()
	return self._selectHeroId
end

function HeroExpBoxModel:getBoxCount()
	local quantity = 0

	for _, id in ipairs(HeroExpBoxEnum.BoxIds) do
		quantity = quantity + ItemModel.instance:getItemQuantity(MaterialType, id)
	end

	return quantity
end

function HeroExpBoxModel:getKeyCo()
	local co = ItemModel.instance:getItemConfig(MaterialType, HeroExpBoxEnum.KeyIds[1])

	return co
end

function HeroExpBoxModel:getKeyIcon()
	local co = self:getKeyCo()

	return co.icon
end

function HeroExpBoxModel:getKeyName()
	local co = self:getKeyCo()

	return co.name
end

function HeroExpBoxModel:getKeyCount()
	local quantity = 0

	for _, id in ipairs(HeroExpBoxEnum.KeyIds) do
		quantity = quantity + ItemModel.instance:getItemQuantity(MaterialType, id)
	end

	return quantity
end

function HeroExpBoxModel:getNeedKeyCount(itemId)
	local effect = self:getBoxEffect(itemId)

	return effect.needKeyCount
end

function HeroExpBoxModel:hasExpBoxItem()
	for _, type in ipairs(HeroExpBoxEnum.ItemSubType) do
		local list = ItemModel.instance:getItemsBySubType(type)

		if #list > 0 then
			return true
		end
	end
end

HeroExpBoxModel.instance = HeroExpBoxModel.New()

return HeroExpBoxModel
