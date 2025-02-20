module("modules.logic.equip.view.decompose.EquipDecomposeView", package.seeall)

slot0 = class("EquipDecomposeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_equipsort/#btn_rarerank")
	slot0._btnlvrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_equipsort/#btn_lvrank")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_equipsort/#btn_filter")
	slot0._gonotfilter = gohelper.findChild(slot0.viewGO, "left_container/#go_equipsort/#btn_filter/#go_notfilter")
	slot0._gofilter = gohelper.findChild(slot0.viewGO, "left_container/#go_equipsort/#btn_filter/#go_filter")
	slot0._btnfastadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_cost/fast/#btn_fastadd")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "left_container/#go_cost/txt_selected/#txt_num")
	slot0._btnclear = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/go_clear/#btn_clear")
	slot0._simageequipicon = gohelper.findChildSingleImage(slot0.viewGO, "right_container/frame/#simage_equipicon")
	slot0._txtequipname = gohelper.findChildText(slot0.viewGO, "right_container/#txt_equipname")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "right_container/#txt_count")
	slot0._btndecompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "right_container/#btn_decompose")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "left_container/#go_empty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnlvrank:AddClickListener(slot0._btnlvrankOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
	slot0._btnfastadd:AddClickListener(slot0._btnfastaddOnClick, slot0)
	slot0._btnclear:AddClickListener(slot0._btnclearOnClick, slot0)
	slot0._btndecompose:AddClickListener(slot0._btndecomposeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnlvrank:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
	slot0._btnfastadd:RemoveClickListener()
	slot0._btnclear:RemoveClickListener()
	slot0._btndecompose:RemoveClickListener()
end

slot0.Color = {
	Select = "#DF6931",
	Normal = "#717070"
}

function slot0._btnrarerankOnClick(slot0)
	EquipDecomposeListModel.instance:changeRareStatus()
end

function slot0._btnlvrankOnClick(slot0)
	EquipDecomposeListModel.instance:changeLevelSortStatus()
end

function slot0._btnfilterOnClick(slot0)
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = slot0.viewName
	})
end

function slot0._btnfastaddOnClick(slot0)
	EquipDecomposeListModel.instance:fastAddEquip()
end

function slot0._btnclearOnClick(slot0)
	EquipDecomposeListModel.instance:clearSelectEquip()
end

slot0.DecomposeAnimKey = "DecomposeAnimKey"

function slot0._btndecomposeOnClick(slot0)
	if EquipDecomposeListModel.instance:getSelectCount() < 1 then
		return
	end

	slot0.scrollRect.velocity = Vector2.zero

	UIBlockMgr.instance:startBlock(uv0.DecomposeAnimKey)
	EquipController.instance:dispatchEvent(EquipEvent.OnEquipBeforeDecompose)
	TaskDispatcher.runDelay(slot0._sendDecomposeRequest, slot0, EquipEnum.DecomposeAnimDuration)
end

function slot0._sendDecomposeRequest(slot0)
	UIBlockMgr.instance:endBlock(uv0.DecomposeAnimKey)

	if EquipDecomposeListModel.instance:getSelectCount() < 1 then
		return
	end

	EquipRpc.instance:sendEquipDecomposeRequest()
end

function slot0.onClickDecomposeEquip(slot0)
	EquipController.instance:openEquipView({
		equipId = EquipConfig.instance.equipDecomposeEquipId
	})
end

function slot0._editableInitView(slot0)
	slot0.multipleChar = luaLang("multiple")
	slot0._txtcount.text = string.format("%s0", slot0.multipleChar)
	slot0.preCount = 0
	slot0.scrollRect = gohelper.findChild(slot0.viewGO, "left_container/#go_scrollcontainer/#scroll_equip"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	slot0.txtCountAnimator = gohelper.findChildComponent(slot0.viewGO, "right_container/vx_count/ani", gohelper.Type_Animator)

	slot0._simagebg:LoadImage(ResUrl.getEquipBg("full/equip_decompose_fullbg.png"))

	slot0.goclear = gohelper.findChild(slot0.viewGO, "left_container/go_clear")
	slot0.goDecomposeBtn = slot0._btndecompose.gameObject
	slot0.rareBtnItem = slot0:createBtnItem(slot0._btnrarerank.gameObject)
	slot0.lvBtnItem = slot0:createBtnItem(slot0._btnlvrank.gameObject)
	slot0.rareBtnItem.tag = EquipDecomposeListModel.SortTag.Rare
	slot0.lvBtnItem.tag = EquipDecomposeListModel.SortTag.Level

	gohelper.setActive(slot0._goempty, false)
	slot0:initFilterDrop()
	gohelper.addUIClickAudio(slot0._btndecompose.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)

	slot0.decomposeEquipClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "right_container/frame/#simage_equipicon")

	slot0.decomposeEquipClick:AddClickListener(slot0.onClickDecomposeEquip, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, slot0.onEquipTypeHasChange, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.OnEquipDecomposeSelectEquipChange, slot0.onEquipDecomposeSelectEquipChange, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.OnEquipDecomposeSortStatusChange, slot0.onEquipDecomposeSortStatusChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0.onOpenView, slot0)
end

function slot0.createBtnItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.goSelect = gohelper.findChild(slot2.go, "select")
	slot2.txtGraphic = gohelper.findChildComponent(slot2.go, "normal/txt", gohelper.Type_Graphic)
	slot2.arrowGraphic = gohelper.findChildComponent(slot2.go, "normal/txt/arrow", gohelper.Type_Graphic)
	slot2.arrowTr = gohelper.findChildComponent(slot2.go, "normal/txt/arrow", gohelper.Type_Transform)

	return slot2
end

function slot0.initFilterDrop(slot0)
	slot0.dropFilter = gohelper.findChildDropdown(slot0.viewGO, "left_container/#go_cost/#drop_filter")
	slot0._goDrop = slot0.dropFilter.gameObject
	slot0.dropArrowTr = gohelper.findChildComponent(slot0._goDrop, "Arrow", gohelper.Type_Transform)
	slot0.dropClick = gohelper.getClick(slot0._goDrop)
	slot0.dropExtend = DropDownExtend.Get(slot0._goDrop)
	slot4 = slot0.onDropShow

	slot0.dropExtend:init(slot4, slot0.onDropHide, slot0)

	slot0.filterRareList = {}

	for slot4 = EquipEnum.EquipDecomposeMinRare, EquipEnum.EquipDecomposeMaxRare do
		table.insert(slot0.filterRareList, slot4)
	end

	slot1 = {}

	for slot5, slot6 in ipairs(slot0.filterRareList) do
		if slot6 == 0 then
			table.insert(slot1, luaLang("equip_filter_all"))
		else
			table.insert(slot1, string.format(luaLang("equip_filter_str"), slot6 + 1))
		end
	end

	slot0.dropFilter:ClearOptions()
	slot0.dropFilter:AddOptions(slot1)
	slot0.dropFilter:AddOnValueChanged(slot0.onDropValueChanged, slot0)
	slot0.dropClick:AddClickListener(function ()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, slot0)
	EquipDecomposeListModel.instance:setFilterRare(slot0.filterRareList[1])

	slot0.initDropDone = true
end

function slot0.onDropValueChanged(slot0, slot1)
	if not slot0.initDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	EquipDecomposeListModel.instance:setFilterRare(slot0.filterRareList[slot1 + 1])
end

function slot0.onDropHide(slot0)
	transformhelper.setLocalScale(slot0.dropArrowTr, 1, 1, 1)
end

function slot0.onDropShow(slot0)
	transformhelper.setLocalScale(slot0.dropArrowTr, 1, -1, 1)
end

function slot0.onOpen(slot0)
	slot0.decomposeEquipConfig = EquipConfig.instance:getEquipCo(EquipConfig.instance.equipDecomposeEquipId)
	slot0.decomposeEquipUnitCount = EquipConfig.instance.equipDecomposeEquipUnitCount
	slot0.filterMo = EquipFilterModel.instance:generateFilterMo(slot0.viewName)

	EquipDecomposeListModel.instance:initEquipData()
	slot0:refreshUI()
	TaskDispatcher.runDelay(slot0.firstRefreshEquip, slot0, EquipEnum.EquipEnterAnimWaitTime)
end

function slot0.firstRefreshEquip(slot0)
	slot0.viewContainer._views[2]._animationStartTime = Time.time

	slot0:refreshCenterGroupUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshTopGroupUI()
	slot0:refreshBottomGroup()
end

function slot0.refreshRight(slot0)
	slot0:refreshDecomposeEquip()
	slot0:refreshCount()
	slot0:refreshDecomposeBtn()
end

function slot0.refreshTopGroupUI(slot0)
	slot0:refreshBtnItem(slot0.rareBtnItem)
	slot0:refreshBtnItem(slot0.lvBtnItem)
	slot0:refreshFilterBtn()
end

function slot0.refreshCenterGroupUI(slot0)
	EquipDecomposeListModel.instance:refreshEquip()
	gohelper.setActive(slot0._goempty, EquipDecomposeListModel.instance:isEmpty())
end

function slot0.refreshBottomGroup(slot0)
	slot0._txtnum.text = string.format("<color=#ff7933>%s</color>/%s", EquipDecomposeListModel.instance:getSelectCount(), EquipEnum.DecomposeMaxCount)

	slot0:refreshClear()
end

function slot0.refreshBtnItem(slot0, slot1)
	slot2 = EquipDecomposeListModel.instance:getSortTag() == slot1.tag

	gohelper.setActive(slot1.goSelect, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot1.txtGraphic, slot2 and uv0.Color.Select or uv0.Color.Normal)
	SLFramework.UGUI.GuiHelper.SetColor(slot1.arrowGraphic, slot2 and uv0.Color.Select or uv0.Color.Normal)
	transformhelper.setLocalScale(slot1.arrowTr, 1, EquipDecomposeListModel.instance:getSortIsAscend(slot1.tag) and 1 or -1, 1)
end

function slot0.refreshFilterBtn(slot0)
	slot1 = slot0.filterMo:isFiltering()

	gohelper.setActive(slot0._gonotfilter, not slot1)
	gohelper.setActive(slot0._gofilter, slot1)
end

function slot0.refreshClear(slot0)
	gohelper.setActive(slot0.goclear, EquipDecomposeListModel.instance:getDecomposeEquipCount() > 0)
end

function slot0.refreshCount(slot0)
	if slot0.preCount == EquipDecomposeListModel.instance:getDecomposeEquipCount() * slot0.decomposeEquipUnitCount then
		return
	end

	slot0.preCount = slot1

	slot0:killTween()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0.preCount, slot1, EquipEnum.DecomposeTxtAnimDuration, slot0.frameCallback, slot0.finishCallback, slot0)

	slot0.txtCountAnimator:Play("vx_count", 0, 0)
end

function slot0.frameCallback(slot0, slot1)
	slot0._txtcount.text = string.format("%s%s", slot0.multipleChar, math.ceil(slot1))
end

function slot0.finishCallback(slot0)
	slot0.tweenId = nil
end

function slot0.refreshDecomposeEquip(slot0)
	slot0._simageequipicon:LoadImage(ResUrl.getEquipIcon(slot0.decomposeEquipConfig.icon .. "_equip"))

	slot0._txtequipname.text = slot0.decomposeEquipConfig.name
end

function slot0.refreshDecomposeBtn(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0.goDecomposeBtn, EquipDecomposeListModel.instance:getSelectCount() < 1)
end

function slot0.onEquipTypeHasChange(slot0, slot1)
	if slot1 ~= slot0.viewName then
		return
	end

	EquipDecomposeListModel.instance:updateEquipData(slot0.filterMo)
	slot0:refreshCenterGroupUI()
	slot0:refreshFilterBtn()
end

function slot0.onEquipDecomposeSelectEquipChange(slot0)
	slot0:refreshBottomGroup()
	slot0:refreshCount()
	slot0:refreshDecomposeBtn()
end

function slot0.onOpenView(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot0:onDecomposeSuccess()
	end
end

function slot0.onDecomposeSuccess(slot0)
	slot0.preCount = 0

	EquipDecomposeListModel.instance:updateEquipData(slot0.filterMo)
	slot0:refreshCenterGroupUI()
	slot0:refreshDecomposeBtn()

	slot0._txtcount.text = string.format("%s0", slot0.multipleChar)
end

function slot0.onEquipDecomposeSortStatusChange(slot0)
	EquipDecomposeListModel.instance:sortEquipList()
	slot0:refreshCenterGroupUI()
	slot0:refreshBtnItem(slot0.rareBtnItem)
	slot0:refreshBtnItem(slot0.lvBtnItem)
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(uv0.DecomposeAnimKey)
	TaskDispatcher.cancelTask(slot0._sendDecomposeRequest, slot0)
	TaskDispatcher.cancelTask(slot0.firstRefreshEquip, slot0)
	slot0:killTween()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageequipicon:UnLoadImage()
	slot0.dropFilter:RemoveOnValueChanged()
	slot0.dropClick:RemoveClickListener()
	slot0.decomposeEquipClick:RemoveClickListener()
end

return slot0
