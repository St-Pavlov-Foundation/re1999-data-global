module("modules.logic.equip.view.decompose.EquipDecomposeView", package.seeall)

local var_0_0 = class("EquipDecomposeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_rarerank")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_lvrank")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_filter")
	arg_1_0._gonotfilter = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_filter/#go_notfilter")
	arg_1_0._gofilter = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_filter/#go_filter")
	arg_1_0._btnfastadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_cost/fast/#btn_fastadd")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "left_container/#go_cost/txt_selected/#txt_num")
	arg_1_0._btnclear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/go_clear/#btn_clear")
	arg_1_0._simageequipicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "right_container/frame/#simage_equipicon")
	arg_1_0._txtequipname = gohelper.findChildText(arg_1_0.viewGO, "right_container/#txt_equipname")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "right_container/#txt_count")
	arg_1_0._btndecompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right_container/#btn_decompose")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_empty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnlvrank:AddClickListener(arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
	arg_2_0._btnfastadd:AddClickListener(arg_2_0._btnfastaddOnClick, arg_2_0)
	arg_2_0._btnclear:AddClickListener(arg_2_0._btnclearOnClick, arg_2_0)
	arg_2_0._btndecompose:AddClickListener(arg_2_0._btndecomposeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnlvrank:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
	arg_3_0._btnfastadd:RemoveClickListener()
	arg_3_0._btnclear:RemoveClickListener()
	arg_3_0._btndecompose:RemoveClickListener()
end

var_0_0.Color = {
	Select = "#DF6931",
	Normal = "#717070"
}

function var_0_0._btnrarerankOnClick(arg_4_0)
	EquipDecomposeListModel.instance:changeRareStatus()
end

function var_0_0._btnlvrankOnClick(arg_5_0)
	EquipDecomposeListModel.instance:changeLevelSortStatus()
end

function var_0_0._btnfilterOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = arg_6_0.viewName
	})
end

function var_0_0._btnfastaddOnClick(arg_7_0)
	EquipDecomposeListModel.instance:fastAddEquip()
end

function var_0_0._btnclearOnClick(arg_8_0)
	EquipDecomposeListModel.instance:clearSelectEquip()
end

var_0_0.DecomposeAnimKey = "DecomposeAnimKey"

function var_0_0._btndecomposeOnClick(arg_9_0)
	if EquipDecomposeListModel.instance:getSelectCount() < 1 then
		return
	end

	arg_9_0.scrollRect.velocity = Vector2.zero

	UIBlockMgr.instance:startBlock(var_0_0.DecomposeAnimKey)
	EquipController.instance:dispatchEvent(EquipEvent.OnEquipBeforeDecompose)
	TaskDispatcher.runDelay(arg_9_0._sendDecomposeRequest, arg_9_0, EquipEnum.DecomposeAnimDuration)
end

function var_0_0._sendDecomposeRequest(arg_10_0)
	UIBlockMgr.instance:endBlock(var_0_0.DecomposeAnimKey)

	if EquipDecomposeListModel.instance:getSelectCount() < 1 then
		return
	end

	EquipRpc.instance:sendEquipDecomposeRequest()
end

function var_0_0.onClickDecomposeEquip(arg_11_0)
	EquipController.instance:openEquipView({
		equipId = EquipConfig.instance.equipDecomposeEquipId
	})
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.multipleChar = luaLang("multiple")
	arg_12_0._txtcount.text = string.format("%s0", arg_12_0.multipleChar)
	arg_12_0.preCount = 0
	arg_12_0.scrollRect = gohelper.findChild(arg_12_0.viewGO, "left_container/#go_scrollcontainer/#scroll_equip"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_12_0.txtCountAnimator = gohelper.findChildComponent(arg_12_0.viewGO, "right_container/vx_count/ani", gohelper.Type_Animator)

	arg_12_0._simagebg:LoadImage(ResUrl.getEquipBg("full/equip_decompose_fullbg.png"))

	arg_12_0.goclear = gohelper.findChild(arg_12_0.viewGO, "left_container/go_clear")
	arg_12_0.goDecomposeBtn = arg_12_0._btndecompose.gameObject
	arg_12_0.rareBtnItem = arg_12_0:createBtnItem(arg_12_0._btnrarerank.gameObject)
	arg_12_0.lvBtnItem = arg_12_0:createBtnItem(arg_12_0._btnlvrank.gameObject)
	arg_12_0.rareBtnItem.tag = EquipDecomposeListModel.SortTag.Rare
	arg_12_0.lvBtnItem.tag = EquipDecomposeListModel.SortTag.Level

	gohelper.setActive(arg_12_0._goempty, false)
	arg_12_0:initFilterDrop()
	gohelper.addUIClickAudio(arg_12_0._btndecompose.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)

	arg_12_0.decomposeEquipClick = gohelper.findChildClickWithDefaultAudio(arg_12_0.viewGO, "right_container/frame/#simage_equipicon")

	arg_12_0.decomposeEquipClick:AddClickListener(arg_12_0.onClickDecomposeEquip, arg_12_0)
	arg_12_0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, arg_12_0.onEquipTypeHasChange, arg_12_0)
	arg_12_0:addEventCb(EquipController.instance, EquipEvent.OnEquipDecomposeSelectEquipChange, arg_12_0.onEquipDecomposeSelectEquipChange, arg_12_0)
	arg_12_0:addEventCb(EquipController.instance, EquipEvent.OnEquipDecomposeSortStatusChange, arg_12_0.onEquipDecomposeSortStatusChange, arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_12_0.onOpenView, arg_12_0)
end

function var_0_0.createBtnItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.go = arg_13_1
	var_13_0.goSelect = gohelper.findChild(var_13_0.go, "select")
	var_13_0.txtGraphic = gohelper.findChildComponent(var_13_0.go, "normal/txt", gohelper.Type_Graphic)
	var_13_0.arrowGraphic = gohelper.findChildComponent(var_13_0.go, "normal/txt/arrow", gohelper.Type_Graphic)
	var_13_0.arrowTr = gohelper.findChildComponent(var_13_0.go, "normal/txt/arrow", gohelper.Type_Transform)

	return var_13_0
end

function var_0_0.initFilterDrop(arg_14_0)
	arg_14_0.dropFilter = gohelper.findChildDropdown(arg_14_0.viewGO, "left_container/#go_cost/#drop_filter")
	arg_14_0._goDrop = arg_14_0.dropFilter.gameObject
	arg_14_0.dropArrowTr = gohelper.findChildComponent(arg_14_0._goDrop, "Arrow", gohelper.Type_Transform)
	arg_14_0.dropClick = gohelper.getClick(arg_14_0._goDrop)
	arg_14_0.dropExtend = DropDownExtend.Get(arg_14_0._goDrop)

	arg_14_0.dropExtend:init(arg_14_0.onDropShow, arg_14_0.onDropHide, arg_14_0)

	arg_14_0.filterRareList = {}

	for iter_14_0 = EquipEnum.EquipDecomposeMinRare, EquipEnum.EquipDecomposeMaxRare do
		table.insert(arg_14_0.filterRareList, iter_14_0)
	end

	local var_14_0 = {}

	for iter_14_1, iter_14_2 in ipairs(arg_14_0.filterRareList) do
		if iter_14_2 == 0 then
			table.insert(var_14_0, luaLang("equip_filter_all"))
		else
			table.insert(var_14_0, string.format(luaLang("equip_filter_str"), iter_14_2 + 1))
		end
	end

	arg_14_0.dropFilter:ClearOptions()
	arg_14_0.dropFilter:AddOptions(var_14_0)
	arg_14_0.dropFilter:AddOnValueChanged(arg_14_0.onDropValueChanged, arg_14_0)
	arg_14_0.dropClick:AddClickListener(function()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, arg_14_0)
	EquipDecomposeListModel.instance:setFilterRare(arg_14_0.filterRareList[1])

	arg_14_0.initDropDone = true
end

function var_0_0.onDropValueChanged(arg_16_0, arg_16_1)
	if not arg_16_0.initDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	EquipDecomposeListModel.instance:setFilterRare(arg_16_0.filterRareList[arg_16_1 + 1])
end

function var_0_0.onDropHide(arg_17_0)
	transformhelper.setLocalScale(arg_17_0.dropArrowTr, 1, 1, 1)
end

function var_0_0.onDropShow(arg_18_0)
	transformhelper.setLocalScale(arg_18_0.dropArrowTr, 1, -1, 1)
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0.decomposeEquipConfig = EquipConfig.instance:getEquipCo(EquipConfig.instance.equipDecomposeEquipId)
	arg_19_0.decomposeEquipUnitCount = EquipConfig.instance.equipDecomposeEquipUnitCount
	arg_19_0.filterMo = EquipFilterModel.instance:generateFilterMo(arg_19_0.viewName)

	EquipDecomposeListModel.instance:initEquipData()
	arg_19_0:refreshUI()
	TaskDispatcher.runDelay(arg_19_0.firstRefreshEquip, arg_19_0, EquipEnum.EquipEnterAnimWaitTime)
end

function var_0_0.firstRefreshEquip(arg_20_0)
	arg_20_0.viewContainer._views[2]._animationStartTime = Time.time

	arg_20_0:refreshCenterGroupUI()
end

function var_0_0.refreshUI(arg_21_0)
	arg_21_0:refreshLeft()
	arg_21_0:refreshRight()
end

function var_0_0.refreshLeft(arg_22_0)
	arg_22_0:refreshTopGroupUI()
	arg_22_0:refreshBottomGroup()
end

function var_0_0.refreshRight(arg_23_0)
	arg_23_0:refreshDecomposeEquip()
	arg_23_0:refreshCount()
	arg_23_0:refreshDecomposeBtn()
end

function var_0_0.refreshTopGroupUI(arg_24_0)
	arg_24_0:refreshBtnItem(arg_24_0.rareBtnItem)
	arg_24_0:refreshBtnItem(arg_24_0.lvBtnItem)
	arg_24_0:refreshFilterBtn()
end

function var_0_0.refreshCenterGroupUI(arg_25_0)
	EquipDecomposeListModel.instance:refreshEquip()
	gohelper.setActive(arg_25_0._goempty, EquipDecomposeListModel.instance:isEmpty())
end

function var_0_0.refreshBottomGroup(arg_26_0)
	local var_26_0 = EquipDecomposeListModel.instance:getSelectCount()

	arg_26_0._txtnum.text = string.format("<color=#ff7933>%s</color>/%s", var_26_0, EquipEnum.DecomposeMaxCount)

	arg_26_0:refreshClear()
end

function var_0_0.refreshBtnItem(arg_27_0, arg_27_1)
	local var_27_0 = EquipDecomposeListModel.instance:getSortTag() == arg_27_1.tag
	local var_27_1 = EquipDecomposeListModel.instance:getSortIsAscend(arg_27_1.tag)

	gohelper.setActive(arg_27_1.goSelect, var_27_0)
	SLFramework.UGUI.GuiHelper.SetColor(arg_27_1.txtGraphic, var_27_0 and var_0_0.Color.Select or var_0_0.Color.Normal)
	SLFramework.UGUI.GuiHelper.SetColor(arg_27_1.arrowGraphic, var_27_0 and var_0_0.Color.Select or var_0_0.Color.Normal)
	transformhelper.setLocalScale(arg_27_1.arrowTr, 1, var_27_1 and 1 or -1, 1)
end

function var_0_0.refreshFilterBtn(arg_28_0)
	local var_28_0 = arg_28_0.filterMo:isFiltering()

	gohelper.setActive(arg_28_0._gonotfilter, not var_28_0)
	gohelper.setActive(arg_28_0._gofilter, var_28_0)
end

function var_0_0.refreshClear(arg_29_0)
	gohelper.setActive(arg_29_0.goclear, EquipDecomposeListModel.instance:getDecomposeEquipCount() > 0)
end

function var_0_0.refreshCount(arg_30_0)
	local var_30_0 = EquipDecomposeListModel.instance:getDecomposeEquipCount() * arg_30_0.decomposeEquipUnitCount

	if arg_30_0.preCount == var_30_0 then
		return
	end

	arg_30_0.preCount = var_30_0

	arg_30_0:killTween()

	arg_30_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_30_0.preCount, var_30_0, EquipEnum.DecomposeTxtAnimDuration, arg_30_0.frameCallback, arg_30_0.finishCallback, arg_30_0)

	arg_30_0.txtCountAnimator:Play("vx_count", 0, 0)
end

function var_0_0.frameCallback(arg_31_0, arg_31_1)
	arg_31_0._txtcount.text = string.format("%s%s", arg_31_0.multipleChar, math.ceil(arg_31_1))
end

function var_0_0.finishCallback(arg_32_0)
	arg_32_0.tweenId = nil
end

function var_0_0.refreshDecomposeEquip(arg_33_0)
	arg_33_0._simageequipicon:LoadImage(ResUrl.getEquipIcon(arg_33_0.decomposeEquipConfig.icon .. "_equip"))

	arg_33_0._txtequipname.text = arg_33_0.decomposeEquipConfig.name
end

function var_0_0.refreshDecomposeBtn(arg_34_0)
	local var_34_0 = EquipDecomposeListModel.instance:getSelectCount()

	ZProj.UGUIHelper.SetGrayscale(arg_34_0.goDecomposeBtn, var_34_0 < 1)
end

function var_0_0.onEquipTypeHasChange(arg_35_0, arg_35_1)
	if arg_35_1 ~= arg_35_0.viewName then
		return
	end

	EquipDecomposeListModel.instance:updateEquipData(arg_35_0.filterMo)
	arg_35_0:refreshCenterGroupUI()
	arg_35_0:refreshFilterBtn()
end

function var_0_0.onEquipDecomposeSelectEquipChange(arg_36_0)
	arg_36_0:refreshBottomGroup()
	arg_36_0:refreshCount()
	arg_36_0:refreshDecomposeBtn()
end

function var_0_0.onOpenView(arg_37_0, arg_37_1)
	if arg_37_1 == ViewName.CommonPropView then
		arg_37_0:onDecomposeSuccess()
	end
end

function var_0_0.onDecomposeSuccess(arg_38_0)
	arg_38_0.preCount = 0

	EquipDecomposeListModel.instance:updateEquipData(arg_38_0.filterMo)
	arg_38_0:refreshCenterGroupUI()
	arg_38_0:refreshDecomposeBtn()

	arg_38_0._txtcount.text = string.format("%s0", arg_38_0.multipleChar)
end

function var_0_0.onEquipDecomposeSortStatusChange(arg_39_0)
	EquipDecomposeListModel.instance:sortEquipList()
	arg_39_0:refreshCenterGroupUI()
	arg_39_0:refreshBtnItem(arg_39_0.rareBtnItem)
	arg_39_0:refreshBtnItem(arg_39_0.lvBtnItem)
end

function var_0_0.killTween(arg_40_0)
	if arg_40_0.tweenId then
		ZProj.TweenHelper.KillById(arg_40_0.tweenId)

		arg_40_0.tweenId = nil
	end
end

function var_0_0.onClose(arg_41_0)
	UIBlockMgr.instance:endBlock(var_0_0.DecomposeAnimKey)
	TaskDispatcher.cancelTask(arg_41_0._sendDecomposeRequest, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0.firstRefreshEquip, arg_41_0)
	arg_41_0:killTween()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
end

function var_0_0.onDestroyView(arg_42_0)
	arg_42_0._simagebg:UnLoadImage()
	arg_42_0._simageequipicon:UnLoadImage()
	arg_42_0.dropFilter:RemoveOnValueChanged()
	arg_42_0.dropClick:RemoveClickListener()
	arg_42_0.decomposeEquipClick:RemoveClickListener()
end

return var_0_0
