module("modules.logic.character.view.CharacterTalentStyleView", package.seeall)

local var_0_0 = class("CharacterTalentStyleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagefrontbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_frontbg")
	arg_1_0._goinspirationItem = gohelper.findChild(arg_1_0.viewGO, "#go_inspirationItem")
	arg_1_0._gocubeinfo = gohelper.findChild(arg_1_0.viewGO, "#go_cubeinfo")
	arg_1_0._txtcompareStyleName = gohelper.findChildText(arg_1_0.viewGO, "#go_cubeinfo/panel/compare/title/name/#txt_compareStyleName")
	arg_1_0._txtcompareLabel = gohelper.findChildText(arg_1_0.viewGO, "#go_cubeinfo/panel/compare/title/desc/go_career/#txt_compareLabel")
	arg_1_0._gocurrency = gohelper.findChild(arg_1_0.viewGO, "#go_cubeinfo/panel/compare/#go_currency")
	arg_1_0._txtcurStyleName = gohelper.findChildText(arg_1_0.viewGO, "#go_cubeinfo/panel/cur/title/name/#txt_curStyleName")
	arg_1_0._txtcurLabel = gohelper.findChildText(arg_1_0.viewGO, "#go_cubeinfo/panel/cur/title/desc/go_career/#txt_curLabel")
	arg_1_0._gostate = gohelper.findChild(arg_1_0.viewGO, "#go_cubeinfo/#go_state")
	arg_1_0._btncompare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cubeinfo/#go_state/#btn_compare")
	arg_1_0._btninteam = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cubeinfo/#go_state/#btn_inteam")
	arg_1_0._btnfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cubeinfo/#go_state/#btn_fold")
	arg_1_0._gorequest = gohelper.findChild(arg_1_0.viewGO, "go_unlock/#go_request")
	arg_1_0._gocaneasycombinetip = gohelper.findChild(arg_1_0.viewGO, "go_unlock/layout/txt_onceCombine")
	arg_1_0._btnunlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_unlock/layout/#btn_unlock")
	arg_1_0._txtunlockpercent = gohelper.findChildText(arg_1_0.viewGO, "go_unlock/layout/#btn_unlock/#txt_unlockpercent")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_unlock/#btn_use")
	arg_1_0._gousing = gohelper.findChild(arg_1_0.viewGO, "go_unlock/#go_using")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "go_unlock/#go_reward")
	arg_1_0._scrollstyle = gohelper.findChildScrollRect(arg_1_0.viewGO, "go_style/#scroll_style")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_style/#item_style/#btn_click")
	arg_1_0._txtstyle = gohelper.findChildText(arg_1_0.viewGO, "go_style/#item_style/#txt_style")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "go_style/#item_style/#go_select")
	arg_1_0._gouse = gohelper.findChild(arg_1_0.viewGO, "go_style/#item_style/#go_use")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "go_style/#item_style/#go_new")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gorightbtns = gohelper.findChild(arg_1_0.viewGO, "#go_rightbtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncompare:AddClickListener(arg_2_0._btncompareOnClick, arg_2_0)
	arg_2_0._btninteam:AddClickListener(arg_2_0._btninteamOnClick, arg_2_0)
	arg_2_0._btnfold:AddClickListener(arg_2_0._btnfoldOnClick, arg_2_0)
	arg_2_0._btnunlock:AddClickListener(arg_2_0._btnunlockOnClick, arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._btnuseOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncompare:RemoveClickListener()
	arg_3_0._btninteam:RemoveClickListener()
	arg_3_0._btnfold:RemoveClickListener()
	arg_3_0._btnunlock:RemoveClickListener()
	arg_3_0._btnuse:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnStatOnClick(arg_4_0)
	local var_4_0 = {
		heroId = arg_4_0._heroId
	}

	CharacterController.instance:openCharacterTalentStatView(var_4_0)
end

function var_0_0._btnuseOnClick(arg_5_0)
	local var_5_0 = arg_5_0:_getSelectCubeMo()

	TalentStyleModel.instance:UseStyle(arg_5_0._heroId, var_5_0)
end

function var_0_0._btncompareOnClick(arg_6_0)
	arg_6_0:_showComparePanel()
	arg_6_0:_showCurCubeAttr()
end

function var_0_0._btninteamOnClick(arg_7_0)
	return
end

function var_0_0._btnfoldOnClick(arg_8_0)
	arg_8_0:_hideComparePanel()
	arg_8_0:_showCurCubeAttr()
end

function var_0_0._btnclickOnClick(arg_9_0)
	return
end

function var_0_0._btnunlockOnClick(arg_10_0)
	local var_10_0 = arg_10_0:_getSelectCubeMo()
	local var_10_1, var_10_2, var_10_3, var_10_4 = arg_10_0:_isEnoughUnlock()

	if var_10_3 then
		if not var_10_0._isUnlock then
			var_10_0._isUnlock = true

			HeroRpc.instance:setUnlockTalentStyleRequest(arg_10_0._heroId, var_10_0._styleId)
		end
	elseif arg_10_0._canEasyCombine then
		PopupCacheModel.instance:setViewIgnoreGetPropView(arg_10_0.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
		RoomProductionHelper.openRoomFormulaMsgBoxView(arg_10_0._easyCombineTable, arg_10_0._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, arg_10_0._onEasyCombineFinished, arg_10_0)

		return
	else
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_10_4, var_10_2)
	end
end

function var_0_0._onEasyCombineFinished(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	PopupCacheModel.instance:setViewIgnoreGetPropView(arg_11_0.viewName, false)

	if arg_11_2 ~= 0 then
		return
	end

	arg_11_0:_btnunlockOnClick()
end

function var_0_0._addEvents(arg_12_0)
	arg_12_0:addEventCb(CharacterController.instance, CharacterEvent.onUnlockTalentStyleReply, arg_12_0._onUnlockTalentStyleReply, arg_12_0)
	arg_12_0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_12_0._onUseTalentStyleReply, arg_12_0)
	arg_12_0:addEventCb(CharacterController.instance, CharacterEvent.onSelectTalentStyle, arg_12_0._onSelectTalentStyle, arg_12_0)
	arg_12_0:addEventCb(CharacterController.instance, CharacterEvent.onHeroTalentStyleStatReply, arg_12_0._onHeroTalentStyleStatReply, arg_12_0)
	arg_12_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_12_0.currencyChangeEvent, arg_12_0)
	arg_12_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_12_0.currencyChangeEvent, arg_12_0)
	arg_12_0._scrollstyle:AddOnValueChanged(arg_12_0._onScrollValueChanged, arg_12_0)

	local var_12_0 = arg_12_0:_getNavigateView()

	if var_12_0 then
		var_12_0:setOverrideStat(arg_12_0._btnStatOnClick, arg_12_0)
	end
end

function var_0_0._removeEvents(arg_13_0)
	arg_13_0:removeEventCb(CharacterController.instance, CharacterEvent.onUnlockTalentStyleReply, arg_13_0._onUnlockTalentStyleReply, arg_13_0)
	arg_13_0:removeEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_13_0._onUseTalentStyleReply, arg_13_0)
	arg_13_0:removeEventCb(CharacterController.instance, CharacterEvent.onSelectTalentStyle, arg_13_0._onSelectTalentStyle, arg_13_0)
	arg_13_0:removeEventCb(CharacterController.instance, CharacterEvent.onHeroTalentStyleStatReply, arg_13_0._onHeroTalentStyleStatReply, arg_13_0)
	arg_13_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_13_0.currencyChangeEvent, arg_13_0)
	arg_13_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_13_0.currencyChangeEvent, arg_13_0)
	arg_13_0._animEvent:RemoveAllEventListener()
	arg_13_0._scrollstyle:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_14_0)
	local var_14_0 = gohelper.findChild(arg_14_0.viewGO, "#go_cubeinfo/panel")

	arg_14_0._attrItem = gohelper.findChild(var_14_0, "attributeItem")
	arg_14_0._curAttrPanel = gohelper.findChild(var_14_0, "cur/panel")
	arg_14_0._compareAttrPanel = gohelper.findChild(var_14_0, "compare/panel")
	arg_14_0._objCompareAttrPanel = gohelper.findChild(var_14_0, "compare")
	arg_14_0._itemCircle = gohelper.findChild(arg_14_0.viewGO, "#go_inspirationItem/item/slot/dec1")
	arg_14_0._txtunlock = gohelper.findChildText(arg_14_0.viewGO, "go_unlock/#btn_unlock/txt")
	arg_14_0._gounlock = gohelper.findChild(arg_14_0.viewGO, "go_unlock")
	arg_14_0._goitemUnlock = gohelper.findChild(arg_14_0.viewGO, "#go_inspirationItem/item/#unlock")
	arg_14_0._goitemUse = gohelper.findChild(arg_14_0.viewGO, "#go_inspirationItem/item/#use")
	arg_14_0._animUnlock = SLFramework.AnimatorPlayer.Get(arg_14_0._gounlock)
	arg_14_0._requestCanvas = arg_14_0._gorequest:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_14_0._txtusing = gohelper.findChildText(arg_14_0.viewGO, "go_unlock/#go_using/txt_using")
	arg_14_0._txtuse = gohelper.findChildText(arg_14_0.viewGO, "go_unlock/#btn_use/txt")

	arg_14_0:_hideItemUnlock()
	arg_14_0:_hideItemUse()
	gohelper.setActive(arg_14_0._attrItem, false)
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:_addEvents()

	arg_16_0._isHideNewTag = nil
	arg_16_0._attrItems = arg_16_0:getUserDataTb_()

	TalentStyleModel.instance:setNewUnlockStyle()
	TalentStyleModel.instance:setNewSelectStyle()

	arg_16_0._animPlayer = SLFramework.AnimatorPlayer.Get(arg_16_0.viewGO)
	arg_16_0._animEvent = arg_16_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_16_0._animEvent:AddEventListener("switch", arg_16_0._refreshView, arg_16_0)

	if not arg_16_0.viewParam.isJustOpen then
		arg_16_0._animPlayer:Play("open", nil, arg_16_0)
	end

	arg_16_0._heroId = arg_16_0.viewParam.hero_id
	arg_16_0._heroMo = HeroModel.instance:getByHeroId(arg_16_0._heroId)

	local var_16_0 = luaLang("talent_style_title_using_cn_" .. arg_16_0._heroMo:getTalentTxtByHeroType())
	local var_16_1 = luaLang("talent_style_title_use_cn_" .. arg_16_0._heroMo:getTalentTxtByHeroType())

	arg_16_0._txtusing.text = var_16_0
	arg_16_0._txtuse.text = var_16_1

	TalentStyleModel.instance:openView(arg_16_0._heroId)
	arg_16_0:_initInspirationItem()

	arg_16_0._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(arg_16_0._heroId)

	arg_16_0:_hideComparePanel()
	arg_16_0:_refreshView()

	local var_16_2 = arg_16_0:_getNavigateView()

	if var_16_2 then
		var_16_2:showStatBtn(false)
	end

	HeroRpc.instance:setTalentStyleReadRequest(arg_16_0._heroId)
	HeroRpc.instance:setHeroTalentStyleStatRequest(arg_16_0._heroId)
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_18_0._hideItemUse, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._hideItemUnlock, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._hideNewTag, arg_18_0)
end

function var_0_0._refreshView(arg_19_0)
	TalentStyleListModel.instance:refreshData(arg_19_0._heroId)
	arg_19_0:_refreshAttribute()
	arg_19_0:_refreshUnlockItem()
	arg_19_0:_refreshBtn()
	arg_19_0:_refreshAttrCompareBtn()
	arg_19_0:_refreshInspirationItem()
end

function var_0_0._onScrollValueChanged(arg_20_0)
	if arg_20_0._isHideNewTag then
		return
	end

	arg_20_0._isHideNewTag = true

	TaskDispatcher.runDelay(arg_20_0._hideNewTag, arg_20_0, 0.2)
end

function var_0_0._hideNewTag(arg_21_0)
	TalentStyleModel.instance:hideNewState(arg_21_0._heroId)
end

function var_0_0._initInspirationItem(arg_22_0)
	local var_22_0 = TalentStyleModel.instance:getHeroMainCubeMo(arg_22_0._heroId)
	local var_22_1 = gohelper.findChild(arg_22_0._goinspirationItem, "item")

	arg_22_0._slot = gohelper.findChildImage(var_22_1, "slot")
	arg_22_0._slotAnim = arg_22_0._slot:GetComponent(typeof(UnityEngine.Animator))
	arg_22_0._cubeIcon = gohelper.findChildImage(var_22_1, "slot/icon")
	arg_22_0._cubeglow = gohelper.findChildImage(var_22_1, "slot/glow")

	local var_22_2 = gohelper.findChildText(var_22_1, "level/level")
	local var_22_3 = HeroResonanceConfig.instance:getCubeConfig(var_22_0.id)
	local var_22_4 = string.split(var_22_3.icon, "_")

	arg_22_0._slotSprite = "gz_" .. var_22_4[#var_22_4]
	var_22_2.text = "Lv." .. var_22_0.level
end

local var_0_1 = Color.white
local var_0_2 = Color(1, 1, 1, 0.5)

function var_0_0._refreshInspirationItem(arg_23_0)
	local var_23_0 = TalentStyleModel.instance:getSelectCubeMo(arg_23_0._heroId)
	local var_23_1 = var_23_0._replaceId
	local var_23_2 = arg_23_0._heroMo.talentCubeInfos.own_main_cube_id
	local var_23_3 = HeroResonanceConfig.instance:getCubeConfig(var_23_1)
	local var_23_4 = arg_23_0._slotSprite
	local var_23_5 = 1.7

	if var_23_3 then
		local var_23_6 = var_23_3.icon
		local var_23_7 = var_23_6

		if var_23_2 ~= var_23_1 and not string.nilorempty(var_23_6) then
			var_23_7 = "mk_" .. var_23_6
			var_23_4 = arg_23_0._slotSprite .. "_2"
		end

		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_23_0._cubeIcon, var_23_7, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_23_0._cubeglow, var_23_7, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_23_0._slot, var_23_4, true)
		transformhelper.setLocalScale(arg_23_0._slot.transform, var_23_5, var_23_5, var_23_5)
	end

	local var_23_8 = var_23_0._isUnlock
	local var_23_9 = var_23_0._isUse

	gohelper.setActive(arg_23_0._itemCircle, var_23_9)

	arg_23_0._cubeIcon.enabled = var_23_9
	arg_23_0._slotAnim.enabled = var_23_8

	arg_23_0._slotAnim:Play("slot_loop", 0, 0)

	arg_23_0._slot.color = var_23_8 and var_0_1 or var_0_2
	arg_23_0._cubeglow.color = var_23_8 and var_0_1 or var_0_2

	gohelper.setActive(arg_23_0._cubeIcon.gameObject, var_23_8)
end

function var_0_0._getAttributeDataList(arg_24_0, arg_24_1)
	if not arg_24_0._cubeAttrDataList then
		arg_24_0._cubeAttrDataList = {}
	end

	if arg_24_0._cubeAttrDataList[arg_24_1] then
		return arg_24_0._cubeAttrDataList[arg_24_1]
	end

	local var_24_0 = TalentStyleModel.instance:getHeroMainCubeMo(arg_24_0._heroId).level
	local var_24_1 = HeroConfig.instance:getTalentCubeAttrConfig(arg_24_1, var_24_0)
	local var_24_2 = {}

	arg_24_0._heroMo:getTalentAttrGainSingle(arg_24_1, var_24_2, nil, nil, var_24_0)

	local var_24_3 = {}

	for iter_24_0, iter_24_1 in pairs(var_24_2) do
		table.insert(var_24_3, {
			key = iter_24_0,
			value = iter_24_1,
			is_special = var_24_1.calculateType == 1,
			config = var_24_1
		})
	end

	table.sort(var_24_3, arg_24_0.sortAttr)

	arg_24_0._cubeAttrDataList[arg_24_1] = var_24_3

	return var_24_3
end

function var_0_0.sortAttr(arg_25_0, arg_25_1)
	if arg_25_0.isDelete ~= arg_25_1.isDelete then
		return arg_25_1.isDelete
	end

	return HeroConfig.instance:getIDByAttrType(arg_25_0.key) < HeroConfig.instance:getIDByAttrType(arg_25_1.key)
end

function var_0_0._showComparePanel(arg_26_0)
	local var_26_0 = TalentStyleModel.instance:getHeroUseCubeId(arg_26_0._heroId)
	local var_26_1 = arg_26_0:_getAttributeDataList(var_26_0)

	arg_26_0:_showAttrItem(2, var_26_1, arg_26_0._compareAttrPanel)
	gohelper.setActive(arg_26_0._objCompareAttrPanel, true)

	local var_26_2, var_26_3 = TalentStyleModel.instance:getHeroUseCubeMo(arg_26_0._heroId):getStyleTag()

	arg_26_0._txtcompareStyleName.text = var_26_2
	arg_26_0._txtcompareLabel.text = var_26_3

	arg_26_0:_refreshAttrCompareBtn()
end

function var_0_0._hideComparePanel(arg_27_0)
	gohelper.setActive(arg_27_0._objCompareAttrPanel, false)
	arg_27_0:_refreshAttrCompareBtn()
end

function var_0_0._refreshAttrCompareBtn(arg_28_0)
	local var_28_0 = TalentStyleModel.instance:getSelectStyleId(arg_28_0._heroId) == TalentStyleModel.instance:getHeroUseCubeStyleId(arg_28_0._heroId)
	local var_28_1 = arg_28_0._objCompareAttrPanel.gameObject.activeSelf

	if var_28_0 and var_28_1 then
		gohelper.setActive(arg_28_0._objCompareAttrPanel, false)

		var_28_1 = false
	end

	gohelper.setActive(arg_28_0._gounlock, not var_28_1)
	gohelper.setActive(arg_28_0._gorightbtns, not var_28_1)
	gohelper.setActive(arg_28_0._btncompare.gameObject, not var_28_0 and not var_28_1)
	gohelper.setActive(arg_28_0._btninteam.gameObject, var_28_0)
	gohelper.setActive(arg_28_0._btnfold.gameObject, var_28_1)
end

function var_0_0._getCurAttributeDataList(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:_getAttributeDataList(arg_29_1)
	local var_29_1 = TalentStyleModel.instance:getHeroUseCubeId(arg_29_0._heroId)
	local var_29_2 = tabletool.copy(var_29_0)

	if var_29_1 ~= arg_29_1 and arg_29_0._objCompareAttrPanel.gameObject.activeSelf then
		local var_29_3 = arg_29_0:_getAttributeDataList(var_29_1)

		for iter_29_0, iter_29_1 in ipairs(var_29_0) do
			local var_29_4 = arg_29_0:getMainCubeAttrDataByType(var_29_3, iter_29_1.key)

			if var_29_4 then
				if iter_29_1.value ~= var_29_4.value then
					iter_29_1.changeNum = iter_29_1.value - var_29_4.value
				end
			else
				iter_29_1.isNew = true
			end
		end

		for iter_29_2, iter_29_3 in ipairs(var_29_3) do
			if not arg_29_0:getMainCubeAttrDataByType(var_29_0, iter_29_3.key) then
				local var_29_5 = tabletool.copy(iter_29_3)

				var_29_5.isDelete = true

				table.insert(var_29_2, var_29_5)
			end
		end
	else
		for iter_29_4, iter_29_5 in ipairs(var_29_0) do
			iter_29_5.changeNum = nil
			iter_29_5.isNew = nil
			iter_29_5.isDelete = nil
		end
	end

	table.sort(var_29_2, arg_29_0.sortAttr)

	return var_29_2
end

function var_0_0.getMainCubeAttrDataByType(arg_30_0, arg_30_1, arg_30_2)
	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		if iter_30_1.key == arg_30_2 then
			return iter_30_1
		end
	end
end

function var_0_0._getAttrItem(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if not arg_31_0._attrItems[arg_31_1] then
		local var_31_0 = arg_31_0:getUserDataTb_()

		arg_31_0._attrItems[arg_31_1] = var_31_0
	end

	local var_31_1 = arg_31_0._attrItems[arg_31_1][arg_31_2]

	if not var_31_1 then
		local var_31_2 = gohelper.clone(arg_31_0._attrItem, arg_31_3, "item_" .. arg_31_2)

		var_31_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_31_2, CharacterTalentStyleAttrItem)
		arg_31_0._attrItems[arg_31_1][arg_31_2] = var_31_1
	end

	return var_31_1
end

function var_0_0._showAttrItem(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	for iter_32_0, iter_32_1 in ipairs(arg_32_2) do
		arg_32_0:_getAttrItem(arg_32_1, iter_32_0, arg_32_3):onRefreshMo(iter_32_0, iter_32_1)
	end

	for iter_32_2 = 1, #arg_32_0._attrItems[arg_32_1] do
		local var_32_0 = arg_32_0._attrItems[arg_32_1][iter_32_2]

		gohelper.setActive(var_32_0.viewGO, iter_32_2 <= #arg_32_2)
	end
end

function var_0_0._refreshAttribute(arg_33_0)
	local var_33_0 = arg_33_0:_getSelectCubeMo()

	arg_33_0:_showCurCubeAttr()

	local var_33_1, var_33_2 = var_33_0:getStyleTag()

	arg_33_0._txtcurStyleName.text = var_33_1
	arg_33_0._txtcurLabel.text = var_33_2
end

function var_0_0._showCurCubeAttr(arg_34_0)
	local var_34_0 = arg_34_0:_getSelectCubeMo()._replaceId
	local var_34_1 = arg_34_0:_getCurAttributeDataList(var_34_0)

	arg_34_0:_showAttrItem(1, var_34_1, arg_34_0._curAttrPanel)
end

function var_0_0._refreshBtn(arg_35_0)
	local var_35_0 = arg_35_0:_getSelectCubeMo()
	local var_35_1 = var_35_0._isUnlock
	local var_35_2 = var_35_1 and var_35_0._isUse

	gohelper.setActive(arg_35_0._btnunlock.gameObject, not var_35_1)
	gohelper.setActive(arg_35_0._btnuse.gameObject, var_35_1 and not var_35_2)
	gohelper.setActive(arg_35_0._gousing.gameObject, var_35_1 and var_35_2)

	if not var_35_1 then
		local var_35_3, var_35_4, var_35_5, var_35_6 = arg_35_0:_isEnoughUnlock()

		ZProj.UGUIHelper.SetGrayscale(arg_35_0._btnunlock.gameObject, not var_35_5 and not arg_35_0._canEasyCombine)

		if var_35_0:isHotUnlock() then
			local var_35_7 = luaLang("character_talentstyle_unlockpercent")
			local var_35_8 = string.format("%.1f", var_35_0:getUnlockPercent() * 0.01)

			arg_35_0._txtunlockpercent.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_35_7, var_35_8)
		end

		gohelper.setActive(arg_35_0._txtunlockpercent.gameObject, var_35_0:isHotUnlock())
	end

	gohelper.setActive(arg_35_0._gorequest, not var_35_1)

	arg_35_0._requestCanvas.alpha = var_35_1 and 0 or 1
end

function var_0_0._refreshUnlockItem(arg_36_0)
	local var_36_0 = arg_36_0:_getSelectCubeMo()

	arg_36_0._canEasyCombine = false

	if not var_36_0._isUnlock then
		local var_36_1 = arg_36_0:_isEnoughUnlock()

		arg_36_0._lackedItemDataList = {}
		arg_36_0._occupyItemDic = {}

		IconMgr.instance:getCommonPropItemIconList(arg_36_0, arg_36_0._onCostItemShow, var_36_1, arg_36_0._gorequest)

		arg_36_0._canEasyCombine, arg_36_0._easyCombineTable = RoomProductionHelper.canEasyCombineItems(arg_36_0._lackedItemDataList, arg_36_0._occupyItemDic)
		arg_36_0._occupyItemDic = nil
	end

	gohelper.setActive(arg_36_0._gocaneasycombinetip, arg_36_0._canEasyCombine)
end

function var_0_0._isEnoughUnlock(arg_37_0)
	local var_37_0 = TalentStyleModel.instance:getSelectStyleId(arg_37_0._heroId)
	local var_37_1 = HeroResonanceConfig.instance:getTalentStyleUnlockConsume(arg_37_0._heroId, var_37_0)

	if var_37_1 then
		local var_37_2 = ItemModel.instance:getItemDataListByConfigStr(var_37_1)
		local var_37_3, var_37_4, var_37_5 = ItemModel.instance:hasEnoughItemsByCellData(var_37_2)

		return var_37_2, var_37_3, var_37_4, var_37_5
	end

	return nil, "", true, nil
end

function var_0_0._onCostItemShow(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	transformhelper.setLocalScale(arg_38_1.viewGO.transform, 0.59, 0.59, 1)
	arg_38_1:onUpdateMO(arg_38_2)
	arg_38_1:setConsume(true)
	arg_38_1:showStackableNum2()
	arg_38_1:isShowEffect(true)
	arg_38_1:setAutoPlay(true)
	arg_38_1:setCountFontSize(48)

	local var_38_0 = arg_38_2.materilType
	local var_38_1 = arg_38_2.materilId
	local var_38_2 = arg_38_2.quantity
	local var_38_3, var_38_4 = ItemModel.instance:getItemIsEnoughText(arg_38_2)

	if var_38_4 then
		table.insert(arg_38_0._lackedItemDataList, {
			type = var_38_0,
			id = var_38_1,
			quantity = var_38_4
		})
	else
		if not arg_38_0._occupyItemDic[var_38_0] then
			arg_38_0._occupyItemDic[var_38_0] = {}
		end

		arg_38_0._occupyItemDic[var_38_0][var_38_1] = (arg_38_0._occupyItemDic[var_38_0][var_38_1] or 0) + var_38_2
	end

	arg_38_1:setCountText(var_38_3)
	arg_38_1:setOnBeforeClickCallback(arg_38_0.onBeforeClickItem, arg_38_0)
	arg_38_1:setRecordFarmItem({
		type = var_38_0,
		id = var_38_1,
		quantity = var_38_2
	})
end

function var_0_0.onBeforeClickItem(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = JumpController.instance:getCurrentOpenedView()

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		if iter_39_1.viewName == ViewName.CharacterTalentStyleView then
			iter_39_1.viewParam.isJustOpen = true

			break
		end
	end

	arg_39_2:setRecordFarmItem({
		type = arg_39_2._itemType,
		id = arg_39_2._itemId,
		quantity = arg_39_2._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = var_39_0
	})
end

function var_0_0._getSelectCubeMo(arg_40_0)
	if not arg_40_0._selectCubeMo then
		arg_40_0._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(arg_40_0._heroId)
	end

	return arg_40_0._selectCubeMo
end

function var_0_0._onUnlockTalentStyleReply(arg_41_0, arg_41_1)
	TalentStyleModel.instance:refreshUnlockList(arg_41_1.heroId)
	arg_41_0:_hideComparePanel()
	arg_41_0._animUnlock:Play("unlock", arg_41_0._unlockAnimEnd, arg_41_0)
	TalentStyleModel.instance:setNewUnlockStyle(arg_41_1.style)
	TaskDispatcher.cancelTask(arg_41_0._hideItemUnlock, arg_41_0)
	gohelper.setActive(arg_41_0._goitemUnlock, true)
	TaskDispatcher.runDelay(arg_41_0._hideItemUnlock, arg_41_0, 1.2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_unlock_02)
end

function var_0_0._unlockAnimEnd(arg_42_0)
	arg_42_0:_refreshView()
end

function var_0_0._hideItemUnlock(arg_43_0)
	gohelper.setActive(arg_43_0._goitemUnlock, false)
end

function var_0_0._hideItemUse(arg_44_0)
	gohelper.setActive(arg_44_0._goitemUse, false)
end

function var_0_0._onUseTalentStyleReply(arg_45_0, arg_45_1)
	arg_45_0:_hideComparePanel()
	arg_45_0:_refreshView()
	TaskDispatcher.cancelTask(arg_45_0._hideItemUse, arg_45_0)
	gohelper.setActive(arg_45_0._goitemUse, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_fm)
	TaskDispatcher.runDelay(arg_45_0._hideItemUse, arg_45_0, 0.6)
end

function var_0_0._onSelectTalentStyle(arg_46_0, arg_46_1)
	arg_46_0._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(arg_46_0._heroId)

	arg_46_0._animPlayer:Play("switch", nil, arg_46_0)
end

function var_0_0.currencyChangeEvent(arg_47_0)
	arg_47_0:_refreshUnlockItem()
	arg_47_0:_refreshBtn()
end

function var_0_0.playCloseAnim(arg_48_0)
	arg_48_0._animPlayer:Play("close", arg_48_0.closeThis, arg_48_0)
end

function var_0_0._onHeroTalentStyleStatReply(arg_49_0, arg_49_1)
	local var_49_0 = #arg_49_1.stylePercentList > 0
	local var_49_1 = arg_49_0:_getNavigateView()

	if var_49_1 then
		var_49_1:showStatBtn(var_49_0)
	end

	if var_49_0 then
		TalentStyleListModel.instance:refreshData(arg_49_1.heroId)
	end
end

function var_0_0._getNavigateView(arg_50_0)
	return arg_50_0.viewContainer:getNavigateView()
end

return var_0_0
