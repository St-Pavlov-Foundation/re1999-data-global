module("modules.logic.rouge.controller.RougeSettlementTriggerHelper", package.seeall)

slot0 = class("RougeSettlementTriggerHelper")

function slot0.isResultTrigger(slot0, ...)
	if not uv0["triggerType" .. slot0] then
		logError("未处理当前触发类型, 触发类型 = " .. tostring(slot0))

		return
	end

	return slot1(...)
end

function slot0.triggerType1(slot0)
	slot2 = RougeModel.instance:getRougeResult() and slot1.reviewInfo

	if (slot2 and slot2.collectionNum or 0) >= (slot0 or 0) then
		slot4 = RougeCollectionModel.instance:getCollectionRareMap()
		slot6 = {}

		if lua_rouge_quality.configList then
			for slot10, slot11 in ipairs(slot5) do
				table.insert(slot6, slot4[slot11.id] and tabletool.len(slot4[slot13]) or 0)
				table.insert(slot6, slot11.name)
			end
		end

		return unpack(slot6)
	end
end

function slot0.triggerType2(slot0)
	slot2 = {}

	if RougeCollectionModel.instance:getAllCollections() then
		for slot6, slot7 in ipairs(slot1) do
			uv0.computeTagCount(slot7, slot2)
		end
	end

	slot3 = 0
	slot4 = -10000

	for slot8, slot9 in pairs(slot2) do
		if slot4 < slot9 then
			slot3 = slot8
			slot9 = slot4
		end
	end

	if slot0 <= slot4 then
		return slot4, lua_rouge_tag.configDict[slot3] and slot5.name
	end
end

function slot0.computeTagCount(slot0, slot1)
	if not slot0 then
		return 0
	end

	uv0.computeTypeTagCount(slot0.cfgId, slot1)

	if slot0:getAllEnchantCfgId() then
		for slot6, slot7 in pairs(slot2) do
			if slot7 and slot7 > 0 then
				uv0.computeTypeTagCount(slot7, slot1)
			end
		end
	end
end

function slot0.computeTypeTagCount(slot0, slot1)
	if RougeCollectionConfig.instance:getCollectionCfg(slot0) and slot2.tags then
		for slot7, slot8 in pairs(slot3) do
			slot1[slot8] = (slot1[slot8] or 0) + 1
		end
	end
end

function slot0.triggerType3(slot0)
	slot2 = RougeModel.instance:getRougeResult() and slot1.compositeCount or 0
	slot4 = {}

	if slot1:getCompositeCollectionIdAndCount() then
		for slot8, slot9 in ipairs(slot3) do
			table.insert(slot4, RougeCollectionConfig.instance:getCollectionCfg(slot9[1]) and slot11.name)
		end
	end

	if slot0 <= slot2 then
		return table.concat(slot4, luaLang("room_levelup_init_and1"))
	end
end

function slot0.triggerType4(slot0)
	slot2 = 0

	if RougeCollectionModel.instance:getSlotAreaCollection() then
		for slot6, slot7 in pairs(slot1) do
			if slot7:getEnchantCount() and slot8 > 0 then
				slot2 = slot2 + 1
			end
		end
	end

	if slot0 <= slot2 then
		return slot2
	end
end

function slot0.triggerType5(slot0)
	slot2 = 0

	if RougeModel.instance:getRougeResult() then
		slot2 = slot1:getTotalFightCount()
	end

	if slot0 <= slot2 then
		return slot2
	end
end

function slot0.triggerType6(slot0)
	if slot0 <= (RougeModel.instance:getRougeResult() and slot1.costPower or 0) then
		return slot2
	end
end

function slot0.triggerType7(slot0)
	if slot0 <= (RougeModel.instance:getRougeResult() and slot1.maxDamage or 0) then
		return slot2
	end
end

function slot0.triggerType8(slot0)
	slot2 = false

	if RougeModel.instance:getRougeResult() then
		slot2 = slot1:isEventFinish(slot0)
	end

	if slot2 then
		return RougeMapConfig.instance:getRougeEvent(slot0) and slot3.name
	end
end

function slot0.triggerType9(slot0)
	slot2 = false

	if RougeModel.instance:getRougeResult() then
		slot2 = slot1:isEntrustFinish(slot0)
	end

	if slot2 then
		return slot0
	end
end

function slot0.triggerType10(slot0)
	if slot0 <= (RougeModel.instance:getRougeResult() and slot1.consumeCoin or 0) then
		return slot2
	end
end

function slot0.triggerType11(slot0)
	if slot0 <= (RougeModel.instance:getRougeResult() and slot1.displaceNum or 0) then
		return slot2
	end
end

function slot0.triggerType12(slot0)
	if slot0 <= (RougeModel.instance:getRougeResult() and slot1.repairShopNum or 0) then
		return slot2
	end
end

function slot0.triggerType13(slot0)
	slot2 = RougeModel.instance:getRougeResult() and slot1.reviewInfo

	if (slot2 and slot2.endId) == slot0 then
		return slot3
	end
end

function slot0.triggerType14(slot0)
	slot1 = RougeMapModel.instance:getEndId()

	if not RougeModel.instance:getRougeResult():isSucceed() and slot1 == slot0 then
		return slot1
	end
end

function slot0.triggerType15()
	if RougeModel.instance:isAbortRouge() then
		return
	end

	slot2 = RougeMapModel.instance:getEndId()
	slot4 = not RougeModel.instance:getRougeResult():isSucceed() and (not slot2 or slot2 <= 0)

	if not RougeMapModel.instance:getCurEvent() then
		return
	end

	if slot4 then
		return slot5.name
	end
end

function slot0.triggerType16()
	if RougeModel.instance:isAbortRouge() then
		return "abort"
	end
end

function slot0.triggerType17()
	return lua_rouge_difficulty.configDict[RougeModel.instance:getRougeResult() and slot1.season][RougeModel.instance:getRougeInfo().difficulty] and slot3.title, RougeController.instance:getStyleConfig() and slot5.name, uv0.getAllInitHeroNames(slot1.initHeroId)
end

function slot0.getAllInitHeroNames(slot0)
	slot1 = {}

	if slot0 then
		for slot5, slot6 in ipairs(slot0) do
			if HeroConfig.instance:getHeroCO(slot6) and slot7.name then
				table.insert(slot1, slot8)
			end
		end
	end

	return table.concat(slot1, luaLang("room_levelup_init_and1"))
end

function slot0.triggerType18()
	slot1 = RougeModel.instance:getRougeResult() and slot0.reviewInfo
	slot2 = slot1 and slot1:getTeamInfo()

	return slot2 and slot2:getAllHeroCount() or 0, RougeModel.instance:getRougeInfo() and slot4.teamSize or 0
end

function slot0.triggerType19()
	slot1 = RougeModel.instance:getRougeResult() and slot0.reviewInfo

	return slot0 and slot0.stepNum, slot1 and slot1.gainCoin or 0
end

function slot0.triggerType20()
	slot2 = slot0 and slot0.teamLevel or 0

	return uv0._getTotalTeamExp(slot0.season, slot2, RougeModel.instance:getRougeInfo() and slot0.teamExp or 0), slot2
end

function slot0._getTotalTeamExp(slot0, slot1, slot2)
	if not slot0 then
		return 0
	end

	slot2 = slot2 or 0
	slot3 = lua_rouge_level.configDict[slot0]

	for slot8 = 1, slot1 or 0 do
		slot9 = slot3 and slot3[slot8]
		slot4 = 0 + (slot9 and slot9.exp or 0)
	end

	return slot4 + slot2
end

return slot0
