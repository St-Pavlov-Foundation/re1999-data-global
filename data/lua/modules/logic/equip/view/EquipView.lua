module("modules.logic.equip.view.EquipView", package.seeall)

local var_0_0 = class("EquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_category")
	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "#go_center")
	arg_1_0._gocentereffect = gohelper.findChild(arg_1_0.viewGO, "#go_center/effect")
	arg_1_0._simageequip = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_center/#simage_equip")
	arg_1_0._gostarList = gohelper.findChild(arg_1_0.viewGO, "#go_center/#go_starList")
	arg_1_0._scrollcostequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_costequip")
	arg_1_0._scrollbreakequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_breakquip")
	arg_1_0._gobreakequipcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_breakquip/Viewport/Content")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._scrollequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_equip")
	arg_1_0._scrollrefineequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_refine_equip")
	arg_1_0._scrollcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_refine_equip/viewport/scrollcontent")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#go_title/rare/#rare")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#txt_name/#txt_nameen")
	arg_1_0._animscrollequip = arg_1_0._scrollequip:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animscrollrefineequip = arg_1_0._scrollrefineequip:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animcenter = arg_1_0._gocenter:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animtitle = arg_1_0._gotitle:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goscrollArea = gohelper.findChild(arg_1_0.viewGO, "#go_scrollArea")
	arg_1_0._equipSlide = SLFramework.UGUI.UIDragListener.Get(arg_1_0._goscrollArea)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._equipSlide:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._equipSlide:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._equipSlide:RemoveDragBeginListener()
	arg_3_0._equipSlide:RemoveDragEndListener()
end

var_0_0.DragAbsPositionX = 30

function var_0_0.initRightRopStatus(arg_4_0)
	arg_4_0._animgorighttop = arg_4_0._gorighttop:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_4_0._gorighttop, true)
	arg_4_0._animgorighttop:Play("go_righttop_out", 0, 1)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getEquipBg("full/bg_equipbg.png"))

	arg_5_0._rareLineColor = {
		"#DCF5D5",
		"#9EB7D7",
		"#7D5B7E",
		"#D2D79E",
		"#D6A181"
	}
	arg_5_0._starList = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, 6 do
		local var_5_0 = gohelper.findChild(arg_5_0._gostarList, "star" .. iter_5_0)

		table.insert(arg_5_0._starList, var_5_0)
	end

	arg_5_0._breakCostItems = arg_5_0:getUserDataTb_()

	gohelper.setActive(arg_5_0._scrollequip.gameObject, false)
	gohelper.setActive(arg_5_0._gocentereffect, false)

	arg_5_0._viewAnim = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0.costEquipScrollAnim = arg_5_0._scrollcostequip:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0.breakEquipScrollAnim = arg_5_0._scrollbreakequip:GetComponent(typeof(UnityEngine.Animator))

	arg_5_0:initRightRopStatus()
end

function var_0_0._onDragBegin(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.viewContainer:getIsOpenLeftBackpack() then
		return
	end

	arg_6_0.startDragPosX = arg_6_2.position.x
end

function var_0_0._onDragEnd(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.viewContainer:getIsOpenLeftBackpack() then
		return
	end

	local var_7_0 = arg_7_2.position.x

	if math.abs(var_7_0 - arg_7_0.startDragPosX) > var_0_0.DragAbsPositionX then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)
		arg_7_0:_onSlide(var_7_0 < arg_7_0.startDragPosX)
	end
end

function var_0_0._onSlide(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:_getCurEquipIndex()

	if arg_8_1 then
		var_8_0 = var_8_0 + 1 > GameUtil.getTabLen(arg_8_0._allEquipList) and 1 or var_8_0 + 1
	else
		var_8_0 = var_8_0 - 1 <= 0 and GameUtil.getTabLen(arg_8_0._allEquipList) or var_8_0 - 1
	end

	local var_8_1 = arg_8_0._allEquipList[var_8_0]

	if var_8_1 ~= arg_8_0._equipMO then
		local var_8_2 = EquipHelper.isNormalEquip(arg_8_0._config)
		local var_8_3 = EquipHelper.isNormalEquip(var_8_1.config)

		if var_8_2 ~= var_8_3 then
			if var_8_2 and EquipCategoryListModel.instance.curCategoryIndex ~= 4 then
				EquipCategoryListModel.instance.curCategoryIndex = 1
			end

			if var_8_3 and EquipCategoryListModel.instance.curCategoryIndex == 2 then
				EquipCategoryListModel.instance.curCategoryIndex = 4
			end
		end
	end

	arg_8_0._equipMO = arg_8_0._allEquipList[var_8_0]
	arg_8_0._equipId = arg_8_0._equipMO and arg_8_0._equipMO.config.id or arg_8_0._equipMO.equipId
	arg_8_0._config = arg_8_0._equipMO and arg_8_0._equipMO.config or EquipConfig.instance:getEquipCo(arg_8_0._equipId)

	arg_8_0:destroyFlow()

	arg_8_0.flow = FlowSequence.New()

	arg_8_0.flow:addWork(DelayFuncWork.New(arg_8_0.playTableViewCloseAnimation, arg_8_0, EquipEnum.AnimationDurationTime))
	arg_8_0.flow:addWork(DelayFuncWork.New(arg_8_0._reSelectEquip, arg_8_0))
	arg_8_0.flow:registerDoneListener(arg_8_0.endAnimBlock, arg_8_0)
	arg_8_0:startAnimBlock()
	arg_8_0.flow:start()
end

function var_0_0._reSelectEquip(arg_9_0)
	local var_9_0 = {
		equipMO = arg_9_0._equipMO,
		defaultTabIds = {
			[2] = EquipCategoryListModel.instance.curCategoryIndex
		}
	}

	EquipController.instance:openEquipView(var_9_0)
end

function var_0_0.startAnimBlock(arg_10_0)
	UIBlockMgr.instance:startBlock("EquipAnimBlock")
end

function var_0_0.endAnimBlock(arg_11_0)
	UIBlockMgr.instance:endBlock("EquipAnimBlock")
end

function var_0_0.destroyFlow(arg_12_0)
	if arg_12_0.flow then
		arg_12_0.flow:destroy()

		arg_12_0.flow = nil
	end

	arg_12_0:endAnimBlock()
end

function var_0_0._getCurEquipIndex(arg_13_0)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._allEquipList) do
		if iter_13_1.uid == arg_13_0._equipMO.uid then
			var_13_0 = iter_13_0
		end
	end

	return var_13_0
end

function var_0_0.playTableViewCloseAnimation(arg_14_0)
	arg_14_0.viewContainer.tableView:playCloseAnimation()
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0._equipMO = arg_15_0.viewParam.equipMO
	arg_15_0._equipId = arg_15_0._equipMO and arg_15_0._equipMO.config.id or arg_15_0.viewParam.equipId
	arg_15_0._config = arg_15_0._equipMO and arg_15_0._equipMO.config or EquipConfig.instance:getEquipCo(arg_15_0._equipId)

	arg_15_0:_refreshUI()
end

function var_0_0.showStar(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._starList) do
		gohelper.setActive(arg_16_0._starList[iter_16_0], iter_16_0 <= arg_16_0._config.rare + 1)
	end
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0._equipMO = arg_17_0.viewParam.equipMO
	arg_17_0._equipId = arg_17_0._equipMO and arg_17_0._equipMO.config.id or arg_17_0.viewParam.equipId
	arg_17_0._config = arg_17_0._equipMO and arg_17_0._equipMO.config or EquipConfig.instance:getEquipCo(arg_17_0._equipId)
	arg_17_0.fromHandBook = arg_17_0.viewParam.fromHandBook

	arg_17_0:_refreshUI()
	arg_17_0:addEventCb(EquipController.instance, EquipEvent.onChangeStrengthenScrollState, arg_17_0.changeStrengthenScrollVisibleState, arg_17_0)
	arg_17_0:addEventCb(EquipController.instance, EquipEvent.onShowBreakCostListModelContainer, arg_17_0.showBreakContainer, arg_17_0)
	arg_17_0:addEventCb(EquipController.instance, EquipEvent.onShowStrengthenListModelContainer, arg_17_0.showStrengthenContainer, arg_17_0)
	arg_17_0:addEventCb(EquipController.instance, EquipEvent.onHideBreakAndStrengthenListModelContainer, arg_17_0.hideStrengthenAndBreakContainer, arg_17_0)
	arg_17_0:addEventCb(EquipController.instance, EquipEvent.onCloseEquipStrengthenView, arg_17_0.hideStrengthenAndBreakContainer, arg_17_0)
	arg_17_0:addEventCb(EquipController.instance, EquipEvent.onChangeRefineScrollState, arg_17_0.changeRefineScrollVisibleState, arg_17_0)
	arg_17_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_17_0.updateSlideEquipList, arg_17_0)
	arg_17_0:hideStrengthenAndBreakContainer()

	arg_17_0._allEquipList = arg_17_0.viewParam.equipList or EquipModel.instance:getEquips()

	NavigateMgr.instance:addEscape(ViewName.EquipView, arg_17_0._onEscapeBtnClick, arg_17_0)

	arg_17_0._isShowRefineScroll = false
	arg_17_0._isShowStrengthenScroll = false

	EquipChooseListModel.instance:openEquipView()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	arg_17_0._viewAnim:Play(UIAnimationName.Open)
end

function var_0_0._onEscapeBtnClick(arg_18_0)
	if arg_18_0._isShowStrengthenScroll then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, false)
	elseif arg_18_0._isShowRefineScroll then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, false)
	else
		arg_18_0:closeThis()
	end
end

function var_0_0._refreshUI(arg_19_0)
	local var_19_0 = arg_19_0.viewParam.defaultTabIds and arg_19_0.viewParam.defaultTabIds[2] or 1

	transformhelper.setLocalPosXY(arg_19_0._gocenter.transform, 0, 0)
	EquipCategoryListModel.instance:initCategory(arg_19_0._equipMO, arg_19_0._config)
	arg_19_0.viewContainer._views[1]:selectCell(var_19_0, true)
	arg_19_0._simageequip:LoadImage(ResUrl.getEquipSuit(arg_19_0._config.icon))

	if arg_19_0.fromHandBook and not HandbookModel.instance:haveEquip(arg_19_0._config.id) then
		ZProj.UGUIHelper.SetGrayscale(arg_19_0._simageequip.gameObject, true)
		gohelper.setActive(arg_19_0._goscrollArea, false)
	else
		gohelper.setActive(arg_19_0._goscrollArea, arg_19_0._equipMO and arg_19_0._equipId)
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_19_0._imagerare, arg_19_0._rareLineColor[arg_19_0._config.rare])

	if not string.nilorempty(arg_19_0._config.name) then
		arg_19_0._txtname.text = arg_19_0._config.name
		arg_19_0._txtnameen.text = arg_19_0._config.name_en
	else
		arg_19_0._txtname.text = ""
		arg_19_0._txtnameen.text = ""
	end

	arg_19_0:showStar()
end

function var_0_0.updateSlideEquipList(arg_20_0)
	local var_20_0 = {}
	local var_20_1

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._allEquipList) do
		local var_20_2 = EquipModel.instance:getEquip(iter_20_1.uid)

		if var_20_2 then
			table.insert(var_20_0, var_20_2)
		end
	end

	arg_20_0._allEquipList = var_20_0
end

function var_0_0.playOpenStrengthenEquipScrollAnimator(arg_21_0)
	arg_21_0.viewContainer.equipStrengthenView:showScrollContainer()
	arg_21_0._animscrollequip:Play("scroll_equip_in")
end

function var_0_0.playCloseStrengthenEquipScrollAnimator(arg_22_0)
	arg_22_0.viewContainer.equipStrengthenView:hideScrollContainer()
	arg_22_0._animscrollequip:Play("scroll_equip_out")
end

function var_0_0.playOpenRefineEquipScrollAnimator(arg_23_0)
	arg_23_0.viewContainer.equipRefineView:showScrollContainer()
	arg_23_0._animscrollrefineequip:Play("scroll_refine_equip_in")
end

function var_0_0.playCloseRefineEquipScrollAnimator(arg_24_0)
	arg_24_0.viewContainer.equipRefineView:hideScrollContainer()
	arg_24_0._animscrollrefineequip:Play("scroll_refine_equip_out")
end

function var_0_0.playOpenCenterAndTitleAnimator(arg_25_0)
	arg_25_0._animtitle:Play("title_in")
	arg_25_0._animcenter:Play("center_in")
end

function var_0_0.playCloseCenterAndTitleAnimator(arg_26_0)
	arg_26_0._animtitle:Play("title_out")
	arg_26_0._animcenter:Play("center_out")
end

function var_0_0.showStrengthenScrollEquip(arg_27_0)
	gohelper.setActive(arg_27_0._scrollequip.gameObject, true)
	gohelper.setActive(arg_27_0._scrollrefineequip.gameObject, false)
end

function var_0_0.hideStrengthenScrollEquip(arg_28_0)
	gohelper.setActive(arg_28_0._scrollequip.gameObject, false)
end

function var_0_0.showRefineScrollEquip(arg_29_0)
	gohelper.setActive(arg_29_0._scrollrefineequip.gameObject, true)
	gohelper.setActive(arg_29_0._scrollequip.gameObject, false)
end

function var_0_0.setStrengthenScrollVerticalNormalizedPosition(arg_30_0, arg_30_1)
	arg_30_0._scrollequip.verticalNormalizedPosition = arg_30_1
end

function var_0_0.hideRefineScrollEquip(arg_31_0)
	gohelper.setActive(arg_31_0._scrollrefineequip.gameObject, false)
end

function var_0_0.showCenterAndTitle(arg_32_0)
	gohelper.setActive(arg_32_0._gocenter, true)
	gohelper.setActive(arg_32_0._gocentereffect, arg_32_0._isClickRefine)
	gohelper.setActive(arg_32_0._gotitle, true)
end

function var_0_0.hideCenterAndTitle(arg_33_0)
	gohelper.setActive(arg_33_0._gocenter, false)
	gohelper.setActive(arg_33_0._gocentereffect, false)
	gohelper.setActive(arg_33_0._gotitle, false)
end

function var_0_0.showTitleAndCenter(arg_34_0)
	arg_34_0._isShowStrengthenScroll = false
	arg_34_0._isShowRefineScroll = false

	arg_34_0:hideStrengthenScrollEquip()
	arg_34_0:hideRefineScrollEquip()
	arg_34_0:showCenterAndTitle()
	arg_34_0:playOpenCenterAndTitleAnimator()
	arg_34_0.viewContainer:setIsOpenLeftBackpack(false)
end

function var_0_0.showStrengthenContainer(arg_35_0)
	gohelper.setActive(arg_35_0._scrollbreakequip.gameObject, false)
	gohelper.setActive(arg_35_0._scrollcostequip.gameObject, true)
end

function var_0_0.showBreakContainer(arg_36_0, arg_36_1)
	gohelper.setActive(arg_36_0._scrollbreakequip.gameObject, true)
	gohelper.setActive(arg_36_0._scrollcostequip.gameObject, false)

	for iter_36_0, iter_36_1 in pairs(arg_36_1) do
		local var_36_0 = arg_36_0._breakCostItems[iter_36_0]

		if not var_36_0 then
			var_36_0 = IconMgr.instance:getCommonItemIcon(arg_36_0._gobreakequipcontent)

			table.insert(arg_36_0._breakCostItems, var_36_0)
		end

		local var_36_1 = string.splitToNumber(iter_36_1, "#")
		local var_36_2 = var_36_1[1]
		local var_36_3 = var_36_1[2]
		local var_36_4 = var_36_1[3]

		var_36_0:setMOValue(var_36_2, var_36_3, var_36_4)
		var_36_0:setCountFontSize(38)
		var_36_0:setRecordFarmItem({
			type = var_36_2,
			id = var_36_3,
			quantity = var_36_4
		})

		local var_36_5 = var_36_0:getCount()
		local var_36_6 = ItemModel.instance:getItemQuantity(var_36_2, var_36_3)

		if var_36_4 <= var_36_6 then
			var_36_5.text = tostring(GameUtil.numberDisplay(var_36_6)) .. "/" .. tostring(GameUtil.numberDisplay(var_36_4))
		else
			var_36_5.text = "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(var_36_6)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(var_36_4))
		end
	end
end

function var_0_0.hideStrengthenAndBreakContainer(arg_37_0)
	gohelper.setActive(arg_37_0._scrollbreakequip.gameObject, false)
	gohelper.setActive(arg_37_0._scrollcostequip.gameObject, false)
end

function var_0_0.changeStrengthenScrollVisibleState(arg_38_0, arg_38_1)
	if arg_38_0._isShowStrengthenScroll == arg_38_1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)

	arg_38_0._isShowStrengthenScroll = arg_38_1

	arg_38_0.viewContainer:setIsOpenLeftBackpack(arg_38_0._isShowStrengthenScroll)
	arg_38_0:destroyFlow()

	arg_38_0.flow = FlowSequence.New()

	if arg_38_0._isShowStrengthenScroll then
		arg_38_0.flow:addWork(DelayFuncWork.New(arg_38_0.playCloseCenterAndTitleAnimator, arg_38_0, EquipEnum.AnimationDurationTime))
		arg_38_0.flow:addWork(DelayFuncWork.New(arg_38_0.hideCenterAndTitle, arg_38_0, 0))
		arg_38_0.flow:addWork(DelayFuncWork.New(arg_38_0.showStrengthenScrollEquip, arg_38_0, 0))
		arg_38_0.flow:addWork(DelayFuncWork.New(arg_38_0.playOpenStrengthenEquipScrollAnimator, arg_38_0, 0))
	else
		arg_38_0.flow:addWork(DelayFuncWork.New(arg_38_0.playCloseStrengthenEquipScrollAnimator, arg_38_0, EquipEnum.AnimationDurationTime))
		arg_38_0.flow:addWork(DelayFuncWork.New(arg_38_0.hideStrengthenScrollEquip, arg_38_0, 0))
		arg_38_0.flow:addWork(DelayFuncWork.New(arg_38_0.showCenterAndTitle, arg_38_0, 0))
		arg_38_0.flow:addWork(DelayFuncWork.New(arg_38_0.playOpenCenterAndTitleAnimator, arg_38_0, 0))
	end

	arg_38_0.flow:start()
end

function var_0_0._clearClickRefine(arg_39_0)
	arg_39_0._isClickRefine = false
end

function var_0_0.changeRefineScrollVisibleState(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_0._isShowRefineScroll == arg_40_1 then
		return
	end

	arg_40_0._isShowRefineScroll = arg_40_1
	arg_40_0._isClickRefine = arg_40_2

	arg_40_0.viewContainer:setIsOpenLeftBackpack(arg_40_0._isShowRefineScroll)
	arg_40_0:destroyFlow()

	arg_40_0.flow = FlowSequence.New()

	if arg_40_0._isShowRefineScroll then
		arg_40_0.flow:addWork(DelayFuncWork.New(arg_40_0.playCloseCenterAndTitleAnimator, arg_40_0, EquipEnum.AnimationDurationTime))
		arg_40_0.flow:addWork(DelayFuncWork.New(arg_40_0.hideCenterAndTitle, arg_40_0, 0))
		arg_40_0.flow:addWork(DelayFuncWork.New(arg_40_0.showRefineScrollEquip, arg_40_0, 0))
		arg_40_0.flow:addWork(DelayFuncWork.New(arg_40_0.playOpenRefineEquipScrollAnimator, arg_40_0, 0))
	else
		arg_40_0.flow:addWork(DelayFuncWork.New(arg_40_0.playCloseRefineEquipScrollAnimator, arg_40_0, EquipEnum.AnimationDurationTime))
		arg_40_0.flow:addWork(DelayFuncWork.New(arg_40_0.hideRefineScrollEquip, arg_40_0, 0))
		arg_40_0.flow:addWork(DelayFuncWork.New(arg_40_0.showCenterAndTitle, arg_40_0, 0))
		arg_40_0.flow:addWork(DelayFuncWork.New(arg_40_0.playOpenCenterAndTitleAnimator, arg_40_0, 0))
		arg_40_0.flow:addWork(DelayFuncWork.New(arg_40_0._clearClickRefine, arg_40_0, 0))
	end

	arg_40_0.flow:start()
end

function var_0_0.hideRefineScrollAndShowStrengthenScroll(arg_41_0)
	arg_41_0._isShowStrengthenScroll = true
	arg_41_0._isShowRefineScroll = false

	arg_41_0:destroyFlow()

	arg_41_0.flow = FlowSequence.New()

	arg_41_0.flow:addWork(DelayFuncWork.New(arg_41_0.playCloseRefineEquipScrollAnimator, arg_41_0, EquipEnum.AnimationDurationTime))
	arg_41_0.flow:addWork(DelayFuncWork.New(arg_41_0.showStrengthenScrollEquip, arg_41_0, 0))
	arg_41_0.flow:addWork(DelayFuncWork.New(arg_41_0.playOpenStrengthenEquipScrollAnimator, arg_41_0, 0))
	arg_41_0.flow:start()
end

function var_0_0.hideStrengthenScrollAndShowRefineScroll(arg_42_0)
	arg_42_0._isShowStrengthenScroll = false
	arg_42_0._isShowRefineScroll = true

	arg_42_0:destroyFlow()

	arg_42_0.flow = FlowSequence.New()

	arg_42_0.flow:addWork(DelayFuncWork.New(arg_42_0.playCloseStrengthenEquipScrollAnimator, arg_42_0, EquipEnum.AnimationDurationTime))
	arg_42_0.flow:addWork(DelayFuncWork.New(arg_42_0.showRefineScrollEquip, arg_42_0, 0))
	arg_42_0.flow:addWork(DelayFuncWork.New(arg_42_0.playOpenRefineEquipScrollAnimator, arg_42_0, 0))
	arg_42_0.flow:start()
end

function var_0_0.refreshRefineEquipList(arg_43_0)
	local var_43_0 = EquipRefineListModel.instance:getDataCount()
	local var_43_1 = recthelper.getHeight(arg_43_0._scrollcontent.transform)
	local var_43_2 = recthelper.getAnchorY(arg_43_0._scrollcontent.transform)
	local var_43_3 = var_43_2 <= var_43_1 - 480 and var_43_2 >= var_43_1 - 700

	if var_43_0 % 3 == 0 and var_43_3 then
		arg_43_0._scrollrefineequip.verticalNormalizedPosition = 0
	end
end

function var_0_0.playCurrencyViewAnimation(arg_44_0, arg_44_1)
	arg_44_0._animgorighttop:Play(arg_44_1)
end

function var_0_0.onClose(arg_45_0)
	EquipChooseListModel.instance:clear()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	arg_45_0:destroyFlow()
end

function var_0_0.onDestroyView(arg_46_0)
	arg_46_0._simagebg:UnLoadImage()
	arg_46_0._simageequip:UnLoadImage()
end

return var_0_0
