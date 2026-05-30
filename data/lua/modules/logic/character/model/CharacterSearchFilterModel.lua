-- chunkname: @modules/logic/character/model/CharacterSearchFilterModel.lua

module("modules.logic.character.model.CharacterSearchFilterModel", package.seeall)

local CharacterSearchFilterModel = class("CharacterSearchFilterModel", BaseModel)

function CharacterSearchFilterModel:onInit()
	self:clearSelectTag()

	self._addLowTags = {}
end

function CharacterSearchFilterModel:reInit()
	self:onInit()
end

function CharacterSearchFilterModel:_initLocalTags()
	self._tagsDict = {}
	self._tagCosDict = {}

	for _, co in ipairs(lua_character_battle_tag.configList) do
		local type = self:getLocalTagTypeByCo(co)

		if type then
			if not self._tagsDict[type] then
				self._tagsDict[type] = {}
			end

			table.insert(self._tagsDict[type], co)
		end

		self._tagCosDict[co.id] = co
	end
end

function CharacterSearchFilterModel:getLocalTagCo(id)
	if not self._tagCosDict then
		self:_initLocalTags()
	end

	return self._tagCosDict[id]
end

function CharacterSearchFilterModel:getTagTypeById(id)
	local co = self:getLocalTagCo(id)

	return self:getLocalTagTypeByCo(co)
end

function CharacterSearchFilterModel:getLocalTagTypeByCo(co)
	return co and co.typeid
end

function CharacterSearchFilterModel:getLocalTags(type)
	if not self._tagsDict then
		self:_initLocalTags()
	end

	return self._tagsDict[type]
end

function CharacterSearchFilterModel:setEditing(isEditing)
	self._isEditing = isEditing

	if not isEditing then
		self._readyAddLowTags = {}
	end
end

function CharacterSearchFilterModel:isEditing()
	return self._isEditing
end

function CharacterSearchFilterModel:selectLocalTag(tagId)
	local type = self:getTagTypeById(tagId)

	type = type == CharacterBackpackEnum.TagId.CharacterFeaturesLow and CharacterBackpackEnum.TagId.CharacterFeaturesHigh or type

	local index = self._selectLocal[type] and tabletool.indexOf(self._selectLocal[type], tagId)
	local isSelect = index ~= nil

	if isSelect then
		table.remove(self._selectLocal[type], index)
	else
		if not self._selectLocal[type] then
			self._selectLocal[type] = {}
		end

		table.insert(self._selectLocal[type], tagId)
	end

	return not isSelect
end

function CharacterSearchFilterModel:isSelectLocalTag(tagId)
	local type = self:getTagTypeById(tagId)

	type = type == CharacterBackpackEnum.TagId.CharacterFeaturesLow and CharacterBackpackEnum.TagId.CharacterFeaturesHigh or type

	local index = self._selectLocal[type] and tabletool.indexOf(self._selectLocal[type], tagId)

	return index ~= nil
end

function CharacterSearchFilterModel:getSelectLocalTags()
	return self._selectLocal
end

function CharacterSearchFilterModel:refreshEditorLowTags(value)
	if not string.nilorempty(value) then
		self._addLowTags = string.split(value, "#")
	end
end

function CharacterSearchFilterModel:addEditorLowTags(tagId, isAdd)
	local index = tabletool.indexOf(self._addLowTags, tagId)

	if isAdd and not index then
		table.insert(self._addLowTags, tagId)
	else
		table.remove(self._addLowTags, index)

		local isSelect = self:isSelectLocalTag(tagId)

		if isSelect then
			self:selectLocalTag(tagId)
		end
	end
end

function CharacterSearchFilterModel:getAddLowTags()
	return self._addLowTags
end

function CharacterSearchFilterModel:cacheReadyAddLowTags(tags)
	self._readyAddLowTags = tags
end

function CharacterSearchFilterModel:getReadyAddLowTags()
	return self._readyAddLowTags
end

function CharacterSearchFilterModel:saveEditorTags()
	local value = ""

	for i, tagId in ipairs(self._addLowTags) do
		if i == 1 then
			value = tagId
		else
			value = value .. "#" .. tagId
		end
	end

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.HeroSearchFilterTags, value)
end

function CharacterSearchFilterModel:setSelectDmgs(dmgs)
	self._selectDmgs = dmgs
end

function CharacterSearchFilterModel:getSelectDmgs()
	return self._selectDmgs or {}
end

function CharacterSearchFilterModel:setSelectAttrs(attrs)
	self._selectAttrs = attrs
end

function CharacterSearchFilterModel:getSelectAttrs()
	return self._selectAttrs or {}
end

function CharacterSearchFilterModel:clearSelectTag()
	self._selectDmgs = {}
	self._selectAttrs = {}
	self._selectLocal = {}

	CharacterModel.instance:clearTagCountDict()
end

function CharacterSearchFilterModel:exitParentView()
	self:clearSelectTag()
	self:setEditing(false)
end

function CharacterSearchFilterModel:onComfirmSearchFilter(dmgs, attrs)
	self._selectDmgs = {}
	self._selectAttrs = {}

	local _dmgs = {}
	local _attrs = {}

	for i, select in pairs(dmgs) do
		if select == true then
			table.insert(_dmgs, i)
			table.insert(self._selectDmgs, i)
		end
	end

	if #_dmgs == 0 then
		for i = 1, CharacterBackpackEnum.dmgItemCount do
			table.insert(_dmgs, i)
		end
	end

	for i, select in pairs(attrs) do
		if select == true then
			table.insert(_attrs, i)
			table.insert(self._selectAttrs, i)
		end
	end

	if #_attrs == 0 then
		for i = 1, CharacterBackpackEnum.attrItemCount do
			table.insert(_attrs, i)
		end
	end

	return _dmgs, _attrs
end

function CharacterSearchFilterModel:hasFilter()
	for _, v in pairs(self._selectDmgs) do
		if v then
			return true
		end
	end

	for _, v in pairs(self._selectAttrs) do
		if v then
			return true
		end
	end

	for _, v in pairs(self._selectLocal) do
		if v then
			return true
		end
	end
end

CharacterSearchFilterModel.instance = CharacterSearchFilterModel.New()

return CharacterSearchFilterModel
