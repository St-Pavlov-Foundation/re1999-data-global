module("modules.logic.playercard.view.PlayerCardCharacterSwitchView", package.seeall)

local var_0_0 = class("PlayerCardCharacterSwitchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.switchViewGO = gohelper.findChild(arg_1_0.viewGO, "#go_characterswitchview/characterswitchview")
	arg_1_0._btnClose = gohelper.findChildButton(arg_1_0.viewGO, "#go_characterswitchview/characterswitchview/#btn_close")
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0.switchViewGO, "right/start/#btn_change", AudioEnum.UI.Store_Good_Click)
	arg_1_0._goshowing = gohelper.findChild(arg_1_0.switchViewGO, "right/start/#go_showing")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.switchViewGO, "right/mask/#scroll_card")
	arg_1_0._btntimerank = gohelper.findChildButtonWithAudio(arg_1_0.switchViewGO, "right/#btn_timerank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.switchViewGO, "right/#btn_rarerank")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.switchViewGO, "#go_btns")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.switchViewGO, "left/#go_info")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.switchViewGO, "left/#go_info/#simage_signature")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.switchViewGO, "left/#go_info/#txt_time")
	arg_1_0._goheroskin = gohelper.findChild(arg_1_0.switchViewGO, "left/#go_heroskin")
	arg_1_0._gobgbottom = gohelper.findChild(arg_1_0.switchViewGO, "left/#go_heroskin/#go_bgbottom")
	arg_1_0._scrollskin = gohelper.findChildScrollRect(arg_1_0.switchViewGO, "left/#go_heroskin/#scroll_skin")
	arg_1_0._goheroskinItem = gohelper.findChild(arg_1_0.switchViewGO, "left/#go_heroskin/#scroll_skin/Viewport/Content/#go_heroskinItem")
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._btntimerank:AddClickListener(arg_2_0._btntimerankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchHero, arg_2_0._onSwitchHero, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchHeroSkin, arg_2_0._switchHeroSkin, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchHeroL2d, arg_2_0._switchL2d, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshSwitchView, arg_2_0._onRefreshSwitchView, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, arg_2_0.refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._btntimerank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._showItemList = arg_4_0:getUserDataTb_()
	arg_4_0._cacheItemList = arg_4_0:getUserDataTb_()

	arg_4_0._goinfo:SetActive(true)

	arg_4_0._timeBtns = arg_4_0:getUserDataTb_()
	arg_4_0._timeArrow = arg_4_0:getUserDataTb_()
	arg_4_0._rareBtns = arg_4_0:getUserDataTb_()
	arg_4_0._rareArrow = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 2 do
		arg_4_0._timeBtns[iter_4_0] = gohelper.findChild(arg_4_0._btntimerank.gameObject, "btn" .. tostring(iter_4_0))
		arg_4_0._timeArrow[iter_4_0] = gohelper.findChild(arg_4_0._timeBtns[iter_4_0], "txt/arrow").transform
		arg_4_0._rareBtns[iter_4_0] = gohelper.findChild(arg_4_0._btnrarerank.gameObject, "btn" .. tostring(iter_4_0))
		arg_4_0._rareArrow[iter_4_0] = gohelper.findChild(arg_4_0._rareBtns[iter_4_0], "txt/arrow").transform
	end

	arg_4_0._sortIndex = 2
	arg_4_0._asceTime = false
	arg_4_0._asceRare = false
end

function var_0_0._btncloseOnClick(arg_5_0)
	if not PlayerCardModel.instance:checkHeroDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, PlayerCardCharacterSwitchViewContainer.yesCallback)
	else
		arg_5_0:closeThis()
	end
end

function var_0_0._btnchangeOnClick(arg_6_0)
	PlayerCardCharacterSwitchListModel.instance:changeMainHero(arg_6_0._heroId, arg_6_0._skinId, arg_6_0._isRandom, arg_6_0._isL2d)
end

function var_0_0._btntimerankOnClick(arg_7_0)
	if arg_7_0._sortIndex ~= 1 then
		arg_7_0._sortIndex = 1
	else
		arg_7_0._asceTime = not arg_7_0._asceTime
	end

	arg_7_0._asceRare = false

	arg_7_0:_refreshBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_8_0)
	if arg_8_0._sortIndex ~= 2 then
		arg_8_0._sortIndex = 2
	else
		arg_8_0._asceRare = not arg_8_0._asceRare
	end

	arg_8_0._asceTime = false

	arg_8_0:_refreshBtnIcon()
end

function var_0_0._onSwitchHero(arg_9_0, arg_9_1)
	arg_9_0:_switchHero(arg_9_1[1], arg_9_1[2], arg_9_1[3], arg_9_0._isL2d)
end

function var_0_0._switchHeroSkin(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_switchHero(arg_10_1, arg_10_2, false, arg_10_0._isL2d)
end

function var_0_0._switchL2d(arg_11_0)
	arg_11_0._isL2d = not arg_11_0._isL2d

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshSwitchView, {
		heroId = arg_11_0._heroId,
		skinId = arg_11_0._skinId,
		isL2d = arg_11_0._isL2d
	})
end

function var_0_0._switchHero(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_3 then
		arg_12_0:_updateHero(arg_12_0._curHeroId, arg_12_0._curSkinId, arg_12_3, arg_12_4)
	else
		arg_12_0:_updateHero(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	end
end

function var_0_0._showMainHero(arg_13_0)
	arg_13_0._curHeroId, arg_13_0._curSkinId, arg_13_0._curRandom, arg_13_0._curIsL2d = arg_13_0.cardInfo:getMainHero()

	if arg_13_0._curHeroId and arg_13_0._curSkinId then
		arg_13_0:_switchHero(arg_13_0._curHeroId, arg_13_0._curSkinId, arg_13_0._curRandom, arg_13_0._curIsL2d)
		arg_13_0:_refreshSelect()
	end
end

function var_0_0._refreshSelect(arg_14_0)
	local var_14_0 = not arg_14_0._isRandom and arg_14_0._heroId
	local var_14_1 = PlayerCardCharacterSwitchListModel.instance:getMoByHeroId(var_14_0)
	local var_14_2 = arg_14_0.viewContainer.scrollView

	if var_14_1 then
		var_14_2:setSelect(var_14_1)
	end
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0:_updateParam()
	arg_15_0:refreshView()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:_updateParam()
	PlayerCardCharacterSwitchListModel.instance:initHeroList()
	arg_16_0:refreshView()
	arg_16_0:_refreshBtnIcon()
end

function var_0_0._updateParam(arg_17_0)
	arg_17_0.userId = PlayerModel.instance:getMyUserId()
	arg_17_0.cardInfo = PlayerCardModel.instance:getCardInfo(arg_17_0.userId)
end

function var_0_0.refreshView(arg_18_0)
	if not arg_18_0.cardInfo then
		return
	end

	arg_18_0:_showMainHero()
end

function var_0_0._refreshBtnIcon(arg_19_0)
	local var_19_0 = arg_19_0._sortIndex

	if var_19_0 == 1 then
		PlayerCardCharacterSwitchListModel.instance:sortByTime(arg_19_0._asceTime)
	else
		PlayerCardCharacterSwitchListModel.instance:sortByRare(arg_19_0._asceRare)
	end

	gohelper.setActive(arg_19_0._timeBtns[1], var_19_0 ~= 1)
	gohelper.setActive(arg_19_0._timeBtns[2], var_19_0 == 1)
	gohelper.setActive(arg_19_0._rareBtns[1], var_19_0 ~= 2)
	gohelper.setActive(arg_19_0._rareBtns[2], var_19_0 == 2)

	local var_19_1 = arg_19_0._asceTime and -1 or 1
	local var_19_2 = arg_19_0._asceRare and -1 or 1

	transformhelper.setLocalScale(arg_19_0._timeArrow[1], 1, var_19_1, 1)
	transformhelper.setLocalScale(arg_19_0._timeArrow[2], 1, var_19_1, 1)
	transformhelper.setLocalScale(arg_19_0._rareArrow[1], 1, var_19_2, 1)
	transformhelper.setLocalScale(arg_19_0._rareArrow[2], 1, var_19_2, 1)
end

function var_0_0.changeHero(arg_20_0, arg_20_1)
	PlayerCardCharacterSwitchListModel.instance.curHeroId = arg_20_1
end

function var_0_0._updateHero(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if arg_21_3 then
		arg_21_0:changeHero()
	else
		arg_21_0:changeHero(arg_21_1)
	end

	arg_21_0._heroId = arg_21_1
	arg_21_0._skinId = arg_21_2
	arg_21_0._isRandom = arg_21_3
	arg_21_0._isL2d = arg_21_4

	local var_21_0 = HeroModel.instance:getByHeroId(arg_21_0._heroId)

	arg_21_0._heroSkinConfig, arg_21_0._hero = SkinConfig.instance:getSkinCo(arg_21_0._skinId or var_21_0 and var_21_0.skin), var_21_0

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshSwitchView, {
		heroId = arg_21_0._heroId,
		skinId = arg_21_0._skinId,
		isL2d = arg_21_0._isL2d
	})
	PlayerCardModel.instance:setSelectHero(arg_21_0._heroId, arg_21_0._skinId)
end

function var_0_0._onRefreshSwitchView(arg_22_0)
	arg_22_0:showTip()
	arg_22_0:refreshSignature()
	arg_22_0:refreshCreateTime()
	arg_22_0:_showSkinList()
end

function var_0_0.refreshSignature(arg_23_0)
	if not arg_23_0._hero then
		return
	end

	arg_23_0._simagesignature:UnLoadImage()
	arg_23_0._simagesignature:LoadImage(ResUrl.getSignature(arg_23_0._hero.config.signature))
end

function var_0_0.showTip(arg_24_0)
	local var_24_0 = arg_24_0._curHeroId == arg_24_0._heroId and arg_24_0._curSkinId == arg_24_0._skinId and arg_24_0._curRandom == arg_24_0._isRandom and arg_24_0._curIsL2d == arg_24_0._isL2d

	gohelper.setActive(arg_24_0._btnchange.gameObject, not var_24_0)
	gohelper.setActive(arg_24_0._goshowing.gameObject, var_24_0)
end

function var_0_0.refreshCreateTime(arg_25_0)
	if not arg_25_0._hero then
		return
	end

	local var_25_0 = ServerTime.formatTimeInLocal(arg_25_0._hero.createTime / 1000, "%Y / %m / %d")

	if not var_25_0 then
		return
	end

	arg_25_0._txttime.text = var_25_0
end

local var_0_1 = {
	149.2,
	-64.3,
	-151.4
}

function var_0_0._showSkinList(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0._heroId
	local var_26_1 = arg_26_0._skinId
	local var_26_2 = arg_26_0._isRandom

	gohelper.setActive(arg_26_0._goheroskin, not var_26_2)

	if not var_26_0 then
		return
	end

	local var_26_3 = HeroModel.instance:getByHeroId(var_26_0)
	local var_26_4 = tabletool.copy(var_26_3.skinInfoList)

	table.sort(var_26_4, var_0_0._sort)

	local var_26_5 = SkinInfoMO.New()

	var_26_5:init({
		expireSec = 0,
		skin = var_26_3.config.skinId
	})
	table.insert(var_26_4, 1, var_26_5)

	local var_26_6 = arg_26_0:removeDuplicates(var_26_4)

	arg_26_0:_hideAllItems()

	for iter_26_0, iter_26_1 in ipairs(var_26_6) do
		local var_26_7 = iter_26_1.skin

		arg_26_0:_showSkinItem(var_26_0, var_26_7, var_26_7 == var_26_1)
	end

	local var_26_8 = math.min(#var_26_6, #var_0_1)

	recthelper.setAnchorY(arg_26_0._gobgbottom.transform, var_0_1[var_26_8])
end

function var_0_0._sort(arg_27_0, arg_27_1)
	return arg_27_0.skin < arg_27_1.skin
end

function var_0_0.removeDuplicates(arg_28_0, arg_28_1)
	local var_28_0 = {}
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		if not var_28_0[iter_28_1.skin] then
			var_28_0[iter_28_1.skin] = true

			table.insert(var_28_1, iter_28_1)
		end
	end

	return var_28_1
end

function var_0_0._hideAllItems(arg_29_0)
	local var_29_0 = #arg_29_0._showItemList

	for iter_29_0 = 1, var_29_0 do
		local var_29_1 = arg_29_0._showItemList[iter_29_0]

		gohelper.setActive(var_29_1.viewGO, false)
		table.insert(arg_29_0._cacheItemList, var_29_1)

		arg_29_0._showItemList[iter_29_0] = nil
	end
end

function var_0_0._showSkinItem(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = table.remove(arg_30_0._cacheItemList)

	if not var_30_0 then
		local var_30_1 = gohelper.cloneInPlace(arg_30_0._goheroskinItem)

		var_30_0 = MonoHelper.addLuaComOnceToGo(var_30_1, PlayerCardCharacterSwitchSkinItem)
	end

	gohelper.setAsLastSibling(var_30_0.viewGO)
	table.insert(arg_30_0._showItemList, var_30_0)
	var_30_0:showSkin(arg_30_1, arg_30_2)
	var_30_0:setSelected(arg_30_3)
end

function var_0_0.onClose(arg_31_0)
	arg_31_0.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseHeroView)
end

function var_0_0.onDestroyView(arg_32_0)
	arg_32_0._simagesignature:UnLoadImage()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, arg_32_0)
end

return var_0_0
