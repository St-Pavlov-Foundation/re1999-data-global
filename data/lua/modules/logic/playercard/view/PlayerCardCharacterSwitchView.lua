module("modules.logic.playercard.view.PlayerCardCharacterSwitchView", package.seeall)

slot0 = class("PlayerCardCharacterSwitchView", BaseView)

function slot0.onInitView(slot0)
	slot0.switchViewGO = gohelper.findChild(slot0.viewGO, "#go_characterswitchview/characterswitchview")
	slot0._btnClose = gohelper.findChildButton(slot0.viewGO, "#go_characterswitchview/characterswitchview/#btn_close")
	slot0._btnchange = gohelper.findChildButtonWithAudio(slot0.switchViewGO, "right/start/#btn_change", AudioEnum.UI.Store_Good_Click)
	slot0._goshowing = gohelper.findChild(slot0.switchViewGO, "right/start/#go_showing")
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.switchViewGO, "right/mask/#scroll_card")
	slot0._btntimerank = gohelper.findChildButtonWithAudio(slot0.switchViewGO, "right/#btn_timerank")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.switchViewGO, "right/#btn_rarerank")
	slot0._gobtns = gohelper.findChild(slot0.switchViewGO, "#go_btns")
	slot0._goinfo = gohelper.findChild(slot0.switchViewGO, "left/#go_info")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.switchViewGO, "left/#go_info/#simage_signature")
	slot0._txttime = gohelper.findChildText(slot0.switchViewGO, "left/#go_info/#txt_time")
	slot0._goheroskin = gohelper.findChild(slot0.switchViewGO, "left/#go_heroskin")
	slot0._gobgbottom = gohelper.findChild(slot0.switchViewGO, "left/#go_heroskin/#go_bgbottom")
	slot0._scrollskin = gohelper.findChildScrollRect(slot0.switchViewGO, "left/#go_heroskin/#scroll_skin")
	slot0._goheroskinItem = gohelper.findChild(slot0.switchViewGO, "left/#go_heroskin/#scroll_skin/Viewport/Content/#go_heroskinItem")
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnchange:AddClickListener(slot0._btnchangeOnClick, slot0)
	slot0._btntimerank:AddClickListener(slot0._btntimerankOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchHero, slot0._onSwitchHero, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchHeroSkin, slot0._switchHeroSkin, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchHeroL2d, slot0._switchL2d, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshSwitchView, slot0._onRefreshSwitchView, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, slot0.refreshView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnchange:RemoveClickListener()
	slot0._btntimerank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._showItemList = slot0:getUserDataTb_()
	slot0._cacheItemList = slot0:getUserDataTb_()

	slot0._goinfo:SetActive(true)

	slot0._timeBtns = slot0:getUserDataTb_()
	slot0._timeArrow = slot0:getUserDataTb_()
	slot0._rareBtns = slot0:getUserDataTb_()
	slot0._rareArrow = slot0:getUserDataTb_()

	for slot4 = 1, 2 do
		slot0._timeBtns[slot4] = gohelper.findChild(slot0._btntimerank.gameObject, "btn" .. tostring(slot4))
		slot0._timeArrow[slot4] = gohelper.findChild(slot0._timeBtns[slot4], "txt/arrow").transform
		slot0._rareBtns[slot4] = gohelper.findChild(slot0._btnrarerank.gameObject, "btn" .. tostring(slot4))
		slot0._rareArrow[slot4] = gohelper.findChild(slot0._rareBtns[slot4], "txt/arrow").transform
	end

	slot0._sortIndex = 2
	slot0._asceTime = false
	slot0._asceRare = false
end

function slot0._btncloseOnClick(slot0)
	if not PlayerCardModel.instance:checkHeroDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, PlayerCardCharacterSwitchViewContainer.yesCallback)
	else
		slot0:closeThis()
	end
end

function slot0._btnchangeOnClick(slot0)
	PlayerCardCharacterSwitchListModel.instance:changeMainHero(slot0._heroId, slot0._skinId, slot0._isRandom, slot0._isL2d)
end

function slot0._btntimerankOnClick(slot0)
	if slot0._sortIndex ~= 1 then
		slot0._sortIndex = 1
	else
		slot0._asceTime = not slot0._asceTime
	end

	slot0._asceRare = false

	slot0:_refreshBtnIcon()
end

function slot0._btnrarerankOnClick(slot0)
	if slot0._sortIndex ~= 2 then
		slot0._sortIndex = 2
	else
		slot0._asceRare = not slot0._asceRare
	end

	slot0._asceTime = false

	slot0:_refreshBtnIcon()
end

function slot0._onSwitchHero(slot0, slot1)
	slot0:_switchHero(slot1[1], slot1[2], slot1[3], slot0._isL2d)
end

function slot0._switchHeroSkin(slot0, slot1, slot2)
	slot0:_switchHero(slot1, slot2, false, slot0._isL2d)
end

function slot0._switchL2d(slot0)
	slot0._isL2d = not slot0._isL2d

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshSwitchView, {
		heroId = slot0._heroId,
		skinId = slot0._skinId,
		isL2d = slot0._isL2d
	})
end

function slot0._switchHero(slot0, slot1, slot2, slot3, slot4)
	if slot3 then
		slot0:_updateHero(slot0._curHeroId, slot0._curSkinId, slot3, slot4)
	else
		slot0:_updateHero(slot1, slot2, slot3, slot4)
	end
end

function slot0._showMainHero(slot0)
	slot0._curHeroId, slot0._curSkinId, slot0._curRandom, slot0._curIsL2d = slot0.cardInfo:getMainHero()

	if slot0._curHeroId and slot0._curSkinId then
		slot0:_switchHero(slot0._curHeroId, slot0._curSkinId, slot0._curRandom, slot0._curIsL2d)
		slot0:_refreshSelect()
	end
end

function slot0._refreshSelect(slot0)
	if PlayerCardCharacterSwitchListModel.instance:getMoByHeroId(not slot0._isRandom and slot0._heroId) then
		slot0.viewContainer.scrollView:setSelect(slot2)
	end
end

function slot0.onUpdateParam(slot0)
	slot0:_updateParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:_updateParam()
	PlayerCardCharacterSwitchListModel.instance:initHeroList()
	slot0:refreshView()
	slot0:_refreshBtnIcon()
end

function slot0._updateParam(slot0)
	slot0.userId = PlayerModel.instance:getMyUserId()
	slot0.cardInfo = PlayerCardModel.instance:getCardInfo(slot0.userId)
end

function slot0.refreshView(slot0)
	if not slot0.cardInfo then
		return
	end

	slot0:_showMainHero()
end

function slot0._refreshBtnIcon(slot0)
	if slot0._sortIndex == 1 then
		PlayerCardCharacterSwitchListModel.instance:sortByTime(slot0._asceTime)
	else
		PlayerCardCharacterSwitchListModel.instance:sortByRare(slot0._asceRare)
	end

	gohelper.setActive(slot0._timeBtns[1], slot1 ~= 1)
	gohelper.setActive(slot0._timeBtns[2], slot1 == 1)
	gohelper.setActive(slot0._rareBtns[1], slot1 ~= 2)
	gohelper.setActive(slot0._rareBtns[2], slot1 == 2)

	slot2 = slot0._asceTime and -1 or 1
	slot3 = slot0._asceRare and -1 or 1

	transformhelper.setLocalScale(slot0._timeArrow[1], 1, slot2, 1)
	transformhelper.setLocalScale(slot0._timeArrow[2], 1, slot2, 1)
	transformhelper.setLocalScale(slot0._rareArrow[1], 1, slot3, 1)
	transformhelper.setLocalScale(slot0._rareArrow[2], 1, slot3, 1)
end

function slot0.changeHero(slot0, slot1)
	PlayerCardCharacterSwitchListModel.instance.curHeroId = slot1
end

function slot0._updateHero(slot0, slot1, slot2, slot3, slot4)
	if slot3 then
		slot0:changeHero()
	else
		slot0:changeHero(slot1)
	end

	slot0._heroId = slot1
	slot0._skinId = slot2
	slot0._isRandom = slot3
	slot0._isL2d = slot4
	slot5 = HeroModel.instance:getByHeroId(slot0._heroId)
	slot0._hero = slot5
	slot0._heroSkinConfig = SkinConfig.instance:getSkinCo(slot0._skinId or slot5 and slot5.skin)

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshSwitchView, {
		heroId = slot0._heroId,
		skinId = slot0._skinId,
		isL2d = slot0._isL2d
	})
	PlayerCardModel.instance:setSelectHero(slot0._heroId, slot0._skinId)
end

function slot0._onRefreshSwitchView(slot0)
	slot0:showTip()
	slot0:refreshSignature()
	slot0:refreshCreateTime()
	slot0:_showSkinList()
end

function slot0.refreshSignature(slot0)
	if not slot0._hero then
		return
	end

	slot0._simagesignature:UnLoadImage()
	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot0._hero.config.signature))
end

function slot0.showTip(slot0)
	slot1 = slot0._curHeroId == slot0._heroId and slot0._curSkinId == slot0._skinId and slot0._curRandom == slot0._isRandom and slot0._curIsL2d == slot0._isL2d

	gohelper.setActive(slot0._btnchange.gameObject, not slot1)
	gohelper.setActive(slot0._goshowing.gameObject, slot1)
end

function slot0.refreshCreateTime(slot0)
	if not slot0._hero then
		return
	end

	if not ServerTime.formatTimeInLocal(slot0._hero.createTime / 1000, "%Y / %m / %d") then
		return
	end

	slot0._txttime.text = slot1
end

slot1 = {
	149.2,
	-64.3,
	-151.4
}

function slot0._showSkinList(slot0, slot1, slot2)
	slot4 = slot0._skinId

	gohelper.setActive(slot0._goheroskin, not slot0._isRandom)

	if not slot0._heroId then
		return
	end

	slot6 = HeroModel.instance:getByHeroId(slot3)
	slot7 = tabletool.copy(slot6.skinInfoList)

	table.sort(slot7, uv0._sort)

	slot8 = SkinInfoMO.New()

	slot8:init({
		expireSec = 0,
		skin = slot6.config.skinId
	})

	slot12 = slot8

	table.insert(slot7, 1, slot12)
	slot0:_hideAllItems()

	for slot12, slot13 in ipairs(slot0:removeDuplicates(slot7)) do
		slot14 = slot13.skin

		slot0:_showSkinItem(slot3, slot14, slot14 == slot4)
	end

	recthelper.setAnchorY(slot0._gobgbottom.transform, uv1[math.min(#slot7, #uv1)])
end

function slot0._sort(slot0, slot1)
	return slot0.skin < slot1.skin
end

function slot0.removeDuplicates(slot0, slot1)
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		if not slot2[slot8.skin] then
			slot2[slot8.skin] = true

			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0._hideAllItems(slot0)
	for slot5 = 1, #slot0._showItemList do
		slot6 = slot0._showItemList[slot5]

		gohelper.setActive(slot6.viewGO, false)
		table.insert(slot0._cacheItemList, slot6)

		slot0._showItemList[slot5] = nil
	end
end

function slot0._showSkinItem(slot0, slot1, slot2, slot3)
	slot4 = table.remove(slot0._cacheItemList) or MonoHelper.addLuaComOnceToGo(gohelper.cloneInPlace(slot0._goheroskinItem), PlayerCardCharacterSwitchSkinItem)

	gohelper.setAsLastSibling(slot4.viewGO)
	table.insert(slot0._showItemList, slot4)
	slot4:showSkin(slot1, slot2)
	slot4:setSelected(slot3)
end

function slot0.onClose(slot0)
	slot0.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseHeroView)
end

function slot0.onDestroyView(slot0)
	slot0._simagesignature:UnLoadImage()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, slot0)
end

return slot0
