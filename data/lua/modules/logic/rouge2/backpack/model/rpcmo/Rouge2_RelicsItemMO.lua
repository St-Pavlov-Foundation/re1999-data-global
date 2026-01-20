-- chunkname: @modules/logic/rouge2/backpack/model/rpcmo/Rouge2_RelicsItemMO.lua

module("modules.logic.rouge2.backpack.model.rpcmo.Rouge2_RelicsItemMO", package.seeall)

local Rouge2_RelicsItemMO = pureTable("Rouge2_RelicsItemMO")

function Rouge2_RelicsItemMO:init(info)
	self._attrMap = GameUtil.rpcInfosToMap(info.attrs, Rouge2_RelicsAttrMO, "_attrId")

	self:initEffects(info.effects)
end

function Rouge2_RelicsItemMO:initEffects(effects)
	self._effectMap = {}

	for _, effectId in ipairs(effects) do
		self._effectMap[effectId] = true
	end
end

function Rouge2_RelicsItemMO:getAttrMap()
	return self._attrMap
end

function Rouge2_RelicsItemMO:getAttrValue(attrId)
	local attrMo = self._attrMap and self._attrMap[attrId]

	return attrMo and attrMo:getValue() or 0
end

function Rouge2_RelicsItemMO:isTriggerEffect(effectId)
	return true
end

return Rouge2_RelicsItemMO
