module("modules.logic.sp01.odyssey.view.OdysseyEquipSuitTabItem", package.seeall)

local var_0_0 = class("OdysseyEquipSuitTabItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	logNormal("点击过滤按钮 type: " .. arg_4_0.mo.type)

	local var_4_0 = arg_4_0._isSelect

	if var_4_0 then
		return
	end

	arg_4_0._view:selectCell(arg_4_0._index, true)
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnEquipSuitSelect, not var_4_0 and arg_4_0.mo or nil)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._enableDeselect = true
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0.mo = arg_8_1

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	if arg_9_0.mo.type == OdysseyEnum.EquipSuitType.All then
		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_9_0._imageicon, "odyssey_herogroup_icon_all")
	else
		local var_9_0 = arg_9_0.mo.config

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_9_0._imageicon, var_9_0.icon)
		arg_9_0:onSelect(false)
	end
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	arg_10_0._isSelect = arg_10_1

	gohelper.setActive(arg_10_0._goselect, arg_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
