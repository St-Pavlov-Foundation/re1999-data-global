module("modules.logic.handbook.view.HandbookEquipView", package.seeall)

local var_0_0 = class("HandbookEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goequip1 = gohelper.findChild(arg_1_0.viewGO, "equipContain/#go_equip1")
	arg_1_0._goequip2 = gohelper.findChild(arg_1_0.viewGO, "equipContain/#go_equip2")
	arg_1_0._goequip3 = gohelper.findChild(arg_1_0.viewGO, "equipContain/#go_equip3")
	arg_1_0._goequip4 = gohelper.findChild(arg_1_0.viewGO, "equipContain/#go_equip4")
	arg_1_0._goleftpage = gohelper.findChild(arg_1_0.viewGO, "#btn_leftpage")
	arg_1_0._goleftarrow = gohelper.findChild(arg_1_0.viewGO, "#btn_leftpage/#go_leftarrow")
	arg_1_0._gorightpage = gohelper.findChild(arg_1_0.viewGO, "#btn_rightpage")
	arg_1_0._gorightarrow = gohelper.findChild(arg_1_0.viewGO, "#btn_rightpage/#go_rightarrow")
	arg_1_0._gorarerank = gohelper.findChild(arg_1_0.viewGO, "sortbtn/#btn_rarerank")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "sortbtn/#btn_filter")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0.onClickBtnFilter, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfilter:RemoveClickListener()
end

var_0_0.everyPageShowCount = 4
var_0_0.DragAbsPositionX = 50
var_0_0.AnimatorBlockName = "HandbookEquipViewAnimator"

function var_0_0.onClickBtnFilter(arg_4_0)
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		viewName = arg_4_0.viewName
	})
end

function var_0_0.leftPageOnClick(arg_5_0)
	if arg_5_0.currentPage <= 1 then
		return
	end

	UIBlockMgr.instance:startBlock(var_0_0.AnimatorBlockName)
	arg_5_0.animatorPlayer:Play("rightout", function(arg_6_0)
		arg_6_0:refreshPage(arg_6_0.currentPage - 1)
		arg_6_0.animatorPlayer:Play("rightin")
		UIBlockMgr.instance:endBlock(var_0_0.AnimatorBlockName)
	end, arg_5_0)
end

function var_0_0.rightPageOnClick(arg_7_0)
	if arg_7_0.currentPage >= arg_7_0.maxPage then
		return
	end

	UIBlockMgr.instance:startBlock(var_0_0.AnimatorBlockName)
	arg_7_0.animatorPlayer:Play("leftout", function(arg_8_0)
		arg_8_0:refreshPage(arg_8_0.currentPage + 1)
		arg_8_0.animatorPlayer:Play("leftin")
		UIBlockMgr.instance:endBlock(var_0_0.AnimatorBlockName)
	end, arg_7_0)
end

function var_0_0.rareRankOnClick(arg_9_0)
	arg_9_0.rareRankAscending = not arg_9_0.rareRankAscending

	arg_9_0:refreshSort()
	arg_9_0:refreshUI()
end

function var_0_0.onEquipItemClick(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.equipList[(arg_10_0.currentPage - 1) * var_0_0.everyPageShowCount + arg_10_1]

	EquipController.instance:openEquipView({
		fromHandBook = true,
		equipId = var_10_0.id
	})
end

function var_0_0.customAddEvent(arg_11_0)
	arg_11_0._leftPageClick = gohelper.findChildClickWithAudio(arg_11_0._goleftarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)
	arg_11_0._rightPageClick = gohelper.findChildClickWithAudio(arg_11_0._gorightarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)

	arg_11_0._leftPageClick:AddClickListener(arg_11_0.leftPageOnClick, arg_11_0)
	arg_11_0._rightPageClick:AddClickListener(arg_11_0.rightPageOnClick, arg_11_0)

	arg_11_0._rareRankClick = gohelper.getClickWithAudio(arg_11_0._gorarerank, AudioEnum.UI.play_ui_hero_card_click)

	arg_11_0._rareRankClick:AddClickListener(arg_11_0.rareRankOnClick, arg_11_0)

	arg_11_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_11_0.viewGO)

	arg_11_0._drag:AddDragBeginListener(arg_11_0.onDragBeginHandle, arg_11_0)
	arg_11_0._drag:AddDragEndListener(arg_11_0.onDragEndHandle, arg_11_0)
	arg_11_0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, arg_11_0.onFilterValueChange, arg_11_0)
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.simageList = arg_12_0:getUserDataTb_()
	arg_12_0.txtNameList = arg_12_0:getUserDataTb_()
	arg_12_0.txtNameEnList = arg_12_0:getUserDataTb_()
	arg_12_0.goRareList = arg_12_0:getUserDataTb_()
	arg_12_0.goEquipList = arg_12_0:getUserDataTb_()
	arg_12_0.equipClickList = arg_12_0:getUserDataTb_()

	arg_12_0:addItem(arg_12_0._goequip1, 1)
	arg_12_0:addItem(arg_12_0._goequip2, 2)
	arg_12_0:addItem(arg_12_0._goequip3, 3)
	arg_12_0:addItem(arg_12_0._goequip4, 4)

	arg_12_0.goRareRankIcon1 = gohelper.findChild(arg_12_0.viewGO, "sortbtn/#btn_rarerank/txt/go_icon1")
	arg_12_0.goRareRankIcon2 = gohelper.findChild(arg_12_0.viewGO, "sortbtn/#btn_rarerank/txt/go_icon2")
	arg_12_0.goNotFilter = gohelper.findChild(arg_12_0.viewGO, "sortbtn/#btn_filter/#go_notfilter")
	arg_12_0.goFilter = gohelper.findChild(arg_12_0.viewGO, "sortbtn/#btn_filter/#go_filter")
	arg_12_0.currentPage = 0
	arg_12_0.maxPage = 0
	arg_12_0.equipList = nil
	arg_12_0.startDragPosX = 0
	arg_12_0.rareRankAscending = false

	arg_12_0:customAddEvent()
	arg_12_0._simagebg:LoadImage(ResUrl.getHandbookCharacterIcon("full/bg111"))

	arg_12_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_12_0.viewGO)
end

function var_0_0.onCareerClick(arg_13_0, arg_13_1)
	if arg_13_0.career == arg_13_1.career then
		return
	end

	arg_13_0.career = arg_13_1.career

	arg_13_0:refreshUI()
end

function var_0_0.addItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = gohelper.findChildSingleImage(arg_14_1, "simage_equipicon")
	local var_14_1 = gohelper.findChildText(arg_14_1, "txt_name")
	local var_14_2 = gohelper.findChildText(arg_14_1, "txt_name/txt_nameEn")
	local var_14_3 = arg_14_0:getUserDataTb_()

	for iter_14_0 = 3, 6 do
		local var_14_4 = gohelper.findChild(arg_14_1, "txt_name/rare/rare" .. iter_14_0)

		table.insert(var_14_3, var_14_4)
	end

	table.insert(arg_14_0.simageList, var_14_0)
	table.insert(arg_14_0.txtNameList, var_14_1)
	table.insert(arg_14_0.txtNameEnList, var_14_2)
	table.insert(arg_14_0.goRareList, var_14_3)
	table.insert(arg_14_0.goEquipList, arg_14_1)

	local var_14_5 = gohelper.getClick(arg_14_1)

	var_14_5:AddClickListener(arg_14_0.onEquipItemClick, arg_14_0, arg_14_2)
	table.insert(arg_14_0.equipClickList, var_14_5)
end

function var_0_0.onFilterValueChange(arg_15_0, arg_15_1)
	if arg_15_1 ~= arg_15_0.viewName then
		return
	end

	arg_15_0:refreshEquipData()
	arg_15_0:refreshSort()
	arg_15_0:refreshUI()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0.filterMo = EquipFilterModel.instance:generateFilterMo(arg_16_0.viewName)

	arg_16_0:refreshEquipData()
	arg_16_0:refreshSort()
	arg_16_0:refreshUI()
end

function var_0_0.refreshEquipData(arg_17_0)
	arg_17_0.equipList = arg_17_0:getEquips()
	arg_17_0.maxPage = arg_17_0:getMaxPageNum()
end

function var_0_0.refreshSort(arg_18_0)
	if arg_18_0.rareRankAscending then
		table.sort(arg_18_0.equipList, arg_18_0.rareAscendingSortFunc)
	else
		table.sort(arg_18_0.equipList, arg_18_0.rareDescendingSortFunc)
	end
end

function var_0_0.refreshUI(arg_19_0)
	arg_19_0:refreshBtnStatus()
	arg_19_0:refreshPage(1)
end

function var_0_0.refreshBtnStatus(arg_20_0)
	gohelper.setActive(arg_20_0.goRareRankIcon1, arg_20_0.rareRankAscending)
	gohelper.setActive(arg_20_0.goRareRankIcon2, not arg_20_0.rareRankAscending)
	arg_20_0:refreshFilterBtnStatus()
end

function var_0_0.refreshFilterBtnStatus(arg_21_0)
	local var_21_0 = arg_21_0.filterMo:isFiltering()

	gohelper.setActive(arg_21_0.goFilter, var_21_0)
	gohelper.setActive(arg_21_0.goNotFilter, not var_21_0)
end

function var_0_0.refreshPage(arg_22_0, arg_22_1)
	arg_22_0.currentPage = arg_22_1

	local var_22_0 = (arg_22_1 - 1) * var_0_0.everyPageShowCount

	for iter_22_0 = 1, var_0_0.everyPageShowCount do
		arg_22_0:handleItem(iter_22_0, arg_22_0.equipList[var_22_0 + iter_22_0])
	end

	gohelper.setActive(arg_22_0._goleftarrow, arg_22_0.currentPage > 1)
	gohelper.setActive(arg_22_0._gorightarrow, arg_22_0.currentPage < arg_22_0.maxPage)
end

function var_0_0.rareAscendingSortFunc(arg_23_0, arg_23_1)
	if arg_23_0.rare ~= arg_23_1.rare then
		return arg_23_0.rare < arg_23_1.rare
	end

	return arg_23_0.id < arg_23_1.id
end

function var_0_0.rareDescendingSortFunc(arg_24_0, arg_24_1)
	if arg_24_0.rare ~= arg_24_1.rare then
		return arg_24_0.rare > arg_24_1.rare
	end

	return arg_24_0.id < arg_24_1.id
end

function var_0_0.getEquips(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(lua_handbook_equip.configList) do
		local var_25_1 = EquipConfig.instance:getEquipCo(iter_25_1.equipId)

		if arg_25_0:checkNeedEquipCo(var_25_1) then
			table.insert(var_25_0, var_25_1)
		end
	end

	return var_25_0
end

function var_0_0.getMaxPageNum(arg_26_0)
	return math.ceil(#arg_26_0.equipList / var_0_0.everyPageShowCount)
end

function var_0_0.checkNeedEquipCo(arg_27_0, arg_27_1)
	if not arg_27_1 then
		return false
	end

	if not arg_27_0.filterMo:isFiltering() then
		return true
	end

	if not arg_27_0.filterMo:checkIsIncludeTag(arg_27_1) then
		return false
	end

	local var_27_0 = arg_27_0.filterMo:getObtainType()

	if var_27_0 == EquipFilterModel.ObtainEnum.All then
		return true
	end

	if var_27_0 == EquipFilterModel.ObtainEnum.Get then
		return HandbookModel.instance:haveEquip(arg_27_1.id)
	else
		return not HandbookModel.instance:haveEquip(arg_27_1.id)
	end
end

function var_0_0.handleItem(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_2 then
		gohelper.setActive(arg_28_0.goEquipList[arg_28_1], false)

		return
	end

	gohelper.setActive(arg_28_0.goEquipList[arg_28_1], true)
	ZProj.UGUIHelper.SetGrayscale(arg_28_0.simageList[arg_28_1].gameObject, not HandbookModel.instance:haveEquip(arg_28_2.id))
	arg_28_0.simageList[arg_28_1]:LoadImage(ResUrl.getHandbookEquipImage(arg_28_2.icon .. arg_28_1))

	arg_28_0.txtNameList[arg_28_1].text = arg_28_2.name
	arg_28_0.txtNameEnList[arg_28_1].text = arg_28_2.name_en

	for iter_28_0 = 1, #arg_28_0.goRareList[arg_28_1] do
		if arg_28_2.rare == iter_28_0 + 1 then
			gohelper.setActive(arg_28_0.goRareList[arg_28_1][iter_28_0], true)
		else
			gohelper.setActive(arg_28_0.goRareList[arg_28_1][iter_28_0], false)
		end
	end
end

function var_0_0.onDragBeginHandle(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.startDragPosX = arg_29_2.position.x
end

function var_0_0.onDragEndHandle(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_2.position.x

	if math.abs(var_30_0 - arg_30_0.startDragPosX) > var_0_0.DragAbsPositionX then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_click)

		if var_30_0 < arg_30_0.startDragPosX then
			arg_30_0:rightPageOnClick()
		else
			arg_30_0:leftPageOnClick()
		end
	end
end

function var_0_0.onClose(arg_31_0)
	return
end

function var_0_0.onDestroyView(arg_32_0)
	EquipFilterModel.instance:clear(arg_32_0.viewName)

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.equipClickList) do
		iter_32_1:RemoveClickListener()
	end

	arg_32_0._leftPageClick:RemoveClickListener()
	arg_32_0._rightPageClick:RemoveClickListener()
	arg_32_0._rareRankClick:RemoveClickListener()

	if arg_32_0._drag then
		arg_32_0._drag:RemoveDragBeginListener()
		arg_32_0._drag:RemoveDragEndListener()
	end

	arg_32_0.equipList = nil

	arg_32_0._simagebg:UnLoadImage()

	for iter_32_2 = 1, #arg_32_0.simageList do
		arg_32_0.simageList[iter_32_2]:UnLoadImage()
	end
end

return var_0_0
