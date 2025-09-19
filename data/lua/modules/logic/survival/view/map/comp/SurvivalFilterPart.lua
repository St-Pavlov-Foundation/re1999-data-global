module("modules.logic.survival.view.map.comp.SurvivalFilterPart", package.seeall)

local var_0_0 = class("SurvivalFilterPart", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_1, "")
	arg_1_0._filterTips = gohelper.findChild(arg_1_1, "#go_tips")
	arg_1_0._filterItem = gohelper.findChild(arg_1_1, "#go_tips/#go_item")
	arg_1_0._gofilterselect = gohelper.findChild(arg_1_1, "#go_select")

	gohelper.setActive(arg_1_0._filterTips, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._openCloseFilterTips, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0.onTouchScreen, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnfilter:RemoveClickListener()
end

function var_0_0.setOptions(arg_4_0, arg_4_1)
	arg_4_0._filterList = {}
	arg_4_0._filterItems = {}

	gohelper.CreateObjList(arg_4_0, arg_4_0._createFilterItem, arg_4_1, nil, arg_4_0._filterItem, nil, nil, nil, 1)
	arg_4_0:onChange()
end

function var_0_0._createFilterItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._filterItems[arg_5_3] = arg_5_0:getUserDataTb_()
	arg_5_0._filterItems[arg_5_3].selectbg = gohelper.findChild(arg_5_1, "selectbg")

	local var_5_0 = gohelper.findChildTextMesh(arg_5_1, "#txt_desc")

	var_5_0.text = arg_5_2.desc
	arg_5_0._filterItems[arg_5_3].txtdesc = var_5_0
	arg_5_0._filterItems[arg_5_3].data = arg_5_2

	local var_5_1 = gohelper.getClick(arg_5_1)

	arg_5_0:addClickCb(var_5_1, arg_5_0._onClickFilterItem, arg_5_0, arg_5_2)
end

function var_0_0._onClickFilterItem(arg_6_0, arg_6_1)
	local var_6_0 = tabletool.indexOf(arg_6_0._filterList, arg_6_1)

	if var_6_0 then
		table.remove(arg_6_0._filterList, var_6_0)
	else
		table.insert(arg_6_0._filterList, arg_6_1)
	end

	arg_6_0:onChange()
end

function var_0_0.setOptionChangeCallback(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._changeCallback = arg_7_1
	arg_7_0._changeCallobj = arg_7_2
end

function var_0_0._openCloseFilterTips(arg_8_0)
	gohelper.setActive(arg_8_0._filterTips, not arg_8_0._filterTips.activeSelf)

	if arg_8_0._clickCb and arg_8_0._callobj then
		arg_8_0._clickCb(arg_8_0._callobj, arg_8_0._filterTips.activeSelf)
	end
end

function var_0_0.onTouchScreen(arg_9_0)
	if arg_9_0._filterTips.activeSelf then
		if gohelper.isMouseOverGo(arg_9_0._filterTips) or gohelper.isMouseOverGo(arg_9_0._btnfilter) then
			return
		end

		gohelper.setActive(arg_9_0._filterTips, false)

		if arg_9_0._clickCb and arg_9_0._callobj then
			arg_9_0._clickCb(arg_9_0._callobj, arg_9_0._filterTips.activeSelf)
		end
	end
end

function var_0_0.onChange(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._filterItems) do
		local var_10_0 = tabletool.indexOf(arg_10_0._filterList, iter_10_1.data)

		gohelper.setActive(iter_10_1.selectbg, var_10_0)
		SLFramework.UGUI.GuiHelper.SetColor(iter_10_1.txtdesc, var_10_0 and "#000000" or "#FFFFFF")
	end

	gohelper.setActive(arg_10_0._gofilterselect, (next(arg_10_0._filterList)))

	if arg_10_0._changeCallback then
		arg_10_0._changeCallback(arg_10_0._changeCallobj, arg_10_0._filterList)
	end
end

function var_0_0.setClickCb(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._clickCb = arg_11_1
	arg_11_0._callobj = arg_11_2
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0._clickCb = nil
	arg_12_0._callobj = nil
	arg_12_0._changeCallback = nil
	arg_12_0._changeCallobj = nil
end

return var_0_0
