module("modules.logic.equip.view.EquipBreakResultViewContainer", package.seeall)

local var_0_0 = class("EquipBreakResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		EquipBreakResultView.New()
	}
end

return var_0_0
