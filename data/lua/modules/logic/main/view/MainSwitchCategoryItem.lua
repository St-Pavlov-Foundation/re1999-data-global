module("modules.logic.main.view.MainSwitchCategoryItem", package.seeall)

local var_0_0 = class("MainSwitchCategoryItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtitemcn1 = gohelper.findChildText(arg_1_0.viewGO, "bg1/#txt_itemcn1")
	arg_1_0._goreddot1 = gohelper.findChild(arg_1_0.viewGO, "bg1/#txt_itemcn1/#go_reddot1")
	arg_1_0._txtitemen1 = gohelper.findChildText(arg_1_0.viewGO, "bg1/#txt_itemen1")
	arg_1_0._txtitemcn2 = gohelper.findChildText(arg_1_0.viewGO, "bg2/#txt_itemcn2")
	arg_1_0._goreddot2 = gohelper.findChild(arg_1_0.viewGO, "bg2/#txt_itemcn2/#go_reddot2")
	arg_1_0._txtitemen2 = gohelper.findChildText(arg_1_0.viewGO, "bg2/#txt_itemen2")

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
	arg_4_0._btnCategory = SLFramework.UGUI.UIClickListener.Get(arg_4_0.viewGO)

	arg_4_0._btnCategory:AddClickListener(arg_4_0._onItemClick, arg_4_0)

	arg_4_0._bgs = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 2 do
		arg_4_0._bgs[iter_4_0] = gohelper.findChild(arg_4_0.viewGO, "bg" .. tostring(iter_4_0))
	end

	gohelper.setActive(arg_4_0._bgs[2], false)
end

function var_0_0._editableAddEvents(arg_5_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_5_0._refreshReddot, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_6_0._refreshReddot, arg_6_0)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	arg_7_0:refreshStatus()
end

function var_0_0.refreshStatus(arg_8_0)
	local var_8_0 = arg_8_0:_isSelected()

	gohelper.setActive(arg_8_0._bgs[1], not var_8_0)
	gohelper.setActive(arg_8_0._bgs[2], var_8_0)
	arg_8_0:_refreshReddot()
end

function var_0_0._refreshReddot(arg_9_0)
	local var_9_0 = false

	if arg_9_0._mo.id == MainEnum.SwitchType.Scene then
		var_9_0 = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MainSceneSwitch, 0)

		if var_9_0 and arg_9_0:_isSelected() then
			MainSceneSwitchController.closeReddot()

			var_9_0 = false
		end
	end

	gohelper.setActive(arg_9_0._goreddot1, var_9_0)
end

function var_0_0._isSelected(arg_10_0)
	return arg_10_0._mo.id == MainSwitchCategoryListModel.instance:getCategoryId()
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

function var_0_0._onItemClick(arg_12_0)
	if arg_12_0:_isSelected() then
		return
	end

	MainSwitchCategoryListModel.instance:setCategoryId(arg_12_0._mo.id)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchCategoryClick, arg_12_0._mo.id)
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0._btnCategory then
		arg_13_0._btnCategory:RemoveClickListener()
	end
end

return var_0_0
