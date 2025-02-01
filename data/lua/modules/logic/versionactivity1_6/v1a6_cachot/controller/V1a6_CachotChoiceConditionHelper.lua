module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotChoiceConditionHelper", package.seeall)

slot0 = class("V1a6_CachotChoiceConditionHelper")

function slot0.getConditionToast(slot0, ...)
	if not uv0["conditionType" .. slot0] then
		logError("未处理当前条件类型")

		return
	end

	return slot1(...)
end

function slot0.conditionType1(slot0)
	slot2 = V1a6_CachotModel.instance:getRogueInfo() and slot1.collectionCfgMap
	slot3 = slot1 and slot1.collectionBaseMap
	slot4 = slot2 and slot2[slot0]
	slot5 = slot3 and slot3[slot0]

	if not (slot4 and #slot4 > 0) and not (slot5 and #slot5 > 0) then
		return ToastEnum.V1a6CachotToast07, lua_rogue_collection.configDict[slot0].name
	end
end

function slot0.conditionType2(slot0, slot1)
	if V1a6_CachotModel.instance:getRogueInfo().heart < slot0 or slot1 < slot2 then
		return ToastEnum.V1a6CachotToast08, slot0, slot1
	end
end

function slot0.conditionType3(slot0)
	if V1a6_CachotModel.instance:getRogueInfo().coin < slot0 then
		return ToastEnum.V1a6CachotToast24, slot0
	end
end

function slot0.conditionType4(slot0)
	slot2 = V1a6_CachotModel.instance:getRogueInfo() and slot1.collections

	if slot0 > (slot2 and #slot2 or 0) then
		return ToastEnum.V1a6CachotToast14, slot0
	end
end

function slot0.conditionType5(slot0)
	slot2 = V1a6_CachotModel.instance:getRogueInfo() and slot1.collections

	if slot0 < (slot2 and #slot2 or 0) then
		return ToastEnum.V1a6CachotToast15, slot0
	end
end

function slot0.conditionType6(slot0, slot1)
	if uv0.getMatchCollectionNumInBag(slot1) < slot0 then
		return ToastEnum.V1a6CachotToast16, slot0, lua_rogue_collection_group.configDict[slot1] and slot2.dropGroupType or ""
	end
end

function slot0.conditionType7(slot0, slot1)
	if slot0 < uv0.getMatchCollectionNumInBag(slot1) then
		return ToastEnum.V1a6CachotToast17, slot0, lua_rogue_collection_group.configDict[slot1] and slot2.dropGroupType or ""
	end
end

function slot0.getMatchCollectionNumInBag(slot0)
	slot1 = 0

	if slot0 and slot0 ~= 0 then
		if V1a6_CachotCollectionConfig.instance:getCollectionsByGroupId(slot0) and (V1a6_CachotModel.instance:getRogueInfo() and slot2.collectionCfgMap) then
			for slot8, slot9 in pairs(slot4) do
				slot1 = slot1 + (slot3[slot9.id] and #slot10 or 0)
			end
		end
	end

	return slot1
end

function slot0.conditionType8(slot0)
	if not V1a6_CachotModel.instance:getTeamInfo() then
		return
	end

	for slot5, slot6 in ipairs(slot1.lifes) do
		if slot0 < slot6.lifePercent then
			return ToastEnum.V1a6CachotToast18, slot0
		end
	end
end

function slot0.conditionType9(slot0)
	if not V1a6_CachotModel.instance:getTeamInfo() then
		return
	end

	for slot5, slot6 in ipairs(slot1.lifes) do
		if slot6.lifePercent < slot0 then
			return ToastEnum.V1a6CachotToast19, slot0
		end
	end
end

function slot0.conditionType10(slot0)
	if not V1a6_CachotModel.instance:getTeamInfo() then
		return
	end

	for slot5, slot6 in ipairs(slot1.lifes) do
		if slot6.lifePercent <= slot0 then
			return ToastEnum.V1a6CachotToast20, slot0
		end
	end
end

function slot0.conditionType11(slot0)
	if not V1a6_CachotModel.instance:getTeamInfo() then
		return
	end

	for slot5, slot6 in ipairs(slot1.lifes) do
		if slot0 <= slot6.lifePercent then
			return ToastEnum.V1a6CachotToast21, slot0
		end
	end
end

function slot0.conditionType12(slot0)
	if V1a6_CachotModel.instance:getRogueInfo().heart < slot0 then
		return ToastEnum.V1a6CachotToast22, slot0
	end
end

function slot0.conditionType13(slot0)
	if slot0 < V1a6_CachotModel.instance:getRogueInfo().heart then
		return ToastEnum.V1a6CachotToast23, slot0
	end
end

return slot0
