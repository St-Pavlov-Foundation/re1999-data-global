module("modules.logic.survival.view.map.comp.SurvivalSortAndFilterPart", package.seeall)

local var_0_0 = class("SurvivalSortAndFilterPart", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._btnsort = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_sort")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_filter")
	arg_1_0._sortTips = gohelper.findChild(arg_1_1, "#btn_sort/#go_tips")
	arg_1_0._filterTips = gohelper.findChild(arg_1_1, "#btn_filter/#go_tips")
	arg_1_0._sortItem = gohelper.findChild(arg_1_1, "#btn_sort/#go_tips/#go_item")
	arg_1_0._filterItem = gohelper.findChild(arg_1_1, "#btn_filter/#go_tips/#go_item")
	arg_1_0._gosortdown = gohelper.findChild(arg_1_1, "#btn_sort/#go_down")
	arg_1_0._gosortup = gohelper.findChild(arg_1_1, "#btn_sort/#go_up")
	arg_1_0._txtsort = gohelper.findChildTextMesh(arg_1_1, "#btn_sort/#txt_desc")
	arg_1_0._gofilterselect = gohelper.findChild(arg_1_1, "#btn_filter/#go_select")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnsort:AddClickListener(arg_2_0._openCloseSortTips, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._openCloseFilterTips, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0.onTouchScreen, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnsort:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
end

function var_0_0.setOptions(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._curSortType = arg_4_3 or arg_4_1[1]
	arg_4_0._isSortDec = arg_4_4 or false
	arg_4_0._filterList = {}
	arg_4_0._sortItems = {}
	arg_4_0._filterItems = {}

	gohelper.CreateObjList(arg_4_0, arg_4_0._createSortItem, arg_4_1, nil, arg_4_0._sortItem, nil, nil, nil, 1)
	gohelper.CreateObjList(arg_4_0, arg_4_0._createFilterItem, arg_4_2, nil, arg_4_0._filterItem, nil, nil, nil, 1)
	arg_4_0:onChange()
end

function var_0_0._createSortItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._sortItems[arg_5_3] = arg_5_0:getUserDataTb_()
	arg_5_0._sortItems[arg_5_3].selectbg = gohelper.findChild(arg_5_1, "selectbg")
	arg_5_0._sortItems[arg_5_3].data = arg_5_2

	local var_5_0 = gohelper.findChildTextMesh(arg_5_1, "#txt_desc")

	var_5_0.text = arg_5_2.desc
	arg_5_0._sortItems[arg_5_3].txtdesc = var_5_0
	arg_5_0._sortItems[arg_5_3].godown = gohelper.findChild(arg_5_1, "#go_down")
	arg_5_0._sortItems[arg_5_3].goup = gohelper.findChild(arg_5_1, "#go_up")

	local var_5_1 = gohelper.getClick(arg_5_1)

	arg_5_0:addClickCb(var_5_1, arg_5_0._onClickSortItem, arg_5_0, arg_5_2)
end

function var_0_0._onClickSortItem(arg_6_0, arg_6_1)
	if arg_6_0._curSortType == arg_6_1 then
		arg_6_0._isSortDec = not arg_6_0._isSortDec
	else
		arg_6_0._curSortType = arg_6_1
	end

	arg_6_0:onChange()
end

function var_0_0._createFilterItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._filterItems[arg_7_3] = arg_7_0:getUserDataTb_()
	arg_7_0._filterItems[arg_7_3].selectbg = gohelper.findChild(arg_7_1, "selectbg")

	local var_7_0 = gohelper.findChildTextMesh(arg_7_1, "#txt_desc")

	var_7_0.text = arg_7_2.desc
	arg_7_0._filterItems[arg_7_3].txtdesc = var_7_0
	arg_7_0._filterItems[arg_7_3].data = arg_7_2

	local var_7_1 = gohelper.getClick(arg_7_1)

	arg_7_0:addClickCb(var_7_1, arg_7_0._onClickFilterItem, arg_7_0, arg_7_2)
end

function var_0_0._onClickFilterItem(arg_8_0, arg_8_1)
	local var_8_0 = tabletool.indexOf(arg_8_0._filterList, arg_8_1)

	if var_8_0 then
		table.remove(arg_8_0._filterList, var_8_0)
	else
		table.insert(arg_8_0._filterList, arg_8_1)
	end

	arg_8_0:onChange()
end

function var_0_0.setOptionChangeCallback(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._changeCallback = arg_9_1
	arg_9_0._changeCallobj = arg_9_2
end

function var_0_0._openCloseSortTips(arg_10_0)
	gohelper.setActive(arg_10_0._sortTips, not arg_10_0._sortTips.activeSelf)
	gohelper.setActive(arg_10_0._filterTips, false)
end

function var_0_0._openCloseFilterTips(arg_11_0)
	gohelper.setActive(arg_11_0._filterTips, not arg_11_0._filterTips.activeSelf)
	gohelper.setActive(arg_11_0._sortTips, false)
end

function var_0_0.onTouchScreen(arg_12_0)
	if arg_12_0._filterTips.activeSelf then
		if gohelper.isMouseOverGo(arg_12_0._filterTips) or gohelper.isMouseOverGo(arg_12_0._btnfilter) then
			return
		end

		gohelper.setActive(arg_12_0._filterTips, false)
	end

	if arg_12_0._sortTips.activeSelf then
		if gohelper.isMouseOverGo(arg_12_0._sortTips) or gohelper.isMouseOverGo(arg_12_0._btnsort) then
			return
		end

		gohelper.setActive(arg_12_0._sortTips, false)
	end
end

function var_0_0.onChange(arg_13_0)
	arg_13_0._txtsort.text = arg_13_0._curSortType.desc

	gohelper.setActive(arg_13_0._gosortdown, arg_13_0._isSortDec)
	gohelper.setActive(arg_13_0._gosortup, not arg_13_0._isSortDec)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._sortItems) do
		local var_13_0 = iter_13_1.data == arg_13_0._curSortType

		gohelper.setActive(iter_13_1.selectbg, var_13_0)
		gohelper.setActive(iter_13_1.godown, var_13_0 and arg_13_0._isSortDec)
		gohelper.setActive(iter_13_1.goup, var_13_0 and not arg_13_0._isSortDec)
		SLFramework.UGUI.GuiHelper.SetColor(iter_13_1.txtdesc, var_13_0 and "#000000" or "#FFFFFF")
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_0._filterItems) do
		local var_13_1 = tabletool.indexOf(arg_13_0._filterList, iter_13_3.data)

		gohelper.setActive(iter_13_3.selectbg, var_13_1)
		SLFramework.UGUI.GuiHelper.SetColor(iter_13_3.txtdesc, var_13_1 and "#000000" or "#FFFFFF")
	end

	gohelper.setActive(arg_13_0._gofilterselect, (next(arg_13_0._filterList)))

	if arg_13_0._changeCallback then
		arg_13_0._changeCallback(arg_13_0._changeCallobj, arg_13_0._curSortType, arg_13_0._isSortDec, arg_13_0._filterList)
	end
end

return var_0_0
