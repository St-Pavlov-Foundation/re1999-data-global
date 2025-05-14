module("modules.logic.character.view.CharacterBackpackSearchFilterView", package.seeall)

local var_0_0 = class("CharacterBackpackSearchFilterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclosefilterview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closefilterview")
	arg_1_0._godmg1 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg1")
	arg_1_0._godmg2 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg2")
	arg_1_0._goattr1 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr1")
	arg_1_0._goattr2 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr2")
	arg_1_0._goattr3 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr3")
	arg_1_0._goattr4 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr4")
	arg_1_0._goattr5 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr5")
	arg_1_0._goattr6 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr6")
	arg_1_0._golocation1 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location1")
	arg_1_0._golocation2 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location2")
	arg_1_0._golocation3 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location3")
	arg_1_0._golocation4 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location4")
	arg_1_0._golocation5 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location5")
	arg_1_0._golocation6 = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location6")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_reset")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosefilterview:AddClickListener(arg_2_0._btnclosefilterviewOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosefilterview:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btnclosefilterviewOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnresetOnClick(arg_5_0)
	for iter_5_0 = 1, 2 do
		arg_5_0._selectDmgs[iter_5_0] = false
	end

	for iter_5_1 = 1, 6 do
		arg_5_0._selectAttrs[iter_5_1] = false
	end

	for iter_5_2 = 1, 6 do
		arg_5_0._selectLocations[iter_5_2] = false
	end

	arg_5_0:_refreshView()
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	local var_6_0 = {}

	for iter_6_0 = 1, 2 do
		if arg_6_0._selectDmgs[iter_6_0] then
			table.insert(var_6_0, iter_6_0)
		end
	end

	local var_6_1 = {}

	for iter_6_1 = 1, 6 do
		if arg_6_0._selectAttrs[iter_6_1] then
			table.insert(var_6_1, iter_6_1)
		end
	end

	local var_6_2 = {}

	for iter_6_2 = 1, 6 do
		if arg_6_0._selectLocations[iter_6_2] then
			table.insert(var_6_2, iter_6_2)
		end
	end

	if #var_6_0 == 0 then
		var_6_0 = {
			1,
			2
		}
	end

	if #var_6_1 == 0 then
		var_6_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_6_2 == 0 then
		var_6_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_6_3 = {
		dmgs = var_6_0,
		careers = var_6_1,
		locations = var_6_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_6_3, false, CharacterEnum.FilterType.BackpackHero)

	local var_6_4 = {
		dmgs = arg_6_0._selectDmgs,
		attrs = arg_6_0._selectAttrs,
		locations = arg_6_0._selectLocations
	}

	CharacterController.instance:dispatchEvent(CharacterEvent.FilterBackpack, var_6_4)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._dmgSelects = arg_7_0:getUserDataTb_()
	arg_7_0._dmgUnselects = arg_7_0:getUserDataTb_()
	arg_7_0._dmgBtnClicks = arg_7_0:getUserDataTb_()
	arg_7_0._attrSelects = arg_7_0:getUserDataTb_()
	arg_7_0._attrUnselects = arg_7_0:getUserDataTb_()
	arg_7_0._attrBtnClicks = arg_7_0:getUserDataTb_()
	arg_7_0._locationSelects = arg_7_0:getUserDataTb_()
	arg_7_0._locationUnselects = arg_7_0:getUserDataTb_()
	arg_7_0._locationBtnClicks = arg_7_0:getUserDataTb_()

	for iter_7_0 = 1, 2 do
		arg_7_0._dmgUnselects[iter_7_0] = gohelper.findChild(arg_7_0.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_7_0 .. "/unselected")
		arg_7_0._dmgSelects[iter_7_0] = gohelper.findChild(arg_7_0.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_7_0 .. "/selected")
		arg_7_0._dmgBtnClicks[iter_7_0] = gohelper.findChildButtonWithAudio(arg_7_0.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_7_0 .. "/click")

		arg_7_0._dmgBtnClicks[iter_7_0]:AddClickListener(arg_7_0._dmgBtnOnClick, arg_7_0, iter_7_0)
	end

	for iter_7_1 = 1, 6 do
		arg_7_0._attrUnselects[iter_7_1] = gohelper.findChild(arg_7_0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_7_1 .. "/unselected")
		arg_7_0._attrSelects[iter_7_1] = gohelper.findChild(arg_7_0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_7_1 .. "/selected")
		arg_7_0._attrBtnClicks[iter_7_1] = gohelper.findChildButtonWithAudio(arg_7_0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_7_1 .. "/click")

		arg_7_0._attrBtnClicks[iter_7_1]:AddClickListener(arg_7_0._attrBtnOnClick, arg_7_0, iter_7_1)
	end

	for iter_7_2 = 1, 6 do
		arg_7_0._locationUnselects[iter_7_2] = gohelper.findChild(arg_7_0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_7_2 .. "/unselected")
		arg_7_0._locationSelects[iter_7_2] = gohelper.findChild(arg_7_0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_7_2 .. "/selected")
		arg_7_0._locationBtnClicks[iter_7_2] = gohelper.findChildButtonWithAudio(arg_7_0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_7_2 .. "/click")

		arg_7_0._locationBtnClicks[iter_7_2]:AddClickListener(arg_7_0._locationBtnOnClick, arg_7_0, iter_7_2)
	end
end

function var_0_0._attrBtnOnClick(arg_8_0, arg_8_1)
	arg_8_0._selectAttrs[arg_8_1] = not arg_8_0._selectAttrs[arg_8_1]

	arg_8_0:_refreshView()
end

function var_0_0._dmgBtnOnClick(arg_9_0, arg_9_1)
	if not arg_9_0._selectDmgs[arg_9_1] then
		arg_9_0._selectDmgs[3 - arg_9_1] = arg_9_0._selectDmgs[arg_9_1]
	end

	arg_9_0._selectDmgs[arg_9_1] = not arg_9_0._selectDmgs[arg_9_1]

	arg_9_0:_refreshView()
end

function var_0_0._locationBtnOnClick(arg_10_0, arg_10_1)
	arg_10_0._selectLocations[arg_10_1] = not arg_10_0._selectLocations[arg_10_1]

	arg_10_0:_refreshView()
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._selectDmgs = arg_12_0.viewParam.dmgs
	arg_12_0._selectAttrs = arg_12_0.viewParam.attrs
	arg_12_0._selectLocations = arg_12_0.viewParam.locations

	arg_12_0:_refreshView()
end

function var_0_0._refreshView(arg_13_0)
	for iter_13_0 = 1, 2 do
		gohelper.setActive(arg_13_0._dmgUnselects[iter_13_0], not arg_13_0._selectDmgs[iter_13_0])
		gohelper.setActive(arg_13_0._dmgSelects[iter_13_0], arg_13_0._selectDmgs[iter_13_0])
	end

	for iter_13_1 = 1, 6 do
		gohelper.setActive(arg_13_0._attrUnselects[iter_13_1], not arg_13_0._selectAttrs[iter_13_1])
		gohelper.setActive(arg_13_0._attrSelects[iter_13_1], arg_13_0._selectAttrs[iter_13_1])
	end

	for iter_13_2 = 1, 6 do
		gohelper.setActive(arg_13_0._locationUnselects[iter_13_2], not arg_13_0._selectLocations[iter_13_2])
		gohelper.setActive(arg_13_0._locationSelects[iter_13_2], arg_13_0._selectLocations[iter_13_2])
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	for iter_15_0 = 1, 2 do
		arg_15_0._dmgBtnClicks[iter_15_0]:RemoveClickListener()
	end

	for iter_15_1 = 1, 6 do
		arg_15_0._attrBtnClicks[iter_15_1]:RemoveClickListener()
	end

	for iter_15_2 = 1, 6 do
		arg_15_0._locationBtnClicks[iter_15_2]:RemoveClickListener()
	end
end

return var_0_0
