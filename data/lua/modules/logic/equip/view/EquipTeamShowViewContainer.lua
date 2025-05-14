module("modules.logic.equip.view.EquipTeamShowViewContainer", package.seeall)

local var_0_0 = class("EquipTeamShowViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		EquipTeamShowView.New()
	}
end

return var_0_0
