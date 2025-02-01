module("modules.logic.equip.view.EquipView", package.seeall)

slot0 = class("EquipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._scrollcategory = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_category")
	slot0._gocenter = gohelper.findChild(slot0.viewGO, "#go_center")
	slot0._gocentereffect = gohelper.findChild(slot0.viewGO, "#go_center/effect")
	slot0._simageequip = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/#simage_equip")
	slot0._gostarList = gohelper.findChild(slot0.viewGO, "#go_center/#go_starList")
	slot0._scrollcostequip = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_costequip")
	slot0._scrollbreakequip = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_breakquip")
	slot0._gobreakequipcontent = gohelper.findChild(slot0.viewGO, "#scroll_breakquip/Viewport/Content")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")
	slot0._scrollequip = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_equip")
	slot0._scrollrefineequip = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_refine_equip")
	slot0._scrollcontent = gohelper.findChild(slot0.viewGO, "#scroll_refine_equip/viewport/scrollcontent")
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "#go_title")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "#go_title/rare/#rare")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_title/#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_title/#txt_name/#txt_nameen")
	slot0._animscrollequip = slot0._scrollequip:GetComponent(typeof(UnityEngine.Animator))
	slot0._animscrollrefineequip = slot0._scrollrefineequip:GetComponent(typeof(UnityEngine.Animator))
	slot0._animcenter = slot0._gocenter:GetComponent(typeof(UnityEngine.Animator))
	slot0._animtitle = slot0._gotitle:GetComponent(typeof(UnityEngine.Animator))
	slot0._goscrollArea = gohelper.findChild(slot0.viewGO, "#go_scrollArea")
	slot0._equipSlide = SLFramework.UGUI.UIDragListener.Get(slot0._goscrollArea)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._equipSlide:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._equipSlide:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0.removeEvents(slot0)
	slot0._equipSlide:RemoveDragBeginListener()
	slot0._equipSlide:RemoveDragEndListener()
end

slot0.DragAbsPositionX = 30

function slot0.initRightRopStatus(slot0)
	slot0._animgorighttop = slot0._gorighttop:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._gorighttop, true)
	slot0._animgorighttop:Play("go_righttop_out", 0, 1)
end

function slot0._editableInitView(slot0)
	slot4 = "full/bg_equipbg.png"

	slot0._simagebg:LoadImage(ResUrl.getEquipBg(slot4))

	slot0._rareLineColor = {
		"#DCF5D5",
		"#9EB7D7",
		"#7D5B7E",
		"#D2D79E",
		"#D6A181"
	}
	slot0._starList = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		table.insert(slot0._starList, gohelper.findChild(slot0._gostarList, "star" .. slot4))
	end

	slot0._breakCostItems = slot0:getUserDataTb_()

	gohelper.setActive(slot0._scrollequip.gameObject, false)
	gohelper.setActive(slot0._gocentereffect, false)

	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.costEquipScrollAnim = slot0._scrollcostequip:GetComponent(typeof(UnityEngine.Animator))
	slot0.breakEquipScrollAnim = slot0._scrollbreakequip:GetComponent(typeof(UnityEngine.Animator))

	slot0:initRightRopStatus()
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if slot0.viewContainer:getIsOpenLeftBackpack() then
		return
	end

	slot0.startDragPosX = slot2.position.x
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if slot0.viewContainer:getIsOpenLeftBackpack() then
		return
	end

	if uv0.DragAbsPositionX < math.abs(slot2.position.x - slot0.startDragPosX) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)
		slot0:_onSlide(slot3 < slot0.startDragPosX)
	end
end

function slot0._onSlide(slot0, slot1)
	slot2 = slot0:_getCurEquipIndex()

	if slot0._allEquipList[slot1 and (GameUtil.getTabLen(slot0._allEquipList) < slot2 + 1 and 1 or slot2 + 1) or slot2 - 1 <= 0 and GameUtil.getTabLen(slot0._allEquipList) or slot2 - 1] ~= slot0._equipMO and EquipHelper.isNormalEquip(slot0._config) ~= EquipHelper.isNormalEquip(slot3.config) then
		if slot4 and EquipCategoryListModel.instance.curCategoryIndex ~= 4 then
			EquipCategoryListModel.instance.curCategoryIndex = 1
		end

		if slot5 and EquipCategoryListModel.instance.curCategoryIndex == 2 then
			EquipCategoryListModel.instance.curCategoryIndex = 4
		end
	end

	slot0._equipMO = slot0._allEquipList[slot2]
	slot0._equipId = slot0._equipMO and slot0._equipMO.config.id or slot0._equipMO.equipId
	slot0._config = slot0._equipMO and slot0._equipMO.config or EquipConfig.instance:getEquipCo(slot0._equipId)

	slot0:destroyFlow()

	slot0.flow = FlowSequence.New()

	slot0.flow:addWork(DelayFuncWork.New(slot0.playTableViewCloseAnimation, slot0, EquipEnum.AnimationDurationTime))
	slot0.flow:addWork(DelayFuncWork.New(slot0._reSelectEquip, slot0))
	slot0.flow:registerDoneListener(slot0.endAnimBlock, slot0)
	slot0:startAnimBlock()
	slot0.flow:start()
end

function slot0._reSelectEquip(slot0)
	EquipController.instance:openEquipView({
		equipMO = slot0._equipMO,
		defaultTabIds = {
			[2] = EquipCategoryListModel.instance.curCategoryIndex
		}
	})
end

function slot0.startAnimBlock(slot0)
	UIBlockMgr.instance:startBlock("EquipAnimBlock")
end

function slot0.endAnimBlock(slot0)
	UIBlockMgr.instance:endBlock("EquipAnimBlock")
end

function slot0.destroyFlow(slot0)
	if slot0.flow then
		slot0.flow:destroy()

		slot0.flow = nil
	end

	slot0:endAnimBlock()
end

function slot0._getCurEquipIndex(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0._allEquipList) do
		if slot6.uid == slot0._equipMO.uid then
			slot1 = slot5
		end
	end

	return slot1
end

function slot0.playTableViewCloseAnimation(slot0)
	slot0.viewContainer.tableView:playCloseAnimation()
end

function slot0.onUpdateParam(slot0)
	slot0._equipMO = slot0.viewParam.equipMO
	slot0._equipId = slot0._equipMO and slot0._equipMO.config.id or slot0.viewParam.equipId
	slot0._config = slot0._equipMO and slot0._equipMO.config or EquipConfig.instance:getEquipCo(slot0._equipId)

	slot0:_refreshUI()
end

function slot0.showStar(slot0)
	for slot4, slot5 in pairs(slot0._starList) do
		gohelper.setActive(slot0._starList[slot4], slot4 <= slot0._config.rare + 1)
	end
end

function slot0.onOpen(slot0)
	slot0._equipMO = slot0.viewParam.equipMO
	slot0._equipId = slot0._equipMO and slot0._equipMO.config.id or slot0.viewParam.equipId
	slot0._config = slot0._equipMO and slot0._equipMO.config or EquipConfig.instance:getEquipCo(slot0._equipId)
	slot0.fromHandBook = slot0.viewParam.fromHandBook

	slot0:_refreshUI()
	slot0:addEventCb(EquipController.instance, EquipEvent.onChangeStrengthenScrollState, slot0.changeStrengthenScrollVisibleState, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onShowBreakCostListModelContainer, slot0.showBreakContainer, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onShowStrengthenListModelContainer, slot0.showStrengthenContainer, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onHideBreakAndStrengthenListModelContainer, slot0.hideStrengthenAndBreakContainer, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onCloseEquipStrengthenView, slot0.hideStrengthenAndBreakContainer, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onChangeRefineScrollState, slot0.changeRefineScrollVisibleState, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, slot0.updateSlideEquipList, slot0)
	slot0:hideStrengthenAndBreakContainer()

	slot0._allEquipList = slot0.viewParam.equipList or EquipModel.instance:getEquips()

	NavigateMgr.instance:addEscape(ViewName.EquipView, slot0._onEscapeBtnClick, slot0)

	slot0._isShowRefineScroll = false
	slot0._isShowStrengthenScroll = false

	EquipChooseListModel.instance:openEquipView()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	slot0._viewAnim:Play(UIAnimationName.Open)
end

function slot0._onEscapeBtnClick(slot0)
	if slot0._isShowStrengthenScroll then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, false)
	elseif slot0._isShowRefineScroll then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, false)
	else
		slot0:closeThis()
	end
end

function slot0._refreshUI(slot0)
	transformhelper.setLocalPosXY(slot0._gocenter.transform, 0, 0)
	EquipCategoryListModel.instance:initCategory(slot0._equipMO, slot0._config)
	slot0.viewContainer._views[1]:selectCell(slot0.viewParam.defaultTabIds and slot0.viewParam.defaultTabIds[2] or 1, true)
	slot0._simageequip:LoadImage(ResUrl.getEquipSuit(slot0._config.icon))

	if slot0.fromHandBook and not HandbookModel.instance:haveEquip(slot0._config.id) then
		ZProj.UGUIHelper.SetGrayscale(slot0._simageequip.gameObject, true)
		gohelper.setActive(slot0._goscrollArea, false)
	else
		gohelper.setActive(slot0._goscrollArea, slot0._equipMO and slot0._equipId)
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagerare, slot0._rareLineColor[slot0._config.rare])

	if not string.nilorempty(slot0._config.name) then
		slot0._txtname.text = slot0._config.name
		slot0._txtnameen.text = slot0._config.name_en
	else
		slot0._txtname.text = ""
		slot0._txtnameen.text = ""
	end

	slot0:showStar()
end

function slot0.updateSlideEquipList(slot0)
	slot1 = {}
	slot2 = nil

	for slot6, slot7 in ipairs(slot0._allEquipList) do
		if EquipModel.instance:getEquip(slot7.uid) then
			table.insert(slot1, slot2)
		end
	end

	slot0._allEquipList = slot1
end

function slot0.playOpenStrengthenEquipScrollAnimator(slot0)
	slot0.viewContainer.equipStrengthenView:showScrollContainer()
	slot0._animscrollequip:Play("scroll_equip_in")
end

function slot0.playCloseStrengthenEquipScrollAnimator(slot0)
	slot0.viewContainer.equipStrengthenView:hideScrollContainer()
	slot0._animscrollequip:Play("scroll_equip_out")
end

function slot0.playOpenRefineEquipScrollAnimator(slot0)
	slot0.viewContainer.equipRefineView:showScrollContainer()
	slot0._animscrollrefineequip:Play("scroll_refine_equip_in")
end

function slot0.playCloseRefineEquipScrollAnimator(slot0)
	slot0.viewContainer.equipRefineView:hideScrollContainer()
	slot0._animscrollrefineequip:Play("scroll_refine_equip_out")
end

function slot0.playOpenCenterAndTitleAnimator(slot0)
	slot0._animtitle:Play("title_in")
	slot0._animcenter:Play("center_in")
end

function slot0.playCloseCenterAndTitleAnimator(slot0)
	slot0._animtitle:Play("title_out")
	slot0._animcenter:Play("center_out")
end

function slot0.showStrengthenScrollEquip(slot0)
	gohelper.setActive(slot0._scrollequip.gameObject, true)
	gohelper.setActive(slot0._scrollrefineequip.gameObject, false)
end

function slot0.hideStrengthenScrollEquip(slot0)
	gohelper.setActive(slot0._scrollequip.gameObject, false)
end

function slot0.showRefineScrollEquip(slot0)
	gohelper.setActive(slot0._scrollrefineequip.gameObject, true)
	gohelper.setActive(slot0._scrollequip.gameObject, false)
end

function slot0.setStrengthenScrollVerticalNormalizedPosition(slot0, slot1)
	slot0._scrollequip.verticalNormalizedPosition = slot1
end

function slot0.hideRefineScrollEquip(slot0)
	gohelper.setActive(slot0._scrollrefineequip.gameObject, false)
end

function slot0.showCenterAndTitle(slot0)
	gohelper.setActive(slot0._gocenter, true)
	gohelper.setActive(slot0._gocentereffect, slot0._isClickRefine)
	gohelper.setActive(slot0._gotitle, true)
end

function slot0.hideCenterAndTitle(slot0)
	gohelper.setActive(slot0._gocenter, false)
	gohelper.setActive(slot0._gocentereffect, false)
	gohelper.setActive(slot0._gotitle, false)
end

function slot0.showTitleAndCenter(slot0)
	slot0._isShowStrengthenScroll = false
	slot0._isShowRefineScroll = false

	slot0:hideStrengthenScrollEquip()
	slot0:hideRefineScrollEquip()
	slot0:showCenterAndTitle()
	slot0:playOpenCenterAndTitleAnimator()
	slot0.viewContainer:setIsOpenLeftBackpack(false)
end

function slot0.showStrengthenContainer(slot0)
	gohelper.setActive(slot0._scrollbreakequip.gameObject, false)
	gohelper.setActive(slot0._scrollcostequip.gameObject, true)
end

function slot0.showBreakContainer(slot0, slot1)
	gohelper.setActive(slot0._scrollbreakequip.gameObject, true)
	gohelper.setActive(slot0._scrollcostequip.gameObject, false)

	for slot5, slot6 in pairs(slot1) do
		if not slot0._breakCostItems[slot5] then
			table.insert(slot0._breakCostItems, IconMgr.instance:getCommonItemIcon(slot0._gobreakequipcontent))
		end

		slot8 = string.splitToNumber(slot6, "#")
		slot9 = slot8[1]
		slot10 = slot8[2]
		slot11 = slot8[3]

		slot7:setMOValue(slot9, slot10, slot11)
		slot7:setCountFontSize(38)
		slot7:setRecordFarmItem({
			type = slot9,
			id = slot10,
			quantity = slot11
		})

		if slot11 <= ItemModel.instance:getItemQuantity(slot9, slot10) then
			slot7:getCount().text = tostring(GameUtil.numberDisplay(slot13)) .. "/" .. tostring(GameUtil.numberDisplay(slot11))
		else
			slot12.text = "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(slot13)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(slot11))
		end
	end
end

function slot0.hideStrengthenAndBreakContainer(slot0)
	gohelper.setActive(slot0._scrollbreakequip.gameObject, false)
	gohelper.setActive(slot0._scrollcostequip.gameObject, false)
end

function slot0.changeStrengthenScrollVisibleState(slot0, slot1)
	if slot0._isShowStrengthenScroll == slot1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)

	slot0._isShowStrengthenScroll = slot1

	slot0.viewContainer:setIsOpenLeftBackpack(slot0._isShowStrengthenScroll)
	slot0:destroyFlow()

	slot0.flow = FlowSequence.New()

	if slot0._isShowStrengthenScroll then
		slot0.flow:addWork(DelayFuncWork.New(slot0.playCloseCenterAndTitleAnimator, slot0, EquipEnum.AnimationDurationTime))
		slot0.flow:addWork(DelayFuncWork.New(slot0.hideCenterAndTitle, slot0, 0))
		slot0.flow:addWork(DelayFuncWork.New(slot0.showStrengthenScrollEquip, slot0, 0))
		slot0.flow:addWork(DelayFuncWork.New(slot0.playOpenStrengthenEquipScrollAnimator, slot0, 0))
	else
		slot0.flow:addWork(DelayFuncWork.New(slot0.playCloseStrengthenEquipScrollAnimator, slot0, EquipEnum.AnimationDurationTime))
		slot0.flow:addWork(DelayFuncWork.New(slot0.hideStrengthenScrollEquip, slot0, 0))
		slot0.flow:addWork(DelayFuncWork.New(slot0.showCenterAndTitle, slot0, 0))
		slot0.flow:addWork(DelayFuncWork.New(slot0.playOpenCenterAndTitleAnimator, slot0, 0))
	end

	slot0.flow:start()
end

function slot0._clearClickRefine(slot0)
	slot0._isClickRefine = false
end

function slot0.changeRefineScrollVisibleState(slot0, slot1, slot2)
	if slot0._isShowRefineScroll == slot1 then
		return
	end

	slot0._isShowRefineScroll = slot1
	slot0._isClickRefine = slot2

	slot0.viewContainer:setIsOpenLeftBackpack(slot0._isShowRefineScroll)
	slot0:destroyFlow()

	slot0.flow = FlowSequence.New()

	if slot0._isShowRefineScroll then
		slot0.flow:addWork(DelayFuncWork.New(slot0.playCloseCenterAndTitleAnimator, slot0, EquipEnum.AnimationDurationTime))
		slot0.flow:addWork(DelayFuncWork.New(slot0.hideCenterAndTitle, slot0, 0))
		slot0.flow:addWork(DelayFuncWork.New(slot0.showRefineScrollEquip, slot0, 0))
		slot0.flow:addWork(DelayFuncWork.New(slot0.playOpenRefineEquipScrollAnimator, slot0, 0))
	else
		slot0.flow:addWork(DelayFuncWork.New(slot0.playCloseRefineEquipScrollAnimator, slot0, EquipEnum.AnimationDurationTime))
		slot0.flow:addWork(DelayFuncWork.New(slot0.hideRefineScrollEquip, slot0, 0))
		slot0.flow:addWork(DelayFuncWork.New(slot0.showCenterAndTitle, slot0, 0))
		slot0.flow:addWork(DelayFuncWork.New(slot0.playOpenCenterAndTitleAnimator, slot0, 0))
		slot0.flow:addWork(DelayFuncWork.New(slot0._clearClickRefine, slot0, 0))
	end

	slot0.flow:start()
end

function slot0.hideRefineScrollAndShowStrengthenScroll(slot0)
	slot0._isShowStrengthenScroll = true
	slot0._isShowRefineScroll = false

	slot0:destroyFlow()

	slot0.flow = FlowSequence.New()

	slot0.flow:addWork(DelayFuncWork.New(slot0.playCloseRefineEquipScrollAnimator, slot0, EquipEnum.AnimationDurationTime))
	slot0.flow:addWork(DelayFuncWork.New(slot0.showStrengthenScrollEquip, slot0, 0))
	slot0.flow:addWork(DelayFuncWork.New(slot0.playOpenStrengthenEquipScrollAnimator, slot0, 0))
	slot0.flow:start()
end

function slot0.hideStrengthenScrollAndShowRefineScroll(slot0)
	slot0._isShowStrengthenScroll = false
	slot0._isShowRefineScroll = true

	slot0:destroyFlow()

	slot0.flow = FlowSequence.New()

	slot0.flow:addWork(DelayFuncWork.New(slot0.playCloseStrengthenEquipScrollAnimator, slot0, EquipEnum.AnimationDurationTime))
	slot0.flow:addWork(DelayFuncWork.New(slot0.showRefineScrollEquip, slot0, 0))
	slot0.flow:addWork(DelayFuncWork.New(slot0.playOpenRefineEquipScrollAnimator, slot0, 0))
	slot0.flow:start()
end

function slot0.refreshRefineEquipList(slot0)
	if EquipRefineListModel.instance:getDataCount() % 3 == 0 and (recthelper.getAnchorY(slot0._scrollcontent.transform) <= recthelper.getHeight(slot0._scrollcontent.transform) - 480 and slot3 >= slot2 - 700) then
		slot0._scrollrefineequip.verticalNormalizedPosition = 0
	end
end

function slot0.playCurrencyViewAnimation(slot0, slot1)
	slot0._animgorighttop:Play(slot1)
end

function slot0.onClose(slot0)
	EquipChooseListModel.instance:clear()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	slot0:destroyFlow()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageequip:UnLoadImage()
end

return slot0
