module("modules.logic.rouge.view.RougeResultReView", package.seeall)

slot0 = class("RougeResultReView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#go_fail/#simage_mask")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._simagerightmask = gohelper.findChildSingleImage(slot0.viewGO, "img_dec/#simage_rightmask")
	slot0._simageleftmask = gohelper.findChildSingleImage(slot0.viewGO, "img_dec/#simage_leftmask")
	slot0._godlctitles = gohelper.findChild(slot0.viewGO, "Left/title/#go_dlctitles")
	slot0._godifficulty = gohelper.findChild(slot0.viewGO, "Left/#go_difficulty")
	slot0._txtdifficulty = gohelper.findChildText(slot0.viewGO, "Left/#go_difficulty/#txt_difficulty")
	slot0._txtend = gohelper.findChildText(slot0.viewGO, "Left/#txt_end")
	slot0._gofaction = gohelper.findChild(slot0.viewGO, "Left/#go_faction")
	slot0._imageTypeIcon = gohelper.findChildImage(slot0.viewGO, "Left/#go_faction/#image_TypeIcon")
	slot0._txtTypeName = gohelper.findChildText(slot0.viewGO, "Left/#go_faction/image_NameBG/#txt_TypeName")
	slot0._txtLv = gohelper.findChildText(slot0.viewGO, "Left/#go_faction/#txt_Lv")
	slot0._gocollection = gohelper.findChild(slot0.viewGO, "Left/#go_collection")
	slot0._txtcollectionnum = gohelper.findChildText(slot0.viewGO, "Left/#go_collection/#txt_collectionnum")
	slot0._gocoin = gohelper.findChild(slot0.viewGO, "Left/#go_coin")
	slot0._txtcoinnum = gohelper.findChildText(slot0.viewGO, "Left/#go_coin/#txt_coinnum")
	slot0._scrollherogroup = gohelper.findChildScrollRect(slot0.viewGO, "Left/#scroll_herogroup")
	slot0._goline1 = gohelper.findChild(slot0.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_line1")
	slot0._goline2 = gohelper.findChild(slot0.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_line2")
	slot0._goplayinfo = gohelper.findChild(slot0.viewGO, "Right/#go_playinfo")
	slot0._txtplayername = gohelper.findChildText(slot0.viewGO, "Right/#go_playinfo/#txt_playername")
	slot0._txtplayerlv = gohelper.findChildText(slot0.viewGO, "Right/#go_playinfo/#txt_playerlv")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "Right/#go_playinfo/#txt_time")
	slot0._simageplayericon = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_playinfo/#simage_playericon")
	slot0._gochessboard = gohelper.findChild(slot0.viewGO, "Right/#go_chessboard")
	slot0._gomeshContainer = gohelper.findChild(slot0.viewGO, "Right/#go_chessboard/#go_meshContainer")
	slot0._gomeshItem = gohelper.findChild(slot0.viewGO, "Right/#go_chessboard/#go_meshContainer/#go_meshItem")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "Right/#go_chessboard/#go_dragContainer/#go_chessitem")
	slot0._gocellModel = gohelper.findChild(slot0.viewGO, "Right/#go_chessboard/#go_cellModel")
	slot0._godragarea = gohelper.findChild(slot0.viewGO, "Right/#go_chessboard/#go_dragarea")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gohide = gohelper.findChild(slot0.viewGO, "#go_hide")
	slot0._btnhide = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_hide/#btn_hide")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnhide:AddClickListener(slot0._btnhideOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnhide:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnhideOnClick(slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._heroLineTab = slot0:getUserDataTb_()
	slot0._gonormaltitle = gohelper.findChild(slot0.viewGO, "Left/title/normal")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.PurdahPull)
	slot0:refreshUI(slot0.viewParam and slot0.viewParam.reviewInfo)
	gohelper.setActive(slot0._gotopleft, slot0.viewParam and slot0.viewParam.showNavigate)
end

function slot0.onOpenFinish(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.NextShowSettlementTxt)
end

function slot0.refreshUI(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot1:isSucceed()

	gohelper.setActive(slot0._gosuccess, slot2)
	gohelper.setActive(slot0._gofail, not slot2)

	slot0._txtend.text = uv0.refreshEndingDesc(slot1)

	slot0:refreshBaseInfo(slot1)
	slot0:refreshTitle(slot1)
	slot0:refreshStyleInfo(slot1)
	slot0:refreshInitHeroUI(slot1)
	slot0:refreshPlayerInfo(slot1)
	slot0:refreshCollectionSlotArea(slot1)
end

function slot0.refreshEndingDesc(slot0)
	slot2 = ""

	return slot0:isSucceed() and RougeConfig.instance:getEndingCO(slot0.endId) and slot4.desc or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("p_rougeresultreportview_txt_dec5"), slot0:isInMiddleLayer() and lua_rouge_middle_layer.configDict[slot0.middleLayerId] and slot7.name or lua_rouge_layer.configDict[slot0.layerId] and slot7.name)
end

function slot0.refreshBaseInfo(slot0, slot1)
	slot0._txtcollectionnum.text = slot1.collectionNum
	slot0._txtcoinnum.text = slot1.gainCoin
	slot0._txtdifficulty.text = lua_rouge_difficulty.configDict[slot1.season][slot1.difficulty] and slot6.title
	slot0._txtLv.text = string.format("Lv.%s", slot1.teamLevel)
end

function slot0.refreshTitle(slot0, slot1)
	for slot8 = 1, slot0._godlctitles.transform.childCount do
		slot9 = slot0._godlctitles.transform:GetChild(slot8 - 1).gameObject

		gohelper.setActive(slot9, slot9.name == RougeDLCHelper.versionListToString(slot1 and slot1:getVersions()))
	end

	gohelper.setActive(slot0._gonormaltitle, not (slot2 and #slot2 > 0))
end

function slot0.refreshStyleInfo(slot0, slot1)
	slot0._txtTypeName.text = lua_rouge_style.configDict[slot1.season][slot1.style] and slot4.name

	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageTypeIcon, string.format("%s_light", slot4 and slot4.icon))
end

function slot0.refreshInitHeroUI(slot0, slot1)
	slot3, slot4 = slot0:buildHeroPlaceMap(slot1:getTeamInfo())
	slot5 = 0
	slot7 = 1

	while slot7 <= 4 or 0 <= slot4 do
		slot5 = slot5 + 1
		slot6 = slot5 + slot0:getLineHeroCount(slot7) - 1

		slot0:refreshLineItem(slot0:getOrCreateHeroIconLine(slot7), slot7, slot3, slot5, slot6)

		slot5 = slot6
		slot7 = slot7 + 1
	end
end

function slot0.buildHeroPlaceMap(slot0, slot1)
	slot2 = {
		[slot10 + uv0.SingleHeroCountPerLine] = slot3[slot10] or 0
	}
	slot3, slot4, slot5 = slot0:splitAllHeros(slot1)

	for slot10 = 1, RougeEnum.FightTeamNormalHeroNum do
	end

	for slot12 = 1, RougeEnum.FightTeamHeroNum - RougeEnum.FightTeamNormalHeroNum do
		slot2[slot12 + uv0.SingleHeroCountPerLine + uv0.DoubleHeroCountPerLine + 1] = slot4[slot12] or 0
	end

	for slot14 = 1, #slot5 do
		slot16 = slot14
		slot16 = slot14 <= uv0.SingleHeroCountPerLine and slot14 or slot14 == uv0.SingleHeroCountPerLine + 1 and uv0.SingleHeroCountPerLine + uv0.DoubleHeroCountPerLine + 1 or uv0.DoubleHeroCountPerLine * 2 + slot14
		slot2[slot16] = slot5[slot14]

		if 0 < slot16 then
			slot10 = slot16
		end
	end

	return slot2, slot10
end

function slot0.splitAllHeros(slot0, slot1)
	slot2 = slot1 and slot1:getAllHeroId()
	slot3 = {}
	slot4 = {}
	slot5 = {}
	slot6 = {}
	slot0._needFrameHeroIdMap = {}

	if slot1 and slot1:getBattleHeroList() then
		for slot11, slot12 in ipairs(slot7) do
			slot13 = slot12.heroId
			slot14 = slot12.supportHeroId

			table.insert(slot4, slot13)
			table.insert(slot3, slot14)

			slot6[slot13] = true
			slot6[slot14] = true
			slot0._needFrameHeroIdMap[slot13] = true
			slot0._needFrameHeroIdMap[slot14] = true
		end
	end

	if slot2 then
		for slot11, slot12 in ipairs(slot2) do
			if not slot6[slot12] then
				table.insert(slot5, slot12)
			end
		end
	end

	return slot4, slot3, slot5
end

function slot0.getOrCreateHeroIconLine(slot0, slot1)
	if not slot0._heroLineTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.parent = gohelper.cloneInPlace(slot1 % 2 == 1 and slot0._goline1 or slot0._goline2, "line_" .. slot1)
		slot2.heroItems = slot0:getUserDataTb_()

		for slot10 = 1, slot0:getLineHeroCount(slot1) do
			slot11 = gohelper.cloneInPlace(gohelper.findChild(slot2.parent, "go_item"), "heroitem_" .. slot10)

			slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot11, "icon")

			slot2.heroItems[slot10] = slot11

			if slot10 ~= 1 and slot1 ~= 2 and slot1 ~= 3 and slot10 % 2 == 0 then
				slot11.transform:SetAsFirstSibling()
			end
		end

		slot0._heroLineTab[slot1] = slot2
	end

	return slot2
end

slot0.DoubleHeroCountPerLine = 4
slot0.SingleHeroCountPerLine = 5

function slot0.getLineHeroCount(slot0, slot1)
	return slot1 % 2 == 1 and uv0.SingleHeroCountPerLine or uv0.DoubleHeroCountPerLine
end

function slot0.refreshLineItem(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot1 then
		return
	end

	for slot9 = slot4, slot5 do
		slot0:refreshHeroUI(slot1.heroItems[slot9 - slot4 + 1], slot3 and slot3[slot9])
	end

	gohelper.setActive(slot1.parent, true)
end

function slot0.refreshHeroUI(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot3 = slot2 and slot2 > 0

	gohelper.setActive(slot1, true)
	gohelper.setActive(gohelper.findChild(slot1, "icon/#go_heroitem/empty"), not slot3)
	gohelper.setActive(gohelper.findChild(slot1, "icon/#go_heroitem/frame"), false)
	gohelper.setActive(gohelper.findChildSingleImage(slot1, "icon/#go_heroitem/#image_rolehead").gameObject, slot3)

	if slot3 then
		slot7 = HeroConfig.instance:getHeroCO(slot2)
		slot8 = nil
		slot8 = (not HeroModel.instance:getByHeroId(slot2) or HeroModel.instance:getCurrentSkinConfig(slot2)) and SkinConfig.instance:getSkinCo(slot7 and slot7.skinId)

		slot6:LoadImage(ResUrl.getHeadIconSmall(slot8 and slot8.headIcon))
		gohelper.setActive(slot5, slot0._needFrameHeroIdMap[slot2])
	end
end

function slot0.refreshPlayerInfo(slot0, slot1)
	slot0._txtplayername.text = slot1.playerName
	slot0._txtplayerlv.text = string.format("Lv.%s", slot1.playerLevel)
	slot0._txttime.text = TimeUtil.localTime2ServerTimeString(slot1.finishTime / 1000, "%Y.%m.%d %H:%M")

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageplayericon)
	end

	slot0._liveHeadIcon:setLiveHead(slot1.portrait)
end

function slot0.refreshCollectionSlotArea(slot0, slot1)
	slot2 = slot1.style
	slot3 = slot1.season
	slot4 = slot1:getSlotCollections()

	if not slot0._slotComp then
		slot0._slotComp = RougeCollectionSlotComp.Get(slot0._gochessboard, RougeCollectionHelper.ResultReViewCollectionSlotParam)
	end

	slot5 = RougeCollectionConfig.instance:getStyleCollectionBagSize(slot3, slot2)

	slot0._slotComp:onUpdateMO(slot5.col, slot5.row, slot4)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._slotComp then
		slot0._slotComp:destroy()
	end
end

return slot0
