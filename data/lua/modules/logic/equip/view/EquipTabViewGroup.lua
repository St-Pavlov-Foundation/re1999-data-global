module("modules.logic.equip.view.EquipTabViewGroup", package.seeall)

local var_0_0 = class("EquipTabViewGroup", TabViewGroup)

function var_0_0.onUpdateParam(arg_1_0)
	arg_1_0:onOpen()
end

function var_0_0.playCloseAnimation(arg_2_0)
	if arg_2_0:_hasLoaded(arg_2_0._curTabId) then
		local var_2_0 = arg_2_0._tabViews[arg_2_0._curTabId]

		if isTypeOf(var_2_0, MultiView) then
			var_2_0:callChildrenFunc("playCloseAnimation")
		else
			var_2_0:playCloseAnimation()
		end
	end
end

return var_0_0
