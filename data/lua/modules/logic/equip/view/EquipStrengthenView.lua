module("modules.logic.equip.view.EquipStrengthenView", package.seeall)

slot0 = class("EquipStrengthenView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobeforewhite = gohelper.findChild(slot0.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_beforewhite")
	slot0._imagewhite = gohelper.findChildImage(slot0.viewGO, "layoutgroup/progress/bar/#go_barPos/#image_white")
	slot0._goafterwhite = gohelper.findChild(slot0.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_afterwhite")
	slot0._imagegreen1 = gohelper.findChildImage(slot0.viewGO, "layoutgroup/progress/bar/#go_barPos/#image_green1")
	slot0._gofullexp = gohelper.findChild(slot0.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_fullexp")
	slot0._txtaddexp = gohelper.findChildText(slot0.viewGO, "layoutgroup/progress/bar/#go_barPos/#txt_addexp")
	slot0._txtexp = gohelper.findChildText(slot0.viewGO, "layoutgroup/progress/bar/#go_barPos/#txt_exp")
	slot0._gomaxbreakbartip = gohelper.findChild(slot0.viewGO, "layoutgroup/progress/bar/#go_barPos/#go_maxbreakbartip")
	slot0._gobarPos = gohelper.findChild(slot0.viewGO, "layoutgroup/progress/bar/#go_barPos")
	slot0._txtcurlevel = gohelper.findChildText(slot0.viewGO, "layoutgroup/progress/#txt_curlevel")
	slot0._golevelupeffect = gohelper.findChild(slot0.viewGO, "layoutgroup/progress/#go_leveup")
	slot0._txttotallevel = gohelper.findChildText(slot0.viewGO, "layoutgroup/progress/#txt_curlevel/#txt_totallevel")
	slot0._goengravingEffect = gohelper.findChild(slot0.viewGO, "layoutgroup/progress/#engraving")
	slot0._gomaxbreaktip = gohelper.findChild(slot0.viewGO, "#go_maxbreaktip")
	slot0._golevelup = gohelper.findChild(slot0.viewGO, "layoutgroup/attribute/container/#go_levelup")
	slot0._gostrengthenattr = gohelper.findChild(slot0.viewGO, "layoutgroup/attribute/container/#go_strengthenattr")
	slot0._gobreakeffect = gohelper.findChild(slot0.viewGO, "layoutgroup/attribute/container/#go_breakeffect")
	slot0._gocost = gohelper.findChild(slot0.viewGO, "#go_cost")
	slot0._imagecurrency = gohelper.findChildImage(slot0.viewGO, "#go_cost/strengthen_cost/currency/#simage_currency")
	slot0._txtcurrency = gohelper.findChildText(slot0.viewGO, "#go_cost/strengthen_cost/currency/#txt_currency")
	slot0._gonocurrency = gohelper.findChild(slot0.viewGO, "#go_cost/strengthen_cost/currency/#go_nocurrency")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_cost/#go_btns")
	slot0._btnupgrade = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cost/#go_btns/start/#btn_upgrade")
	slot0._btnbreak = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cost/#go_btns/break/#btn_break")
	slot0._txtcostcount = gohelper.findChildText(slot0.viewGO, "#go_cost/title/#txt_costcount")
	slot0._gobreakcount = gohelper.findChild(slot0.viewGO, "#go_cost/title/#go_breakcount")
	slot0._goimprove = gohelper.findChild(slot0.viewGO, "#go_improve")
	slot0._btnfastadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cost/fast/#btn_fastadd")
	slot0._gosortbtns = gohelper.findChild(slot0.viewGO, "#go_improve/#go_sortbtns")
	slot0._btnlvrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_improve/#go_sortbtns/#btn_lvrank")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_improve/#go_sortbtns/#btn_rarerank")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_improve/#go_sortbtns/#btn_filter")
	slot0._btnback = gohelper.findChildButton(slot0.viewGO, "#go_improve/#btn_back")
	slot0._golackequip = gohelper.findChild(slot0.viewGO, "#go_improve/#go_lackequip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnupgrade:AddClickListener(slot0._btnupgradeOnClick, slot0)
	slot0._btnbreak:AddClickListener(slot0._btnbreakOnClick, slot0)
	slot0._btnfastadd:AddClickListener(slot0._btnfastaddOnClick, slot0)
	slot0._btnlvrank:AddClickListener(slot0._btnlvrankOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnupgrade:RemoveClickListener()
	slot0._btnbreak:RemoveClickListener()
	slot0._btnfastadd:RemoveClickListener()
	slot0._btnlvrank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnback:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
end

slot0.ShowContainerStatusEnum = {
	ShowBreak = 2,
	ShowUpgrade = 1,
	ShowMax = 3
}
slot0.LevelChangeAnimationTime = 0.5
slot0.Color = {
	NormalColor = Color.New(0.8509803921568627, 0.6274509803921569, 0.43529411764705883, 1),
	NextColor = Color.New(0.5137254901960784, 0.7372549019607844, 0.5176470588235295, 1)
}

function slot0._btnfilterOnClick(slot0)
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = slot0.viewName
	})
end

function slot0._btnlvrankOnClick(slot0)
	EquipChooseListModel.instance:sordByLevel()
	slot0:_refreshEquipBtnIcon()
end

function slot0._btnrarerankOnClick(slot0)
	EquipChooseListModel.instance:sordByQuality()
	slot0:_refreshEquipBtnIcon()
end

function slot0._refreshEquipBtnIcon(slot0)
	gohelper.setActive(slot0._equipLvBtns[1], EquipChooseListModel.instance:getBtnTag() ~= 1)
	gohelper.setActive(slot0._equipLvBtns[2], slot1 == 1)
	gohelper.setActive(slot0._equipQualityBtns[1], slot1 ~= 2)
	gohelper.setActive(slot0._equipQualityBtns[2], slot1 == 2)

	slot2, slot3 = EquipChooseListModel.instance:getRankState()

	transformhelper.setLocalScale(slot0._equipLvArrow[1], 1, slot2, 1)
	transformhelper.setLocalScale(slot0._equipLvArrow[2], 1, slot2, 1)
	transformhelper.setLocalScale(slot0._equipQualityArrow[1], 1, slot3, 1)
	transformhelper.setLocalScale(slot0._equipQualityArrow[2], 1, slot3, 1)
end

function slot0._btnbackOnClick(slot0)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, false)
end

function slot0._btnfastaddOnClick(slot0)
	if slot0.breaking then
		return
	end

	EquipChooseListModel.instance:fastAddEquip()
end

function slot0._btnupgradeOnClick(slot0)
	if not EquipChooseListModel.instance:getChooseEquipList() or #slot1 == 0 then
		if slot0._goimprove.activeSelf then
			GameFacade.showToast(ToastEnum.EquipStrengthenNoItem)
		end

		EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, true)

		return
	end

	if not slot0._enoughGold then
		GameFacade.showToast(ToastEnum.EquipStrengthenNoGold)

		return
	end

	slot3 = false

	for slot8, slot9 in ipairs(slot1) do
		table.insert({}, {
			slot9.uid,
			slot9._chooseNum
		})

		slot4 = false or EquipChooseListModel.instance:getHeroMoByEquipUid(slot9.uid)

		if slot9.config.isExpEquip == 0 and slot9.config.rare >= 4 then
			slot3 = true
		end
	end

	if (slot4 ~= nil or slot3) and (slot0._playerSaveTabs.saveTime == nil or slot0._playerSaveTabs.saveTime ~= os.date("*t", ServerTime.nowInLocal() - 18000).day) then
		EquipController.instance:openEquipStrengthenAlertView({
			callback = function (slot0)
				if slot0 then
					uv0._playerSaveTabs.saveTime = uv1.day
					uv0._playUserIdTabs[uv0._curPlayerInfoId] = uv0._playerSaveTabs

					PlayerPrefsHelper.setString(PlayerPrefsKey.EquipStrengthen, cjson.encode(uv0._playUserIdTabs))
				end

				EquipRpc.instance:sendEquipStrengthenRequest(uv0._equipMO.uid, uv2)
			end,
			content = slot4 == nil and luaLang("equip_lang_3") or luaLang("equip_lang_2")
		})
	else
		EquipRpc.instance:sendEquipStrengthenRequest(slot0._equipMO.uid, slot2)
	end
end

function slot0._hideGravingEffect(slot0)
	gohelper.setActive(slot0._goengravingEffect, false)
end

function slot0._btnbreakOnClick(slot0)
	if not slot0._enoughBreak then
		return
	end

	if not slot0._enoughGold then
		GameFacade.showToast(ToastEnum.EquipStrengthenNoGold)

		return
	end

	slot0.breaking = true

	EquipChooseListModel.instance:setIsLock(slot0.breaking)
	EquipRpc.instance:sendEquipBreakRequest(slot0._equipMO.uid)
end

function slot0._hideLevelUpEffect(slot0)
	gohelper.setActive(slot0._golevelupeffect, false)
end

function slot0._editableInitView(slot0)
	slot0.breakSuccessAnimationTime = slot0._golevelupeffect:GetComponent(typeof(UnityEngine.Animation)).clip.length
	slot0._animimprove = slot0._goimprove:GetComponent(typeof(UnityEngine.Animator))
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._strengthenattrs = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gostrengthenattr, false)

	slot0._whiteWidth = recthelper.getWidth(slot0._imagewhite.transform)
	slot0.imageBreakIcon = gohelper.findChildImage(slot0._gobreakeffect, "image_icon")
	slot0.txtBreakAttrName = gohelper.findChildText(slot0._gobreakeffect, "txt_name")
	slot0.txtBreakValue = gohelper.findChildText(slot0._gobreakeffect, "txt_value")
	slot0.txtBreakPreValue = gohelper.findChildText(slot0._gobreakeffect, "txt_prevalue")
	slot0.goBreakRightArrow = gohelper.findChild(slot0._gobreakeffect, "go_rightarrow")
	slot0.goNotFilter = gohelper.findChild(slot0.viewGO, "#go_improve/#go_sortbtns/#btn_filter/#go_notfilter")
	slot0.goFilter = gohelper.findChild(slot0.viewGO, "#go_improve/#go_sortbtns/#btn_filter/#go_filter")
	slot5 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Gold).icon .. "_1"

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecurrency, slot5)

	slot0._equipLvBtns = slot0:getUserDataTb_()
	slot0._equipLvArrow = slot0:getUserDataTb_()
	slot0._equipQualityBtns = slot0:getUserDataTb_()
	slot0._equipQualityArrow = slot0:getUserDataTb_()

	for slot5 = 1, 2 do
		slot0._equipLvBtns[slot5] = gohelper.findChild(slot0._btnlvrank.gameObject, "btn" .. tostring(slot5))
		slot0._equipLvArrow[slot5] = gohelper.findChild(slot0._equipLvBtns[slot5], "txt/arrow").transform
		slot0._equipQualityBtns[slot5] = gohelper.findChild(slot0._btnrarerank.gameObject, "btn" .. tostring(slot5))
		slot0._equipQualityArrow[slot5] = gohelper.findChild(slot0._equipQualityBtns[slot5], "txt/arrow").transform
	end

	gohelper.setActive(slot0._equipLvArrow[1].gameObject, false)
	gohelper.setActive(slot0._equipQualityArrow[1].gameObject, false)
	gohelper.addUIClickAudio(slot0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnbreak.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)
	gohelper.addUIClickAudio(slot0._btnupgrade.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)
	gohelper.addUIClickAudio(slot0._btnfastadd.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Addall)

	slot0._enoughBreak = false
	slot0.breaking = false

	EquipChooseListModel.instance:setIsLock(slot0.breaking)

	slot0.initDropDone = false

	slot0:initFilterDrop()

	slot0._goupgrade = gohelper.findChild(slot0._gobtns, "start")
	slot0._gobreak = gohelper.findChild(slot0._gobtns, "break")

	gohelper.setActive(slot0._goimprove, false)

	slot0.initDropDone = true
	slot0.showContainerStatus = uv0.ShowContainerStatusEnum.ShowUpgrade

	slot0:setBtnBackWidth()
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.setBtnBackWidth, slot0)
end

function slot0.setBtnBackWidth(slot0)
	recthelper.setWidth(slot0._btnback.gameObject.transform, 0.45 * recthelper.getWidth(slot0._goimprove.transform))
end

function slot0.onDropHide(slot0)
	transformhelper.setLocalScale(slot0.trDropArrow, 1, 1, 1)
end

function slot0.onDropShow(slot0)
	transformhelper.setLocalScale(slot0.trDropArrow, 1, -1, 1)
end

function slot0.initFilterDrop(slot0)
	slot0.dropFilter = gohelper.findChildDropdown(slot0._gocost, "#drop_filter")
	slot0.trDropArrow = gohelper.findChildComponent(slot0.dropFilter.gameObject, "Arrow", typeof(UnityEngine.Transform))
	slot0.dropClick = gohelper.getClick(slot0.dropFilter.gameObject)
	slot0.dropExtend = DropDownExtend.Get(slot0.dropFilter.gameObject)
	slot4 = slot0.onDropHide

	slot0.dropExtend:init(slot0.onDropShow, slot4, slot0)

	slot0.filterRareLevelList = {}

	for slot4 = 2, EquipConfig.instance:getMaxFilterRare() do
		table.insert(slot0.filterRareLevelList, slot4)
	end

	slot1 = {}

	for slot5, slot6 in ipairs(slot0.filterRareLevelList) do
		if slot6 == 0 then
			table.insert(slot1, luaLang("equip_filter_all"))
		else
			table.insert(slot1, string.format(luaLang("equip_filter_str"), slot6))
		end
	end

	slot0.dropFilter:ClearOptions()
	slot0.dropFilter:AddOptions(slot1)
	slot0.dropFilter:AddOnValueChanged(slot0.onDropValueChanged, slot0)
	slot0.dropClick:AddClickListener(function ()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, slot0)

	for slot6, slot7 in ipairs(slot0.filterRareLevelList) do
		if slot7 == EquipChooseListModel.instance:getFilterRare() then
			slot0.dropFilter:SetValue(slot6 - 1)

			break
		end
	end
end

function slot0.onDropValueChanged(slot0, slot1)
	if not slot0.initDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	EquipChooseListModel.instance:setFilterRare(slot0.filterRareLevelList[slot1 + 1])
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.filterMo = EquipFilterModel.instance:generateFilterMo(slot0.viewName)
	slot0._equipMO = slot0.viewContainer.viewParam.equipMO
	slot0._config = slot0._equipMO.config
	slot0._equipMaxLv = EquipConfig.instance:getMaxLevel(slot0._config)

	slot0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, slot0._onEquipStrengthenReply, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onChooseChange, slot0._onChooseChange, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, slot0._onUpdateEquip, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0._onUpdateEquip, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onStrengthenFast, slot0._btnfastaddOnClick, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onStrengthenUpgrade, slot0._btnupgradeOnClick, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, slot0._onBreakSuccess, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onEquipLockChange, slot0._onEquipLockChange, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshBreakCostIcon, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCost, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, slot0.onEquipTypeHasChange, slot0)
	EquipChooseListModel.instance:initEquipMo(slot0._equipMO, false)
	EquipChooseListModel.instance:initEquipList(slot0.filterCareer)

	slot0._playUserIdTabs = slot0:getUserDataTb_()
	slot0._playerSaveTabs = slot0:getUserDataTb_()

	if not string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.EquipStrengthen, "")) then
		slot0._playUserIdTabs = cjson.decode(slot1)
	end

	slot0._curPlayerInfoId = PlayerModel.instance:getPlayinfo().userId

	if slot0._playUserIdTabs[slot0._curPlayerInfoId] == nil then
		slot0._playerSaveTabs.saveTime = nil
		slot0._playUserIdTabs[slot0._curPlayerInfoId] = slot0._playerSaveTabs
	else
		slot0._playerSaveTabs = slot0._playUserIdTabs[slot0._curPlayerInfoId]
	end

	slot0:showContainer()
	slot0:updateLevelInfo(slot0._equipMO.level)

	if slot0.viewContainer:getIsOpenLeftBackpack() then
		slot0.viewContainer.equipView:hideRefineScrollAndShowStrengthenScroll()
	else
		gohelper.setActive(slot0._goimprove, false)
	end

	slot0._viewAnim:Play(UIAnimationName.Open)
	slot0:playOutsideNodeAnimation(UIAnimationName.Open)
	slot0.viewContainer:playCurrencyViewAnimation("go_righttop_ina")
end

function slot0.showContainer(slot0)
	if slot0._equipMO.level == slot0._equipMaxLv then
		slot0.showContainerStatus = uv0.ShowContainerStatusEnum.ShowMax

		slot0:hideUpgradeAndBreakContainer()

		return
	end

	if slot0._equipMO.level == EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0._equipMO) then
		slot0.showContainerStatus = uv0.ShowContainerStatusEnum.ShowBreak

		slot0:showBreakContainer()

		return
	end

	slot0.showContainerStatus = uv0.ShowContainerStatusEnum.ShowUpgrade

	slot0:showUpgradeContainer()
end

function slot0.showScrollContainer(slot0)
	slot0.isShow = true

	EquipChooseListModel.instance:setEquipList()
	slot0:refreshEquipChooseEmptyContainer()
	slot0:_refreshEquipBtnIcon()
	gohelper.setActive(slot0._goimprove, true)
	slot0._animimprove:Play("go_improve_in")
end

function slot0.hideScrollContainer(slot0)
	slot0.isShow = false

	slot0._animimprove:Play("go_improve_out")
	TaskDispatcher.runDelay(slot0._hideImprove, slot0, EquipEnum.AnimationDurationTime)
end

function slot0.refreshEquipChooseEmptyContainer(slot0)
	gohelper.setActive(slot0._golackequip, EquipChooseListModel.instance:getCount() == 0)
end

function slot0._hideImprove(slot0)
	gohelper.setActive(slot0._goimprove, false)
end

function slot0.onEquipTypeHasChange(slot0, slot1)
	if slot1 ~= slot0.viewName then
		return
	end

	slot0.viewContainer.equipView:setStrengthenScrollVerticalNormalizedPosition(1)
	EquipChooseListModel.instance:initEquipList(slot0.filterMo, true)
	EquipChooseListModel.instance:setEquipList()
	slot0:refreshFilterBtn()
end

function slot0.refreshFilterBtn(slot0)
	slot1 = slot0.filterMo:isFiltering()

	gohelper.setActive(slot0.goNotFilter, not slot1)
	gohelper.setActive(slot0.goFilter, slot1)
end

function slot0._onUpdateEquip(slot0)
	if slot0.tabContainer._curTabId ~= EquipCategoryListModel.ViewIndex.EquipStrengthenViewIndex then
		return
	end

	EquipChooseListModel.instance:initEquipList(slot0.career, true)
	EquipChooseListModel.instance:setEquipList()
	slot0:refreshEquipChooseEmptyContainer()
end

function slot0._updateCostItemList(slot0)
	if EquipChooseListModel.instance:calcStrengthen() > 0 then
		slot0._txtaddexp.text = "EXP+" .. slot1
	else
		slot0._txtaddexp.text = ""
	end

	slot0:showStrengthenEffect(slot1)
end

function slot0._onChooseChange(slot0)
	slot0._txtcostcount.text = string.format("%s<color=#E8E5DF>(%s/%s)</color>", luaLang("p_equip_8"), EquipChooseListModel.instance:getChooseEquipsNum(), EquipEnum.StrengthenMaxCount)

	slot0:_updateCostItemList()
end

function slot0.playExpAnimationEffect(slot0)
	TaskDispatcher.cancelTask(slot0._hideGravingEffect, slot0)
	gohelper.setActive(slot0._goengravingEffect, true)
	TaskDispatcher.runDelay(slot0._hideGravingEffect, slot0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_engrave)
end

function slot0.playExpBreakAnimationEffect(slot0)
	gohelper.setActive(slot0._golevelupeffect, true)
end

function slot0._onEquipStrengthenReply(slot0)
	slot0.isUpgradeReply = true

	EquipChooseListModel.instance:initEquipList(slot0.career, false)
	EquipChooseListModel.instance:setEquipList()
	slot0:refreshEquipChooseEmptyContainer()
	EquipChooseListModel.instance:resetSelectedEquip()
	slot0:playExpAnimationEffect()

	slot0._expList = nil

	slot0:showContainer()

	slot0.isUpgradeReply = false
end

function slot0.showStrengthenEffect(slot0, slot1)
	if slot0._equipMaxLv == slot0._equipMO.level then
		return
	end

	slot3 = slot0._equipMO.level

	recthelper.setWidth(slot0._imagegreen1.transform, 0)

	slot4 = false

	if (slot1 or 0) > 0 then
		slot4 = EquipConfig.instance:getStrengthenToLv(slot0._config.rare, slot0._equipMO.level, slot0._equipMO.exp + slot1) ~= slot0._equipMO.level
		slot0._enoughGold = slot0:setCurrencyValue(EquipConfig.instance:getStrengthenToLvCost(slot0._config.rare, slot0._equipMO.level, slot0._equipMO.exp, slot1))

		slot0:showExpAnimation(slot1, EquipConfig.instance:getEquipStrengthenCostCo(slot0._config.rare, slot0._equipMO.level + 1))
	else
		slot0._enoughGold = slot0:setCurrencyValue(0)
		slot0._txtcurrency.text = ""

		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcurrency, "#E8E5DF")

		if slot0._expList then
			slot0:showExpAnimation(slot1, slot2)

			slot0._expList = nil
		end
	end

	ZProj.UGUIHelper.SetGrayscale(slot0._btnupgrade.gameObject, slot1 <= 0)

	slot5, slot6 = EquipConfig.instance:getStrengthenToLvExpInfo(slot0._config.rare, slot0._equipMO.level, slot0._equipMO.exp, slot1)

	recthelper.setWidth(slot0._imagewhite.transform, slot0._whiteWidth * math.min(slot0._equipMO.exp / slot2.exp, 1))

	slot0._txtexp.text = string.format("%s/%s", slot5, slot6)

	slot0:setAttribute(slot1, slot4, slot2, slot3)
end

function slot0.setAttribute(slot0, slot1, slot2, slot3, slot4)
	slot0._upgrade = slot2
	slot0._addexp = slot1
	slot0._attrIndex = 1

	if slot2 then
		slot5, slot6, slot7, slot8 = EquipConfig.instance:getEquipAddBaseAttr(slot0._equipMO)
		slot9, slot10, slot11, slot12 = EquipConfig.instance:getEquipAddBaseAttr(slot0._equipMO, slot4)

		slot0:showAttr(CharacterEnum.AttrId.Attack, 0, slot10, slot6, slot3)
		slot0:showAttr(CharacterEnum.AttrId.Hp, 0, slot9, slot5, slot3)
		slot0:showAttr(CharacterEnum.AttrId.Defense, 0, slot11, slot7, slot3)
		slot0:showAttr(CharacterEnum.AttrId.Mdefense, 0, slot12, slot8, slot3)
	else
		slot5, slot6, slot7, slot8 = EquipConfig.instance:getEquipAddBaseAttr(slot0._equipMO)

		slot0:showAttr(CharacterEnum.AttrId.Attack, 0, slot6)
		slot0:showAttr(CharacterEnum.AttrId.Hp, 0, slot5)
		slot0:showAttr(CharacterEnum.AttrId.Defense, 0, slot7)
		slot0:showAttr(CharacterEnum.AttrId.Mdefense, 0, slot8)
	end

	for slot8 = slot0._attrIndex, #slot0._strengthenattrs do
		gohelper.setActive(slot0._strengthenattrs[slot8].go, false)
	end

	slot5, slot6 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(slot0._config, slot0._equipMO.breakLv)

	if slot5 then
		gohelper.setActive(slot0._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(slot0.imageBreakIcon, "icon_att_" .. slot5)

		slot0.txtBreakAttrName.text = EquipHelper.getAttrBreakText(slot5)

		gohelper.setAsLastSibling(slot0._gobreakeffect)

		if slot0.showContainerStatus == uv0.ShowContainerStatusEnum.ShowBreak then
			slot7, slot8 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(slot0._config, slot0._equipMO.breakLv + 1)
			slot0.txtBreakPreValue.text = EquipHelper.getAttrPercentValueStr(slot6)
			slot0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(slot8)
			slot0.txtBreakValue.color = uv0.Color.NextColor

			gohelper.setActive(slot0.goBreakRightArrow, true)
			gohelper.setActive(slot0.txtBreakPreValue, true)
		else
			slot0.txtBreakValue.color = uv0.Color.NormalColor

			gohelper.setActive(slot0.goBreakRightArrow, false)
			gohelper.setActive(slot0.txtBreakPreValue, false)

			slot0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(slot6)
		end
	else
		gohelper.setActive(slot0._gobreakeffect, false)
	end
end

function slot0.showBreakLv(slot0, slot1, slot2)
	for slot8 = 1, slot1.transform.childCount do
		UISpriteSetMgr.instance:setEquipSprite(gohelper.onceAddComponent(slot3:GetChild(slot8 - 1).gameObject, gohelper.Type_Image), slot8 <= slot2 and "xx_11" or "xx_10")
	end
end

function slot0.calcTotalExp(slot0, slot1)
	if not slot1 then
		return 0, 0
	end

	return slot1[1], slot1[2]
end

function slot0.showExpAnimation(slot0, slot1, slot2)
	if slot0.isUpgradeReply then
		return
	end

	slot4 = nil
	slot0._expList, slot4 = EquipConfig.instance:getStrengthenToLvCostExp(slot0._config.rare, slot0._equipMO.level, slot0._equipMO.exp, slot1, slot0._equipMO.breakLv)
	slot5, slot6 = slot0:calcTotalExp(slot0._expList)
	slot7, slot8 = slot0:calcTotalExp(slot0._expList)

	if slot0._sequence then
		slot0._sequence:destroy()
	end

	slot9 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0._equipMO)

	slot0:setExpProgressStatus(false)

	slot0.tweenWork = TweenWork.New({
		type = "DOTweenFloat",
		from = slot6,
		to = slot8,
		t = slot0._skipExpAnimation and 0 or 0.2,
		frameCb = function (slot0)
			slot1 = uv0 + slot0
			slot2 = Mathf.Floor(slot1)
			slot3 = slot1 - slot2

			if uv3 <= uv2 and uv4 <= uv1._equipMO.level + slot2 or uv2 <= uv3 and uv4 <= uv1._equipMO.level + uv2 + uv0 then
				if uv1.tweenWork then
					uv1.tweenWork:clearWork()
					uv1:setExpProgressStatus(true)
					uv1:updateLevelInfo(uv4)
					uv1:setMaxLevelTxtExp(true)
				end

				return
			end

			if slot2 > 0 then
				recthelper.setWidth(uv1._imagewhite.transform, 0)
				uv1._imagegreen1.transform:SetParent(uv1._goafterwhite.transform)
			else
				if uv5 then
					recthelper.setWidth(uv1._imagewhite.transform, uv1._whiteWidth * math.min(uv1._equipMO.exp / uv5.exp, 1))
				end

				uv1._imagegreen1.transform:SetParent(uv1._gobeforewhite.transform)
			end

			recthelper.setWidth(uv1._imagegreen1.transform, slot3 * uv1._whiteWidth)
			uv1:updateLevelInfo(slot4)
		end,
		ease = EaseType.Linear
	})
	slot0._sequence = FlowSequence.New()

	slot0._sequence:addWork(slot0.tweenWork)
	slot0._sequence:registerDoneListener(function ()
		if uv0 then
			uv1:setExpProgressStatus(true)
			uv1:updateLevelInfo(uv2)
			uv1:setMaxLevelTxtExp(true)
		end
	end)
	slot0._sequence:start()
end

function slot0.updateLevelInfo(slot0, slot1)
	slot2 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0._equipMO)
	slot0._txttotallevel.text = string.format("<color=#E8E5DF>/%s</color>", slot2)
	slot0._txtcurlevel.text = math.min(slot1, slot2)
end

function slot0.showAttr(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot3 <= -1 then
		return
	end

	slot6 = slot4 and slot4 < slot3
	slot7 = HeroConfig.instance:getHeroAttributeCO(slot1)

	if not slot0._strengthenattrs[slot0._attrIndex] then
		slot9 = slot0:getUserDataTb_()
		slot9.go = gohelper.cloneInPlace(slot0._gostrengthenattr, "item" .. slot8)
		slot9.txtvalue = gohelper.findChildText(slot9.go, "layout/txt_value")
		slot9.txtname = gohelper.findChildText(slot9.go, "layout/txt_name")
		slot9.imageicon = gohelper.findChildImage(slot9.go, "image_icon")
		slot9.txtprevvalue = gohelper.findChildText(slot9.go, "layout/txt_prevvalue")
		slot9.gorightarrow = gohelper.findChild(slot9.go, "layout/go_rightarrow")
		slot9.bg = gohelper.findChild(slot9.go, "layout/go_bg")

		table.insert(slot0._strengthenattrs, slot9)
	end

	gohelper.setActive(slot9.bg, slot8 % 2 == 0)
	CharacterController.instance:SetAttriIcon(slot9.imageicon, slot1, GameUtil.parseColor("#736E6A"))

	slot9.txtvalue.text = slot0._upgrade and EquipConfig.instance:dirGetEquipValueStr(slot2, slot3) or "+0"

	if slot0._upgrade and slot0._addexp > 0 then
		SLFramework.UGUI.GuiHelper.SetColor(slot9.txtvalue, "#83BC84")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot9.txtvalue, "#CAC8C5")
	end

	slot9.txtname.text = slot7.name
	slot9.txtprevvalue.text = slot6 and EquipConfig.instance:dirGetEquipValueStr(slot2, slot4) or EquipConfig.instance:dirGetEquipValueStr(slot2, slot3)

	gohelper.setActive(slot9.gorightarrow, true)
	gohelper.setActive(slot9.go, true)

	slot0._attrIndex = slot0._attrIndex + 1

	if not slot5 then
		slot9.txtvalue.text = slot9.txtprevvalue.text

		gohelper.setActive(slot9.txtprevvalue.gameObject, false)
		gohelper.setActive(slot9.gorightarrow, false)
	else
		gohelper.setActive(slot9.txtprevvalue.gameObject, true)
		gohelper.setActive(slot9.gorightarrow, true)
	end
end

function slot0.showUpgradeContainer(slot0)
	EquipSelectedListModel.instance:initList()
	slot0:_onChooseChange()
	EquipController.instance:dispatchEvent(EquipEvent.onShowStrengthenListModelContainer)
	gohelper.setActive(slot0._gocost, true)
	gohelper.setActive(slot0._gostart, true)
	gohelper.setActive(slot0._gobreak, false)
	slot0._gomaxbreaktip:SetActive(false)
	slot0._gomaxbreakbartip:SetActive(false)
	gohelper.setActive(slot0._golevelup, false)
	gohelper.setActive(slot0._gobreakcount, false)
	gohelper.setActive(slot0._txtcostcount.gameObject, true)
	gohelper.setActive(slot0._goupgrade, true)
	gohelper.setActive(slot0._gobreak, false)
	slot0:setExpProgressStatus(false)
	slot0:refreshFilterBtn()
end

function slot0.showBreakContainer(slot0)
	if not EquipConfig.instance:getNextBreakLevelCostCo(slot0._equipMO) or not slot1.cost then
		return
	end

	slot0._enoughBreak = slot0:setBreakCostIconAndDispatchEvent(slot1)
	slot0._enoughGold = slot0:setCurrencyValue(slot1.scoreCost)

	slot0:setAttribute(0, false)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnbreak.gameObject, not slot0._enoughBreak or not slot0._enoughGold)
	gohelper.setActive(slot0._gocost, true)
	gohelper.setActive(slot0._gostart, false)
	gohelper.setActive(slot0._gobreak, true)
	slot0._gomaxbreaktip:SetActive(false)
	slot0._gomaxbreakbartip:SetActive(false)
	gohelper.setActive(slot0._golevelup, true)
	gohelper.setActive(slot0._gobreakcount, true)
	gohelper.setActive(slot0._txtcostcount.gameObject, false)
	gohelper.setActive(slot0._goupgrade, false)
	gohelper.setActive(slot0._gobreak, true)
	slot0:setExpProgressStatus(true)
	slot0:setMaxLevelTxtExp()

	gohelper.findChildText(slot0._golevelup, "layout/txt_prevvalue").text = string.format("%s/%s", slot0._equipMO.level, EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0._equipMO))
	gohelper.findChildText(slot0._golevelup, "layout/txt_value").text = string.format("%s/%s", slot0._equipMO.level, EquipConfig.instance:getNextBreakLevelMaxLevel(slot0._equipMO))
end

function slot0.hideUpgradeAndBreakContainer(slot0)
	EquipController.instance:dispatchEvent(EquipEvent.onHideBreakAndStrengthenListModelContainer)
	slot0:setAttribute(0, false)
	slot0:setMaxLevelTxtExp()

	slot0._txttotallevel.text = ""
	slot0._txtcurlevel.text = slot0._equipMO.level

	recthelper.setWidth(slot0._imagewhite.transform, slot0._whiteWidth)
	slot0._gomaxbreaktip:SetActive(true)
	slot0:hideStrengthenScroll()
	slot0._gomaxbreakbartip:SetActive(false)
	slot0._gocost:SetActive(false)
	slot0:setExpProgressStatus(true)
end

function slot0.setMaxLevelTxtExp(slot0, slot1)
	slot3 = EquipConfig.instance:getEquipStrengthenCostCo(slot0._config.rare, EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0._equipMO)).exp
	slot0._txtexp.text = string.format("%s/%s", tostring(slot3), tostring(slot3))

	if not slot1 then
		slot0._txtaddexp.text = ""
	end
end

function slot0.setCurrencyValue(slot0, slot1)
	slot2 = false

	if slot1 <= CurrencyModel.instance:getGold() then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcurrency, "#E8E5DF")

		slot2 = true
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcurrency, "#CC4E4E")

		slot2 = false
	end

	slot0._txtcurrency.text = slot1 ~= 0 and slot1 or ""

	gohelper.setActive(slot0._gonocurrency, slot1 <= 0)

	return slot2
end

function slot0.enoughBreakConsume(slot0, slot1)
	for slot5 = 1, #slot1 do
		if ItemModel.instance:getItemQuantity(slot1[slot5].type, slot1[slot5].id) < slot1[slot5].quantity then
			return false
		end
	end

	return true
end

function slot0.setExpProgressStatus(slot0, slot1)
	gohelper.setActive(slot0._gofullexp, slot1)
	gohelper.setActive(slot0._goafterwhite, not slot1)
	gohelper.setActive(slot0._imagewhite.gameObject, not slot1)
end

function slot0._onBreakSuccess(slot0)
	slot0:showContainer()

	if slot0.flow then
		slot0.flow:destroy()
	end

	slot0.flow = FlowSequence.New()

	if slot0.viewContainer:isOpenLeftStrengthenScroll() then
		slot0.flow:addWork(DelayFuncWork.New(slot0.hideStrengthenScroll, slot0, EquipEnum.AnimationDurationTime))
	end

	slot0.flow:addWork(DelayFuncWork.New(function ()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_breach)
	end, slot0, 0.3))
	slot0.flow:addWork(DelayFuncWork.New(slot0.playExpBreakAnimationEffect, slot0, slot0.breakSuccessAnimationTime))
	slot0.flow:addWork(DelayFuncWork.New(slot0._hideLevelUpEffect, slot0, 0))
	slot0.flow:addWork(DelayFuncWork.New(slot0.levelChangeAnimation, slot0, uv0.LevelChangeAnimationTime))
	slot0.flow:addWork(DelayFuncWork.New(slot0.refreshLevelInfo, slot0, 0))
	slot0.flow:registerDoneListener(slot0.onBreakAnimationDone, slot0)
	slot0.flow:start()
end

function slot0.onBreakAnimationDone(slot0)
	slot0.breaking = false

	EquipChooseListModel.instance:setIsLock(slot0.breaking)
end

function slot0._onEquipLockChange(slot0, slot1)
	if slot1.isLock then
		EquipChooseListModel.instance:deselectEquip(EquipModel.instance:getEquip(slot1.uid))
	end
end

function slot0.hideStrengthenScroll(slot0)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, false)
end

function slot0.levelChangeAnimation(slot0)
	slot1 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0._equipMO)
	slot2 = EquipConfig.instance:_getBreakLevelMaxLevel(slot0._equipMO.config.rare, slot0._equipMO.breakLv - 1)

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot2, slot1, uv0.LevelChangeAnimationTime, slot0.setMaxLevel, slot0.tweenDone, slot0, nil, EaseType.Linear)
end

function slot0.setMaxLevel(slot0, slot1)
	slot0._txttotallevel.text = "/" .. slot1
end

function slot0.tweenDone(slot0)
	slot0.tweenId = nil
end

function slot0.refreshLevelInfo(slot0)
	slot0:updateLevelInfo(slot0._equipMO.level)
end

function slot0.setBreakCostIconAndDispatchEvent(slot0, slot1)
	slot2 = {}

	for slot7 = 1, #string.split(slot1.cost, "|") do
		slot8 = string.splitToNumber(slot3[slot7], "#")

		table.insert(slot2, {
			type = tonumber(slot8[1]),
			id = tonumber(slot8[2]),
			quantity = tonumber(slot8[3])
		})
	end

	EquipController.instance:dispatchEvent(EquipEvent.onShowBreakCostListModelContainer, slot3)

	return slot0:enoughBreakConsume(slot2)
end

function slot0._refreshBreakCostIcon(slot0)
	slot0._enoughBreak = slot0:setBreakCostIconAndDispatchEvent(EquipConfig.instance:getNextBreakLevelCostCo(slot0._equipMO))

	ZProj.UGUIHelper.SetGrayscale(slot0._btnbreak.gameObject, not slot0._enoughBreak or not slot0._enoughGold)
end

function slot0.refreshCost(slot0)
	if slot0.showContainerStatus == uv0.ShowContainerStatusEnum.ShowUpgrade then
		slot0._enoughGold = slot0:setCurrencyValue(EquipConfig.instance:getStrengthenToLvCost(slot0._config.rare, slot0._equipMO.level, slot0._equipMO.exp, EquipChooseListModel.instance:calcStrengthen()))
	elseif slot0.showContainerStatus == uv0.ShowContainerStatusEnum.ShowBreak then
		if not EquipConfig.instance:getNextBreakLevelCostCo(slot0._equipMO) or not slot1.cost then
			return
		end

		slot0._enoughGold = slot0:setCurrencyValue(slot1.scoreCost)
	end
end

function slot0.onClose(slot0)
	EquipChooseListModel.instance:clearEquipList()
	EquipSelectedListModel.instance:clearList()

	slot0._expList = nil

	EquipController.instance:dispatchEvent(EquipEvent.onCloseEquipStrengthenView)
	EquipBreakCostListModel.instance:clearList()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

	if slot0.flow then
		slot0.flow:destroy()
	end

	slot0.flow = nil
	slot0.breaking = false

	EquipChooseListModel.instance:setIsLock(slot0.breaking)

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end

	slot0:playCloseAnimation()
end

function slot0.playCloseAnimation(slot0)
	slot0._viewAnim:Play(UIAnimationName.Close)
	slot0:playOutsideNodeAnimation(UIAnimationName.Close)
	slot0.viewContainer:playCurrencyViewAnimation("go_righttop_out")
end

function slot0.playOutsideNodeAnimation(slot0, slot1)
	if slot0.showContainerStatus == uv0.ShowContainerStatusEnum.ShowUpgrade then
		slot0.viewContainer.equipView.costEquipScrollAnim:Play(slot1)
	elseif slot0.showContainerStatus == uv0.ShowContainerStatusEnum.ShowBreak then
		slot0.viewContainer.equipView.breakEquipScrollAnim:Play(slot1)
	end
end

function slot0.onDestroyView(slot0)
	EquipFilterModel.instance:clear(slot0.viewName)
	TaskDispatcher.cancelTask(slot0._hideGravingEffect, slot0)
	TaskDispatcher.cancelTask(slot0._hideImprove, slot0)
	slot0.dropFilter:RemoveOnValueChanged()
	slot0.dropClick:RemoveClickListener()

	if slot0._sequence then
		slot0._sequence:destroy()
	end

	if slot0.dropExtend then
		slot0.dropExtend:dispose()
	end
end

return slot0
