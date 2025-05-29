module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroLevelViewContainer", package.seeall)

local var_0_0 = class("DiceHeroLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	DiceHeroModel.instance.guideChapter = arg_1_0.viewParam.chapterId

	return {
		DiceHeroLevelView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return var_0_0
