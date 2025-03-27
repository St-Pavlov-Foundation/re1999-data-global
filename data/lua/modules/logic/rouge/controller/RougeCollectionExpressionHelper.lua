module("modules.logic.rouge.controller.RougeCollectionExpressionHelper", package.seeall)

slot0 = _M

setmetatable({
	hasAttrMuchZero = false,
	min = math.min,
	max = math.max,
	attrMap = {}
}, {
	__index = function (slot0, slot1)
		if not (slot0.attrMap and slot0.attrMap[slot1]) then
			logError(string.format("尝试解析造物描述失败!!! 失败原因: 无法匹配属性Flag:%s", slot1))
		end

		if (slot2 or 0) > 0 then
			slot0.hasAttrMuchZero = true
		end

		return slot2
	end
})

function slot0.getCollectionAttrMap(slot0, slot1, slot2)
	if slot0 then
		return uv0._buildCollectionAttrMap2(RougeCollectionModel.instance:getCollectionByUid(slot0))
	else
		return uv0._buildCollectionAttrMap(slot1, slot2)
	end
end

function slot0._buildCollectionAttrMap(slot0, slot1)
	return uv0._computeAttrValue(slot1, RougeCollectionConfig.instance:getCollectionStaticAttrValueMap(slot0))
end

function slot0._buildCollectionAttrMap2(slot0)
	if not slot0 then
		return
	end

	slot1 = slot0:getAttrValueMap()

	if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(slot0.id) then
		return slot1
	end

	slot3 = uv0._buildCollectionAttrMap(slot0.cfgId, slot0:getAllEnchantCfgId())

	if slot1 then
		for slot7, slot8 in pairs(slot1) do
			slot3[slot7] = (slot3[slot7] or 0) + slot8
		end
	end

	return slot3
end

function slot0._computeAttrValue(slot0, slot1)
	slot2 = {}

	if slot0 and slot1 then
		for slot6, slot7 in ipairs(slot0) do
			if slot7 > 0 and slot1[slot7] then
				for slot11, slot12 in pairs(slot1[slot7]) do
					slot14 = RougeCollectionConfig.instance:getCollectionAttrByFlag(slot11) and slot13.id or 0
					slot2[slot14] = slot2[slot14] or 0
					slot2[slot14] = slot2[slot14] + slot12
				end
			end
		end
	end

	return slot2
end

slot3 = "#CCFF99"

function slot0.getDescExpressionResult(slot0, slot1)
	if string.nilorempty(slot0) or not slot1 then
		return slot0
	end

	return string.gsub(slot0, "%b{}", function (slot0)
		return uv0._loadAndExecuteExpressionFunc(slot0, uv1)
	end)
end

function slot0._loadAndExecuteExpressionFunc(slot0, slot1)
	slot2 = uv0._loadExpressionFunc(string.gsub(string.gsub(slot0, "{", ""), "}", ""))

	setfenv(slot2, uv0._buildGsubExperisonEnv(slot1))

	slot4, slot5 = slot2()

	if slot5 then
		slot4 = string.format("<%s>%s</color>", uv1, slot4)
	end

	return slot4
end

function slot0._loadExpressionFunc(slot0)
	if not loadstring(string.format("return %s, hasAttrMuchZero", string.lower(slot0))) then
		logError("肉鸽造物描述表达式解析失败: 文本内容:" .. tostring(slot0))

		return slot0
	end

	return slot2
end

function slot0._buildGsubExperisonEnv(slot0)
	slot1 = uv0
	slot1.hasAttrMuchZero = false
	slot1.attrMap = uv1._buildAttrNameAndValueMap(slot0)

	return slot1
end

function slot0._buildAttrNameAndValueMap(slot0)
	slot2 = {}

	if RougeCollectionConfig.instance:getAllCollectionAttrMap() then
		for slot6, slot7 in pairs(slot1) do
			slot2[slot7.flag] = slot0[slot6] or 0
		end
	end

	return slot2
end

return slot0
