module("modules.logic.character.view.CharacterSwitchView", package.seeall)

local var_0_0 = class("CharacterSwitchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/start/#btn_change")
	arg_1_0._goshowing = gohelper.findChild(arg_1_0.viewGO, "right/start/#go_showing")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/mask/#scroll_card")
	arg_1_0._btntimerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_timerank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_rarerank")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gospinescale = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "left/#go_info")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#go_info/#simage_signature")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "left/#go_info/date/#txt_time")
	arg_1_0._goheroskin = gohelper.findChild(arg_1_0.viewGO, "left/#go_heroskin")
	arg_1_0._gobgbottom = gohelper.findChild(arg_1_0.viewGO, "left/#go_heroskin/#go_bgbottom")
	arg_1_0._scrollskin = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#go_heroskin/#scroll_skin")
	arg_1_0._goheroskinItem = gohelper.findChild(arg_1_0.viewGO, "left/#go_heroskin/#scroll_skin/Viewport/Content/#go_heroskinItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._btntimerank:AddClickListener(arg_2_0._btntimerankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._btntimerank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
end

function var_0_0._btnchangeOnClick(arg_4_0)
	if not arg_4_0._isRandom then
		arg_4_0._curHeroId = arg_4_0._heroId
		arg_4_0._curSkinId = arg_4_0._skinId
	end

	arg_4_0._curRandom = arg_4_0._isRandom

	CharacterSwitchListModel.instance:changeMainHero(arg_4_0._curHeroId, arg_4_0._curSkinId, arg_4_0._isRandom)
	CharacterController.instance:dispatchEvent(CharacterEvent.MainThumbnailSignature, arg_4_0._heroId)

	local var_4_0 = LimitedRoleController.instance:getNeedPlayLimitedCO()

	if var_4_0 and SettingsModel.instance.limitedRoleMO:isAuto() then
		LimitedRoleController.instance:play(LimitedRoleEnum.Stage.SwitchRole, var_4_0)
	end

	arg_4_0:showTip()
end

function var_0_0._btntimerankOnClick(arg_5_0)
	if arg_5_0._sortIndex ~= 1 then
		arg_5_0._sortIndex = 1
	else
		arg_5_0._asceTime = not arg_5_0._asceTime
	end

	arg_5_0._asceRare = false

	arg_5_0:_refreshBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_6_0)
	if arg_6_0._sortIndex ~= 2 then
		arg_6_0._sortIndex = 2
	else
		arg_6_0._asceRare = not arg_6_0._asceRare
	end

	arg_6_0._asceTime = false

	arg_6_0:_refreshBtnIcon()
end

function var_0_0._refreshBtnIcon(arg_7_0)
	local var_7_0 = arg_7_0._sortIndex

	if var_7_0 == 1 then
		CharacterSwitchListModel.instance:sortByTime(arg_7_0._asceTime)
	else
		CharacterSwitchListModel.instance:sortByRare(arg_7_0._asceRare)
	end

	gohelper.setActive(arg_7_0._timeBtns[1], var_7_0 ~= 1)
	gohelper.setActive(arg_7_0._timeBtns[2], var_7_0 == 1)
	gohelper.setActive(arg_7_0._rareBtns[1], var_7_0 ~= 2)
	gohelper.setActive(arg_7_0._rareBtns[2], var_7_0 == 2)

	local var_7_1 = arg_7_0._asceTime and -1 or 1
	local var_7_2 = arg_7_0._asceRare and -1 or 1

	transformhelper.setLocalScale(arg_7_0._timeArrow[1], 1, var_7_1, 1)
	transformhelper.setLocalScale(arg_7_0._timeArrow[2], 1, var_7_1, 1)
	transformhelper.setLocalScale(arg_7_0._rareArrow[1], 1, var_7_2, 1)
	transformhelper.setLocalScale(arg_7_0._rareArrow[2], 1, var_7_2, 1)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._rootAnimator = arg_8_0.viewGO:GetComponent("Animator")
	arg_8_0._heroIdSet = {}
	arg_8_0._showItemList = arg_8_0:getUserDataTb_()
	arg_8_0._cacheItemList = arg_8_0:getUserDataTb_()

	arg_8_0._goinfo:SetActive(false)

	arg_8_0._timeBtns = arg_8_0:getUserDataTb_()
	arg_8_0._timeArrow = arg_8_0:getUserDataTb_()
	arg_8_0._rareBtns = arg_8_0:getUserDataTb_()
	arg_8_0._rareArrow = arg_8_0:getUserDataTb_()

	for iter_8_0 = 1, 2 do
		arg_8_0._timeBtns[iter_8_0] = gohelper.findChild(arg_8_0._btntimerank.gameObject, "btn" .. tostring(iter_8_0))
		arg_8_0._timeArrow[iter_8_0] = gohelper.findChild(arg_8_0._timeBtns[iter_8_0], "txt/arrow").transform
		arg_8_0._rareBtns[iter_8_0] = gohelper.findChild(arg_8_0._btnrarerank.gameObject, "btn" .. tostring(iter_8_0))
		arg_8_0._rareArrow[iter_8_0] = gohelper.findChild(arg_8_0._rareBtns[iter_8_0], "txt/arrow").transform
	end

	arg_8_0._sortIndex = 2
	arg_8_0._asceTime = false
	arg_8_0._asceRare = false

	gohelper.addUIClickAudio(arg_8_0._btnchange.gameObject, AudioEnum.UI.Store_Good_Click)
	CharacterSwitchListModel.instance:initHeroList()
	arg_8_0:_showMainHero(true)
	arg_8_0:_refreshSelect()
	arg_8_0:_refreshBtnIcon()
	MainHeroView.setSpineScale(arg_8_0._gospinescale)
end

function var_0_0._onScreenResize(arg_9_0)
	MainHeroView.setSpineScale(arg_9_0._gospinescale)
end

function var_0_0._showMainHero(arg_10_0, arg_10_1)
	arg_10_0._curHeroId, arg_10_0._curSkinId, arg_10_0._curRandom = CharacterSwitchListModel.instance:getMainHero()

	arg_10_0:changeHero(arg_10_0._curHeroId)

	if arg_10_0._curHeroId and arg_10_0._curSkinId then
		arg_10_0:_switchHero(arg_10_0._curHeroId, arg_10_0._curSkinId, arg_10_0._curRandom)

		if arg_10_1 then
			arg_10_0:_refreshSelect()
		end
	end
end

function var_0_0._refreshSelect(arg_11_0)
	local var_11_0 = not arg_11_0._isRandom and arg_11_0._heroId
	local var_11_1 = CharacterSwitchListModel.instance:getMoByHeroId(var_11_0)
	local var_11_2 = arg_11_0.viewContainer:getCharacterScrollView()

	if var_11_1 then
		var_11_2:setSelect(var_11_1)
	end
end

function var_0_0.changeHero(arg_12_0, arg_12_1)
	CharacterSwitchListModel.instance.curHeroId = arg_12_1
end

function var_0_0._updateHero(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if gohelper.isNil(arg_13_0._golightspine) then
		return
	end

	if arg_13_3 then
		arg_13_0:changeHero(nil)
	else
		arg_13_0:changeHero(arg_13_1)
	end

	if not arg_13_3 then
		arg_13_0:_modifySkinState(arg_13_1, arg_13_2)
	end

	local var_13_0 = arg_13_0._skinId

	arg_13_0._heroId = arg_13_1
	arg_13_0._skinId = arg_13_2
	arg_13_0._isRandom = arg_13_3

	arg_13_0:showTip()

	local var_13_1 = HeroModel.instance:getByHeroId(arg_13_0._heroId)
	local var_13_2 = SkinConfig.instance:getSkinCo(arg_13_0._skinId or var_13_1 and var_13_1.skin)

	if not var_13_2 then
		return
	end

	arg_13_0._hero = var_13_1
	arg_13_0._heroSkinConfig = var_13_2

	if not arg_13_0._lightSpine then
		arg_13_0:_getLightSpine()

		arg_13_0._lightSpine = LightModelAgent.Create(arg_13_0._golightspine, true)
	elseif var_13_0 ~= arg_13_0._skinId or not LimitedRoleController.instance:isPlayingAction() then
		arg_13_0._lightSpine:stopVoice()
	end

	arg_13_0:_setOffset()
	TaskDispatcher.cancelTask(arg_13_0._delayInitLightSpine, arg_13_0)
	arg_13_0._lightSpine:setResPath(var_13_2, arg_13_0._onLightSpineLoaded, arg_13_0)
	arg_13_0._simagesignature:UnLoadImage()
	arg_13_0._simagesignature:LoadImage(ResUrl.getSignature(arg_13_0._hero.config.signature))
end

function var_0_0._setOffset(arg_14_0)
	local var_14_0 = SkinConfig.instance:getSkinOffset(arg_14_0._heroSkinConfig.mainViewOffset)
	local var_14_1 = arg_14_0._golightspine.transform

	recthelper.setAnchor(var_14_1, tonumber(var_14_0[1]), tonumber(var_14_0[2]))

	local var_14_2 = tonumber(var_14_0[3])

	transformhelper.setLocalScale(var_14_1, var_14_2, var_14_2, var_14_2)
end

function var_0_0._getLightSpine(arg_15_0)
	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	local var_15_0 = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP/MainThumbnailView/#go_spine_scale/lightspine/#go_lightspine")

	gohelper.addChildPosStay(arg_15_0._golightspine.transform.parent.gameObject, var_15_0)
	gohelper.destroy(arg_15_0._golightspine)

	arg_15_0._golightspine = var_15_0
end

function var_0_0.showTip(arg_16_0)
	local var_16_0 = arg_16_0._curHeroId == arg_16_0._heroId and arg_16_0._curSkinId == arg_16_0._skinId and arg_16_0._curRandom == arg_16_0._isRandom

	if arg_16_0._isRandom and arg_16_0._curRandom then
		var_16_0 = true
	end

	gohelper.setActive(arg_16_0._btnchange.gameObject, not var_16_0)
	gohelper.setActive(arg_16_0._goshowing.gameObject, var_16_0)
end

function var_0_0._needDelay(arg_17_0)
	return arg_17_0._heroSkinConfig.id == 301601 or arg_17_0._heroSkinConfig.id == 301602
end

function var_0_0._onLightSpineLoaded(arg_18_0)
	if not arg_18_0:_needDelay() then
		arg_18_0:_delayInitLightSpine()

		return
	end

	TaskDispatcher.runDelay(arg_18_0._delayInitLightSpine, arg_18_0, 0.1)
end

function var_0_0._delayInitLightSpine(arg_19_0)
	if gohelper.isNil(arg_19_0.viewGO) then
		return
	end

	local var_19_0 = arg_19_0._lightSpine:getRenderer()

	WeatherController.instance:setLightModel(arg_19_0._lightSpine)

	local var_19_1 = {
		roleGo = arg_19_0._lightSpine:getSpineGo(),
		heroId = arg_19_0._heroId,
		sharedMaterial = var_19_0.sharedMaterial,
		skinId = arg_19_0._skinId
	}

	WeatherController.instance:changeRoleGo(var_19_1)
	arg_19_0._goinfo:SetActive(true)

	local var_19_2 = ServerTime.formatTimeInLocal(arg_19_0._hero.createTime / 1000, "%Y / %m / %d")

	if not var_19_2 then
		return
	end

	arg_19_0._txttime.text = var_19_2
end

function var_0_0.onUpdateParam(arg_20_0)
	return
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0:addEventCb(CharacterController.instance, CharacterEvent.SwitchHero, arg_21_0._onSwitchHero, arg_21_0)
	arg_21_0:addEventCb(CharacterController.instance, CharacterEvent.SwitchHeroSkin, arg_21_0._switchHeroSkin, arg_21_0)
	arg_21_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_21_0._onScreenResize, arg_21_0)
	arg_21_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneFinishStory, arg_21_0._onSwitchSceneFinishStory, arg_21_0)
end

function var_0_0.onClose(arg_22_0)
	gohelper.setActive(arg_22_0._golightspine, true)
	arg_22_0:_showMainHero()
	TaskDispatcher.cancelTask(arg_22_0._delayInitLightSpine, arg_22_0)
end

function var_0_0._onSwitchSceneFinishStory(arg_23_0)
	arg_23_0._switchSceneFinishStory = true
end

function var_0_0._checkSpineAnim(arg_24_0)
	if arg_24_0._switchSceneFinishStory and arg_24_0._lightSpine then
		arg_24_0._lightSpine:play(StoryAnimName.B_IDLE, true)
	end

	arg_24_0._switchSceneFinishStory = false
end

function var_0_0.onTabSwitchOpen(arg_25_0)
	gohelper.setActive(arg_25_0._golightspine, true)
	arg_25_0._rootAnimator:Play("open", 0, 0)
	arg_25_0:_checkSpineAnim()
end

function var_0_0.onTabSwitchClose(arg_26_0, arg_26_1)
	if not arg_26_1 then
		arg_26_0._lightSpine:stopVoice()
		gohelper.setActive(arg_26_0._golightspine, false)
	end
end

function var_0_0.onCloseFinish(arg_27_0)
	local var_27_0 = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP/MainThumbnailView/#go_spine_scale/lightspine")

	if gohelper.isNil(var_27_0) or gohelper.isNil(arg_27_0._golightspine) then
		return
	end

	gohelper.addChildPosStay(var_27_0, arg_27_0._golightspine)
	arg_27_0:_checkSpineAnim()
end

function var_0_0._switchHeroSkin(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0:_updateHero(arg_28_1, arg_28_2, false)
end

function var_0_0._onSwitchHero(arg_29_0, arg_29_1)
	arg_29_0:_switchHero(arg_29_1[1], arg_29_1[2], arg_29_1[3])
end

function var_0_0._modifySkinState(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_2 ~= CharacterVoiceEnum.LuxiSkin2 then
		return
	end

	if PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, arg_30_2, 0) ~= 0 then
		return
	end

	local var_30_0 = CharacterVoiceEnum.LuxiState.HumanFace

	PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.SkinState, arg_30_2, var_30_0)
	PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.SkinState, arg_30_1, var_30_0)

	local var_30_1 = PlayerModel.instance:getPropKeyValueString(PlayerEnum.SimpleProperty.SkinState)

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.SkinState, var_30_1)
end

function var_0_0._switchHero(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_3 then
		arg_31_0:_updateHero(arg_31_0._curHeroId, arg_31_0._curSkinId, arg_31_3)
	else
		arg_31_0:_updateHero(arg_31_1, arg_31_2, arg_31_3)
	end

	gohelper.setActive(arg_31_0._goheroskin, not arg_31_3)
	arg_31_0:_showSkinList(arg_31_1, arg_31_2)

	if arg_31_1 then
		arg_31_0._heroIdSet[arg_31_1] = true

		if tabletool.len(arg_31_0._heroIdSet) >= 5 then
			arg_31_0._heroIdSet = {}

			GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.5, arg_31_0)
		end
	end
end

function var_0_0._sort(arg_32_0, arg_32_1)
	return arg_32_0.skin < arg_32_1.skin
end

local var_0_1 = {
	149.2,
	-64.3,
	-151.4
}

function var_0_0._showSkinList(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_1 then
		return
	end

	local var_33_0 = HeroModel.instance:getByHeroId(arg_33_1)
	local var_33_1 = tabletool.copy(var_33_0.skinInfoList)

	table.sort(var_33_1, var_0_0._sort)

	local var_33_2 = SkinInfoMO.New()

	var_33_2:init({
		expireSec = 0,
		skin = var_33_0.config.skinId
	})
	table.insert(var_33_1, 1, var_33_2)

	local var_33_3 = arg_33_0:removeDuplicates(var_33_1)

	arg_33_0:_hideAllItems()

	for iter_33_0, iter_33_1 in ipairs(var_33_3) do
		local var_33_4 = iter_33_1.skin

		arg_33_0:_showSkinItem(arg_33_1, var_33_4, var_33_4 == arg_33_2)
	end

	local var_33_5 = math.min(#var_33_3, #var_0_1)

	recthelper.setAnchorY(arg_33_0._gobgbottom.transform, var_0_1[var_33_5])
end

function var_0_0.removeDuplicates(arg_34_0, arg_34_1)
	local var_34_0 = {}
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		if not var_34_0[iter_34_1.skin] then
			var_34_0[iter_34_1.skin] = true

			table.insert(var_34_1, iter_34_1)
		end
	end

	return var_34_1
end

function var_0_0._hideAllItems(arg_35_0)
	local var_35_0 = #arg_35_0._showItemList

	for iter_35_0 = 1, var_35_0 do
		local var_35_1 = arg_35_0._showItemList[iter_35_0]

		gohelper.setActive(var_35_1.viewGO, false)
		table.insert(arg_35_0._cacheItemList, var_35_1)

		arg_35_0._showItemList[iter_35_0] = nil
	end
end

function var_0_0._showSkinItem(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = table.remove(arg_36_0._cacheItemList)

	if not var_36_0 then
		local var_36_1 = gohelper.cloneInPlace(arg_36_0._goheroskinItem)

		var_36_0 = MonoHelper.addLuaComOnceToGo(var_36_1, CharacterSwitchSkinItem)
	end

	gohelper.setAsLastSibling(var_36_0.viewGO)
	table.insert(arg_36_0._showItemList, var_36_0)
	var_36_0:showSkin(arg_36_1, arg_36_2)
	var_36_0:setSelected(arg_36_3)
end

function var_0_0.onDestroyView(arg_37_0)
	arg_37_0._simagesignature:UnLoadImage()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, arg_37_0)
end

return var_0_0
