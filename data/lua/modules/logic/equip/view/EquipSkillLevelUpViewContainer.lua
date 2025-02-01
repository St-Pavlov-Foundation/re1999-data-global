module("modules.logic.equip.view.EquipSkillLevelUpViewContainer", package.seeall)

slot0 = class("EquipSkillLevelUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		EquipSkillLevelUpView.New()
	}
end

return slot0
