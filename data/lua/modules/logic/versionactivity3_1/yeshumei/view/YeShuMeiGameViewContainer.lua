module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiGameViewContainer", package.seeall)

local var_0_0 = class("YeShuMeiGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, YeShuMeiGameView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	YeShuMeiStatHelper.instance:sendGameAbort()

	if not GuideModel.instance:isGuideRunning(YeShuMeiGameView.GuideId) then
		arg_3_0:closeThis()
	end
end

return var_0_0
