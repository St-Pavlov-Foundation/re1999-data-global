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
	if not arg_13_0._enoughBreak then
		return
	end

	if not arg_13_0._enoughGold then
		GameFacade.showToast(ToastEnum.EquipStrengthenNoGold)

		return
	end

	arg_13_0.breaking = true

	EquipChooseListModel.instance:setIsLock(arg_13_0.breaking)
	EquipRpc.instance:sendEquipBreakRequest(arg_13_0._equipMO.uid)
end

function var_0_0._hideLevelUpEffect(arg_14_0)
	gohelper.setActive(arg_14_0._golevelupeffect, false)
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0.breakSuccessAnimationTime = arg_15_0._golevelupeffect:GetComponent(typeof(UnityEngine.Animation)).clip.length
	arg_15_0._animimprove = arg_15_0._goimprove:GetComponent(typeof(UnityEngine.Animator))
	arg_15_0._viewAnim = arg_15_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_15_0._strengthenattrs = arg_15_0:getUserDataTb_()

	gohelper.setActive(arg_15_0._gostrengthenattr, false)

	arg_15_0._whiteWidth = recthelper.getWidth(arg_15_0._imagewhite.transform)
	arg_15_0.imageBreakIcon = gohelper.findChildImage(arg_15_0._gobreakeffect, "image_icon")
	arg_15_0.txtBreakAttrName = gohelper.findChildText(arg_15_0._gobreakeffect, "txt_name")
	arg_15_0.txtBreakValue = gohelper.findChildText(arg_15_0._gobreakeffect, "txt_value")
	arg_15_0.txtBreakPreValue = gohelper.findChildText(arg_15_0._gobreakeffect, "txt_prevalue")
	arg_15_0.goBreakRightArrow = gohelper.findChild(arg_15_0._gobreakeffect, "go_rightarrow")
	arg_15_0.goNotFilter = gohelper.findChild(arg_15_0.viewGO, "#go_improve/#go_sortbtns/#btn_filter/#go_notfilter")
	arg_15_0.goFilter = gohelper.findChild(arg_15_0.viewGO, "#go_improve/#go_sortbtns/#btn_filter/#go_filter")

	local var_15_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Gold).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_15_0._imagecurrency, var_15_0 .. "_1")

	arg_15_0._equipLvBtns = arg_15_0:getUserDataTb_()
	arg_15_0._equipLvArrow = arg_15_0:getUserDataTb_()
	arg_15_0._equipQualityBtns = arg_15_0:getUserDataTb_()
	arg_15_0._equipQualityArrow = arg_15_0:getUserDataTb_()

	for iter_15_0 = 1, 2 do
		arg_15_0._equipLvBtns[iter_15_0] = gohelper.findChild(arg_15_0._btnlvrank.gameObject, "btn" .. tostring(iter_15_0))
		arg_15_0._equipLvArrow[iter_15_0] = gohelper.findChild(arg_15_0._equipLvBtns[iter_15_0], "txt/arrow").transform
		arg_15_0._equipQualityBtns[iter_15_0] = gohelper.findChild(arg_15_0._btnrarerank.gameObject, "btn" .. tostring(iter_15_0))
		arg_15_0._equipQualityArrow[iter_15_0] = gohelper.findChild(arg_15_0._equipQualityBtns[iter_15_0], "txt/arrow").transform
	end

	gohelper.setActive(arg_15_0._equipLvArrow[1].gameObject, false)
	gohelper.setActive(arg_15_0._equipQualityArrow[1].gameObject, false)
	gohelper.addUIClickAudio(arg_15_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_15_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_15_0._btnbreak.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)
	gohelper.addUIClickAudio(arg_15_0._btnupgrade.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)
	gohelper.addUIClickAudio(arg_15_0._btnfastadd.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Addall)

	arg_15_0._enoughBreak = false
	arg_15_0.breaking = false

	EquipChooseListModel.instance:setIsLock(arg_15_0.breaking)

	arg_15_0.initDropDone = false

	arg_15_0:initFilterDrop()

	arg_15_0._goupgrade = gohelper.findChild(arg_15_0._gobtns, "start")
	arg_15_0._gobreak = gohelper.findChild(arg_15_0._gobtns, "break")

	gohelper.setActive(arg_15_0._goimprove, false)

	arg_15_0.initDropDone = true
	arg_15_0.showContainerStatus = var_0_0.ShowContainerStatusEnum.ShowUpgrade

	arg_15_0:setBtnBackWidth()
	arg_15_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_15_0.setBtnBackWidth, arg_15_0)
end

function var_0_0.setBtnBackWidth(arg_16_0)
	local var_16_0 = recthelper.getWidth(arg_16_0._goimprove.transform)

	recthelper.setWidth(arg_16_0._btnback.gameObject.transform, 0.45 * var_16_0)
end

function var_0_0.onDropHide(arg_17_0)
	transformhelper.setLocalScale(arg_17_0.trDropArrow, 1, 1, 1)
end

function var_0_0.onDropShow(arg_18_0)
	transformhelper.setLocalScale(arg_18_0.trDropArrow, 1, -1, 1)
end

function var_0_0.initFilterDrop(arg_19_0)
	arg_19_0.dropFilter = gohelper.findChildDropdown(arg_19_0._gocost, "#drop_filter")
	arg_19_0.trDropArrow = gohelper.findChildComponent(arg_19_0.dropFilter.gameObject, "Arrow", typeof(UnityEngine.Transform))
	arg_19_0.dropClick = gohelper.getClick(arg_19_0.dropFilter.gameObject)
	arg_19_0.dropExtend = DropDownExtend.Get(arg_19_0.dropFilter.gameObject)

	arg_19_0.dropExtend:init(arg_19_0.onDropShow, arg_19_0.onDropHide, arg_19_0)

	arg_19_0.filterRareLevelList = {}

	for iter_19_0 = 2, EquipConfig.instance:getMaxFilterRare() do
		table.insert(arg_19_0.filterRareLevelList, iter_19_0)
	end

	local var_19_0 = {}

	for iter_19_1, iter_19_2 in ipairs(arg_19_0.filterRareLevelList) do
		if iter_19_2 == 0 then
			table.insert(var_19_0, luaLang("equip_filter_all"))
		else
			table.insert(var_19_0, string.format(luaLang("equip_filter_str"), iter_19_2))
		end
	end

	arg_19_0.dropFilter:ClearOptions()
	arg_19_0.dropFilter:AddOptions(var_19_0)
	arg_19_0.dropFilter:AddOnValueChanged(arg_19_0.onDropValueChanged, arg_19_0)
	arg_19_0.dropClick:AddClickListener(function()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, arg_19_0)

	local var_19_1 = EquipChooseListModel.instance:getFilterRare()

	for iter_19_3, iter_19_4 in ipairs(arg_19_0.filterRareLevelList) do
		if iter_19_4 == var_19_1 then
			arg_19_0.dropFilter:SetValue(iter_19_3 - 1)

			break
		end
	end
end

function var_0_0.onDropValueChanged(arg_21_0, arg_21_1)
	if not arg_21_0.initDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	EquipChooseListModel.instance:setFilterRare(arg_21_0.filterRareLevelList[arg_21_1 + 1])
end

function var_0_0.onUpdateParam(arg_22_0)
	return
end

function var_0_0.onOpen(arg_23_0)
	arg_23_0.filterMo = EquipFilterModel.instance:generateFilterMo(arg_23_0.viewName)
	arg_23_0._equipMO = arg_23_0.viewContainer.viewParam.equipMO
	arg_23_0._config = arg_23_0._equipMO.config
	arg_23_0._equipMaxLv = EquipConfig.instance:getMaxLevel(arg_23_0._config)

	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_23_0._onEquipStrengthenReply, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onChooseChange, arg_23_0._onChooseChange, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_23_0._onUpdateEquip, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_23_0._onUpdateEquip, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onStrengthenFast, arg_23_0._btnfastaddOnClick, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onStrengthenUpgrade, arg_23_0._btnupgradeOnClick, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_23_0._onBreakSuccess, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onEquipLockChange, arg_23_0._onEquipLockChange, arg_23_0)
	arg_23_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_23_0._refreshBreakCostIcon, arg_23_0)
	arg_23_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_23_0.refreshCost, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, arg_23_0.onEquipTypeHasChange, arg_23_0)
	EquipChooseListModel.instance:initEquipMo(arg_23_0._equipMO, false)
	EquipChooseListModel.instance:initEquipList(arg_23_0.filterCareer)

	arg_23_0._playUserIdTabs = arg_23_0:getUserDataTb_()
	arg_23_0._playerSaveTabs = arg_23_0:getUserDataTb_()

	local var_23_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.EquipStrengthen, "")

	if not string.nilorempty(var_23_0) then
		arg_23_0._playUserIdTabs = cjson.decode(var_23_0)
	end

	arg_23_0._curPlayerInfoId = PlayerModel.instance:getPlayinfo().userId

	if arg_23_0._playUserIdTabs[arg_23_0._curPlayerInfoId] == nil then
		arg_23_0._playerSaveTabs.saveTime = nil
		arg_23_0._playUserIdTabs[arg_23_0._curPlayerInfoId] = arg_23_0._playerSaveTabs
	else
		arg_23_0._playerSaveTabs = arg_23_0._playUserIdTabs[arg_23_0._curPlayerInfoId]
	end

	arg_23_0:showContainer()
	arg_23_0:updateLevelInfo(arg_23_0._equipMO.level)

	if arg_23_0.viewContainer:getIsOpenLeftBackpack() then
		arg_23_0.viewContainer.equipView:hideRefineScrollAndShowStrengthenScroll()
	else
		gohelper.setActive(arg_23_0._goimprove, false)
	end

	arg_23_0._viewAnim:Play(UIAnimationName.Open)
	arg_23_0:playOutsideNodeAnimation(UIAnimationName.Open)
	arg_23_0.viewContainer:playCurrencyViewAnimation("go_righttop_ina")
end

function var_0_0.showContainer(arg_24_0)
	if arg_24_0._equipMO.level == arg_24_0._equipMaxLv then
		arg_24_0.showContainerStatus = var_0_0.ShowContainerStatusEnum.ShowMax

		arg_24_0:hideUpgradeAndBreakContainer()

		return
	end

	if arg_24_0._equipMO.level == EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_24_0._equipMO) then
		arg_24_0.showContainerStatus = var_0_0.ShowContainerStatusEnum.ShowBreak

		arg_24_0:showBreakContainer()

		return
	end

	arg_24_0.showContainerStatus = var_0_0.ShowContainerStatusEnum.ShowUpgrade

	arg_24_0:showUpgradeContainer()
end

function var_0_0.showScrollContainer(arg_25_0)
	arg_25_0.isShow = true

	EquipChooseListModel.instance:setEquipList()
	arg_25_0:refreshEquipChooseEmptyContainer()
	arg_25_0:_refreshEquipBtnIcon()
	gohelper.setActive(arg_25_0._goimprove, true)
	arg_25_0._animimprove:Play("go_improve_in")
end

function var_0_0.hideScrollContainer(arg_26_0)
	arg_26_0.isShow = false

	arg_26_0._animimprove:Play("go_improve_out")
	TaskDispatcher.runDelay(arg_26_0._hideImprove, arg_26_0, EquipEnum.AnimationDurationTime)
end

function var_0_0.refreshEquipChooseEmptyContainer(arg_27_0)
	local var_27_0 = EquipChooseListModel.instance:getCount()

	gohelper.setActive(arg_27_0._golackequip, var_27_0 == 0)
end

function var_0_0._hideImprove(arg_28_0)
	gohelper.setActive(arg_28_0._goimprove, false)
end

function var_0_0.onEquipTypeHasChange(arg_29_0, arg_29_1)
	if arg_29_1 ~= arg_29_0.viewName then
		return
	end

	arg_29_0.viewContainer.equipView:setStrengthenScrollVerticalNormalizedPosition(1)
	EquipChooseListModel.instance:initEquipList(arg_29_0.filterMo, true)
	EquipChooseListModel.instance:setEquipList()
	arg_29_0:refreshFilterBtn()
end

function var_0_0.refreshFilterBtn(arg_30_0)
	local var_30_0 = arg_30_0.filterMo:isFiltering()

	gohelper.setActive(arg_30_0.goNotFilter, not var_30_0)
	gohelper.setActive(arg_30_0.goFilter, var_30_0)
end

function var_0_0._onUpdateEquip(arg_31_0)
	if arg_31_0.tabContainer._curTabId ~= EquipCategoryListModel.ViewIndex.EquipStrengthenViewIndex then
		return
	end

	EquipChooseListModel.instance:initEquipList(arg_31_0.career, true)
	EquipChooseListModel.instance:setEquipList()
	arg_31_0:refreshEquipChooseEmptyContainer()
end

function var_0_0._updateCostItemList(arg_32_0)
	local var_32_0 = EquipChooseListModel.instance:calcStrengthen()

	if var_32_0 > 0 then
		arg_32_0._txtaddexp.text = "EXP+" .. var_32_0
	else
		arg_32_0._txtaddexp.text = ""
	end

	arg_32_0:showStrengthenEffect(var_32_0)
end

function var_0_0._onChooseChange(arg_33_0)
	arg_33_0._txtcostcount.text = string.format("%s<color=#E8E5DF>(%s/%s)</color>", luaLang("p_equip_8"), EquipChooseListModel.instance:getChooseEquipsNum(), EquipEnum.StrengthenMaxCount)

	arg_33_0:_updateCostItemList()
end

function var_0_0.playExpAnimationEffect(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._hideGravingEffect, arg_34_0)
	gohelper.setActive(arg_34_0._goengravingEffect, true)
	TaskDispatcher.runDelay(arg_34_0._hideGravingEffect, arg_34_0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_engrave)
end

function var_0_0.playExpBreakAnimationEffect(arg_35_0)
	gohelper.setActive(arg_35_0._golevelupeffect, true)
end

function var_0_0._onEquipStrengthenReply(arg_36_0)
	arg_36_0.isUpgradeReply = true

	EquipChooseListModel.instance:initEquipList(arg_36_0.career, false)
	EquipChooseListModel.instance:setEquipList()
	arg_36_0:refreshEquipChooseEmptyContainer()
	EquipChooseListModel.instance:resetSelectedEquip()
	arg_36_0:playExpAnimationEffect()

	arg_36_0._expList = nil

	arg_36_0:showContainer()

	arg_36_0.isUpgradeReply = false
end

function var_0_0.showStrengthenEffect(arg_37_0, arg_37_1)
	if arg_37_0._equipMaxLv == arg_37_0._equipMO.level then
		return
	end

	arg_37_1 = arg_37_1 or 0

	local var_37_0 = EquipConfig.instance:getEquipStrengthenCostCo(arg_37_0._config.rare, arg_37_0._equipMO.level + 1)
	local var_37_1 = arg_37_0._equipMO.level

	recthelper.setWidth(arg_37_0._imagegreen1.transform, 0)

	local var_37_2 = false

	if arg_37_1 > 0 then
		var_37_1 = EquipConfig.instance:getStrengthenToLv(arg_37_0._config.rare, arg_37_0._equipMO.level, arg_37_0._equipMO.exp + arg_37_1)
		var_37_2 = var_37_1 ~= arg_37_0._equipMO.level

		local var_37_3 = EquipConfig.instance:getStrengthenToLvCost(arg_37_0._config.rare, arg_37_0._equipMO.level, arg_37_0._equipMO.exp, arg_37_1)

		arg_37_0._enoughGold = arg_37_0:setCurrencyValue(var_37_3)

		arg_37_0:showExpAnimation(arg_37_1, var_37_0)
	else
		arg_37_0._enoughGold = arg_37_0:setCurrencyValue(0)
		arg_37_0._txtcurrency.text = ""

		SLFramework.UGUI.GuiHelper.SetColor(arg_37_0._txtcurrency, "#E8E5DF")

		if arg_37_0._expList then
			arg_37_0:showExpAnimation(arg_37_1, var_37_0)

			arg_37_0._expList = nil
		end
	end

	ZProj.UGUIHelper.SetGrayscale(arg_37_0._btnupgrade.gameObject, arg_37_1 <= 0)

	local var_37_4, var_37_5 = EquipConfig.instance:getStrengthenToLvExpInfo(arg_37_0._config.rare, arg_37_0._equipMO.level, arg_37_0._equipMO.exp, arg_37_1)
	local var_37_6 = arg_37_0._whiteWidth * math.min(arg_37_0._equipMO.exp / var_37_0.exp, 1)

	recthelper.setWidth(arg_37_0._imagewhite.transform, var_37_6)

	arg_37_0._txtexp.text = string.format("%s/%s", var_37_4, var_37_5)

	arg_37_0:setAttribute(arg_37_1, var_37_2, var_37_0, var_37_1)
end

function var_0_0.setAttribute(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	arg_38_0._upgrade = arg_38_2
	arg_38_0._addexp = arg_38_1
	arg_38_0._attrIndex = 1

	if arg_38_2 then
		local var_38_0, var_38_1, var_38_2, var_38_3 = EquipConfig.instance:getEquipAddBaseAttr(arg_38_0._equipMO)
		local var_38_4, var_38_5, var_38_6, var_38_7 = EquipConfig.instance:getEquipAddBaseAttr(arg_38_0._equipMO, arg_38_4)

		arg_38_0:showAttr(CharacterEnum.AttrId.Attack, 0, var_38_5, var_38_1, arg_38_3)
		arg_38_0:showAttr(CharacterEnum.AttrId.Hp, 0, var_38_4, var_38_0, arg_38_3)
		arg_38_0:showAttr(CharacterEnum.AttrId.Defense, 0, var_38_6, var_38_2, arg_38_3)
		arg_38_0:showAttr(CharacterEnum.AttrId.Mdefense, 0, var_38_7, var_38_3, arg_38_3)
	else
		local var_38_8, var_38_9, var_38_10, var_38_11 = EquipConfig.instance:getEquipAddBaseAttr(arg_38_0._equipMO)

		arg_38_0:showAttr(CharacterEnum.AttrId.Attack, 0, var_38_9)
		arg_38_0:showAttr(CharacterEnum.AttrId.Hp, 0, var_38_8)
		arg_38_0:showAttr(CharacterEnum.AttrId.Defense, 0, var_38_10)
		arg_38_0:showAttr(CharacterEnum.AttrId.Mdefense, 0, var_38_11)
	end

	for iter_38_0 = arg_38_0._attrIndex, #arg_38_0._strengthenattrs do
		gohelper.setActive(arg_38_0._strengthenattrs[iter_38_0].go, false)
	end

	local var_38_12, var_38_13 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(arg_38_0._config, arg_38_0._equipMO.breakLv)

	if var_38_12 then
		gohelper.setActive(arg_38_0._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_38_0.imageBreakIcon, "icon_att_" .. var_38_12)

		arg_38_0.txtBreakAttrName.text = EquipHelper.getAttrBreakText(var_38_12)

		gohelper.setAsLastSibling(arg_38_0._gobreakeffect)

		if arg_38_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowBreak then
			local var_38_14, var_38_15 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(arg_38_0._config, arg_38_0._equipMO.breakLv + 1)

			arg_38_0.txtBreakPreValue.text = EquipHelper.getAttrPercentValueStr(var_38_13)
			arg_38_0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_38_15)
			arg_38_0.txtBreakValue.color = var_0_0.Color.NextColor

			gohelper.setActive(arg_38_0.goBreakRightArrow, true)
			gohelper.setActive(arg_38_0.txtBreakPreValue, true)
		else
			arg_38_0.txtBreakValue.color = var_0_0.Color.NormalColor

			gohelper.setActive(arg_38_0.goBreakRightArrow, false)
			gohelper.setActive(arg_38_0.txtBreakPreValue, false)

			arg_38_0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_38_13)
		end
	else
		gohelper.setActive(arg_38_0._gobreakeffect, false)
	end
end

function var_0_0.showBreakLv(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_1.transform
	local var_39_1 = var_39_0.childCount

	for iter_39_0 = 1, var_39_1 do
		local var_39_2 = var_39_0:GetChild(iter_39_0 - 1)
		local var_39_3 = gohelper.onceAddComponent(var_39_2.gameObject, gohelper.Type_Image)

		UISpriteSetMgr.instance:setEquipSprite(var_39_3, iter_39_0 <= arg_39_2 and "xx_11" or "xx_10")
	end
end

function var_0_0.calcTotalExp(arg_40_0, arg_40_1)
	if not arg_40_1 then
		return 0, 0
	end

	return arg_40_1[1], arg_40_1[2]
end

function var_0_0.showExpAnimation(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_0.isUpgradeReply then
		return
	end

	local var_41_0 = arg_41_0._expList
	local var_41_1
	local var_41_2

	arg_41_0._expList, var_41_2 = EquipConfig.instance:getStrengthenToLvCostExp(arg_41_0._config.rare, arg_41_0._equipMO.level, arg_41_0._equipMO.exp, arg_41_1, arg_41_0._equipMO.breakLv)

	local var_41_3, var_41_4 = arg_41_0:calcTotalExp(var_41_0)
	local var_41_5, var_41_6 = arg_41_0:calcTotalExp(arg_41_0._expList)

	if arg_41_0._sequence then
		arg_41_0._sequence:destroy()
	end

	local var_41_7 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_41_0._equipMO)

	local function var_41_8(arg_42_0)
		local var_42_0 = var_41_5 + arg_42_0
		local var_42_1 = Mathf.Floor(var_42_0)
		local var_42_2 = var_42_0 - var_42_1
		local var_42_3 = arg_41_0._equipMO.level + var_42_1

		if var_41_6 >= var_41_4 and var_42_3 >= var_41_7 or var_41_6 <= var_41_4 and arg_41_0._equipMO.level + var_41_6 + var_41_5 >= var_41_7 then
			if arg_41_0.tweenWork then
				arg_41_0.tweenWork:clearWork()
				arg_41_0:setExpProgressStatus(true)
				arg_41_0:updateLevelInfo(var_41_7)
				arg_41_0:setMaxLevelTxtExp(true)
			end

			return
		end

		if var_42_1 > 0 then
			recthelper.setWidth(arg_41_0._imagewhite.transform, 0)
			arg_41_0._imagegreen1.transform:SetParent(arg_41_0._goafterwhite.transform)
		else
			if arg_41_2 then
				local var_42_4 = arg_41_0._whiteWidth * math.min(arg_41_0._equipMO.exp / arg_41_2.exp, 1)

				recthelper.setWidth(arg_41_0._imagewhite.transform, var_42_4)
			end

			arg_41_0._imagegreen1.transform:SetParent(arg_41_0._gobeforewhite.transform)
		end

		recthelper.setWidth(arg_41_0._imagegreen1.transform, var_42_2 * arg_41_0._whiteWidth)
		arg_41_0:updateLevelInfo(var_42_3)
	end

	local var_41_9 = arg_41_0._skipExpAnimation and 0 or 0.2

	arg_41_0:setExpProgressStatus(false)

	arg_41_0.tweenWork = TweenWork.New({
		type = "DOTweenFloat",
		from = var_41_4,
		to = var_41_6,
		t = var_41_9,
		frameCb = var_41_8,
		ease = EaseType.Linear
	})
	arg_41_0._sequence = FlowSequence.New()

	arg_41_0._sequence:addWork(arg_41_0.tweenWork)
	arg_41_0._sequence:registerDoneListener(function()
		if var_41_2 then
			arg_41_0:setExpProgressStatus(true)
			arg_41_0:updateLevelInfo(var_41_7)
			arg_41_0:setMaxLevelTxtExp(true)
		end
	end)
	arg_41_0._sequence:start()
end

function var_0_0.updateLevelInfo(arg_44_0, arg_44_1)
	local var_44_0 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_44_0._equipMO)
	local var_44_1 = string.format("<color=#E8E5DF>/%s</color>", var_44_0)

	arg_44_0._txttotallevel.text = var_44_1
	arg_44_0._txtcurlevel.text = math.min(arg_44_1, var_44_0)
end

function var_0_0.showAttr(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
	if arg_45_3 <= -1 then
		return
	end

	local var_45_0 = arg_45_4 and arg_45_4 < arg_45_3
	local var_45_1 = HeroConfig.instance:getHeroAttributeCO(arg_45_1)
	local var_45_2 = arg_45_0._attrIndex
	local var_45_3 = arg_45_0._strengthenattrs[var_45_2]

	if not var_45_3 then
		var_45_3 = arg_45_0:getUserDataTb_()
		var_45_3.go = gohelper.cloneInPlace(arg_45_0._gostrengthenattr, "item" .. var_45_2)
		var_45_3.txtvalue = gohelper.findChildText(var_45_3.go, "layout/txt_value")
		var_45_3.txtname = gohelper.findChildText(var_45_3.go, "layout/txt_name")
		var_45_3.imageicon = gohelper.findChildImage(var_45_3.go, "image_icon")
		var_45_3.txtprevvalue = gohelper.findChildText(var_45_3.go, "layout/txt_prevvalue")
		var_45_3.gorightarrow = gohelper.findChild(var_45_3.go, "layout/go_rightarrow")
		var_45_3.bg = gohelper.findChild(var_45_3.go, "layout/go_bg")

		table.insert(arg_45_0._strengthenattrs, var_45_3)
	end

	gohelper.setActive(var_45_3.bg, var_45_2 % 2 == 0)
	CharacterController.instance:SetAttriIcon(var_45_3.imageicon, arg_45_1, GameUtil.parseColor("#736E6A"))

	var_45_3.txtvalue.text = arg_45_0._upgrade and EquipConfig.instance:dirGetEquipValueStr(arg_45_2, arg_45_3) or "+0"

	if arg_45_0._upgrade and arg_45_0._addexp > 0 then
		SLFramework.UGUI.GuiHelper.SetColor(var_45_3.txtvalue, "#83BC84")
	else
		SLFramework.UGUI.GuiHelper.SetColor(var_45_3.txtvalue, "#CAC8C5")
	end

	var_45_3.txtname.text = var_45_1.name
	var_45_3.txtprevvalue.text = var_45_0 and EquipConfig.instance:dirGetEquipValueStr(arg_45_2, arg_45_4) or EquipConfig.instance:dirGetEquipValueStr(arg_45_2, arg_45_3)

	gohelper.setActive(var_45_3.gorightarrow, true)
	gohelper.setActive(var_45_3.go, true)

	arg_45_0._attrIndex = arg_45_0._attrIndex + 1

	if not arg_45_5 then
		var_45_3.txtvalue.text = var_45_3.txtprevvalue.text

		gohelper.setActive(var_45_3.txtprevvalue.gameObject, false)
		gohelper.setActive(var_45_3.gorightarrow, false)
	else
		gohelper.setActive(var_45_3.txtprevvalue.gameObject, true)
		gohelper.setActive(var_45_3.gorightarrow, true)
	end
end

function var_0_0.showUpgradeContainer(arg_46_0)
	EquipSelectedListModel.instance:initList()
	arg_46_0:_onChooseChange()
	EquipController.instance:dispatchEvent(EquipEvent.onShowStrengthenListModelContainer)
	gohelper.setActive(arg_46_0._gocost, true)
	gohelper.setActive(arg_46_0._gostart, true)
	gohelper.setActive(arg_46_0._gobreak, false)
	arg_46_0._gomaxbreaktip:SetActive(false)
	arg_46_0._gomaxbreakbartip:SetActive(false)
	gohelper.setActive(arg_46_0._golevelup, false)
	gohelper.setActive(arg_46_0._gobreakcount, false)
	gohelper.setActive(arg_46_0._txtcostcount.gameObject, true)
	gohelper.setActive(arg_46_0._goupgrade, true)
	gohelper.setActive(arg_46_0._gobreak, false)
	arg_46_0:setExpProgressStatus(false)
	arg_46_0:refreshFilterBtn()
end

function var_0_0.showBreakContainer(arg_47_0)
	local var_47_0 = EquipConfig.instance:getNextBreakLevelCostCo(arg_47_0._equipMO)

	if not var_47_0 or not var_47_0.cost then
		return
	end

	arg_47_0._enoughBreak = arg_47_0:setBreakCostIconAndDispatchEvent(var_47_0)
	arg_47_0._enoughGold = arg_47_0:setCurrencyValue(var_47_0.scoreCost)

	arg_47_0:setAttribute(0, false)
	ZProj.UGUIHelper.SetGrayscale(arg_47_0._btnbreak.gameObject, not arg_47_0._enoughBreak or not arg_47_0._enoughGold)
	gohelper.setActive(arg_47_0._gocost, true)
	gohelper.setActive(arg_47_0._gostart, false)
	gohelper.setActive(arg_47_0._gobreak, true)
	arg_47_0._gomaxbreaktip:SetActive(false)
	arg_47_0._gomaxbreakbartip:SetActive(false)
	gohelper.setActive(arg_47_0._golevelup, true)
	gohelper.setActive(arg_47_0._gobreakcount, true)
	gohelper.setActive(arg_47_0._txtcostcount.gameObject, false)
	gohelper.setActive(arg_47_0._goupgrade, false)
	gohelper.setActive(arg_47_0._gobreak, true)
	arg_47_0:setExpProgressStatus(true)
	arg_47_0:setMaxLevelTxtExp()

	local var_47_1 = gohelper.findChildText(arg_47_0._golevelup, "layout/txt_prevvalue")
	local var_47_2 = gohelper.findChildText(arg_47_0._golevelup, "layout/txt_value")

	var_47_1.text = string.format("%s/%s", arg_47_0._equipMO.level, EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_47_0._equipMO))
	var_47_2.text = string.format("%s/%s", arg_47_0._equipMO.level, EquipConfig.instance:getNextBreakLevelMaxLevel(arg_47_0._equipMO))
end

function var_0_0.hideUpgradeAndBreakContainer(arg_48_0)
	EquipController.instance:dispatchEvent(EquipEvent.onHideBreakAndStrengthenListModelContainer)
	arg_48_0:setAttribute(0, false)
	arg_48_0:setMaxLevelTxtExp()

	arg_48_0._txttotallevel.text = ""
	arg_48_0._txtcurlevel.text = arg_48_0._equipMO.level

	recthelper.setWidth(arg_48_0._imagewhite.transform, arg_48_0._whiteWidth)
	arg_48_0._gomaxbreaktip:SetActive(true)
	arg_48_0:hideStrengthenScroll()
	arg_48_0._gomaxbreakbartip:SetActive(false)
	arg_48_0._gocost:SetActive(false)
	arg_48_0:setExpProgressStatus(true)
end

function var_0_0.setMaxLevelTxtExp(arg_49_0, arg_49_1)
	local var_49_0 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_49_0._equipMO)
	local var_49_1 = EquipConfig.instance:getEquipStrengthenCostCo(arg_49_0._config.rare, var_49_0).exp

	arg_49_0._txtexp.text = string.format("%s/%s", tostring(var_49_1), tostring(var_49_1))

	if not arg_49_1 then
		arg_49_0._txtaddexp.text = ""
	end
end

function var_0_0.setCurrencyValue(arg_50_0, arg_50_1)
	local var_50_0 = false

	if arg_50_1 <= CurrencyModel.instance:getGold() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_50_0._txtcurrency, "#E8E5DF")

		var_50_0 = true
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_50_0._txtcurrency, "#CC4E4E")

		var_50_0 = false
	end

	arg_50_0._txtcurrency.text = arg_50_1 ~= 0 and arg_50_1 or ""

	gohelper.setActive(arg_50_0._gonocurrency, arg_50_1 <= 0)

	return var_50_0
end

function var_0_0.enoughBreakConsume(arg_51_0, arg_51_1)
	for iter_51_0 = 1, #arg_51_1 do
		if ItemModel.instance:getItemQuantity(arg_51_1[iter_51_0].type, arg_51_1[iter_51_0].id) < arg_51_1[iter_51_0].quantity then
			return false
		end
	end

	return true
end

function var_0_0.setExpProgressStatus(arg_52_0, arg_52_1)
	gohelper.setActive(arg_52_0._gofullexp, arg_52_1)
	gohelper.setActive(arg_52_0._goafterwhite, not arg_52_1)
	gohelper.setActive(arg_52_0._imagewhite.gameObject, not arg_52_1)
end

function var_0_0._onBreakSuccess(arg_53_0)
	arg_53_0:showContainer()

	if arg_53_0.flow then
		arg_53_0.flow:destroy()
	end

	arg_53_0.flow = FlowSequence.New()

	if arg_53_0.viewContainer:isOpenLeftStrengthenScroll() then
		arg_53_0.flow:addWork(DelayFuncWork.New(arg_53_0.hideStrengthenScroll, arg_53_0, EquipEnum.AnimationDurationTime))
	end

	arg_53_0.flow:addWork(DelayFuncWork.New(function()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_breach)
	end, arg_53_0, 0.3))
	arg_53_0.flow:addWork(DelayFuncWork.New(arg_53_0.playExpBreakAnimationEffect, arg_53_0, arg_53_0.breakSuccessAnimationTime))
	arg_53_0.flow:addWork(DelayFuncWork.New(arg_53_0._hideLevelUpEffect, arg_53_0, 0))
	arg_53_0.flow:addWork(DelayFuncWork.New(arg_53_0.levelChangeAnimation, arg_53_0, var_0_0.LevelChangeAnimationTime))
	arg_53_0.flow:addWork(DelayFuncWork.New(arg_53_0.refreshLevelInfo, arg_53_0, 0))
	arg_53_0.flow:registerDoneListener(arg_53_0.onBreakAnimationDone, arg_53_0)
	arg_53_0.flow:start()
end

function var_0_0.onBreakAnimationDone(arg_55_0)
	arg_55_0.breaking = false

	EquipChooseListModel.instance:setIsLock(arg_55_0.breaking)
end

function var_0_0._onEquipLockChange(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_1.uid

	if arg_56_1.isLock then
		local var_56_1 = EquipModel.instance:getEquip(var_56_0)

		EquipChooseListModel.instance:deselectEquip(var_56_1)
	end
end

function var_0_0.hideStrengthenScroll(arg_57_0)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, false)
end

function var_0_0.levelChangeAnimation(arg_58_0)
	local var_58_0 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_58_0._equipMO)
	local var_58_1 = EquipConfig.instance:_getBreakLevelMaxLevel(arg_58_0._equipMO.config.rare, arg_58_0._equipMO.breakLv - 1)

	if arg_58_0.tweenId then
		ZProj.TweenHelper.KillById(arg_58_0.tweenId)
	end

	arg_58_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_58_1, var_58_0, var_0_0.LevelChangeAnimationTime, arg_58_0.setMaxLevel, arg_58_0.tweenDone, arg_58_0, nil, EaseType.Linear)
end

function var_0_0.setMaxLevel(arg_59_0, arg_59_1)
	arg_59_0._txttotallevel.text = "/" .. arg_59_1
end

function var_0_0.tweenDone(arg_60_0)
	arg_60_0.tweenId = nil
end

function var_0_0.refreshLevelInfo(arg_61_0)
	arg_61_0:updateLevelInfo(arg_61_0._equipMO.level)
end

function var_0_0.setBreakCostIconAndDispatchEvent(arg_62_0, arg_62_1)
	local var_62_0 = {}
	local var_62_1 = string.split(arg_62_1.cost, "|")

	for iter_62_0 = 1, #var_62_1 do
		local var_62_2 = string.splitToNumber(var_62_1[iter_62_0], "#")
		local var_62_3 = {
			type = tonumber(var_62_2[1]),
			id = tonumber(var_62_2[2]),
			quantity = tonumber(var_62_2[3])
		}

		table.insert(var_62_0, var_62_3)
	end

	EquipController.instance:dispatchEvent(EquipEvent.onShowBreakCostListModelContainer, var_62_1)

	return arg_62_0:enoughBreakConsume(var_62_0)
end

function var_0_0._refreshBreakCostIcon(arg_63_0)
	local var_63_0 = EquipConfig.instance:getNextBreakLevelCostCo(arg_63_0._equipMO)

	arg_63_0._enoughBreak = arg_63_0:setBreakCostIconAndDispatchEvent(var_63_0)

	ZProj.UGUIHelper.SetGrayscale(arg_63_0._btnbreak.gameObject, not arg_63_0._enoughBreak or not arg_63_0._enoughGold)
end

function var_0_0.refreshCost(arg_64_0)
	if arg_64_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowUpgrade then
		local var_64_0 = EquipChooseListModel.instance:calcStrengthen()
		local var_64_1 = EquipConfig.instance:getStrengthenToLvCost(arg_64_0._config.rare, arg_64_0._equipMO.level, arg_64_0._equipMO.exp, var_64_0)

		arg_64_0._enoughGold = arg_64_0:setCurrencyValue(var_64_1)
	elseif arg_64_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowBreak then
		local var_64_2 = EquipConfig.instance:getNextBreakLevelCostCo(arg_64_0._equipMO)

		if not var_64_2 or not var_64_2.cost then
			return
		end

		arg_64_0._enoughGold = arg_64_0:setCurrencyValue(var_64_2.scoreCost)
	end
end

function var_0_0.onClose(arg_65_0)
	EquipChooseListModel.instance:clearEquipList()
	EquipSelectedListModel.instance:clearList()

	arg_65_0._expList = nil

	EquipController.instance:dispatchEvent(EquipEvent.onCloseEquipStrengthenView)
	EquipBreakCostListModel.instance:clearList()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

	if arg_65_0.flow then
		arg_65_0.flow:destroy()
	end

	arg_65_0.flow = nil
	arg_65_0.breaking = false

	EquipChooseListModel.instance:setIsLock(arg_65_0.breaking)

	if arg_65_0.tweenId then
		ZProj.TweenHelper.KillById(arg_65_0.tweenId)
	end

	arg_65_0:playCloseAnimation()
end

function var_0_0.playCloseAnimation(arg_66_0)
	arg_66_0._viewAnim:Play(UIAnimationName.Close)
	arg_66_0:playOutsideNodeAnimation(UIAnimationName.Close)
	arg_66_0.viewContainer:playCurrencyViewAnimation("go_righttop_out")
end

function var_0_0.playOutsideNodeAnimation(arg_67_0, arg_67_1)
	if arg_67_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowUpgrade then
		arg_67_0.viewContainer.equipView.costEquipScrollAnim:Play(arg_67_1)
	elseif arg_67_0.showContainerStatus == var_0_0.ShowContainerStatusEnum.ShowBreak then
		arg_67_0.viewContainer.equipView.breakEquipScrollAnim:Play(arg_67_1)
	end
end

function var_0_0.onDestroyView(arg_68_0)
	EquipFilterModel.instance:clear(arg_68_0.viewName)
	TaskDispatcher.cancelTask(arg_68_0._hideGravingEffect, arg_68_0)
	TaskDispatcher.cancelTask(arg_68_0._hideImprove, arg_68_0)
	arg_68_0.dropFilter:RemoveOnValueChanged()
	arg_68_0.dropClick:RemoveClickListener()

	if arg_68_0._sequence then
		arg_68_0._sequence:destroy()
	end

	if arg_68_0.dropExtend then
		arg_68_0.dropExtend:dispose()
	end
end

return var_0_0
