module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.CharacterSkillTipViewContainer", package.seeall)

local var_0_0 = class("CharacterSkillTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CharacterSkillTipView.New())

	return var_1_0
end

return var_0_0
