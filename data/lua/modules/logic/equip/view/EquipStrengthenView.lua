module("modules.logic.equip.view.EquipStrengthenView", package.seeall)

local var_0_0 = class("EquipStrengthenView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobeforewhite = gohelper.findChild(arg_1_0.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_beforewhite")
	arg_1_0._imagewhite = gohelper.findChildImage(arg_1_0.viewGO, "layoutgroup/progress/bar/#go_barPos/#image_white")
	arg_1_0._goafterwhite = gohelper.findChild(arg_1_0.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_afterwhite")
	arg_1_0._imagegreen1 = gohelper.findChildImage(arg_1_0.viewGO, "layoutgroup/progress/bar/#go_barPos/#image_green1")
	arg_1_0._gofullexp = gohelper.findChild(arg_1_0.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_fullexp")
	arg_1_0._txtaddexp = gohelper.findChildText(arg_1_0.viewGO, "layoutgroup/progress/bar/#go_barPos/#txt_addexp")
	arg_1_0._txtexp = gohelper.findChildText(arg_1_0.viewGO, "layoutgroup/progress/bar/#go_barPos/#txt_exp")
	arg_1_0._gomaxbreakbartip = gohelper.findChild(arg_1_0.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_maxbreakbartip")
	arg_1_0._gobarPos = gohelper.findChild(arg_1_0.viewGO, "layoutgroup/progress/bar/#go_barPos")
	arg_1_0._txtcurlevel = gohelper.findChildText(arg_1_0.viewGO, "layoutgroup/progress/#txt_curlevel")
	arg_1_0._golevelupeffect = gohelper.findChild(arg_1_0.viewGO, "layoutgroup/progress/#go_leveup")
	arg_1_0._txttotallevel = gohelper.findChildText(arg_1_0.viewGO, "layoutgroup/progress/#txt_curlevel/#txt_totallevel")
	arg_1_0._goengravingEffect = gohelper.findChild(arg_1_0.viewGO, "layoutgroup/progress/#engraving")
	arg_1_0._gomaxbreaktip = gohelper.findChild(arg_1_0.viewGO, "#go_maxbreaktip")
	arg_1_0._golevelup = gohelper.findChild(arg_1_0.viewGO, "layoutgroup/attribute/container/#go_levelup")
	arg_1_0._gostrengthenattr = gohelper.findChild(arg_1_0.viewGO, "layoutgroup/attribute/container/#go_strengthenattr")
	arg_1_0._gobreakeffect = gohelper.findChild(arg_1_0.viewGO, "layoutgroup/attribute/container/#go_breakeffect")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "#go_cost")
	arg_1_0._gocaneasycombinetip = gohelper.findChild(arg_1_0.viewGO, "#go_cost/txt_onceCombine")
	arg_1_0._imagecurrency = gohelper.findChildImage(arg_1_0.viewGO, "#go_cost/strengthen_cost/currency/#simage_currency")
	arg_1_0._txtcurrency = gohelper.findChildText(arg_1_0.viewGO, "#go_cost/strengthen_cost/currency/#txt_currency")
	arg_1_0._gonocurrency = gohelper.findChild(arg_1_0.viewGO, "#go_cost/strengthen_cost/currency/#go_nocurrency")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_cost/#go_btns")
	arg_1_0._btnupgrade = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cost/#go_btns/start/#btn_upgrade")
	arg_1_0._btnbreak = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cost/#go_btns/break/#btn_break")
	arg_1_0._txtcostcount = gohelper.findChildText(arg_1_0.viewGO, "#go_cost/title/#txt_costcount")
	arg_1_0._gobreakcount = gohelper.findChild(arg_1_0.viewGO, "#go_cost/title/#go_breakcount")
	arg_1_0._goimprove = gohelper.findChild(arg_1_0.viewGO, "#go_improve")
	arg_1_0._btnfastadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cost/fast/#btn_fastadd")
	arg_1_0._gosortbtns = gohelper.findChild(arg_1_0.viewGO, "#go_improve/#go_sortbtns")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_improve/#go_sortbtns/#btn_lvrank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_improve/#go_sortbtns/#btn_rarerank")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_improve/#go_sortbtns/#btn_filter")
	arg_1_0._btnback = gohelper.findChildButton(arg_1_0.viewGO, "#go_improve/#btn_back")
	arg_1_0._golackequip = gohelper.findChild(arg_1_0.viewGO, "#go_improve/#go_lackequip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnupgrade:AddClickListener(arg_2_0._btnupgradeOnClick, arg_2_0)
	arg_2_0._btnbreak:AddClickListener(arg_2_0._btnbreakOnClick, arg_2_0)
	arg_2_0._btnfastadd:AddClickListener(arg_2_0._btnfastaddOnClick, arg_2_0)
	arg_2_0._btnlvrank:AddClickListener(arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnupgrade:RemoveClickListener()
	arg_3_0._btnbreak:RemoveClickListener()
	arg_3_0._btnfastadd:RemoveClickListener()
	arg_3_0._btnlvrank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
end

var_0_0.ShowContainerStatusEnum = {
	ShowBreak = 2,
	ShowUpgrade = 1,
	ShowMax = 3
}
var_0_0.LevelChangeAnimationTime = 0.5
var_0_0.Color = {
	NormalColor = Color.New(0.8509803921568627, 0.6274509803921569, 0.43529411764705883, 1),
	NextColor = Color.New(0.5137254901960784, 0.7372549019607844, 0.5176470588235295, 1)
}

function var_0_0._btnfilterOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = arg_4_0.viewName
	})
end

function var_0_0._btnlvrankOnClick(arg_5_0)
	EquipChooseListModel.instance:sordByLevel()
	arg_5_0:_refreshEquipBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_6_0)
	EquipChooseListModel.instance:sordByQuality()
	arg_6_0:_refreshEquipBtnIcon()
end

function var_0_0._refreshEquipBtnIcon(arg_7_0)
	local var_7_0 = EquipChooseListModel.instance:getBtnTag()

	gohelper.setActive(arg_7_0._equipLvBtns[1], var_7_0 ~= 1)
	gohelper.setActive(arg_7_0._equipLvBtns[2], var_7_0 == 1)
	gohelper.setActive(arg_7_0._equipQualityBtns[1], var_7_0 ~= 2)
	gohelper.setActive(arg_7_0._equipQualityBtns[2], var_7_0 == 2)

	local var_7_1, var_7_2 = EquipChooseListModel.instance:getRankState()

	transformhelper.setLocalScale(arg_7_0._equipLvArrow[1], 1, var_7_1, 1)
	transformhelper.setLocalScale(arg_7_0._equipLvArrow[2], 1, var_7_1, 1)
	transformhelper.setLocalScale(arg_7_0._equipQualityArrow[1], 1, var_7_2, 1)
	transformhelper.setLocalScale(arg_7_0._equipQualityArrow[2], 1, var_7_2, 1)
end

function var_0_0._btnbackOnClick(arg_8_0)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, false)
end

function var_0_0._btnfastaddOnClick(arg_9_0)
	if arg_9_0.breaking then
		return
	end

	EquipChooseListModel.instance:fastAddEquip()
end

function var_0_0._btnupgradeOnClick(arg_10_0)
	local var_10_0 = EquipChooseListModel.instance:getChooseEquipList()

	if not var_10_0 or #var_10_0 == 0 then
		if arg_10_0._goimprove.activeSelf then
			GameFacade.showToast(ToastEnum.EquipStrengthenNoItem)
		end

		EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, true)

		return
	end

	if not arg_10_0._enoughGold then
		GameFacade.showToast(ToastEnum.EquipStrengthenNoGold)

		return
	end

	local var_10_1 = {}
	local var_10_2 = false
	local var_10_3 = false

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		table.insert(var_10_1, {
			iter_10_1.uid,
			iter_10_1._chooseNum
		})

		var_10_3 = var_10_3 or EquipChooseListModel.instance:getHeroMoByEquipUid(iter_10_1.uid)

		if iter_10_1.config.isExpEquip == 0 and iter_10_1.config.rare >= 4 then
			var_10_2 = true
		end
	end

	local var_10_4 = os.date("*t", ServerTime.nowInLocal() - 18000)

	if (var_10_3 ~= nil or var_10_2) and (arg_10_0._playerSaveTabs.saveTime == nil or arg_10_0._playerSaveTabs.saveTime ~= var_10_4.day) then
		EquipController.instance:openEquipStrengthenAlertView({
			callback = function(arg_11_0)
				if arg_11_0 then
					arg_10_0._playerSaveTabs.saveTime = var_10_4.day
					arg_10_0._playUserIdTabs[arg_10_0._curPlayerInfoId] = arg_10_0._playerSaveTabs

					local var_11_0 = cjson.encode(arg_10_0._playUserIdTabs)

					PlayerPrefsHelper.setString(PlayerPrefsKey.EquipStrengthen, var_11_0)
				end

				EquipRpc.instance:sendEquipStrengthenRequest(arg_10_0._equipMO.uid, var_10_1)
			end,
			content = var_10_3 == nil and luaLang("equip_lang_3") or luaLang("equip_lang_2")
		})
	else
		EquipRpc.instance:sendEquipStrengthenRequest(arg_10_0._equipMO.uid, var_10_1)
	end
end

function var_0_0._hideGravingEffect(arg_12_0)
	gohelper.setActive(arg_12_0._goengravingEffect, false)
end

function var_0_0._btnbreakOnClick(arg_13_0)
	if not arg_13_0._enoughGold then
		GameFacade.showToast(ToastEnum.EquipStrengthenNoGold)

		return
	end

	if not arg_13_0._enoughBreak then
		if arg_13_0._canEasyCombine then
			PopupCacheModel.instance:setViewIgnoreGetPropView(arg_13_0.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
			RoomProductionHelper.openRoomFormulaMsgBoxView(arg_13_0._easyCombineTable, arg_13_0._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, arg_13_0._onEasyCombineFinished, arg_13_0)
		end

		return
	end

	arg_13_0.breaking = true

	EquipChooseListModel.instance:setIsLock(arg_13_0.breaking)
	EquipRpc.instance:sendEquipBreakRequest(arg_13_0._equipMO.uid)
end

function var_0_0._onEasyCombineFinished(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	PopupCacheModel.instance:setViewIgnoreGetPropView(arg_14_0.viewName, false)

	if arg_14_2 ~= 0 then
		return
	end

	arg_14_0:_btnbreakOnClick()
end

function var_0_0._hideLevelUpEffect(arg_15_0)
	gohelper.setActive(arg_15_0._golevelupeffect, false)
end

function var_0_0._editableInitView(arg_16_0)
	arg_16_0.breakSuccessAnimationTime = arg_16_0._golevelupeffect:GetComponent(typeof(UnityEngine.Animation)).clip.length
	arg_16_0._animimprove = arg_16_0._goimprove:GetComponent(typeof(UnityEngine.Animator))
	arg_16_0._viewAnim = arg_16_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_16_0._strengthenattrs = arg_16_0:getUserDataTb_()

	gohelper.setActive(arg_16_0._gostrengthenattr, false)

	arg_16_0._whiteWidth = recthelper.getWidth(arg_16_0._imagewhite.transform)
	arg_16_0.imageBreakIcon = gohelper.findChildImage(arg_16_0._gobreakeffect, "image_icon")
	arg_16_0.txtBreakAttrName = gohelper.findChildText(arg_16_0._gobreakeffect, "txt_name")
	arg_16_0.txtBreakValue = gohelper.findChildText(arg_16_0._gobreakeffect, "txt_value")
	arg_16_0.txtBreakPreValue = gohelper.findChildText(arg_16_0._gobreakeffect, "txt_prevalue")
	arg_16_0.goBreakRightArrow = gohelper.findChild(arg_16_0._gobreakeffect, "go_rightarrow")
	arg_16_0.goNotFilter = gohelper.findChild(arg_16_0.viewGO, "#go_improve/#go_sortbtns/#btn_filter/#go_notfilter")
	arg_16_0.goFilter = gohelper.findChild(arg_16_0.viewGO, "#go_improve/#go_sortbtns/#btn_filter/#go_filter")

	local var_16_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Gold).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imagecurrency, var_16_0 .. "_1")

	arg_16_0._equipLvBtns = arg_16_0:getUserDataTb_()
	arg_16_0._equipLvArrow = arg_16_0:getUserDataTb_()
	arg_16_0._equipQualityBtns = arg_16_0:getUserDataTb_()
	arg_16_0._equipQualityArrow = arg_16_0:getUserDataTb_()

	for iter_16_0 = 1, 2 do
		arg_16_0._equipLvBtns[iter_16_0] = gohelper.findChild(arg_16_0._btnlvrank.gameObject, "btn" .. tostring(iter_16_0))
		arg_16_0._equipLvArrow[iter_16_0] = gohelper.findChild(arg_16_0._equipLvBtns[iter_16_0], "txt/arrow").transform
		arg_16_0._equipQualityBtns[iter_16_0] = gohelper.findChild(arg_16_0._btnrarerank.gameObject, "btn" .. tostring(iter_16_0))
		arg_16_0._equipQualityArrow[iter_16_0] = gohelper.findChild(arg_16_0._equipQualityBtns[iter_16_0], "txt/arrow").transform
	end

	gohelper.setActive(arg_16_0._equipLvArrow[1].gameObject, false)
	gohelper.setActive(arg_16_0._equipQualityArrow[1].gameObject, false)
	gohelper.addUIClickAudio(arg_16_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_16_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_16_0._btnbreak.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)
	gohelper.addUIClickAudio(arg_16_0._btnupgrade.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)
	gohelper.addUIClickAudio(arg_16_0._btnfastadd.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Addall)

	arg_16_0._enoughBreak = false
	arg_16_0.breaking = false

	EquipChooseListModel.instance:setIsLock(arg_16_0.breaking)

	arg_16_0.initDropDone = false

	arg_16_0:initFilterDrop()

	arg_16_0._goupgrade = gohelper.findChild(arg_16_0._gobtns, "start")
	arg_16_0._gobreak = gohelper.findChild(arg_16_0._gobtns, "break")

	gohelper.setActive(arg_16_0._goimprove, false)

	arg_16_0.initDropDone = true
	arg_16_0.showContainerStatus = var_0_0.ShowContainerStatusEnum.ShowUpgrade

	arg_16_0:setBtnBackWidth()
	arg_16_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_16_0.setBtnBackWidth, arg_16_0)
end

function var_0_0.setBtnBackWidth(arg_17_0)
	local var_17_0 = recthelper.getWidth(arg_17_0._goimprove.transform)

	recthelper.setWidth(arg_17_0._btnback.gameObject.transform, 0.45 * var_17_0)
end

function var_0_0.onDropHide(arg_18_0)
	transformhelper.setLocalScale(arg_18_0.trDropArrow, 1, 1, 1)
end

function var_0_0.onDropShow(arg_19_0)
	transformhelper.setLocalScale(arg_19_0.trDropArrow, 1, -1, 1)
end

function var_0_0.initFilterDrop(arg_20_0)
	arg_20_0.dropFilter = gohelper.findChildDropdown(arg_20_0._gocost, "#drop_filter")
	arg_20_0.trDropArrow = gohelper.findChildComponent(arg_20_0.dropFilter.gameObject, "Arrow", typeof(UnityEngine.Transform))
	arg_20_0.dropClick = gohelper.getClick(arg_20_0.dropFilter.gameObject)
	arg_20_0.dropExtend = DropDownExtend.Get(arg_20_0.dropFilter.gameObject)

	arg_20_0.dropExtend:init(arg_20_0.onDropShow, arg_20_0.onDropHide, arg_20_0)

	arg_20_0.filterRareLevelList = {}

	for iter_20_0 = 2, EquipConfig.instance:getMaxFilterRare() do
		table.insert(arg_20_0.filterRareLevelList, iter_20_0)
	end

	local var_20_0 = {}

	for iter_20_1, iter_20_2 in ipairs(arg_20_0.filterRareLevelList) do
		if iter_20_2 == 0 then
			table.insert(var_20_0, luaLang("equip_filter_all"))
		else
			table.insert(var_20_0, string.format(luaLang("equip_filter_str"), iter_20_2))
		end
	end

	arg_20_0.dropFilter:ClearOptions()
	arg_20_0.dropFilter:AddOptions(var_20_0)
	arg_20_0.dropFilter:AddOnValueChanged(arg_20_0.onDropValueChanged, arg_20_0)
	arg_20_0.dropClick:AddClickListener(function()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, arg_20_0)

	local var_20_1 = EquipChooseListModel.instance:getFilterRare()

	for iter_20_3, iter_20_4 in ipairs(arg_20_0.filterRareLevelList) do
		if iter_20_4 == var_20_1 then
			arg_20_0.dropFilter:SetValue(iter_20_3 - 1)

			break
		end
	end
end

function var_0_0.onDropValueChanged(arg_22_0, arg_22_1)
	if not arg_22_0.initDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	EquipChooseListModel.instance:setFilterRare(arg_22_0.filterRareLevelList[arg_22_1 + 1])
end

function var_0_0.onUpdateParam(arg_23_0)
	return
end

function var_0_0.onOpen(arg_24_0)
	arg_24_0.filterMo = EquipFilterModel.instance:generateFilterMo(arg_24_0.viewName)
	arg_24_0._equipMO = arg_24_0.viewContainer.viewParam.equipMO
	arg_24_0._config = arg_24_0._equipMO.config
	arg_24_0._equipMaxLv = EquipConfig.instance:getMaxLevel(arg_24_0._config)

	arg_24_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_24_0._onEquipStrengthenReply, arg_24_0)
	arg_24_0:addEventCb(EquipController.instance, EquipEvent.onChooseChange, arg_24_0._onChooseChange, arg_24_0)
	arg_24_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_24_0._onUpdateEquip, arg_24_0)
	arg_24_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_24_0._onUpdateEquip, arg_24_0)
	arg_24_0:addEventCb(EquipController.instance, EquipEvent.onStrengthenFast, arg_24_0._btnfastaddOnClick, arg_24_0)
	arg_24_0:addEventCb(EquipController.instance, EquipEvent.onStrengthenUpgrade, arg_24_0._btnupgradeOnClick, arg_24_0)
	arg_24_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_24_0._onBreakSuccess, arg_24_0)
	arg_24_0:addEventCb(EquipController.instance, EquipEvent.onEquipLockChange, arg_24_0._onEquipLockChange, arg_24_0)
	arg_24_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_24_0._refreshBreakCostIcon, arg_24_0)
	arg_24_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_24_0.refreshCost, arg_24_0)
	arg_24_0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, arg_24_0.onEquipTypeHasChange, arg_24_0)
	EquipChooseListModel.instance:initEquipMo(arg_24_0._equipMO, false)
	EquipChooseListModel.instance:initEquipList(arg_24_0.filterCareer)

	arg_24_0._playUserIdTabs = arg_24_0:getUserDataTb_()
	arg_24_0._playerSaveTabs = arg_24_0:getUserDataTb_()

	local var_24_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.EquipStrengthen, "")

	if not string.nilorempty(var_24_0) then
		arg_24_0._playUserIdTabs = cjson.decode(var_24_0)
	end

	arg_24_0._curPlayerInfoId = PlayerModel.instance:getPlayinfo().userId

	if arg_24_0._playUserIdTabs[arg_24_0._curPlayerInfoId] == nil then
		arg_24_0._playerSaveTabs.saveTime = nil
		arg_24_0._playUserIdTabs[arg_24_0._curPlayerInfoId] = arg_24_0._playerSaveTabs
	else
		arg_24_0._playerSaveTabs = arg_24_0._playUserIdTabs[arg_24_0._curPlayerInfoId]
	end

	arg_24_0:showContainer()
	arg_24_0:updateLevelInfo(arg_24_0._equipMO.level)

	if arg_24_0.viewContainer:getIsOpenLeftBackpack() then
		arg_24_0.viewContainer.equipView:hideRefineScrollAndShowStrengthenScroll()
	else
		gohelper.setActive(arg_24_0._goimprove, false)
	end

	arg_24_0._viewAnim:Play(UIAnimationName.Open)
	arg_24_0:playOutsideNodeAnimation(UIAnimationName.Open)
	arg_24_0.viewContainer:playCurrencyViewAnimation("go_righttop_ina")
end

function var_0_0.showContainer(arg_25_0)
	if arg_25_0._equipMO.level == arg_25_0._equipMaxLv then
		arg_25_0.showContainerStatus = var_0_0.ShowContainerStatusEnum.ShowMax

		arg_25_0:hideUpgradeAndBreakContainer()

		return
	end

	if arg_25_0._equipMO.level == EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_25_0._equipMO) then
		arg_25_0.showContainerStatus = var_0_0.ShowContainerStatusEnum.ShowBreak

		arg_25_0:showBreakContainer()

		return
	end

	arg_25_0.showContainerStatus = var_0_0.ShowContainerStatusEnum.ShowUpgrade

	arg_25_0:showUpgradeContainer()
end

function var_0_0.showScrollContainer(arg_26_0)
	arg_26_0.isShow = true

	EquipChooseListModel.instance:setEquipList()
	arg_26_0:refreshEquipChooseEmptyContainer()
	arg_26_0:_refreshEquipBtnIcon()
	gohelper.setActive(arg_26_0._goimprove, true)
	arg_26_0._animimprove:Play("go_improve_in")
end

function var_0_0.hideScrollContainer(arg_27_0)
	arg_27_0.isShow = false

	arg_27_0._animimprove:Play("go_improve_out")
	TaskDispatcher.runDelay(arg_27_0._hideImprove, arg_27_0, EquipEnum.AnimationDurationTime)
end

function var_0_0.refreshEquipChooseEmptyContainer(arg_28_0)
	local var_28_0 = EquipChooseListModel.instance:getCount()

	gohelper.setActive(arg_28_0._golackequip, var_28_0 == 0)
end

function var_0_0._hideImprove(arg_29_0)
	gohelper.setActive(arg_29_0._goimprove, false)
end

function var_0_0.onEquipTypeHasChange(arg_30_0, arg_30_1)
	if arg_30_1 ~= arg_30_0.viewName then
		return
	end

	arg_30_0.viewContainer.equipView:setStrengthenScrollVerticalNormalizedPosition(1)
	EquipChooseListModel.instance:initEquipList(arg_30_0.filterMo, true)
	EquipChooseListModel.instance:setEquipList()
	arg_30_0:refreshFilterBtn()
end

function var_0_0.refreshFilterBtn(arg_31_0)
	local var_31_0 = arg_31_0.filterMo:isFiltering()

	gohelper.setActive(arg_31_0.goNotFilter, not var_31_0)
	gohelper.setActive(arg_31_0.goFilter, var_31_0)
end

function var_0_0._onUpdateEquip(arg_32_0)
	if arg_32_0.tabContainer._curTabId ~= EquipCategoryListModel.ViewIndex.EquipStrengthenViewIndex then
		return
	end

	EquipChooseListModel.instance:initEquipList(arg_32_0.career, true)
	EquipChooseListModel.instance:setEquipList()
	arg_32_0:refreshEquipChooseEmptyContainer()
end

function var_0_0._updateCostItemList(arg_33_0)
	local var_33_0 = EquipChooseListModel.instance:calcStrengthen()

	if var_33_0 > 0 then
		arg_33_0._txtaddexp.text = "EXP+" .. var_33_0
	else
		arg_33_0._txtaddexp.text = ""
	end

	arg_33_0:showStrengthenEffect(var_33_0)
end

function var_0_0._onChooseChange(arg_34_0)
	arg_34_0._txtcostcount.text = string.format("%s<color=#E8E5DF>(%s/%s)</color>", luaLang("p_equip_8"), EquipChooseListModel.instance:getChooseEquipsNum(), EquipEnum.StrengthenMaxCount)

	arg_34_0:_updateCostItemList()
end

function var_0_0.playExpAnimationEffect(arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._hideGravingEffect, arg_35_0)
	gohelper.setActive(arg_35_0._goengravingEffect, true)
	TaskDispatcher.runDelay(arg_35_0._hideGravingEffect, arg_35_0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_engrave)
end

function var_0_0.playExpBreakAnimationEffect(arg_36_0)
	gohelper.setActive(arg_36_0._golevelupeffect, true)
end

function var_0_0._onEquipStrengthenReply(arg_37_0)
	arg_37_0.isUpgradeReply = true

	EquipChooseListModel.instance:initEquipList(arg_37_0.career, false)
	EquipChooseListModel.instance:setEquipList()
	arg_37_0:refreshEquipChooseEmptyContainer()
	EquipChooseListModel.instance:resetSelectedEquip()
	arg_37_0:playExpAnimationEffect()

	arg_37_0._expList = nil

	arg_37_0:showContainer()

	arg_37_0.isUpgradeReply = false
end

function var_0_0.showStrengthenEffect(arg_38_0, arg_38_1)
	if arg_38_0._equipMaxLv == arg_38_0._equipMO.level then
		return
	end

	arg_38_1 = arg_38_1 or 0

	local var_38_0 = EquipConfig.instance:getEquipStrengthenCostCo(arg_38_0._config.rare, arg_38_0._equipMO.level + 1)
	local var_38_1 = arg_38_0._equipMO.level

	recthelper.setWidth(arg_38_0._imagegreen1.transform, 0)

	local var_38_2 = false

	if arg_38_1 > 0 then
		var_38_1 = EquipConfig.instance:getStrengthenToLv(arg_38_0._config.rare, arg_38_0._equipMO.level, arg_38_0._equipMO.exp + arg_38_1)
		var_38_2 = var_38_1 ~= arg_38_0._equipMO.level

		local var_38_3 = EquipConfig.instance:getStrengthenToLvCost(arg_38_0._config.rare, arg_38_0._equipMO.level, arg_38_0._equipMO.exp, arg_38_1)

		arg_38_0._enoughGold = arg_38_0:setCurrencyValue(var_38_3)

		arg_38_0:showExpAnimation(arg_38_1, var_38_0)
	else
		arg_38_0._enoughGold = arg_38_0:setCurrencyValue(0)
		arg_38_0._txtcurrency.text = ""

		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtcurrency, "#E8E5DF")

		if arg_38_0._expList then
			arg_38_0:showExpAnimation(arg_38_1, var_38_0)

			arg_38_0._expList = nil
		end
	end

	ZProj.UGUIHelper.SetGrayscale(arg_38_0._btnupgrade.gameObject, arg_38_1 <= 0)

	local var_38_4, var_38_5 = EquipConfig.instance:getStrengthenToLvExpInfo(arg_38_0._config.rare, arg_38_0._equipMO.level, arg_38_0._equipMO.exp, arg_38_1)
	local var_38_6 = arg_38_0._whiteWidth * math.min(arg_38_0._equipMO.exp / var_38_0.exp, 1)

	recthelper.setWidth(arg_38_0._imagewhite.transform, var_38_6)

	arg_38_0._txtexp.text = string.format("%s/%s", var_38_4, var_38_5)

	arg_38_0:setAttribute(arg_38_1, var_38_2, var_38_0, var_38_1)
end

function var_0_0.setAttribute(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	arg_39_0._upgrade = arg_39_2
	arg_39_0._addexp = arg_39_1
	arg_39_0._attrIndex = 1

	if arg_39_2 then
		local var_39_0, var_39_1, var_39_2, var_39_3 = EquipConfig.instance:getEquipAddBaseAttr(arg_39_0._equipMO)
		local var_39_4, var_39_5, var_39_6, var_39_7 = EquipConfig.instance:getEquipAddBaseAttr(arg_39_0._equipMO, arg_39_4)

		arg_39_0:showAttr(CharacterEnum.AttrId.Attack, 0, var_39_5, var_39_1, arg_39_3)
		arg_39_0:showAttr(CharacterEnum.AttrId.Hp, 0, var_39_4, var_39_0, arg_39_3)
		arg_39_0:showAttr(CharacterEnum.AttrId.Defense, 0, var_39_6, var_39_2, arg_39_3)
		arg_39_0:showAttr(CharacterEnum.AttrId.Mdefense, 0, var_39_7, var_39_3, arg_39_3)
	else
		local var_39_8, var_39_9, var_39_10, var_39_11 = EquipConfig.instance:getEquipAddBaseAttr(arg_39_0._equipMO)

		arg_39_0:showAttr(CharacterEnum.AttrId.Attack, 0, var_39_9)
		arg_39_0:showAttr(CharacterEnum.AttrId.Hp, 0, var_39_8)
		arg_39_0:showAttr(CharacterEnum.AttrId.Defense, 0, var_39_10)
		arg_39_0:showAttr(CharacterEnum.AttrId.Mdefense, 0, var_39_11)
	end

	for iter_39_0 = arg_39_0._attrIndex, #arg_39_0._strengthenattrs do
		gohelper.setActive(arg_39_0._strengthenattrs[iter_39_0].go, false)
	end

	local var_39_12, var_39_13 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(arg_39_0._config, arg_39_0._equipMO.breakLv)

	if var_39_12 then
		gohelper.setActive(arg_39_0._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_39_0.imageBreakIcon, "icon_att_" .. var_39_12)

		arg_39_0.txtBreakAttrName.text = EquipHelper.getAttrBreakText(var_39_12)

		gohelper.setAsLastSibling(arg_39_0._gobreakeffect)

		if arg_39_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowBreak then
			local var_39_14, var_39_15 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(arg_39_0._config, arg_39_0._equipMO.breakLv + 1)

			arg_39_0.txtBreakPreValue.text = EquipHelper.getAttrPercentValueStr(var_39_13)
			arg_39_0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_39_15)
			arg_39_0.txtBreakValue.color = var_0_0.Color.NextColor

			gohelper.setActive(arg_39_0.goBreakRightArrow, true)
			gohelper.setActive(arg_39_0.txtBreakPreValue, true)
		else
			arg_39_0.txtBreakValue.color = var_0_0.Color.NormalColor

			gohelper.setActive(arg_39_0.goBreakRightArrow, false)
			gohelper.setActive(arg_39_0.txtBreakPreValue, false)

			arg_39_0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_39_13)
		end
	else
		gohelper.setActive(arg_39_0._gobreakeffect, false)
	end
end

function var_0_0.showBreakLv(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_1.transform
	local var_40_1 = var_40_0.childCount

	for iter_40_0 = 1, var_40_1 do
		local var_40_2 = var_40_0:GetChild(iter_40_0 - 1)
		local var_40_3 = gohelper.onceAddComponent(var_40_2.gameObject, gohelper.Type_Image)

		UISpriteSetMgr.instance:setEquipSprite(var_40_3, iter_40_0 <= arg_40_2 and "xx_11" or "xx_10")
	end
end

function var_0_0.calcTotalExp(arg_41_0, arg_41_1)
	if not arg_41_1 then
		return 0, 0
	end

	return arg_41_1[1], arg_41_1[2]
end

function var_0_0.showExpAnimation(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_0.isUpgradeReply then
		return
	end

	local var_42_0 = arg_42_0._expList
	local var_42_1
	local var_42_2

	arg_42_0._expList, var_42_2 = EquipConfig.instance:getStrengthenToLvCostExp(arg_42_0._config.rare, arg_42_0._equipMO.level, arg_42_0._equipMO.exp, arg_42_1, arg_42_0._equipMO.breakLv)

	local var_42_3, var_42_4 = arg_42_0:calcTotalExp(var_42_0)
	local var_42_5, var_42_6 = arg_42_0:calcTotalExp(arg_42_0._expList)

	if arg_42_0._sequence then
		arg_42_0._sequence:destroy()
	end

	local var_42_7 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_42_0._equipMO)

	local function var_42_8(arg_43_0)
		local var_43_0 = var_42_5 + arg_43_0
		local var_43_1 = Mathf.Floor(var_43_0)
		local var_43_2 = var_43_0 - var_43_1
		local var_43_3 = arg_42_0._equipMO.level + var_43_1

		if var_42_6 >= var_42_4 and var_43_3 >= var_42_7 or var_42_6 <= var_42_4 and arg_42_0._equipMO.level + var_42_6 + var_42_5 >= var_42_7 then
			if arg_42_0.tweenWork then
				arg_42_0.tweenWork:clearWork()
				arg_42_0:setExpProgressStatus(true)
				arg_42_0:updateLevelInfo(var_42_7)
				arg_42_0:setMaxLevelTxtExp(true)
			end

			return
		end

		if var_43_1 > 0 then
			recthelper.setWidth(arg_42_0._imagewhite.transform, 0)
			arg_42_0._imagegreen1.transform:SetParent(arg_42_0._goafterwhite.transform)
		else
			if arg_42_2 then
				local var_43_4 = arg_42_0._whiteWidth * math.min(arg_42_0._equipMO.exp / arg_42_2.exp, 1)

				recthelper.setWidth(arg_42_0._imagewhite.transform, var_43_4)
			end

			arg_42_0._imagegreen1.transform:SetParent(arg_42_0._gobeforewhite.transform)
		end

		recthelper.setWidth(arg_42_0._imagegreen1.transform, var_43_2 * arg_42_0._whiteWidth)
		arg_42_0:updateLevelInfo(var_43_3)
	end

	local var_42_9 = arg_42_0._skipExpAnimation and 0 or 0.2

	arg_42_0:setExpProgressStatus(false)

	arg_42_0.tweenWork = TweenWork.New({
		type = "DOTweenFloat",
		from = var_42_4,
		to = var_42_6,
		t = var_42_9,
		frameCb = var_42_8,
		ease = EaseType.Linear
	})
	arg_42_0._sequence = FlowSequence.New()

	arg_42_0._sequence:addWork(arg_42_0.tweenWork)
	arg_42_0._sequence:registerDoneListener(function()
		if var_42_2 then
			arg_42_0:setExpProgressStatus(true)
			arg_42_0:updateLevelInfo(var_42_7)
			arg_42_0:setMaxLevelTxtExp(true)
		end
	end)
	arg_42_0._sequence:start()
end

function var_0_0.updateLevelInfo(arg_45_0, arg_45_1)
	local var_45_0 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_45_0._equipMO)
	local var_45_1 = string.format("<color=#E8E5DF>/%s</color>", var_45_0)

	arg_45_0._txttotallevel.text = var_45_1
	arg_45_0._txtcurlevel.text = math.min(arg_45_1, var_45_0)
end

function var_0_0.showAttr(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	if arg_46_3 <= -1 then
		return
	end

	local var_46_0 = arg_46_4 and arg_46_4 < arg_46_3
	local var_46_1 = HeroConfig.instance:getHeroAttributeCO(arg_46_1)
	local var_46_2 = arg_46_0._attrIndex
	local var_46_3 = arg_46_0._strengthenattrs[var_46_2]

	if not var_46_3 then
		var_46_3 = arg_46_0:getUserDataTb_()
		var_46_3.go = gohelper.cloneInPlace(arg_46_0._gostrengthenattr, "item" .. var_46_2)
		var_46_3.txtvalue = gohelper.findChildText(var_46_3.go, "layout/txt_value")
		var_46_3.txtname = gohelper.findChildText(var_46_3.go, "layout/txt_name")
		var_46_3.imageicon = gohelper.findChildImage(var_46_3.go, "image_icon")
		var_46_3.txtprevvalue = gohelper.findChildText(var_46_3.go, "layout/txt_prevvalue")
		var_46_3.gorightarrow = gohelper.findChild(var_46_3.go, "layout/go_rightarrow")
		var_46_3.bg = gohelper.findChild(var_46_3.go, "layout/go_bg")

		table.insert(arg_46_0._strengthenattrs, var_46_3)
	end

	gohelper.setActive(var_46_3.bg, var_46_2 % 2 == 0)
	CharacterController.instance:SetAttriIcon(var_46_3.imageicon, arg_46_1, GameUtil.parseColor("#736E6A"))

	var_46_3.txtvalue.text = arg_46_0._upgrade and EquipConfig.instance:dirGetEquipValueStr(arg_46_2, arg_46_3) or "+0"

	if arg_46_0._upgrade and arg_46_0._addexp > 0 then
		SLFramework.UGUI.GuiHelper.SetColor(var_46_3.txtvalue, "#83BC84")
	else
		SLFramework.UGUI.GuiHelper.SetColor(var_46_3.txtvalue, "#CAC8C5")
	end

	var_46_3.txtname.text = var_46_1.name
	var_46_3.txtprevvalue.text = var_46_0 and EquipConfig.instance:dirGetEquipValueStr(arg_46_2, arg_46_4) or EquipConfig.instance:dirGetEquipValueStr(arg_46_2, arg_46_3)

	gohelper.setActive(var_46_3.gorightarrow, true)
	gohelper.setActive(var_46_3.go, true)

	arg_46_0._attrIndex = arg_46_0._attrIndex + 1

	if not arg_46_5 then
		var_46_3.txtvalue.text = var_46_3.txtprevvalue.text

		gohelper.setActive(var_46_3.txtprevvalue.gameObject, false)
		gohelper.setActive(var_46_3.gorightarrow, false)
	else
		gohelper.setActive(var_46_3.txtprevvalue.gameObject, true)
		gohelper.setActive(var_46_3.gorightarrow, true)
	end
end

function var_0_0.showUpgradeContainer(arg_47_0)
	EquipSelectedListModel.instance:initList()
	arg_47_0:_onChooseChange()
	EquipController.instance:dispatchEvent(EquipEvent.onShowStrengthenListModelContainer)
	gohelper.setActive(arg_47_0._gocost, true)
	gohelper.setActive(arg_47_0._gostart, true)
	gohelper.setActive(arg_47_0._gobreak, false)
	arg_47_0._gomaxbreaktip:SetActive(false)
	arg_47_0._gomaxbreakbartip:SetActive(false)
	gohelper.setActive(arg_47_0._golevelup, false)
	gohelper.setActive(arg_47_0._gobreakcount, false)
	gohelper.setActive(arg_47_0._txtcostcount.gameObject, true)
	gohelper.setActive(arg_47_0._goupgrade, true)
	gohelper.setActive(arg_47_0._gobreak, false)
	gohelper.setActive(arg_47_0._gocaneasycombinetip, false)
	arg_47_0:setExpProgressStatus(false)
	arg_47_0:refreshFilterBtn()
end

function var_0_0.showBreakContainer(arg_48_0)
	local var_48_0 = EquipConfig.instance:getNextBreakLevelCostCo(arg_48_0._equipMO)

	if not var_48_0 or not var_48_0.cost then
		return
	end

	arg_48_0._enoughBreak = arg_48_0:setBreakCostIconAndDispatchEvent(var_48_0)
	arg_48_0._enoughGold = arg_48_0:setCurrencyValue(var_48_0.scoreCost)

	arg_48_0:setAttribute(0, false)
	ZProj.UGUIHelper.SetGrayscale(arg_48_0._btnbreak.gameObject, not arg_48_0._enoughBreak and not arg_48_0._canEasyCombine or not arg_48_0._enoughGold)
	gohelper.setActive(arg_48_0._gocost, true)
	gohelper.setActive(arg_48_0._gostart, false)
	gohelper.setActive(arg_48_0._gobreak, true)
	arg_48_0._gomaxbreaktip:SetActive(false)
	arg_48_0._gomaxbreakbartip:SetActive(false)
	gohelper.setActive(arg_48_0._golevelup, true)
	gohelper.setActive(arg_48_0._gobreakcount, true)
	gohelper.setActive(arg_48_0._txtcostcount.gameObject, false)
	gohelper.setActive(arg_48_0._goupgrade, false)
	gohelper.setActive(arg_48_0._gobreak, true)
	arg_48_0:setExpProgressStatus(true)
	arg_48_0:setMaxLevelTxtExp()

	local var_48_1 = gohelper.findChildText(arg_48_0._golevelup, "layout/txt_prevvalue")
	local var_48_2 = gohelper.findChildText(arg_48_0._golevelup, "layout/txt_value")

	var_48_1.text = string.format("%s/%s", arg_48_0._equipMO.level, EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_48_0._equipMO))
	var_48_2.text = string.format("%s/%s", arg_48_0._equipMO.level, EquipConfig.instance:getNextBreakLevelMaxLevel(arg_48_0._equipMO))
end

function var_0_0.hideUpgradeAndBreakContainer(arg_49_0)
	EquipController.instance:dispatchEvent(EquipEvent.onHideBreakAndStrengthenListModelContainer)
	arg_49_0:setAttribute(0, false)
	arg_49_0:setMaxLevelTxtExp()

	arg_49_0._txttotallevel.text = ""
	arg_49_0._txtcurlevel.text = arg_49_0._equipMO.level

	recthelper.setWidth(arg_49_0._imagewhite.transform, arg_49_0._whiteWidth)
	arg_49_0._gomaxbreaktip:SetActive(true)
	arg_49_0:hideStrengthenScroll()
	arg_49_0._gomaxbreakbartip:SetActive(false)
	arg_49_0._gocost:SetActive(false)
	arg_49_0:setExpProgressStatus(true)
end

function var_0_0.setMaxLevelTxtExp(arg_50_0, arg_50_1)
	local var_50_0 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_50_0._equipMO)
	local var_50_1 = EquipConfig.instance:getEquipStrengthenCostCo(arg_50_0._config.rare, var_50_0).exp

	arg_50_0._txtexp.text = string.format("%s/%s", tostring(var_50_1), tostring(var_50_1))

	if not arg_50_1 then
		arg_50_0._txtaddexp.text = ""
	end
end

function var_0_0.setCurrencyValue(arg_51_0, arg_51_1)
	local var_51_0 = false

	if arg_51_1 <= CurrencyModel.instance:getGold() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_51_0._txtcurrency, "#E8E5DF")

		var_51_0 = true
		arg_51_0._occupyGold = arg_51_1
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_51_0._txtcurrency, "#CC4E4E")

		var_51_0 = false
		arg_51_0._occupyGold = 0
	end

	arg_51_0._txtcurrency.text = arg_51_1 ~= 0 and arg_51_1 or ""

	gohelper.setActive(arg_51_0._gonocurrency, arg_51_1 <= 0)
	arg_51_0:checkCanEasyCombine()

	return var_51_0
end

function var_0_0.enoughBreakConsume(arg_52_0, arg_52_1)
	arg_52_0._lackedItemDataList = {}
	arg_52_0._occupyItemDic = {}

	local var_52_0 = true

	for iter_52_0 = 1, #arg_52_1 do
		local var_52_1 = arg_52_1[iter_52_0].type
		local var_52_2 = arg_52_1[iter_52_0].id
		local var_52_3 = arg_52_1[iter_52_0].quantity
		local var_52_4 = ItemModel.instance:getItemQuantity(var_52_1, var_52_2)

		if var_52_4 < var_52_3 then
			local var_52_5 = var_52_3 - var_52_4

			table.insert(arg_52_0._lackedItemDataList, {
				type = var_52_1,
				id = var_52_2,
				quantity = var_52_5
			})

			var_52_0 = false
		else
			if not arg_52_0._occupyItemDic[var_52_1] then
				arg_52_0._occupyItemDic[var_52_1] = {}
			end

			arg_52_0._occupyItemDic[var_52_1][var_52_2] = (arg_52_0._occupyItemDic[var_52_1][var_52_2] or 0) + var_52_3
		end
	end

	arg_52_0:checkCanEasyCombine()

	return var_52_0
end

function var_0_0.checkCanEasyCombine(arg_53_0)
	local var_53_0 = {}

	if arg_53_0._occupyItemDic then
		for iter_53_0, iter_53_1 in pairs(arg_53_0._occupyItemDic) do
			var_53_0[iter_53_0] = iter_53_1
		end
	end

	local var_53_1 = var_53_0[MaterialEnum.MaterialType.Currency]

	if not var_53_1 then
		var_53_1 = {}
		var_53_0[MaterialEnum.MaterialType.Currency] = var_53_1
	end

	var_53_1[CurrencyEnum.CurrencyType.Gold] = (var_53_1[CurrencyEnum.CurrencyType.Gold] or 0) + (arg_53_0._occupyGold or 0)
	arg_53_0._canEasyCombine = false

	if arg_53_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowBreak then
		arg_53_0._canEasyCombine, arg_53_0._easyCombineTable = RoomProductionHelper.canEasyCombineItems(arg_53_0._lackedItemDataList, var_53_0)
	end

	gohelper.setActive(arg_53_0._gocaneasycombinetip, arg_53_0._canEasyCombine)
end

function var_0_0.setExpProgressStatus(arg_54_0, arg_54_1)
	gohelper.setActive(arg_54_0._gofullexp, arg_54_1)
	gohelper.setActive(arg_54_0._goafterwhite, not arg_54_1)
	gohelper.setActive(arg_54_0._imagewhite.gameObject, not arg_54_1)
end

function var_0_0._onBreakSuccess(arg_55_0)
	arg_55_0:showContainer()

	if arg_55_0.flow then
		arg_55_0.flow:destroy()
	end

	arg_55_0.flow = FlowSequence.New()

	if arg_55_0.viewContainer:isOpenLeftStrengthenScroll() then
		arg_55_0.flow:addWork(DelayFuncWork.New(arg_55_0.hideStrengthenScroll, arg_55_0, EquipEnum.AnimationDurationTime))
	end

	arg_55_0.flow:addWork(DelayFuncWork.New(function()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_breach)
	end, arg_55_0, 0.3))
	arg_55_0.flow:addWork(DelayFuncWork.New(arg_55_0.playExpBreakAnimationEffect, arg_55_0, arg_55_0.breakSuccessAnimationTime))
	arg_55_0.flow:addWork(DelayFuncWork.New(arg_55_0._hideLevelUpEffect, arg_55_0, 0))
	arg_55_0.flow:addWork(DelayFuncWork.New(arg_55_0.levelChangeAnimation, arg_55_0, var_0_0.LevelChangeAnimationTime))
	arg_55_0.flow:addWork(DelayFuncWork.New(arg_55_0.refreshLevelInfo, arg_55_0, 0))
	arg_55_0.flow:registerDoneListener(arg_55_0.onBreakAnimationDone, arg_55_0)
	arg_55_0.flow:start()
end

function var_0_0.onBreakAnimationDone(arg_57_0)
	arg_57_0.breaking = false

	EquipChooseListModel.instance:setIsLock(arg_57_0.breaking)
end

function var_0_0._onEquipLockChange(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_1.uid

	if arg_58_1.isLock then
		local var_58_1 = EquipModel.instance:getEquip(var_58_0)

		EquipChooseListModel.instance:deselectEquip(var_58_1)
	end
end

function var_0_0.hideStrengthenScroll(arg_59_0)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, false)
end

function var_0_0.levelChangeAnimation(arg_60_0)
	local var_60_0 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_60_0._equipMO)
	local var_60_1 = EquipConfig.instance:_getBreakLevelMaxLevel(arg_60_0._equipMO.config.rare, arg_60_0._equipMO.breakLv - 1)

	if arg_60_0.tweenId then
		ZProj.TweenHelper.KillById(arg_60_0.tweenId)
	end

	arg_60_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_60_1, var_60_0, var_0_0.LevelChangeAnimationTime, arg_60_0.setMaxLevel, arg_60_0.tweenDone, arg_60_0, nil, EaseType.Linear)
end

function var_0_0.setMaxLevel(arg_61_0, arg_61_1)
	arg_61_0._txttotallevel.text = "/" .. arg_61_1
end

function var_0_0.tweenDone(arg_62_0)
	arg_62_0.tweenId = nil
end

function var_0_0.refreshLevelInfo(arg_63_0)
	arg_63_0:updateLevelInfo(arg_63_0._equipMO.level)
end

function var_0_0.setBreakCostIconAndDispatchEvent(arg_64_0, arg_64_1)
	local var_64_0 = {}
	local var_64_1 = string.split(arg_64_1.cost, "|")

	for iter_64_0 = 1, #var_64_1 do
		local var_64_2 = string.splitToNumber(var_64_1[iter_64_0], "#")
		local var_64_3 = {
			type = tonumber(var_64_2[1]),
			id = tonumber(var_64_2[2]),
			quantity = tonumber(var_64_2[3])
		}

		table.insert(var_64_0, var_64_3)
	end

	EquipController.instance:dispatchEvent(EquipEvent.onShowBreakCostListModelContainer, var_64_1)

	return arg_64_0:enoughBreakConsume(var_64_0)
end

function var_0_0._refreshBreakCostIcon(arg_65_0)
	local var_65_0 = EquipConfig.instance:getNextBreakLevelCostCo(arg_65_0._equipMO)

	arg_65_0._enoughBreak = arg_65_0:setBreakCostIconAndDispatchEvent(var_65_0)

	ZProj.UGUIHelper.SetGrayscale(arg_65_0._btnbreak.gameObject, not arg_65_0._enoughBreak and not arg_65_0._canEasyCombine or not arg_65_0._enoughGold)
end

function var_0_0.refreshCost(arg_66_0)
	if arg_66_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowUpgrade then
		local var_66_0 = EquipChooseListModel.instance:calcStrengthen()
		local var_66_1 = EquipConfig.instance:getStrengthenToLvCost(arg_66_0._config.rare, arg_66_0._equipMO.level, arg_66_0._equipMO.exp, var_66_0)

		arg_66_0._enoughGold = arg_66_0:setCurrencyValue(var_66_1)
	elseif arg_66_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowBreak then
		local var_66_2 = EquipConfig.instance:getNextBreakLevelCostCo(arg_66_0._equipMO)

		if not var_66_2 or not var_66_2.cost then
			return
		end

		arg_66_0._enoughGold = arg_66_0:setCurrencyValue(var_66_2.scoreCost)
	end
end

function var_0_0.onClose(arg_67_0)
	EquipChooseListModel.instance:clearEquipList()
	EquipSelectedListModel.instance:clearList()

	arg_67_0._expList = nil

	EquipController.instance:dispatchEvent(EquipEvent.onCloseEquipStrengthenView)
	EquipBreakCostListModel.instance:clearList()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

	if arg_67_0.flow then
		arg_67_0.flow:destroy()
	end

	arg_67_0.flow = nil
	arg_67_0.breaking = false

	EquipChooseListModel.instance:setIsLock(arg_67_0.breaking)

	if arg_67_0.tweenId then
		ZProj.TweenHelper.KillById(arg_67_0.tweenId)
	end

	arg_67_0:playCloseAnimation()
end

function var_0_0.playCloseAnimation(arg_68_0)
	arg_68_0._viewAnim:Play(UIAnimationName.Close)
	arg_68_0:playOutsideNodeAnimation(UIAnimationName.Close)
	arg_68_0.viewContainer:playCurrencyViewAnimation("go_righttop_out")
end

function var_0_0.playOutsideNodeAnimation(arg_69_0, arg_69_1)
	if arg_69_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowUpgrade then
		arg_69_0.viewContainer.equipView.costEquipScrollAnim:Play(arg_69_1)
	elseif arg_69_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowBreak then
		arg_69_0.viewContainer.equipView.breakEquipScrollAnim:Play(arg_69_1)
	end
end

function var_0_0.onDestroyView(arg_70_0)
	EquipFilterModel.instance:clear(arg_70_0.viewName)
	TaskDispatcher.cancelTask(arg_70_0._hideGravingEffect, arg_70_0)
	TaskDispatcher.cancelTask(arg_70_0._hideImprove, arg_70_0)
	arg_70_0.dropFilter:RemoveOnValueChanged()
	arg_70_0.dropClick:RemoveClickListener()

	if arg_70_0._sequence then
		arg_70_0._sequence:destroy()
	end

	if arg_70_0.dropExtend then
		arg_70_0.dropExtend:dispose()
	end
end

return var_0_0
