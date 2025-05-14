module("modules.logic.room.view.RoomInitBuildingDegreeItem", package.seeall)

local var_0_0 = class("RoomInitBuildingDegreeItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._go = arg_4_0.viewGO
	arg_4_0._goline = gohelper.findChild(arg_4_0.viewGO, "line")
	arg_4_0._txtdegree = gohelper.findChildText(arg_4_0.viewGO, "txt_degree")
	arg_4_0._goicon = gohelper.findChild(arg_4_0.viewGO, "icon")
	arg_4_0._goblockicon = gohelper.findChild(arg_4_0.viewGO, "block_icon")
	arg_4_0._txtname = gohelper.findChildText(arg_4_0.viewGO, "txt_name")
	arg_4_0._txtcount = gohelper.findChildText(arg_4_0.viewGO, "txt_count")
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._showDegreeMO = arg_5_1

	arg_5_0:_refreshUI()
end

function var_0_0._refreshUI(arg_6_0)
	local var_6_0 = arg_6_0._showDegreeMO

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.degreeType == 1

	if arg_6_0._lastIsBlock ~= var_6_1 then
		arg_6_0._lastIsBlock = var_6_1

		gohelper.setActive(arg_6_0._goline, var_6_1)
		gohelper.setActive(arg_6_0._goblockicon, var_6_1)
		gohelper.setActive(arg_6_0._goicon, not var_6_1)
	end

	arg_6_0._txtcount.text = luaLang("multiple") .. var_6_0.count
	arg_6_0._txtname.text = var_6_1 and luaLang("p_roominitbuilding_plane") or var_6_0.name
	arg_6_0._txtdegree.text = var_6_0.degree
end

function var_0_0.onDestroy(arg_7_0)
	return
end

return var_0_0
