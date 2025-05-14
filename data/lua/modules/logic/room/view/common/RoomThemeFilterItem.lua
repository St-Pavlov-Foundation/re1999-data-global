module("modules.logic.room.view.common.RoomThemeFilterItem", package.seeall)

local var_0_0 = class("RoomThemeFilterItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onBtnclick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goselect = gohelper.findChild(arg_4_0.viewGO, "beselected")
	arg_4_0._gounselect = gohelper.findChild(arg_4_0.viewGO, "unselected")
	arg_4_0._txtselectName = gohelper.findChildText(arg_4_0.viewGO, "beselected/name")
	arg_4_0._txtunselectName = gohelper.findChildText(arg_4_0.viewGO, "unselected/name")
	arg_4_0._btnclick = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "click")
end

function var_0_0._onBtnclick(arg_5_0)
	if not arg_5_0._themeItemMO then
		return
	end

	local var_5_0 = arg_5_0._themeItemMO.id

	if RoomThemeFilterListModel.instance:isSelectById(var_5_0) then
		RoomThemeFilterListModel.instance:setSelectById(var_5_0, false)
	else
		RoomThemeFilterListModel.instance:setSelectById(var_5_0, true)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.UIRoomThemeFilterChanged)
end

function var_0_0._refreshUI(arg_6_0)
	if not arg_6_0._themeItemMO then
		return
	end

	if arg_6_0._lastId ~= arg_6_0._themeItemMO.id then
		arg_6_0._lastId = arg_6_0._themeItemMO.id
		arg_6_0._txtselectName.text = arg_6_0._themeItemMO.config.name
		arg_6_0._txtunselectName.text = arg_6_0._themeItemMO.config.name
	end

	local var_6_0 = RoomThemeFilterListModel.instance:isSelectById(arg_6_0._themeItemMO.id)

	if arg_6_0._lastSelect ~= var_6_0 then
		arg_6_0._lastSelect = var_6_0

		gohelper.setActive(arg_6_0._goselect, var_6_0)
		gohelper.setActive(arg_6_0._gounselect, not var_6_0)
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._themeItemMO = arg_7_1

	arg_7_0:_refreshUI()
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
