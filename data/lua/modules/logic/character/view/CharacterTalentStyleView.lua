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
	arg_1_0._btnunlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_unlock/#btn_unlock")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_unlock/#btn_use")
	arg_1_0._gousing = gohelper.findChild(arg_1_0.viewGO, "go_unlock/#go_using")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "go_unlock/#go_reward")
	arg_1_0._txtunlockpercent = gohelper.findChildText(arg_1_0.viewGO, "go_unlock/#btn_unlock/#txt_unlockpercent")
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
	else
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_10_4, var_10_2)
	end
end

function var_0_0._addEvents(arg_11_0)
	arg_11_0:addEventCb(CharacterController.instance, CharacterEvent.onUnlockTalentStyleReply, arg_11_0._onUnlockTalentStyleReply, arg_11_0)
	arg_11_0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_11_0._onUseTalentStyleReply, arg_11_0)
	arg_11_0:addEventCb(CharacterController.instance, CharacterEvent.onSelectTalentStyle, arg_11_0._onSelectTalentStyle, arg_11_0)
	arg_11_0:addEventCb(CharacterController.instance, CharacterEvent.onHeroTalentStyleStatReply, arg_11_0._onHeroTalentStyleStatReply, arg_11_0)
	arg_11_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_11_0.currencyChangeEvent, arg_11_0)
	arg_11_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_11_0.currencyChangeEvent, arg_11_0)
	arg_11_0._scrollstyle:AddOnValueChanged(arg_11_0._onScrollValueChanged, arg_11_0)

	local var_11_0 = arg_11_0:_getNavigateView()

	if var_11_0 then
		var_11_0:setOverrideStat(arg_11_0._btnStatOnClick, arg_11_0)
	end
end

function var_0_0._removeEvents(arg_12_0)
	arg_12_0:removeEventCb(CharacterController.instance, CharacterEvent.onUnlockTalentStyleReply, arg_12_0._onUnlockTalentStyleReply, arg_12_0)
	arg_12_0:removeEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_12_0._onUseTalentStyleReply, arg_12_0)
	arg_12_0:removeEventCb(CharacterController.instance, CharacterEvent.onSelectTalentStyle, arg_12_0._onSelectTalentStyle, arg_12_0)
	arg_12_0:removeEventCb(CharacterController.instance, CharacterEvent.onHeroTalentStyleStatReply, arg_12_0._onHeroTalentStyleStatReply, arg_12_0)
	arg_12_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_12_0.currencyChangeEvent, arg_12_0)
	arg_12_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_12_0.currencyChangeEvent, arg_12_0)
	arg_12_0._animEvent:RemoveAllEventListener()
	arg_12_0._scrollstyle:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_13_0)
	local var_13_0 = gohelper.findChild(arg_13_0.viewGO, "#go_cubeinfo/panel")

	arg_13_0._attrItem = gohelper.findChild(var_13_0, "attributeItem")
	arg_13_0._curAttrPanel = gohelper.findChild(var_13_0, "cur/panel")
	arg_13_0._compareAttrPanel = gohelper.findChild(var_13_0, "compare/panel")
	arg_13_0._objCompareAttrPanel = gohelper.findChild(var_13_0, "compare")
	arg_13_0._itemCircle = gohelper.findChild(arg_13_0.viewGO, "#go_inspirationItem/item/slot/dec1")
	arg_13_0._txtunlock = gohelper.findChildText(arg_13_0.viewGO, "go_unlock/#btn_unlock/txt")
	arg_13_0._gounlock = gohelper.findChild(arg_13_0.viewGO, "go_unlock")
	arg_13_0._goitemUnlock = gohelper.findChild(arg_13_0.viewGO, "#go_inspirationItem/item/#unlock")
	arg_13_0._goitemUse = gohelper.findChild(arg_13_0.viewGO, "#go_inspirationItem/item/#use")
	arg_13_0._animUnlock = SLFramework.AnimatorPlayer.Get(arg_13_0._gounlock)
	arg_13_0._requestCanvas = arg_13_0._gorequest:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_13_0._txtusing = gohelper.findChildText(arg_13_0.viewGO, "go_unlock/#go_using/txt_using")
	arg_13_0._txtuse = gohelper.findChildText(arg_13_0.viewGO, "go_unlock/#btn_use/txt")

	arg_13_0:_hideItemUnlock()
	arg_13_0:_hideItemUse()
	gohelper.setActive(arg_13_0._attrItem, false)
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:_addEvents()

	arg_15_0._isHideNewTag = nil
	arg_15_0._attrItems = arg_15_0:getUserDataTb_()

	TalentStyleModel.instance:setNewUnlockStyle()
	TalentStyleModel.instance:setNewSelectStyle()

	arg_15_0._animPlayer = SLFramework.AnimatorPlayer.Get(arg_15_0.viewGO)
	arg_15_0._animEvent = arg_15_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_15_0._animEvent:AddEventListener("switch", arg_15_0._refreshView, arg_15_0)

	if not arg_15_0.viewParam.isJustOpen then
		arg_15_0._animPlayer:Play("open", nil, arg_15_0)
	end

	arg_15_0._heroId = arg_15_0.viewParam.hero_id
	arg_15_0._heroMo = HeroModel.instance:getByHeroId(arg_15_0._heroId)

	local var_15_0 = luaLang("talent_style_title_using_cn_" .. arg_15_0._heroMo:getTalentTxtByHeroType())
	local var_15_1 = luaLang("talent_style_title_use_cn_" .. arg_15_0._heroMo:getTalentTxtByHeroType())

	arg_15_0._txtusing.text = var_15_0
	arg_15_0._txtuse.text = var_15_1

	TalentStyleModel.instance:openView(arg_15_0._heroId)
	arg_15_0:_initInspirationItem()

	arg_15_0._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(arg_15_0._heroId)

	arg_15_0:_hideComparePanel()
	arg_15_0:_refreshView()

	local var_15_2 = arg_15_0:_getNavigateView()

	if var_15_2 then
		var_15_2:showStatBtn(false)
	end

	HeroRpc.instance:setTalentStyleReadRequest(arg_15_0._heroId)
	HeroRpc.instance:setHeroTalentStyleStatRequest(arg_15_0._heroId)
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_17_0._hideItemUse, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._hideItemUnlock, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._hideNewTag, arg_17_0)
end

function var_0_0._refreshView(arg_18_0)
	TalentStyleListModel.instance:refreshData(arg_18_0._heroId)
	arg_18_0:_refreshAttribute()
	arg_18_0:_refreshBtn()
	arg_18_0:_refreshUnlockItem()
	arg_18_0:_refreshAttrCompareBtn()
	arg_18_0:_refreshInspirationItem()
end

function var_0_0._onScrollValueChanged(arg_19_0)
	if arg_19_0._isHideNewTag then
		return
	end

	arg_19_0._isHideNewTag = true

	TaskDispatcher.runDelay(arg_19_0._hideNewTag, arg_19_0, 0.2)
end

function var_0_0._hideNewTag(arg_20_0)
	TalentStyleModel.instance:hideNewState(arg_20_0._heroId)
end

function var_0_0._initInspirationItem(arg_21_0)
	local var_21_0 = TalentStyleModel.instance:getHeroMainCubeMo(arg_21_0._heroId)
	local var_21_1 = gohelper.findChild(arg_21_0._goinspirationItem, "item")

	arg_21_0._slot = gohelper.findChildImage(var_21_1, "slot")
	arg_21_0._slotAnim = arg_21_0._slot:GetComponent(typeof(UnityEngine.Animator))
	arg_21_0._cubeIcon = gohelper.findChildImage(var_21_1, "slot/icon")
	arg_21_0._cubeglow = gohelper.findChildImage(var_21_1, "slot/glow")

	local var_21_2 = gohelper.findChildText(var_21_1, "level/level")
	local var_21_3 = HeroResonanceConfig.instance:getCubeConfig(var_21_0.id)
	local var_21_4 = string.split(var_21_3.icon, "_")

	arg_21_0._slotSprite = "gz_" .. var_21_4[#var_21_4]
	var_21_2.text = "Lv." .. var_21_0.level
end

local var_0_1 = Color.white
local var_0_2 = Color(1, 1, 1, 0.5)

function var_0_0._refreshInspirationItem(arg_22_0)
	local var_22_0 = TalentStyleModel.instance:getSelectCubeMo(arg_22_0._heroId)
	local var_22_1 = var_22_0._replaceId
	local var_22_2 = arg_22_0._heroMo.talentCubeInfos.own_main_cube_id
	local var_22_3 = HeroResonanceConfig.instance:getCubeConfig(var_22_1)
	local var_22_4 = arg_22_0._slotSprite
	local var_22_5 = 1.7

	if var_22_3 then
		local var_22_6 = var_22_3.icon
		local var_22_7 = var_22_6

		if var_22_2 ~= var_22_1 and not string.nilorempty(var_22_6) then
			var_22_7 = "mk_" .. var_22_6
			var_22_4 = arg_22_0._slotSprite .. "_2"
		end

		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_22_0._cubeIcon, var_22_7, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_22_0._cubeglow, var_22_7, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_22_0._slot, var_22_4, true)
		transformhelper.setLocalScale(arg_22_0._slot.transform, var_22_5, var_22_5, var_22_5)
	end

	local var_22_8 = var_22_0._isUnlock
	local var_22_9 = var_22_0._isUse

	gohelper.setActive(arg_22_0._itemCircle, var_22_9)

	arg_22_0._cubeIcon.enabled = var_22_9
	arg_22_0._slotAnim.enabled = var_22_8

	arg_22_0._slotAnim:Play("slot_loop", 0, 0)

	arg_22_0._slot.color = var_22_8 and var_0_1 or var_0_2
	arg_22_0._cubeglow.color = var_22_8 and var_0_1 or var_0_2

	gohelper.setActive(arg_22_0._cubeIcon.gameObject, var_22_8)
end

function var_0_0._getAttributeDataList(arg_23_0, arg_23_1)
	if not arg_23_0._cubeAttrDataList then
		arg_23_0._cubeAttrDataList = {}
	end

	if arg_23_0._cubeAttrDataList[arg_23_1] then
		return arg_23_0._cubeAttrDataList[arg_23_1]
	end

	local var_23_0 = TalentStyleModel.instance:getHeroMainCubeMo(arg_23_0._heroId).level
	local var_23_1 = HeroConfig.instance:getTalentCubeAttrConfig(arg_23_1, var_23_0)
	local var_23_2 = {}

	arg_23_0._heroMo:getTalentAttrGainSingle(arg_23_1, var_23_2, nil, nil, var_23_0)

	local var_23_3 = {}

	for iter_23_0, iter_23_1 in pairs(var_23_2) do
		table.insert(var_23_3, {
			key = iter_23_0,
			value = iter_23_1,
			is_special = var_23_1.calculateType == 1,
			config = var_23_1
		})
	end

	table.sort(var_23_3, arg_23_0.sortAttr)

	arg_23_0._cubeAttrDataList[arg_23_1] = var_23_3

	return var_23_3
end

function var_0_0.sortAttr(arg_24_0, arg_24_1)
	if arg_24_0.isDelete ~= arg_24_1.isDelete then
		return arg_24_1.isDelete
	end

	return HeroConfig.instance:getIDByAttrType(arg_24_0.key) < HeroConfig.instance:getIDByAttrType(arg_24_1.key)
end

function var_0_0._showComparePanel(arg_25_0)
	local var_25_0 = TalentStyleModel.instance:getHeroUseCubeId(arg_25_0._heroId)
	local var_25_1 = arg_25_0:_getAttributeDataList(var_25_0)

	arg_25_0:_showAttrItem(2, var_25_1, arg_25_0._compareAttrPanel)
	gohelper.setActive(arg_25_0._objCompareAttrPanel, true)

	local var_25_2, var_25_3 = TalentStyleModel.instance:getHeroUseCubeMo(arg_25_0._heroId):getStyleTag()

	arg_25_0._txtcompareStyleName.text = var_25_2
	arg_25_0._txtcompareLabel.text = var_25_3

	arg_25_0:_refreshAttrCompareBtn()
end

function var_0_0._hideComparePanel(arg_26_0)
	gohelper.setActive(arg_26_0._objCompareAttrPanel, false)
	arg_26_0:_refreshAttrCompareBtn()
end

function var_0_0._refreshAttrCompareBtn(arg_27_0)
	local var_27_0 = TalentStyleModel.instance:getSelectStyleId(arg_27_0._heroId) == TalentStyleModel.instance:getHeroUseCubeStyleId(arg_27_0._heroId)
	local var_27_1 = arg_27_0._objCompareAttrPanel.gameObject.activeSelf

	if var_27_0 and var_27_1 then
		gohelper.setActive(arg_27_0._objCompareAttrPanel, false)

		var_27_1 = false
	end

	gohelper.setActive(arg_27_0._gounlock, not var_27_1)
	gohelper.setActive(arg_27_0._gorightbtns, not var_27_1)
	gohelper.setActive(arg_27_0._btncompare.gameObject, not var_27_0 and not var_27_1)
	gohelper.setActive(arg_27_0._btninteam.gameObject, var_27_0)
	gohelper.setActive(arg_27_0._btnfold.gameObject, var_27_1)
end

function var_0_0._getCurAttributeDataList(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:_getAttributeDataList(arg_28_1)
	local var_28_1 = TalentStyleModel.instance:getHeroUseCubeId(arg_28_0._heroId)
	local var_28_2 = tabletool.copy(var_28_0)

	if var_28_1 ~= arg_28_1 and arg_28_0._objCompareAttrPanel.gameObject.activeSelf then
		local var_28_3 = arg_28_0:_getAttributeDataList(var_28_1)

		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			local var_28_4 = arg_28_0:getMainCubeAttrDataByType(var_28_3, iter_28_1.key)

			if var_28_4 then
				if iter_28_1.value ~= var_28_4.value then
					iter_28_1.changeNum = iter_28_1.value - var_28_4.value
				end
			else
				iter_28_1.isNew = true
			end
		end

		for iter_28_2, iter_28_3 in ipairs(var_28_3) do
			if not arg_28_0:getMainCubeAttrDataByType(var_28_0, iter_28_3.key) then
				local var_28_5 = tabletool.copy(iter_28_3)

				var_28_5.isDelete = true

				table.insert(var_28_2, var_28_5)
			end
		end
	else
		for iter_28_4, iter_28_5 in ipairs(var_28_0) do
			iter_28_5.changeNum = nil
			iter_28_5.isNew = nil
			iter_28_5.isDelete = nil
		end
	end

	table.sort(var_28_2, arg_28_0.sortAttr)

	return var_28_2
end

function var_0_0.getMainCubeAttrDataByType(arg_29_0, arg_29_1, arg_29_2)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		if iter_29_1.key == arg_29_2 then
			return iter_29_1
		end
	end
end

function var_0_0._getAttrItem(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if not arg_30_0._attrItems[arg_30_1] then
		local var_30_0 = arg_30_0:getUserDataTb_()

		arg_30_0._attrItems[arg_30_1] = var_30_0
	end

	local var_30_1 = arg_30_0._attrItems[arg_30_1][arg_30_2]

	if not var_30_1 then
		local var_30_2 = gohelper.clone(arg_30_0._attrItem, arg_30_3, "item_" .. arg_30_2)

		var_30_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_30_2, CharacterTalentStyleAttrItem)
		arg_30_0._attrItems[arg_30_1][arg_30_2] = var_30_1
	end

	return var_30_1
end

function var_0_0._showAttrItem(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	for iter_31_0, iter_31_1 in ipairs(arg_31_2) do
		arg_31_0:_getAttrItem(arg_31_1, iter_31_0, arg_31_3):onRefreshMo(iter_31_0, iter_31_1)
	end

	for iter_31_2 = 1, #arg_31_0._attrItems[arg_31_1] do
		local var_31_0 = arg_31_0._attrItems[arg_31_1][iter_31_2]

		gohelper.setActive(var_31_0.viewGO, iter_31_2 <= #arg_31_2)
	end
end

function var_0_0._refreshAttribute(arg_32_0)
	local var_32_0 = arg_32_0:_getSelectCubeMo()

	arg_32_0:_showCurCubeAttr()

	local var_32_1, var_32_2 = var_32_0:getStyleTag()

	arg_32_0._txtcurStyleName.text = var_32_1
	arg_32_0._txtcurLabel.text = var_32_2
end

function var_0_0._showCurCubeAttr(arg_33_0)
	local var_33_0 = arg_33_0:_getSelectCubeMo()._replaceId
	local var_33_1 = arg_33_0:_getCurAttributeDataList(var_33_0)

	arg_33_0:_showAttrItem(1, var_33_1, arg_33_0._curAttrPanel)
end

function var_0_0._refreshBtn(arg_34_0)
	local var_34_0 = arg_34_0:_getSelectCubeMo()
	local var_34_1 = var_34_0._isUnlock
	local var_34_2 = var_34_1 and var_34_0._isUse

	gohelper.setActive(arg_34_0._btnunlock.gameObject, not var_34_1)
	gohelper.setActive(arg_34_0._btnuse.gameObject, var_34_1 and not var_34_2)
	gohelper.setActive(arg_34_0._gousing.gameObject, var_34_1 and var_34_2)

	if not var_34_1 then
		local var_34_3, var_34_4, var_34_5, var_34_6 = arg_34_0:_isEnoughUnlock()

		ZProj.UGUIHelper.SetGrayscale(arg_34_0._btnunlock.gameObject, not var_34_5)

		if var_34_0:isHotUnlock() then
			local var_34_7 = luaLang("character_talentstyle_unlockpercent")
			local var_34_8 = string.format("%.1f", var_34_0:getUnlockPercent() * 0.01)

			arg_34_0._txtunlockpercent.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_34_7, var_34_8)
		end

		gohelper.setActive(arg_34_0._txtunlockpercent.gameObject, var_34_0:isHotUnlock())
	end

	gohelper.setActive(arg_34_0._gorequest, not var_34_1)

	arg_34_0._requestCanvas.alpha = var_34_1 and 0 or 1
end

function var_0_0._refreshUnlockItem(arg_35_0)
	if not arg_35_0:_getSelectCubeMo()._isUnlock then
		local var_35_0 = arg_35_0:_isEnoughUnlock()

		IconMgr.instance:getCommonPropItemIconList(arg_35_0, arg_35_0._onCostItemShow, var_35_0, arg_35_0._gorequest)
	end
end

function var_0_0._isEnoughUnlock(arg_36_0)
	local var_36_0 = TalentStyleModel.instance:getSelectStyleId(arg_36_0._heroId)
	local var_36_1 = HeroResonanceConfig.instance:getTalentStyleUnlockConsume(arg_36_0._heroId, var_36_0)

	if var_36_1 then
		local var_36_2 = ItemModel.instance:getItemDataListByConfigStr(var_36_1)
		local var_36_3, var_36_4, var_36_5 = ItemModel.instance:hasEnoughItemsByCellData(var_36_2)

		return var_36_2, var_36_3, var_36_4, var_36_5
	end

	return nil, "", true, nil
end

function var_0_0._onCostItemShow(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	transformhelper.setLocalScale(arg_37_1.viewGO.transform, 0.59, 0.59, 1)
	arg_37_1:onUpdateMO(arg_37_2)
	arg_37_1:setConsume(true)
	arg_37_1:showStackableNum2()
	arg_37_1:isShowEffect(true)
	arg_37_1:setAutoPlay(true)
	arg_37_1:setCountFontSize(48)
	arg_37_1:setCountText(ItemModel.instance:getItemIsEnoughText(arg_37_2))
	arg_37_1:setOnBeforeClickCallback(arg_37_0.onBeforeClickItem, arg_37_0)
	arg_37_1:setRecordFarmItem({
		type = arg_37_2.materilType,
		id = arg_37_2.materilId,
		quantity = arg_37_2.quantity
	})
end

function var_0_0.onBeforeClickItem(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = JumpController.instance:getCurrentOpenedView()

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		if iter_38_1.viewName == ViewName.CharacterTalentStyleView then
			iter_38_1.viewParam.isJustOpen = true

			break
		end
	end

	arg_38_2:setRecordFarmItem({
		type = arg_38_2._itemType,
		id = arg_38_2._itemId,
		quantity = arg_38_2._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = var_38_0
	})
end

function var_0_0._getSelectCubeMo(arg_39_0)
	if not arg_39_0._selectCubeMo then
		arg_39_0._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(arg_39_0._heroId)
	end

	return arg_39_0._selectCubeMo
end

function var_0_0._onUnlockTalentStyleReply(arg_40_0, arg_40_1)
	TalentStyleModel.instance:refreshUnlockList(arg_40_1.heroId)
	arg_40_0:_hideComparePanel()
	arg_40_0._animUnlock:Play("unlock", arg_40_0._unlockAnimEnd, arg_40_0)
	TalentStyleModel.instance:setNewUnlockStyle(arg_40_1.style)
	TaskDispatcher.cancelTask(arg_40_0._hideItemUnlock, arg_40_0)
	gohelper.setActive(arg_40_0._goitemUnlock, true)
	TaskDispatcher.runDelay(arg_40_0._hideItemUnlock, arg_40_0, 1.2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_unlock_02)
end

function var_0_0._unlockAnimEnd(arg_41_0)
	arg_41_0:_refreshView()
end

function var_0_0._hideItemUnlock(arg_42_0)
	gohelper.setActive(arg_42_0._goitemUnlock, false)
end

function var_0_0._hideItemUse(arg_43_0)
	gohelper.setActive(arg_43_0._goitemUse, false)
end

function var_0_0._onUseTalentStyleReply(arg_44_0, arg_44_1)
	arg_44_0:_hideComparePanel()
	arg_44_0:_refreshView()
	TaskDispatcher.cancelTask(arg_44_0._hideItemUse, arg_44_0)
	gohelper.setActive(arg_44_0._goitemUse, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_fm)
	TaskDispatcher.runDelay(arg_44_0._hideItemUse, arg_44_0, 0.6)
end

function var_0_0._onSelectTalentStyle(arg_45_0, arg_45_1)
	arg_45_0._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(arg_45_0._heroId)

	arg_45_0._animPlayer:Play("switch", nil, arg_45_0)
end

function var_0_0.currencyChangeEvent(arg_46_0)
	arg_46_0:_refreshUnlockItem()
	arg_46_0:_refreshBtn()
end

function var_0_0.playCloseAnim(arg_47_0)
	arg_47_0._animPlayer:Play("close", arg_47_0.closeThis, arg_47_0)
end

function var_0_0._onHeroTalentStyleStatReply(arg_48_0, arg_48_1)
	local var_48_0 = #arg_48_1.stylePercentList > 0
	local var_48_1 = arg_48_0:_getNavigateView()

	if var_48_1 then
		var_48_1:showStatBtn(var_48_0)
	end

	if var_48_0 then
		TalentStyleListModel.instance:refreshData(arg_48_1.heroId)
	end
end

function var_0_0._getNavigateView(arg_49_0)
	return arg_49_0.viewContainer:getNavigateView()
end

return var_0_0
