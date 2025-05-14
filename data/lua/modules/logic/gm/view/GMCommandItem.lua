module("modules.logic.gm.view.GMCommandItem", package.seeall)

local var_0_0 = class("GMCommandItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._mo = nil
	arg_1_0._itemClick = SLFramework.UGUI.UIClickListener.Get(arg_1_1)

	arg_1_0._itemClick:AddClickListener(arg_1_0._onClickItem, arg_1_0)

	arg_1_0._selectGO = gohelper.findChild(arg_1_1, "imgSelect")
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "txtName")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1
	arg_2_0._txtName.text = arg_2_0._mo.id .. ". " .. arg_2_0._mo.name
end

function var_0_0.onSelect(arg_3_0, arg_3_1)
	arg_3_0._hasSelected = arg_3_1

	gohelper.setActive(arg_3_0._selectGO, arg_3_1)
end

function var_0_0._onClickItem(arg_4_0)
	GMController.instance:dispatchEvent(GMCommandView.ClickItem, arg_4_0._mo)

	if arg_4_0._hasSelected then
		GMController.instance:dispatchEvent(GMCommandView.ClickItemAgain, arg_4_0._mo)
	end

	arg_4_0._view:setSelect(arg_4_0._mo)
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._itemClick then
		arg_5_0._itemClick:RemoveClickListener()

		arg_5_0._itemClick = nil
	end
end

return var_0_0
