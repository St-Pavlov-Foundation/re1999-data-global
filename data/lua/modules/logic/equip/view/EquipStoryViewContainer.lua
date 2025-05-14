module("modules.logic.equip.view.EquipStoryViewContainer", package.seeall)

local var_0_0 = class("EquipStoryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		EquipStoryView.New()
	}
end

return var_0_0
