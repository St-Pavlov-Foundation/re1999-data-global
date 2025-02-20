module("modules.logic.season.view1_3.Season1_3SettlementHeroItem", package.seeall)

slot0 = class("Season1_3SettlementHeroItem", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._gohero = gohelper.findChild(slot0.viewGO, "#go_hero")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_hero/#simage_heroicon")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "#go_hero/#image_career")
	slot0._gocard1 = gohelper.findChild(slot0.viewGO, "#go_hero/layout/#go_cards/#go_card1")
	slot0._gocard2 = gohelper.findChild(slot0.viewGO, "#go_hero/layout/#go_cards/#go_card2")
	slot0._gosingle = gohelper.findChild(slot0.viewGO, "#go_hero/layout/#go_cards/#go_single")
	slot0._goequip = gohelper.findChild(slot0.viewGO, "#go_hero/layout/#go_equip")
	slot0._imageequipicon = gohelper.findChildImage(slot0.viewGO, "#go_hero/layout/#go_equip/#image_equipicon")
	slot0._imageequiprare = gohelper.findChildImage(slot0.viewGO, "#go_hero/layout/#go_equip/#image_equiprare")
	slot0._gocards = gohelper.findChild(slot0.viewGO, "#go_hero/layout/#go_cards")
	slot0._equipPart = gohelper.findChild(slot0.viewGO, "#go_hero/layout")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onRefreshViewParam(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._is_replay = slot1
	slot0._hero = slot2
	slot0._equip = slot3
	slot0._equip_104 = slot4
	slot0._replay_data = slot5
	slot0._trail = slot6
end

function slot0.onOpen(slot0)
	slot0:setViewVisibleInternal(false)

	if slot0._is_replay then
		slot0:_showReplayData()
	else
		slot0:_showNormalData()
	end

	if slot0._no104Equip and slot0._noEquip then
		gohelper.setActive(slot0._equipPart, false)
	end

	gohelper.setActive(slot0._gocards, not slot0._no104Equip)
end

function slot0._showNormalData(slot0)
	if slot0._trail then
		slot0:_showTrailHeroIcon(slot0._trail)
	else
		slot0:_showHeroIcon(slot0._hero)
	end

	slot1 = slot0._equip and EquipModel.instance:getEquip(slot0._equip[1])

	slot0:_showEquipIcon(slot1 and slot1.equipId)

	if slot0._equip_104 then
		slot3 = Activity104Model.instance:getAllItemMo()
		slot4 = {}

		for slot8, slot9 in ipairs(slot0._equip_104) do
			if slot3[slot9] then
				table.insert(slot4, slot3[slot9].uid)
			end
		end

		slot0._no104Equip = #slot4 == 0

		for slot9, slot10 in ipairs(slot4) do
			slot0:_showEquip104(slot9, slot10, slot5)
		end
	end
end

function slot0._showTrailHeroIcon(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = lua_hero_trial.configDict[slot1.trialId][0]
	slot3 = HeroConfig.instance:getHeroCO(slot2.heroId)
	slot4 = nil
	slot5 = slot3.career

	if (slot2.skin <= 0 or SkinConfig.instance:getSkinCo(slot2.skin)) and SkinConfig.instance:getSkinCo(slot3.skinId) then
		slot0._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(slot4.retangleIcon))
	else
		gohelper.setActive(slot0.viewGO.transform.parent.gameObject, false)
	end

	if slot5 then
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot5))
	end
end

function slot0._showHeroIcon(slot0, slot1, slot2)
	slot4 = nil

	if HeroModel.instance:getById(slot1) then
		slot2 = slot2 or slot3.skin
		slot4 = slot3.config.career
	elseif FightDataHelper.entityMgr:getById(slot1) and lua_monster.configDict[slot5.modelId] then
		slot2 = slot2 or slot6.skinId
		slot4 = slot6.career
	end

	if slot2 then
		if FightConfig.instance:getSkinCO(slot2) then
			slot0._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(slot5.retangleIcon))
		end
	else
		gohelper.setActive(slot0.viewGO.transform.parent.gameObject, false)
	end

	if slot4 then
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot4))
	end
end

function slot0._showEquipIcon(slot0, slot1)
	if slot1 and slot1 ~= 0 then
		slot2 = EquipConfig.instance:getEquipCo(slot1)

		UISpriteSetMgr.instance:setHerogroupEquipIconSprite(slot0._imageequipicon, slot2.icon)
		UISpriteSetMgr.instance:setHeroGroupSprite(slot0._imageequiprare, "bianduixingxian_" .. slot2.rare)
	else
		gohelper.setActive(slot0._goequip, false)

		slot0._noEquip = true
	end
end

function slot0._showEquip104(slot0, slot1, slot2, slot3, slot4)
	if slot4 == 0 then
		return
	end

	slot0:openSubView(Season1_3CelebrityCardGetItem, Season1_3CelebrityCardItem.AssetPath, slot3 <= 1 and slot0._gosingle or slot0["_gocard" .. slot1], slot2, nil, slot4)
end

function slot0._showReplayData(slot0)
	slot0:_showHeroIcon(slot0._hero, slot0._replay_data and slot0._replay_data.skin)
	slot0:_showEquipIcon(slot0._equip and slot0._equip.equipId)

	if slot1 ~= "0" and slot1 ~= "-100000" and slot0._equip_104 then
		slot0._no104Equip = #slot0._equip_104 == 0

		for slot6 = 1, slot2 do
			slot0:_showEquip104(slot6, slot0._equip_104[slot6].equipUid, slot2, slot0._equip_104[slot6].equipId)
		end
	end
end

slot1 = {}

function slot0._refreshEquipPos(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageheroicon:UnLoadImage()
end

return slot0
