module("modules.logic.playercard.view.comp.PlayerCardCardItem", package.seeall)

slot0 = class("PlayerCardCardItem", ListScrollCell)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.compType = slot1 and slot1.compType
	slot0.cardIndex = slot1 and slot1.index
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0.imageBg = gohelper.findChildImage(slot0.viewGO, "#image_bg")
	slot0.goEmpty = gohelper.findChild(slot0.viewGO, "empty")
	slot0.goEmptyAdd = gohelper.findChild(slot0.goEmpty, "#btn_add")
	slot0.goEmptyImg = gohelper.findChild(slot0.goEmpty, "img_empty")
	slot0.goNormal = gohelper.findChild(slot0.viewGO, "normal")
	slot0.txtCardName = gohelper.findChildTextMesh(slot0.goNormal, "#txt_cardname")
	slot0.txtEnName = gohelper.findChildTextMesh(slot0.goNormal, "#txt_en")
	slot0.txtDesc = gohelper.findChildTextMesh(slot0.goNormal, "#txt_dec")
	slot0.goNormalChange = gohelper.findChild(slot0.goNormal, "#btn_change")
	slot0.goSelect = gohelper.findChild(slot0.viewGO, "select")
	slot0.txtIndex = gohelper.findChildTextMesh(slot0.goSelect, "#txt_order")
	slot0.btnChange = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_change")
	slot0.goSelectedEff = gohelper.findChild(slot0.viewGO, "selected_eff")

	slot0:initCard()
	slot0:setVisible(true)
end

function slot0.setVisible(slot0, slot1)
	if slot0.isVisible == slot1 then
		return
	end

	slot0.isVisible = slot1

	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.playSelelctEffect(slot0)
	gohelper.setActive(slot0.goSelectedEff, false)
	gohelper.setActive(slot0.goSelectedEff, true)
	PlayerCardController.instance:playChangeEffectAudio()
end

function slot0.initCard(slot0)
	for slot4, slot5 in pairs(PlayerCardEnum.CardKey) do
		if slot0[string.format("_initCard" .. slot5)] then
			slot7(slot0)
		end
	end
end

function slot0._initCard3(slot0)
	slot0.goRole = gohelper.findChild(slot0.goNormal, "#go_role")
	slot0._collectionFulls = slot0:getUserDataTb_()

	for slot4 = 1, 5 do
		slot0._collectionFulls[slot4] = gohelper.findChildImage(slot0.goRole, string.format("collection/collection%s/#image_full", slot4))
	end
end

function slot0._initCard4(slot0)
	slot0.goRoom = gohelper.findChild(slot0.goNormal, "#go_room")
	slot0.txtLand = gohelper.findChildTextMesh(slot0.goRoom, "#txt_num1")
	slot0.txtBuilding = gohelper.findChildTextMesh(slot0.goRoom, "#txt_num2")
end

function slot0._initCard6(slot0)
	slot0.goExplore = gohelper.findChild(slot0.goNormal, "#go_explore")
	slot0.exportItem = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.txtExplore = gohelper.findChildTextMesh(slot0.goExplore, "#txt_num" .. tostring(slot4))
		slot5.image = gohelper.findChildImage(slot0.goExplore, string.format("#txt_num%s/icon", slot4))
		slot0.exportItem[slot4] = slot5
	end
end

function slot0.refreshView(slot0, slot1, slot2)
	if slot0.notIsFirst and slot0.cardConfig ~= slot2 then
		slot0:playSelelctEffect()
	end

	slot0.notIsFirst = true
	slot0.cardInfo = slot1
	slot0.cardConfig = slot2

	if slot0.cardConfig then
		UISpriteSetMgr.instance:setPlayerInfoSprite(slot0.imageBg, "player_card_" .. slot2.id, true)
		gohelper.setActive(slot0.goEmpty, false)
		gohelper.setActive(slot0.goNormal, true)
		gohelper.setActive(slot0.goNormalChange, slot0:isPlayerSelf() and slot0.compType == PlayerCardEnum.CompType.Normal and slot0.cardIndex == 4)

		slot0.txtCardName.text = slot2.name
		slot0.txtEnName.text = slot2.nameEn

		slot0:refreshCard()
	else
		gohelper.setActive(slot0.goEmpty, true)
		gohelper.setActive(slot0.goNormal, false)

		slot3 = slot0:isPlayerSelf() and slot0.compType == PlayerCardEnum.CompType.Normal

		gohelper.setActive(slot0.goEmptyAdd, slot3)
		gohelper.setActive(slot0.goEmptyImg, not slot3)
		UISpriteSetMgr.instance:setPlayerInfoSprite(slot0.imageBg, "player_card_0", true)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:refreshView(slot1.info, slot1.config)

	if PlayerCardProgressModel.instance:getSelectIndex(slot1.id) then
		gohelper.setActive(slot0.goSelect, true)

		slot0.txtIndex.text = tostring(slot2)
	else
		gohelper.setActive(slot0.goSelect, false)
	end
end

function slot0.getConfig(slot0)
	return slot0.cardConfig
end

function slot0.isPlayerSelf(slot0)
	return slot0.cardInfo and slot0.cardInfo:isSelf()
end

function slot0.getPlayerInfo(slot0)
	return slot0.cardInfo and slot0.cardInfo:getPlayerInfo()
end

function slot0.refreshCard(slot0)
	slot0:resetCard()

	if slot0[string.format("_refreshCard" .. slot0.cardConfig.id)] then
		slot2(slot0)
	end
end

function slot0.resetCard(slot0)
	gohelper.setActive(slot0.goRole, false)
	gohelper.setActive(slot0.goRoom, false)
	gohelper.setActive(slot0.goExplore, false)

	slot0.txtDesc.text = ""
end

function slot0._refreshCard1(slot0)
	slot0.txtDesc.text = TimeUtil.timestampToString3(ServerTime.timeInLocal(slot0:getPlayerInfo().registerTime / 1000))
end

function slot0._refreshCard2(slot0)
	slot0.txtDesc.text = formatLuaLang("cachotprogressview_remainDay", slot0:getPlayerInfo().totalLoginDays)
end

function slot0._refreshCard3(slot0)
	gohelper.setActive(slot0.goRole, true)

	slot1 = slot0:getPlayerInfo()
	slot3 = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	slot4 = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	slot5 = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	slot6 = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)
	slot0._collectionFulls[1].fillAmount = math.min(HeroConfig.instance:getAnyOnlineRareCharacterCount(1) > 0 and slot1.heroRareNNCount / slot2 or 1, 1)
	slot0._collectionFulls[2].fillAmount = math.min(slot3 > 0 and slot1.heroRareNCount / slot3 or 1, 1)
	slot0._collectionFulls[3].fillAmount = math.min(slot4 > 0 and slot1.heroRareRCount / slot4 or 1, 1)
	slot0._collectionFulls[4].fillAmount = math.min(slot5 > 0 and slot1.heroRareSRCount / slot5 or 1, 1)
	slot0._collectionFulls[5].fillAmount = math.min(slot6 > 0 and slot1.heroRareSSRCount / slot6 or 1, 1)
end

function slot0._refreshCard4(slot0)
	gohelper.setActive(slot0.goRoom, true)

	if string.splitToNumber(slot0.cardInfo.roomCollection, "#") and slot2[1] then
		slot0.txtLand.text = slot3
	else
		slot0.txtLand.text = PlayerCardEnum.EmptyString
	end

	if slot2 and slot2[2] then
		slot0.txtBuilding.text = slot4
	else
		slot0.txtBuilding.text = PlayerCardEnum.EmptyString
	end
end

function slot0._refreshCard5(slot0)
	if slot0.cardInfo.weekwalkDeepLayerId == -1 then
		slot0.txtDesc.text = PlayerCardEnum.EmptyString2
	elseif lua_weekwalk_scene.configDict[WeekWalkConfig.instance:getMapConfig(slot1) and slot2.sceneId] then
		slot0.txtDesc.text = slot3.battleName
	else
		slot0.txtDesc.text = PlayerCardEnum.EmptyString2
	end
end

function slot0._refreshCard6(slot0)
	gohelper.setActive(slot0.goExplore, true)

	slot2 = GameUtil.splitString2(slot0.cardInfo.exploreCollection, true) or {}

	slot0:_refreshExportItem(1, slot2[3], "dungeon_secretroom_btn_triangle")
	slot0:_refreshExportItem(2, slot2[2], "dungeon_secretroom_btn_sandglass")
	slot0:_refreshExportItem(3, slot2[1], "dungeon_secretroom_btn_box")
end

function slot0._refreshCard7(slot0)
	if slot0.cardInfo.rougeDifficulty == -1 then
		slot0.txtDesc.text = PlayerCardEnum.EmptyString2
	else
		slot0.txtDesc.text = formatLuaLang("playercard_rougedesc", slot1)
	end
end

function slot0._refreshCard8(slot0)
	if slot0.cardInfo.act128SSSCount == -1 then
		slot0.txtDesc.text = PlayerCardEnum.EmptyString2
	else
		slot0.txtDesc.text = formatLuaLang("times2", slot1)
	end
end

function slot0._refreshExportItem(slot0, slot1, slot2, slot3)
	slot5 = slot2 and slot2[2]

	if slot2 and slot2[1] then
		slot0.exportItem[slot1].txtExplore.text = slot4
	else
		slot6.txtExplore.text = PlayerCardEnum.EmptyString
	end

	if slot4 and slot5 and slot5 <= slot4 then
		UISpriteSetMgr.instance:setExploreSprite(slot6.image, slot3 .. "1", true)
	else
		UISpriteSetMgr.instance:setExploreSprite(slot6.image, slot3 .. "2", true)
	end
end

function slot0.addEventListeners(slot0)
	slot0.btnChange:AddClickListener(slot0.btnChangeOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnChange:RemoveClickListener()
end

function slot0.btnChangeOnClick(slot0)
	if not slot0:isPlayerSelf() then
		return
	end

	if slot0.compType == PlayerCardEnum.CompType.Normal then
		ViewMgr.instance:openView(ViewName.PlayerCardShowView)
	elseif slot0.cardConfig then
		PlayerCardProgressModel.instance:clickItem(slot0.cardConfig.id)
	end
end

function slot0.onDestroy(slot0)
end

return slot0
