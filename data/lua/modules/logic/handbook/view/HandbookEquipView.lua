module("modules.logic.handbook.view.HandbookEquipView", package.seeall)

slot0 = class("HandbookEquipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goequip1 = gohelper.findChild(slot0.viewGO, "equipContain/#go_equip1")
	slot0._goequip2 = gohelper.findChild(slot0.viewGO, "equipContain/#go_equip2")
	slot0._goequip3 = gohelper.findChild(slot0.viewGO, "equipContain/#go_equip3")
	slot0._goequip4 = gohelper.findChild(slot0.viewGO, "equipContain/#go_equip4")
	slot0._goleftpage = gohelper.findChild(slot0.viewGO, "#btn_leftpage")
	slot0._goleftarrow = gohelper.findChild(slot0.viewGO, "#btn_leftpage/#go_leftarrow")
	slot0._gorightpage = gohelper.findChild(slot0.viewGO, "#btn_rightpage")
	slot0._gorightarrow = gohelper.findChild(slot0.viewGO, "#btn_rightpage/#go_rightarrow")
	slot0._gorarerank = gohelper.findChild(slot0.viewGO, "sortbtn/#btn_rarerank")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "sortbtn/#btn_filter")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfilter:AddClickListener(slot0.onClickBtnFilter, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfilter:RemoveClickListener()
end

slot0.everyPageShowCount = 4
slot0.DragAbsPositionX = 50
slot0.AnimatorBlockName = "HandbookEquipViewAnimator"

function slot0.onClickBtnFilter(slot0)
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		viewName = slot0.viewName
	})
end

function slot0.leftPageOnClick(slot0)
	if slot0.currentPage <= 1 then
		return
	end

	UIBlockMgr.instance:startBlock(uv0.AnimatorBlockName)
	slot0.animatorPlayer:Play("rightout", function (slot0)
		slot0:refreshPage(slot0.currentPage - 1)
		slot0.animatorPlayer:Play("rightin")
		UIBlockMgr.instance:endBlock(uv0.AnimatorBlockName)
	end, slot0)
end

function slot0.rightPageOnClick(slot0)
	if slot0.maxPage <= slot0.currentPage then
		return
	end

	UIBlockMgr.instance:startBlock(uv0.AnimatorBlockName)
	slot0.animatorPlayer:Play("leftout", function (slot0)
		slot0:refreshPage(slot0.currentPage + 1)
		slot0.animatorPlayer:Play("leftin")
		UIBlockMgr.instance:endBlock(uv0.AnimatorBlockName)
	end, slot0)
end

function slot0.rareRankOnClick(slot0)
	slot0.rareRankAscending = not slot0.rareRankAscending

	slot0:refreshSort()
	slot0:refreshUI()
end

function slot0.onEquipItemClick(slot0, slot1)
	EquipController.instance:openEquipView({
		fromHandBook = true,
		equipId = slot0.equipList[(slot0.currentPage - 1) * uv0.everyPageShowCount + slot1].id
	})
end

function slot0.customAddEvent(slot0)
	slot0._leftPageClick = gohelper.findChildClickWithAudio(slot0._goleftarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)
	slot0._rightPageClick = gohelper.findChildClickWithAudio(slot0._gorightarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)

	slot0._leftPageClick:AddClickListener(slot0.leftPageOnClick, slot0)
	slot0._rightPageClick:AddClickListener(slot0.rightPageOnClick, slot0)

	slot0._rareRankClick = gohelper.getClickWithAudio(slot0._gorarerank, AudioEnum.UI.play_ui_hero_card_click)

	slot0._rareRankClick:AddClickListener(slot0.rareRankOnClick, slot0)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0.viewGO)

	slot0._drag:AddDragBeginListener(slot0.onDragBeginHandle, slot0)
	slot0._drag:AddDragEndListener(slot0.onDragEndHandle, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, slot0.onFilterValueChange, slot0)
end

function slot0._editableInitView(slot0)
	slot0.simageList = slot0:getUserDataTb_()
	slot0.txtNameList = slot0:getUserDataTb_()
	slot0.txtNameEnList = slot0:getUserDataTb_()
	slot0.goRareList = slot0:getUserDataTb_()
	slot0.goEquipList = slot0:getUserDataTb_()
	slot0.equipClickList = slot0:getUserDataTb_()

	slot0:addItem(slot0._goequip1, 1)
	slot0:addItem(slot0._goequip2, 2)
	slot0:addItem(slot0._goequip3, 3)
	slot0:addItem(slot0._goequip4, 4)

	slot0.goRareRankIcon1 = gohelper.findChild(slot0.viewGO, "sortbtn/#btn_rarerank/txt/go_icon1")
	slot0.goRareRankIcon2 = gohelper.findChild(slot0.viewGO, "sortbtn/#btn_rarerank/txt/go_icon2")
	slot0.goNotFilter = gohelper.findChild(slot0.viewGO, "sortbtn/#btn_filter/#go_notfilter")
	slot0.goFilter = gohelper.findChild(slot0.viewGO, "sortbtn/#btn_filter/#go_filter")
	slot0.currentPage = 0
	slot0.maxPage = 0
	slot0.equipList = nil
	slot0.startDragPosX = 0
	slot0.rareRankAscending = false

	slot0:customAddEvent()
	slot0._simagebg:LoadImage(ResUrl.getHandbookCharacterIcon("full/bg111"))

	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
end

function slot0.onCareerClick(slot0, slot1)
	if slot0.career == slot1.career then
		return
	end

	slot0.career = slot1.career

	slot0:refreshUI()
end

function slot0.addItem(slot0, slot1, slot2)
	slot3 = gohelper.findChildSingleImage(slot1, "simage_equipicon")
	slot4 = gohelper.findChildText(slot1, "txt_name")
	slot5 = gohelper.findChildText(slot1, "txt_name/txt_nameEn")
	slot6 = slot0:getUserDataTb_()

	for slot10 = 3, 6 do
		table.insert(slot6, gohelper.findChild(slot1, "txt_name/rare/rare" .. slot10))
	end

	table.insert(slot0.simageList, slot3)
	table.insert(slot0.txtNameList, slot4)
	table.insert(slot0.txtNameEnList, slot5)
	table.insert(slot0.goRareList, slot6)
	table.insert(slot0.goEquipList, slot1)

	slot7 = gohelper.getClick(slot1)

	slot7:AddClickListener(slot0.onEquipItemClick, slot0, slot2)
	table.insert(slot0.equipClickList, slot7)
end

function slot0.onFilterValueChange(slot0, slot1)
	if slot1 ~= slot0.viewName then
		return
	end

	slot0:refreshEquipData()
	slot0:refreshSort()
	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	slot0.filterMo = EquipFilterModel.instance:generateFilterMo(slot0.viewName)

	slot0:refreshEquipData()
	slot0:refreshSort()
	slot0:refreshUI()
end

function slot0.refreshEquipData(slot0)
	slot0.equipList = slot0:getEquips()
	slot0.maxPage = slot0:getMaxPageNum()
end

function slot0.refreshSort(slot0)
	if slot0.rareRankAscending then
		table.sort(slot0.equipList, slot0.rareAscendingSortFunc)
	else
		table.sort(slot0.equipList, slot0.rareDescendingSortFunc)
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshBtnStatus()
	slot0:refreshPage(1)
end

function slot0.refreshBtnStatus(slot0)
	gohelper.setActive(slot0.goRareRankIcon1, slot0.rareRankAscending)
	gohelper.setActive(slot0.goRareRankIcon2, not slot0.rareRankAscending)
	slot0:refreshFilterBtnStatus()
end

function slot0.refreshFilterBtnStatus(slot0)
	slot1 = slot0.filterMo:isFiltering()

	gohelper.setActive(slot0.goFilter, slot1)
	gohelper.setActive(slot0.goNotFilter, not slot1)
end

function slot0.refreshPage(slot0, slot1)
	slot0.currentPage = slot1

	for slot6 = 1, uv0.everyPageShowCount do
		slot0:handleItem(slot6, slot0.equipList[(slot1 - 1) * uv0.everyPageShowCount + slot6])
	end

	gohelper.setActive(slot0._goleftarrow, slot0.currentPage > 1)
	gohelper.setActive(slot0._gorightarrow, slot0.currentPage < slot0.maxPage)
end

function slot0.rareAscendingSortFunc(slot0, slot1)
	if slot0.rare ~= slot1.rare then
		return slot0.rare < slot1.rare
	end

	return slot0.id < slot1.id
end

function slot0.rareDescendingSortFunc(slot0, slot1)
	if slot0.rare ~= slot1.rare then
		return slot1.rare < slot0.rare
	end

	return slot0.id < slot1.id
end

function slot0.getEquips(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_handbook_equip.configList) do
		if slot0:checkNeedEquipCo(EquipConfig.instance:getEquipCo(slot6.equipId)) then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.getMaxPageNum(slot0)
	return math.ceil(#slot0.equipList / uv0.everyPageShowCount)
end

function slot0.checkNeedEquipCo(slot0, slot1)
	if not slot1 then
		return false
	end

	if not slot0.filterMo:isFiltering() then
		return true
	end

	if not slot0.filterMo:checkIsIncludeTag(slot1) then
		return false
	end

	if slot0.filterMo:getObtainType() == EquipFilterModel.ObtainEnum.All then
		return true
	end

	if slot2 == EquipFilterModel.ObtainEnum.Get then
		return HandbookModel.instance:haveEquip(slot1.id)
	else
		return not HandbookModel.instance:haveEquip(slot1.id)
	end
end

function slot0.handleItem(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot0.goEquipList[slot1], false)

		return
	end

	gohelper.setActive(slot0.goEquipList[slot1], true)
	ZProj.UGUIHelper.SetGrayscale(slot0.simageList[slot1].gameObject, not HandbookModel.instance:haveEquip(slot2.id))

	slot6 = ResUrl.getHandbookEquipImage

	slot0.simageList[slot1]:LoadImage(slot6(slot2.icon .. slot1))

	slot0.txtNameList[slot1].text = slot2.name
	slot0.txtNameEnList[slot1].text = slot2.name_en

	for slot6 = 1, #slot0.goRareList[slot1] do
		if slot2.rare == slot6 + 1 then
			gohelper.setActive(slot0.goRareList[slot1][slot6], true)
		else
			gohelper.setActive(slot0.goRareList[slot1][slot6], false)
		end
	end
end

function slot0.onDragBeginHandle(slot0, slot1, slot2)
	slot0.startDragPosX = slot2.position.x
end

function slot0.onDragEndHandle(slot0, slot1, slot2)
	if uv0.DragAbsPositionX < math.abs(slot2.position.x - slot0.startDragPosX) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_click)

		if slot3 < slot0.startDragPosX then
			slot0:rightPageOnClick()
		else
			slot0:leftPageOnClick()
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot4 = slot0.viewName

	EquipFilterModel.instance:clear(slot4)

	for slot4, slot5 in ipairs(slot0.equipClickList) do
		slot5:RemoveClickListener()
	end

	slot0._leftPageClick:RemoveClickListener()
	slot0._rightPageClick:RemoveClickListener()
	slot0._rareRankClick:RemoveClickListener()

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()
	end

	slot0.equipList = nil

	slot0._simagebg:UnLoadImage()

	for slot4 = 1, #slot0.simageList do
		slot0.simageList[slot4]:UnLoadImage()
	end
end

return slot0
