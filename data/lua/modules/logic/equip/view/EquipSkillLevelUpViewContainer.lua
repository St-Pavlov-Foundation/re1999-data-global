module("modules.logic.equip.view.EquipSkillLevelUpViewContainer", package.seeall)

local var_0_0 = class("EquipSkillLevelUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		EquipSkillLevelUpView.New()
	}
end

return var_0_0
