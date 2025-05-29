module("modules.logic.rouge.view.RougeDLCSelectListItem", package.seeall)

local var_0_0 = class("RougeDLCSelectListItem", MixScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._goselectedequip = gohelper.findChild(arg_1_0.viewGO, "go_info/go_selected_equip")
	arg_1_0._gounselectequip = gohelper.findChild(arg_1_0.viewGO, "go_info/go_unselect_equip")
	arg_1_0._goselectedunequip = gohelper.findChild(arg_1_0.viewGO, "go_info/go_selected_unequip")
	arg_1_0._gounselectunequip = gohelper.findChild(arg_1_0.viewGO, "go_info/go_unselect_unequip")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_info/btn_click")
	arg_1_0._txtsekectedequip = gohelper.findChildText(arg_1_0.viewGO, "go_info/go_selected_equip/txt_title")
	arg_1_0._txtunselectequip = gohelper.findChildText(arg_1_0.viewGO, "go_info/go_unselect_equip/txt_title")
	arg_1_0._txtselectedunequip = gohelper.findChildText(arg_1_0.viewGO, "go_info/go_selected_unequip/txt_title")
	arg_1_0._txtunselectunequip = gohelper.findChildText(arg_1_0.viewGO, "go_info/go_unselect_unequip/txt_title")
	arg_1_0._txtsekectedequipen = gohelper.findChildText(arg_1_0.viewGO, "go_info/go_selected_equip/en")
	arg_1_0._txtunselectequipen = gohelper.findChildText(arg_1_0.viewGO, "go_info/go_unselect_equip/en")
	arg_1_0._txtselectedunequipen = gohelper.findChildText(arg_1_0.viewGO, "go_info/go_selected_unequip/en")
	arg_1_0._txtunselectunequipen = gohelper.findChildText(arg_1_0.viewGO, "go_info/go_unselect_unequip/en")
	arg_1_0._golater = gohelper.findChild(arg_1_0.viewGO, "go_later")
	arg_1_0._goequipedeffect = gohelper.findChild(arg_1_0.viewGO, "go_info/go_selected_equip/click")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "go_info/go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	RougeDLCSelectListModel.instance:selectCell(arg_4_0._index)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEventCb(RougeDLCController.instance, RougeEvent.OnSelectDLC, arg_5_0._onSelectDLC, arg_5_0)
	arg_5_0:addEventCb(RougeDLCController.instance, RougeEvent.OnGetVersionInfo, arg_5_0._onGetVersionInfo, arg_5_0)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0._txtsekectedequip.text = arg_7_0._mo.name
	arg_7_0._txtunselectequip.text = arg_7_0._mo.name
	arg_7_0._txtselectedunequip.text = arg_7_0._mo.name
	arg_7_0._txtunselectunequip.text = arg_7_0._mo.name
	arg_7_0._txtsekectedequipen.text = arg_7_0._mo.enName
	arg_7_0._txtunselectequipen.text = arg_7_0._mo.enName
	arg_7_0._txtselectedunequipen.text = arg_7_0._mo.enName
	arg_7_0._txtunselectunequipen.text = arg_7_0._mo.enName
	arg_7_0._isSelect = RougeDLCSelectListModel.instance:getCurSelectIndex() == arg_7_0._index
	arg_7_0._isEquiped = RougeDLCSelectListModel.instance:isAddDLC(arg_7_0._mo.id)

	arg_7_0:setSelectUI()
	arg_7_0:setLaterFlagVisible()
	RedDotController.instance:addRedDot(arg_7_0._goreddot, RedDotEnum.DotNode.RougeDLCNew, arg_7_0._mo.id)
end

function var_0_0._onSelectDLC(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._mo and arg_8_0._mo.id == arg_8_1
	local var_8_1 = var_8_0 or arg_8_0._isSelect

	arg_8_0._isSelect = var_8_0

	if var_8_1 then
		arg_8_0:setSelectUI()
	end
end

function var_0_0._onGetVersionInfo(arg_9_0)
	arg_9_0:setSelectUI()
end

function var_0_0.setSelectUI(arg_10_0)
	local var_10_0 = RougeDLCSelectListModel.instance:isAddDLC(arg_10_0._mo.id)

	gohelper.setActive(arg_10_0._goselectedequip, arg_10_0._isSelect and var_10_0)
	gohelper.setActive(arg_10_0._gounselectequip, not arg_10_0._isSelect and var_10_0)
	gohelper.setActive(arg_10_0._goselectedunequip, arg_10_0._isSelect and not var_10_0)
	gohelper.setActive(arg_10_0._gounselectunequip, not arg_10_0._isSelect and not var_10_0)
	gohelper.setActive(arg_10_0._goequipedeffect, arg_10_0._isEquiped ~= var_10_0 and var_10_0)
	arg_10_0:setTabIcon(arg_10_0._goselectedequip, true, true)
	arg_10_0:setTabIcon(arg_10_0._gounselectequip, false, true)
	arg_10_0:setTabIcon(arg_10_0._goselectedunequip, true, false)
	arg_10_0:setTabIcon(arg_10_0._gounselectunequip, false, false)

	arg_10_0._isEquiped = var_10_0

	if arg_10_0._isSelect then
		RougeOutsideController.instance:saveNewReadDLCInLocal(arg_10_0._mo.id)
		RougeOutsideController.instance:initDLCReddotInfo()
	end
end

function var_0_0.setTabIcon(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.findChildImage(arg_11_1, "icon")

	if not var_11_0 then
		return
	end

	local var_11_1 = string.format("rouge_dlc%s_leftlogo", arg_11_0._mo.id)
	local var_11_2 = ""

	if arg_11_2 then
		var_11_2 = arg_11_3 and "1" or "2"
	else
		var_11_2 = arg_11_3 and "2" or "3"
	end

	local var_11_3 = var_11_1 .. var_11_2

	UISpriteSetMgr.instance:setRouge4Sprite(var_11_0, var_11_3)
end

function var_0_0.setLaterFlagVisible(arg_12_0)
	gohelper.setActive(arg_12_0._golater, false)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
