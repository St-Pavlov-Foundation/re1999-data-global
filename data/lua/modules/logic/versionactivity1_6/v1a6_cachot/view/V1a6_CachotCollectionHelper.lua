module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionHelper", package.seeall)

slot0 = class("V1a6_CachotCollectionHelper")

function slot0.refreshSkillDesc(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = V1a6_CachotCollectionConfig.instance:getCollectionSkillsInfo(slot0)
	slot8 = slot6 and #slot6 or 0

	tabletool.addValues(slot6, slot7)

	slot11 = slot5 or uv0

	gohelper.CreateObjList(slot11, slot3 or uv0._refreshSingleSkillDesc, slot6, slot1, slot2, nil, 1, slot8)
	gohelper.CreateObjList(slot11, slot4 or uv0._refreshSingleEffectDesc, slot6, slot1, slot2, nil, slot8 + 1)
end

function slot0.refreshSkillDescWithoutEffectDesc(slot0, slot1, slot2, slot3, slot4)
	gohelper.CreateObjList(slot4 or uv0, slot3 or uv0._refreshSingleSkillDesc, slot5, slot1, slot2, nil, 1, V1a6_CachotCollectionConfig.instance:getCollectionSkillsByConfig(slot0) and #slot5 or 0)
end

function slot0._refreshSingleSkillDesc(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(lua_rule.configDict[slot2] and slot4.desc or "")
end

function slot0._refreshSingleEffectDesc(slot0, slot1, slot2, slot3)
	if SkillConfig.instance:getSkillEffectDescCo(slot2) then
		gohelper.findChildText(slot1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(string.format("[%s]: %s", slot4.name, slot4.desc))
	end
end

function slot0.refreshEnchantDesc(slot0, slot1, slot2, slot3, slot4)
	gohelper.CreateObjList(slot4 or uv0, slot3 or uv0._refreshSingleEnchantDesc, V1a6_CachotCollectionConfig.instance:getCollectionSpDescsByConfig(slot0), slot1, slot2)
end

function slot0._refreshSingleEnchantDesc(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(slot2)
end

function slot0.isCollectionBagCanEnchant()
	slot0 = false
	slot1 = false

	if V1a6_CachotModel.instance:getRogueInfo() then
		slot3 = slot2.collections
		slot6 = slot3 and #slot3 or 0

		if (slot2.enchants and #slot4 or 0) <= 0 or slot6 <= 0 then
			return false
		end

		for slot10 = 1, slot6 do
			slot12, slot1 = uv0.isCollectionHoleEmptyOrUnEnchant(slot3[slot10], slot0, slot1)

			if slot12 and slot1 then
				break
			end
		end
	end

	return slot0 and slot1
end

function slot0.isCollectionHoleEmptyOrUnEnchant(slot0, slot1, slot2)
	if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot0.cfgId).type ~= V1a6_CachotEnum.CollectionType.Enchant and not slot1 then
		slot1 = slot1 or slot0:getEnchantCount() < slot3.holeNum
	elseif slot4 == V1a6_CachotEnum.CollectionType.Enchant then
		slot2 = slot2 or slot2 or not slot0:isEnchant()
	end

	return slot1, slot2
end

function slot0.createCollectionHoles(slot0, slot1, slot2)
	gohelper.CreateNumObjList(slot1, slot2, slot0 and slot0.holeNum or 0)
end

function slot0.refreshCollectionUniqueTip(slot0, slot1, slot2)
	if slot0 and slot0.unique == 1 then
		slot4 = ""

		if slot1 then
			slot1.text = (slot0.showRare ~= V1a6_CachotEnum.CollectionShowRare.Boss or luaLang("v1a6_cachotcollection_bossunique")) and luaLang("p_v1a6_cachot_collectionbagview_txt_uniquetips")
		end
	end

	if slot2 then
		gohelper.setActive(slot2, slot3)
	end
end

return slot0
