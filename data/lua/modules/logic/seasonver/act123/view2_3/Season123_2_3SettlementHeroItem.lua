module("modules.logic.seasonver.act123.view2_3.Season123_2_3SettlementHeroItem", package.seeall)

slot0 = class("Season123_2_3SettlementHeroItem", BaseViewExtended)

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
	slot0._commonHeroCard = CommonHeroCard.create(slot0._simageheroicon.gameObject, slot0.viewName)

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
	slot0._equip_123 = slot4
	slot0._replay_data = slot5
	slot0._trail = slot6
end

function slot0.onOpen(slot0)
	slot0.actId = Season123Model.instance:getCurSeasonId()

	slot0:setViewVisibleInternal(false)

	if slot0._is_replay then
		slot0:_showReplayData()
	else
		slot0:_showNormalData()
	end

	if slot0._no123Equip and slot0._noEquip then
		gohelper.setActive(slot0._equipPart, false)
	end

	gohelper.setActive(slot0._gocards, not slot0._no123Equip)
end

function slot0._showNormalData(slot0)
	if slot0._trail then
		slot0:_showTrailHeroIcon(slot0._trail)
	else
		slot0:_showHeroIcon(slot0._hero)
	end

	slot1 = slot0._equip and EquipModel.instance:getEquip(slot0._equip[1])

	slot0:_showEquipIcon(slot1 and slot1.equipId)

	if slot0._equip_123 then
		slot3 = Season123Model.instance:getAllItemMo(slot0.actId)
		slot4 = {}

		for slot8, slot9 in ipairs(slot0._equip_123) do
			if slot3[slot9] then
				table.insert(slot4, slot3[slot9].uid)
			end
		end

		slot0._no123Equip = #slot4 == 0

		for slot9, slot10 in ipairs(slot4) do
			slot0:_showEquip123(slot9, slot10, slot5)
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

	if slot4 then
		slot0._commonHeroCard:onUpdateMO(slot4)
	end
end

function slot0._showHeroIcon(slot0, slot1, slot2)
	slot4, slot5 = nil

	if slot0:checkAssist(slot1, HeroModel.instance:getById(slot1)) then
		slot2 = slot2 or slot3.skin
		slot4 = slot3.config.career
	elseif FightDataHelper.entityMgr:getById(slot1) and lua_monster.configDict[slot6.modelId] then
		slot5 = FightConfig.instance:getSkinCO(slot2 or slot7.skinId)
		slot4 = slot7.career
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

	if slot5 then
		slot0._commonHeroCard:onUpdateMO(slot5)
	end
end

function slot0.checkAssist(slot0, slot1, slot2)
	if not slot2 and Season123Model.instance:getBattleContext().stage ~= nil then
		slot2 = Season123HeroUtils.getHeroMO(slot3.actId, slot1, slot3.stage)
	end

	return slot2
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

function slot0._showEquip123(slot0, slot1, slot2, slot3, slot4)
	if slot4 == 0 then
		return
	end

	slot0:openSubView(Season123_2_3CelebrityCardGetItem, Season123_2_3CelebrityCardItem.AssetPath, slot3 <= 1 and slot0._gosingle or slot0["_gocard" .. slot1], slot2, nil, slot4)
end

function slot0._showReplayData(slot0)
	slot0:_showHeroIcon(slot0._hero, slot0._replay_data and slot0._replay_data.skin)
	slot0:_showEquipIcon(slot0._equip and slot0._equip.equipId)

	if slot1 ~= "0" and slot1 ~= "-100000" and slot0._equip_123 then
		slot0._no123Equip = #slot0._equip_123 == 0

		for slot6 = 1, slot2 do
			slot0:_showEquip123(slot6, slot0._equip_123[slot6].equipUid, slot2, slot0._equip_123[slot6].equipId)
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
