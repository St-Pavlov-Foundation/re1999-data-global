module("modules.logic.room.view.backpack.RoomCritterDecomposeView", package.seeall)

local var_0_0 = class("RoomCritterDecomposeView", BaseView)
local var_0_1 = "DecomposeAnimKey"
local var_0_2 = 0.2
local var_0_3 = 0.5
local var_0_4 = 0.9

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncirtterRare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_critterSort/#btn_cirtterRare")
	arg_1_0._dropmaturefilter = gohelper.findChildDropdown(arg_1_0.viewGO, "left_container/#go_critterSort/#drop_mature")
	arg_1_0._transmatureDroparrow = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_critterSort/#drop_mature/#go_arrow").transform
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_critterSort/#btn_filter")
	arg_1_0._gonotfilter = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_critterSort/#btn_filter/#go_notfilter")
	arg_1_0._gofilter = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_critterSort/#btn_filter/#go_filter")
	arg_1_0._dropRareFilter = gohelper.findChildDropdown(arg_1_0.viewGO, "left_container/#go_cost/#drop_filter")
	arg_1_0._btnfastadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_cost/fast/#btn_fastadd")
	arg_1_0._txtselectNum = gohelper.findChildText(arg_1_0.viewGO, "left_container/#go_cost/txt_selected/#txt_num")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_empty")
	arg_1_0._btnclear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/go_clear/#btn_clear")
	arg_1_0._simageresultItemIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "right_container/frame/#simage_resultIcon")
	arg_1_0._txtresultItemName = gohelper.findChildText(arg_1_0.viewGO, "right_container/#txt_resultName")
	arg_1_0._txtResultCount = gohelper.findChildText(arg_1_0.viewGO, "right_container/#txt_count")
	arg_1_0._btndecompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right_container/#btn_decompose")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncirtterRare:AddClickListener(arg_2_0._btncirtterRareOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
	arg_2_0._btnfastadd:AddClickListener(arg_2_0._btnfastaddOnClick, arg_2_0)
	arg_2_0._btnclear:AddClickListener(arg_2_0._btnclearOnClick, arg_2_0)
	arg_2_0._btndecompose:AddClickListener(arg_2_0._btndecomposeOnClick, arg_2_0)
	arg_2_0._dropmaturefilter:AddOnValueChanged(arg_2_0.onMatureDropValueChange, arg_2_0)
	arg_2_0._dropRareFilter:AddOnValueChanged(arg_2_0.onRareDropValueChange, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, arg_2_0.onCritterFilterTypeChange, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, arg_2_0.onCritterDecomposeSelectChange, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterChangeSort, arg_2_0.onCritterSortChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0.onOpenView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncirtterRare:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
	arg_3_0._btnfastadd:RemoveClickListener()
	arg_3_0._btnclear:RemoveClickListener()
	arg_3_0._btndecompose:RemoveClickListener()
	arg_3_0._dropmaturefilter:RemoveOnValueChanged()
	arg_3_0._dropRareFilter:RemoveOnValueChanged()
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, arg_3_0.onCritterFilterTypeChange, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, arg_3_0.onCritterDecomposeSelectChange, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeSort, arg_3_0.onCritterSortChange, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_3_0.onOpenView, arg_3_0)
end

function var_0_0._btncirtterRareOnClick(arg_4_0)
	local var_4_0 = RoomCritterDecomposeListModel.instance:getIsSortByRareAscend()

	RoomCritterDecomposeListModel.instance:setIsSortByRareAscend(not var_4_0)
end

function var_0_0._btnfilterOnClick(arg_5_0)
	local var_5_0 = {
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}

	CritterController.instance:openCritterFilterView(var_5_0, arg_5_0.viewName)
end

function var_0_0._btnfastaddOnClick(arg_6_0)
	RoomCritterDecomposeListModel.instance:fastAddCritter()
end

function var_0_0._btnclearOnClick(arg_7_0)
	RoomCritterDecomposeListModel.instance:clearSelectedCritter()
end

function var_0_0._btndecomposeOnClick(arg_8_0)
	if RoomCritterDecomposeListModel.instance:getSelectCount() <= 0 then
		return
	end

	if not RoomCritterDecomposeListModel.instance:checkDecomposeCountLimit() then
		GameFacade.showToast(ToastEnum.CritterDecomposeLimitCount)

		return
	end

	arg_8_0.scrollRect.velocity = Vector2.zero

	UIBlockMgr.instance:startBlock(var_0_1)
	CritterController.instance:dispatchEvent(CritterEvent.BeforeDecomposeCritter)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_gplay_uihuan)
	TaskDispatcher.runDelay(arg_8_0._sendCritterDecomposeRequest, arg_8_0, var_0_4)
end

function var_0_0._sendCritterDecomposeRequest(arg_9_0)
	UIBlockMgr.instance:endBlock(var_0_1)

	if RoomCritterDecomposeListModel.instance:getSelectCount() <= 0 then
		return
	end

	local var_9_0 = RoomCritterDecomposeListModel.instance:getSelectUIds()

	CritterRpc.instance:sendBanishCritterRequest(var_9_0)
end

function var_0_0.onMatureDropShow(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	transformhelper.setLocalScale(arg_10_0._transmatureDroparrow, 1, 1, 1)
end

function var_0_0.onMatureDropValueChange(arg_11_0, arg_11_1)
	if not arg_11_0.initMatureDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)

	local var_11_0 = arg_11_0.filterMatureTypeList and arg_11_0.filterMatureTypeList[arg_11_1 + 1]
	local var_11_1 = RoomCritterDecomposeListModel.instance:getFilterMature()

	if var_11_1 and var_11_1 == var_11_0 then
		return
	end

	RoomCritterDecomposeListModel.instance:setFilterMature(var_11_0)
	RoomCritterDecomposeListModel.instance:updateCritterList(arg_11_0.filterMO)
	arg_11_0:refreshCritterList()
end

function var_0_0.onMatureDropHide(arg_12_0)
	transformhelper.setLocalScale(arg_12_0._transmatureDroparrow, 1, -1, 1)
end

function var_0_0.onRareDropShow(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	transformhelper.setLocalScale(arg_13_0._transRareDropArrow, 1, -1, 1)
end

function var_0_0.onRareDropValueChange(arg_14_0, arg_14_1)
	if not arg_14_0.initRareDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	RoomCritterDecomposeListModel.instance:setFilterRare(arg_14_0.filterRareList[arg_14_1 + 1])
end

function var_0_0.onRareDropHide(arg_15_0)
	transformhelper.setLocalScale(arg_15_0._transRareDropArrow, 1, 1, 1)
end

function var_0_0.onCritterFilterTypeChange(arg_16_0, arg_16_1)
	if arg_16_1 ~= arg_16_0.viewName then
		return
	end

	RoomCritterDecomposeListModel.instance:updateCritterList(arg_16_0.filterMO)
	arg_16_0:refreshCritterList()
	arg_16_0:refreshFilterBtn()
end

function var_0_0.onCritterDecomposeSelectChange(arg_17_0)
	arg_17_0:refreshSelectNum()
	arg_17_0:refreshResultCount()
	arg_17_0:refreshDecomposeBtn()
end

function var_0_0.onCritterSortChange(arg_18_0)
	RoomCritterDecomposeListModel.instance:sortCritterList()
	arg_18_0:refreshCritterList()
	arg_18_0:refreshBtnItem(arg_18_0.rareBtnItem)
end

function var_0_0.onOpenView(arg_19_0, arg_19_1)
	if arg_19_1 ~= ViewName.CommonPropView then
		return
	end

	arg_19_0:clearPerCount()
	RoomCritterDecomposeListModel.instance:updateCritterList(arg_19_0.filterMO)
	arg_19_0:refreshCritterList()
	arg_19_0:refreshDecomposeBtn()
end

function var_0_0._editableInitView(arg_20_0)
	arg_20_0._goRareDrop = arg_20_0._dropRareFilter.gameObject
	arg_20_0._transRareDropArrow = gohelper.findChildComponent(arg_20_0._goRareDrop, "Arrow", gohelper.Type_Transform)
	arg_20_0.scrollRect = gohelper.findChild(arg_20_0.viewGO, "left_container/#go_scrollcontainer/#scroll_critter"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_20_0.goclear = gohelper.findChild(arg_20_0.viewGO, "left_container/go_clear")
	arg_20_0.txtCountAnimator = gohelper.findChildComponent(arg_20_0.viewGO, "right_container/vx_count/ani", gohelper.Type_Animator)
	arg_20_0.goDecomposeBtn = arg_20_0._btndecompose.gameObject
	arg_20_0.rareBtnItem = arg_20_0:createSortBtnItem(arg_20_0._btncirtterRare.gameObject)

	arg_20_0:initMatureDropFilter()
	arg_20_0:initRareFilterDrop()

	arg_20_0.multipleChar = luaLang("multiple")

	arg_20_0:clearVar()

	arg_20_0.filterMO = CritterFilterModel.instance:generateFilterMO(arg_20_0.viewName)

	RoomCritterDecomposeListModel.instance:updateCritterList(arg_20_0.filterMO)
end

function var_0_0.createSortBtnItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getUserDataTb_()

	var_21_0.go = arg_21_1
	var_21_0.goNormal = gohelper.findChild(var_21_0.go, "normal")
	var_21_0.goSelected = gohelper.findChild(var_21_0.go, "selected")
	var_21_0.arrowTr = gohelper.findChildComponent(var_21_0.go, "selected/txt/arrow", gohelper.Type_Transform)

	gohelper.setActive(var_21_0.goNormal, false)
	gohelper.setActive(var_21_0.goSelected, true)

	return var_21_0
end

function var_0_0.initMatureDropFilter(arg_22_0)
	arg_22_0.dropMatureExtend = DropDownExtend.Get(arg_22_0._dropmaturefilter.gameObject)

	arg_22_0.dropMatureExtend:init(arg_22_0.onMatureDropShow, arg_22_0.onMatureDropHide, arg_22_0)

	arg_22_0.filterMatureTypeList = {
		CritterEnum.MatureFilterType.All,
		CritterEnum.MatureFilterType.Mature,
		CritterEnum.MatureFilterType.NotMature
	}

	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.filterMatureTypeList) do
		local var_22_1 = CritterEnum.MatureFilterTypeName[iter_22_1]
		local var_22_2 = luaLang(var_22_1)

		table.insert(var_22_0, var_22_2)
	end

	arg_22_0._dropmaturefilter:ClearOptions()
	arg_22_0._dropmaturefilter:AddOptions(var_22_0)

	arg_22_0.initMatureDropDone = true
end

function var_0_0.initRareFilterDrop(arg_23_0)
	arg_23_0.dropRareExtend = DropDownExtend.Get(arg_23_0._goRareDrop)

	arg_23_0.dropRareExtend:init(arg_23_0.onRareDropShow, arg_23_0.onRareDropHide, arg_23_0)

	local var_23_0 = {}

	arg_23_0.filterRareList = {}

	for iter_23_0 = CritterEnum.CritterDecomposeMinRare, CritterEnum.CritterDecomposeMaxRare do
		table.insert(arg_23_0.filterRareList, iter_23_0)

		local var_23_1 = GameUtil.getSubPlaceholderLuaLang(luaLang("critter_rare_filter"), {
			iter_23_0 + 1
		})

		table.insert(var_23_0, var_23_1)
	end

	arg_23_0._dropRareFilter:ClearOptions()
	arg_23_0._dropRareFilter:AddOptions(var_23_0)

	arg_23_0.initRareDropDone = true
end

function var_0_0.onUpdateParam(arg_24_0)
	return
end

function var_0_0.onOpen(arg_25_0)
	arg_25_0:setResultIcon()
	arg_25_0:refresh()
	gohelper.setActive(arg_25_0._goempty, false)
	TaskDispatcher.runDelay(arg_25_0.initCritterList, arg_25_0, var_0_2)
end

function var_0_0.setResultIcon(arg_26_0)
	local var_26_0
	local var_26_1 = ""
	local var_26_2 = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.DecomposeResult)
	local var_26_3 = string.splitToNumber(var_26_2, "#")

	if var_26_3 then
		local var_26_4, var_26_5 = ItemModel.instance:getItemConfigAndIcon(var_26_3[1], var_26_3[2])

		var_26_1 = var_26_4.name
		var_26_0 = var_26_5
	end

	if not string.nilorempty(var_26_0) then
		arg_26_0._simageresultItemIcon:LoadImage(var_26_0)
	end

	arg_26_0._txtresultItemName.text = var_26_1
end

function var_0_0.initCritterList(arg_27_0)
	arg_27_0.viewContainer._views[2]._animationStartTime = Time.time

	arg_27_0:refreshCritterList()
end

function var_0_0.refreshCritterList(arg_28_0)
	RoomCritterDecomposeListModel.instance:refreshCritterShowList()

	local var_28_0 = RoomCritterDecomposeListModel.instance:isEmpty()

	gohelper.setActive(arg_28_0._goempty, var_28_0)
end

function var_0_0.refresh(arg_29_0)
	arg_29_0:refreshTop()
	arg_29_0:refreshSelectNum()
	arg_29_0:refreshResultCount()
	arg_29_0:refreshDecomposeBtn()
end

function var_0_0.refreshTop(arg_30_0)
	arg_30_0:refreshBtnItem(arg_30_0.rareBtnItem)
	arg_30_0:refreshFilterBtn()
end

function var_0_0.refreshBtnItem(arg_31_0, arg_31_1)
	local var_31_0 = RoomCritterDecomposeListModel.instance:getIsSortByRareAscend() and 1 or -1

	transformhelper.setLocalScale(arg_31_1.arrowTr, 1, var_31_0, 1)
end

function var_0_0.refreshFilterBtn(arg_32_0)
	local var_32_0 = arg_32_0.filterMO:isFiltering()

	gohelper.setActive(arg_32_0._gonotfilter, not var_32_0)
	gohelper.setActive(arg_32_0._gofilter, var_32_0)
end

function var_0_0.refreshSelectNum(arg_33_0)
	local var_33_0 = RoomCritterDecomposeListModel.instance:getSelectCount()

	arg_33_0._txtselectNum.text = string.format("<color=#ff7933>%s</color>/%s", var_33_0, CritterEnum.DecomposeMaxCount)

	gohelper.setActive(arg_33_0.goclear, var_33_0 > 0)
end

function var_0_0.refreshResultCount(arg_34_0)
	local var_34_0 = RoomCritterDecomposeListModel.instance:getDecomposeCritterCount()

	if arg_34_0.preCount == var_34_0 then
		return
	end

	arg_34_0.preCount = var_34_0

	arg_34_0:killTween()

	arg_34_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_34_0.preCount, var_34_0, var_0_3, arg_34_0.frameCallback, arg_34_0.finishCallback, arg_34_0)

	arg_34_0.txtCountAnimator:Play("vx_count", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_gplay_uihuan2)
end

function var_0_0.frameCallback(arg_35_0, arg_35_1)
	arg_35_0:setTxtResultCount(math.ceil(arg_35_1))
end

function var_0_0.setTxtResultCount(arg_36_0, arg_36_1)
	arg_36_0._txtResultCount.text = string.format("%s%s", arg_36_0.multipleChar, arg_36_1)
end

function var_0_0.finishCallback(arg_37_0)
	arg_37_0.tweenId = nil
end

function var_0_0.refreshDecomposeBtn(arg_38_0)
	local var_38_0 = RoomCritterDecomposeListModel.instance:getSelectCount()

	ZProj.UGUIHelper.SetGrayscale(arg_38_0.goDecomposeBtn, var_38_0 < 1)
end

function var_0_0.killTween(arg_39_0)
	if arg_39_0.tweenId then
		ZProj.TweenHelper.KillById(arg_39_0.tweenId)

		arg_39_0.tweenId = nil
	end
end

function var_0_0.clearVar(arg_40_0)
	arg_40_0:clearPerCount()
	arg_40_0:killTween()
end

function var_0_0.clearPerCount(arg_41_0)
	arg_41_0.preCount = 0

	arg_41_0:setTxtResultCount(arg_41_0.preCount)
end

function var_0_0.onClose(arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0.initCritterList, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._sendCritterDecomposeRequest, arg_42_0)
	UIBlockMgr.instance:endBlock(var_0_1)
	arg_42_0:clearVar()
end

function var_0_0.onDestroyView(arg_43_0)
	arg_43_0._simageresultItemIcon:UnLoadImage()

	if arg_43_0.dropMatureExtend then
		arg_43_0.dropMatureExtend:dispose()
	end

	if arg_43_0.dropRareExtend then
		arg_43_0.dropRareExtend:dispose()
	end
end

return var_0_0
