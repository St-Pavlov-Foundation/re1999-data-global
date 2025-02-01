module("modules.logic.critter.model.info.CritterAttributeInfoMO", package.seeall)

slot0 = pureTable("CritterAttributeInfoMO")
slot1 = {}

function slot0.init(slot0, slot1)
	slot1 = slot1 or uv0
	slot0.attributeId = slot1.attributeId or 0
	slot0.value = slot1.value and math.floor(slot1.value / 10000) or 0
	slot0.rate = slot1.rate or 0
	slot0._addRate = slot1.addRate or 0
end

function slot0.setAttr(slot0, slot1, slot2)
	slot0.attributeId = slot1
	slot0.value = slot2
end

function slot0.getConfig(slot0)
	return CritterConfig.instance:getCritterAttributeCfg(slot0.attributeId)
end

function slot0.getName(slot0)
	return slot0:getConfig().name
end

function slot0.getIcon(slot0)
	return slot0:getConfig().icon
end

function slot0.getValueNum(slot0)
	return slot0.value
end

function slot0.getAdditionRate(slot0)
	return slot0._addRate
end

function slot0.getIsAddition(slot0)
	return slot0._addRate and slot0._addRate ~= 0
end

function slot0.getRate(slot0)
	if slot0.rate then
		return math.floor(slot0.rate * 0.01) * 0.01
	end
end

function slot0.getRateStr(slot0)
	if slot0:getRate() then
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("critter_attr_rate"), slot1)
	end

	return ""
end

function slot0.getaddRateStr(slot0)
	if slot0:getIsAddition() then
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_critter_Attribute_Addition"), math.floor(slot0._addRate * 0.01))
	end

	return ""
end

return slot0
