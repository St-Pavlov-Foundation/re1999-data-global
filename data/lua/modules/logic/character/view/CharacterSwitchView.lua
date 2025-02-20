module("modules.logic.character.view.CharacterSwitchView", package.seeall)

slot0 = class("CharacterSwitchView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/start/#btn_change")
	slot0._goshowing = gohelper.findChild(slot0.viewGO, "right/start/#go_showing")
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "right/mask/#scroll_card")
	slot0._btntimerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_timerank")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_rarerank")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gospinescale = gohelper.findChild(slot0.viewGO, "#go_spine_scale")
	slot0._golightspine = gohelper.findChild(slot0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "left/#go_info")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "left/#go_info/#simage_signature")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "left/#go_info/date/#txt_time")
	slot0._goheroskin = gohelper.findChild(slot0.viewGO, "left/#go_heroskin")
	slot0._gobgbottom = gohelper.findChild(slot0.viewGO, "left/#go_heroskin/#go_bgbottom")
	slot0._scrollskin = gohelper.findChildScrollRect(slot0.viewGO, "left/#go_heroskin/#scroll_skin")
	slot0._goheroskinItem = gohelper.findChild(slot0.viewGO, "left/#go_heroskin/#scroll_skin/Viewport/Content/#go_heroskinItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnchange:AddClickListener(slot0._btnchangeOnClick, slot0)
	slot0._btntimerank:AddClickListener(slot0._btntimerankOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnchange:RemoveClickListener()
	slot0._btntimerank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
end

function slot0._btnchangeOnClick(slot0)
	if not slot0._isRandom then
		slot0._curHeroId = slot0._heroId
		slot0._curSkinId = slot0._skinId
	end

	slot0._curRandom = slot0._isRandom

	CharacterSwitchListModel.instance:changeMainHero(slot0._curHeroId, slot0._curSkinId, slot0._isRandom)
	CharacterController.instance:dispatchEvent(CharacterEvent.MainThumbnailSignature, slot0._heroId)

	if LimitedRoleController.instance:getNeedPlayLimitedCO() and SettingsModel.instance.limitedRoleMO:isAuto() then
		LimitedRoleController.instance:play(LimitedRoleEnum.Stage.SwitchRole, slot1)
	end

	slot0:showTip()
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

function slot0._refreshBtnIcon(slot0)
	if slot0._sortIndex == 1 then
		CharacterSwitchListModel.instance:sortByTime(slot0._asceTime)
	else
		CharacterSwitchListModel.instance:sortByRare(slot0._asceRare)
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

function slot0._editableInitView(slot0)
	slot0._rootAnimator = slot0.viewGO:GetComponent("Animator")
	slot0._heroIdSet = {}
	slot0._showItemList = slot0:getUserDataTb_()
	slot0._cacheItemList = slot0:getUserDataTb_()
	slot4 = false

	slot0._goinfo:SetActive(slot4)

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

	gohelper.addUIClickAudio(slot0._btnchange.gameObject, AudioEnum.UI.Store_Good_Click)
	CharacterSwitchListModel.instance:initHeroList()
	slot0:_showMainHero(true)
	slot0:_refreshSelect()
	slot0:_refreshBtnIcon()
	MainHeroView.setSpineScale(slot0._gospinescale)
end

function slot0._onScreenResize(slot0)
	MainHeroView.setSpineScale(slot0._gospinescale)
end

function slot0._showMainHero(slot0, slot1)
	slot0._curHeroId, slot0._curSkinId, slot0._curRandom = CharacterSwitchListModel.instance:getMainHero()

	slot0:changeHero(slot0._curHeroId)

	if slot0._curHeroId and slot0._curSkinId then
		slot0:_switchHero(slot0._curHeroId, slot0._curSkinId, slot0._curRandom)

		if slot1 then
			slot0:_refreshSelect()
		end
	end
end

function slot0._refreshSelect(slot0)
	if CharacterSwitchListModel.instance:getMoByHeroId(not slot0._isRandom and slot0._heroId) then
		slot0.viewContainer:getCharacterScrollView():setSelect(slot2)
	end
end

function slot0.changeHero(slot0, slot1)
	CharacterSwitchListModel.instance.curHeroId = slot1
end

function slot0._updateHero(slot0, slot1, slot2, slot3)
	if gohelper.isNil(slot0._golightspine) then
		return
	end

	if slot3 then
		slot0:changeHero(nil)
	else
		slot0:changeHero(slot1)
	end

	if not slot3 then
		slot0:_modifySkinState(slot1, slot2)
	end

	slot4 = slot0._skinId
	slot0._heroId = slot1
	slot0._skinId = slot2
	slot0._isRandom = slot3

	slot0:showTip()

	slot5 = HeroModel.instance:getByHeroId(slot0._heroId)

	if not SkinConfig.instance:getSkinCo(slot0._skinId or slot5 and slot5.skin) then
		return
	end

	slot0._hero = slot5
	slot0._heroSkinConfig = slot6

	if not slot0._lightSpine then
		slot0:_getLightSpine()

		slot0._lightSpine = LightModelAgent.Create(slot0._golightspine, true)
	elseif slot4 ~= slot0._skinId or not LimitedRoleController.instance:isPlayingAction() then
		slot0._lightSpine:stopVoice()
	end

	slot0:_setOffset()
	TaskDispatcher.cancelTask(slot0._delayInitLightSpine, slot0)
	slot0._lightSpine:setResPath(slot6, slot0._onLightSpineLoaded, slot0)
	slot0._simagesignature:UnLoadImage()
	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot0._hero.config.signature))
end

function slot0._setOffset(slot0)
	slot1 = SkinConfig.instance:getSkinOffset(slot0._heroSkinConfig.mainViewOffset)
	slot2 = slot0._golightspine.transform

	recthelper.setAnchor(slot2, tonumber(slot1[1]), tonumber(slot1[2]))

	slot3 = tonumber(slot1[3])

	transformhelper.setLocalScale(slot2, slot3, slot3, slot3)
end

function slot0._getLightSpine(slot0)
	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	slot1 = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP/MainThumbnailView/#go_spine_scale/lightspine/#go_lightspine")

	gohelper.addChildPosStay(slot0._golightspine.transform.parent.gameObject, slot1)
	gohelper.destroy(slot0._golightspine)

	slot0._golightspine = slot1
end

function slot0.showTip(slot0)
	slot1 = slot0._curHeroId == slot0._heroId and slot0._curSkinId == slot0._skinId and slot0._curRandom == slot0._isRandom

	if slot0._isRandom and slot0._curRandom then
		slot1 = true
	end

	gohelper.setActive(slot0._btnchange.gameObject, not slot1)
	gohelper.setActive(slot0._goshowing.gameObject, slot1)
end

function slot0._needDelay(slot0)
	return slot0._heroSkinConfig.id == 301601 or slot0._heroSkinConfig.id == 301602
end

function slot0._onLightSpineLoaded(slot0)
	if not slot0:_needDelay() then
		slot0:_delayInitLightSpine()

		return
	end

	TaskDispatcher.runDelay(slot0._delayInitLightSpine, slot0, 0.1)
end

function slot0._delayInitLightSpine(slot0)
	if gohelper.isNil(slot0.viewGO) then
		return
	end

	WeatherController.instance:setLightModel(slot0._lightSpine)
	WeatherController.instance:changeRoleGo({
		roleGo = slot0._lightSpine:getSpineGo(),
		heroId = slot0._heroId,
		sharedMaterial = slot0._lightSpine:getRenderer().sharedMaterial,
		skinId = slot0._skinId
	})
	slot0._goinfo:SetActive(true)

	if not ServerTime.formatTimeInLocal(slot0._hero.createTime / 1000, "%Y / %m / %d") then
		return
	end

	slot0._txttime.text = slot3
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.SwitchHero, slot0._onSwitchHero, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.SwitchHeroSkin, slot0._switchHeroSkin, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0._golightspine, true)
	slot0:_showMainHero()
	TaskDispatcher.cancelTask(slot0._delayInitLightSpine, slot0)
end

function slot0.onTabSwitchOpen(slot0)
	gohelper.setActive(slot0._golightspine, true)
	slot0._rootAnimator:Play("open", 0, 0)
end

function slot0.onTabSwitchClose(slot0, slot1)
	if not slot1 then
		slot0._lightSpine:stopVoice()
		gohelper.setActive(slot0._golightspine, false)
	end
end

function slot0.onCloseFinish(slot0)
	if gohelper.isNil(UnityEngine.GameObject.Find("UIRoot/POPUP_TOP/MainThumbnailView/#go_spine_scale/lightspine")) or gohelper.isNil(slot0._golightspine) then
		return
	end

	gohelper.addChildPosStay(slot1, slot0._golightspine)
end

function slot0._switchHeroSkin(slot0, slot1, slot2)
	slot0:_updateHero(slot1, slot2, false)
end

function slot0._onSwitchHero(slot0, slot1)
	slot0:_switchHero(slot1[1], slot1[2], slot1[3])
end

function slot0._modifySkinState(slot0, slot1, slot2)
	if slot2 ~= CharacterVoiceEnum.LuxiSkin2 then
		return
	end

	if PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, slot2, 0) ~= 0 then
		return
	end

	slot4 = CharacterVoiceEnum.LuxiState.HumanFace

	PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.SkinState, slot2, slot4)
	PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.SkinState, slot1, slot4)
	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.SkinState, PlayerModel.instance:getPropKeyValueString(PlayerEnum.SimpleProperty.SkinState))
end

function slot0._switchHero(slot0, slot1, slot2, slot3)
	if slot3 then
		slot0:_updateHero(slot0._curHeroId, slot0._curSkinId, slot3)
	else
		slot0:_updateHero(slot1, slot2, slot3)
	end

	gohelper.setActive(slot0._goheroskin, not slot3)
	slot0:_showSkinList(slot1, slot2)

	if slot1 then
		slot0._heroIdSet[slot1] = true

		if tabletool.len(slot0._heroIdSet) >= 5 then
			slot0._heroIdSet = {}

			GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.5, slot0)
		end
	end
end

function slot0._sort(slot0, slot1)
	return slot0.skin < slot1.skin
end

slot1 = {
	149.2,
	-64.3,
	-151.4
}

function slot0._showSkinList(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot3 = HeroModel.instance:getByHeroId(slot1)
	slot4 = tabletool.copy(slot3.skinInfoList)

	table.sort(slot4, uv0._sort)

	slot5 = SkinInfoMO.New()

	slot5:init({
		expireSec = 0,
		skin = slot3.config.skinId
	})

	slot10 = slot5

	table.insert(slot4, 1, slot10)

	slot9 = slot4

	slot0:_hideAllItems()

	for slot9, slot10 in ipairs(slot0:removeDuplicates(slot9)) do
		slot11 = slot10.skin

		slot0:_showSkinItem(slot1, slot11, slot11 == slot2)
	end

	recthelper.setAnchorY(slot0._gobgbottom.transform, uv1[math.min(#slot4, #uv1)])
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
	slot4 = table.remove(slot0._cacheItemList) or MonoHelper.addLuaComOnceToGo(gohelper.cloneInPlace(slot0._goheroskinItem), CharacterSwitchSkinItem)

	gohelper.setAsLastSibling(slot4.viewGO)
	table.insert(slot0._showItemList, slot4)
	slot4:showSkin(slot1, slot2)
	slot4:setSelected(slot3)
end

function slot0.onDestroyView(slot0)
	slot0._simagesignature:UnLoadImage()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, slot0)
end

return slot0
