-- chunkname: @modules/logic/rouge2/common/model/Rouge2_AttrGroupMO.lua

module("modules.logic.rouge2.common.model.Rouge2_AttrGroupMO", package.seeall)

local Rouge2_AttrGroupMO = pureTable("Rouge2_AttrGroupMO")

function Rouge2_AttrGroupMO:init(info)
	self:initAttrInfoList(info.attr)
end

function Rouge2_AttrGroupMO:initAttrInfoList(info)
	self._attrInfoList = {}
	self._attrInfoMap = {}
	self._type2AttrInfoMap = {}

	if not GameSceneMgr.instance:isFightScene() then
		self._updateAttrMap = {}
	end

	for _, attrInfo in ipairs(info) do
		self:updateAttrInfo(attrInfo)
	end
end

function Rouge2_AttrGroupMO:updateAttrInfoList(updates)
	for _, updateAttrInfo in ipairs(updates) do
		self:updateAttrInfo(updateAttrInfo)
	end
end

function Rouge2_AttrGroupMO:updateAttrInfo(attrInfo)
	self._updateAttrMap = self._updateAttrMap or {}

	local attrId = attrInfo.attrId
	local attrMo = self._attrInfoMap[attrId]
	local create = attrMo == nil
	local originValue = 0

	if not attrMo then
		attrMo = Rouge2_AttrMO.New()
		self._attrInfoMap[attrId] = attrMo

		table.insert(self._attrInfoList, attrMo)
	else
		originValue = attrMo:getValue()
	end

	attrMo:init(attrInfo)

	if create then
		local type = attrMo.config.type

		self._type2AttrInfoMap[type] = self._type2AttrInfoMap[type] or {}

		table.insert(self._type2AttrInfoMap[type], attrMo)
	else
		local curAttrValue = attrMo:getValue()
		local updateAttrValue = curAttrValue - originValue

		self._updateAttrMap[attrId] = self._updateAttrMap[attrId] or 0
		self._updateAttrMap[attrId] = self._updateAttrMap[attrId] + updateAttrValue
	end
end

function Rouge2_AttrGroupMO:getAttrInfoList(attrType)
	return self._type2AttrInfoMap and self._type2AttrInfoMap[attrType]
end

function Rouge2_AttrGroupMO:getAttrInfo(attrId)
	return self._attrInfoMap and self._attrInfoMap[attrId]
end

function Rouge2_AttrGroupMO:getAttrValue(attrId)
	local attrMo = self:getAttrInfo(attrId)

	return attrMo and attrMo.value
end

function Rouge2_AttrGroupMO:getUpdateAttrMap()
	return self._updateAttrMap
end

function Rouge2_AttrGroupMO:clearUpdateAttrMap()
	self._updateAttrMap = {}
end

return Rouge2_AttrGroupMO
