module("modules.logic.fight.view.FightEditorStateViewContainer", package.seeall)

local var_0_0 = class("FightEditorStateViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightEditorStateView.New()
	}
end

return var_0_0
