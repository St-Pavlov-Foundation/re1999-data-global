module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_3AstrologyViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.astrologyView = VersionActivity1_3AstrologyView.New()

	return {
		arg_1_0.astrologyView,
		TabViewGroup.New(1, "#go_BackBtns"),
		TabViewGroup.New(2, "#go_plate"),
		TabViewGroup.New(3, "#go_Right")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.VersionActivity1_3Astrology)

		arg_2_0._navigateButtonView:setHomeCheck(arg_2_0._closeCheckFunc, arg_2_0)
		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0.overrideClose, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == 2 then
		return {
			VersionActivity1_3AstrologyPlateView.New()
		}
	elseif arg_2_1 == 3 then
		return {
			VersionActivity1_3AstrologySelectView.New(),
			VersionActivity1_3AstrologyResultView.New()
		}
	end
end

function var_0_0._closeCheckFunc(arg_3_0)
	if not VersionActivity1_3AstrologyModel.instance:isEffectiveAdjust() then
		return true
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg2, MsgBoxEnum.BoxType.Yes_No, function()
		arg_3_0:sendUpdateProgressRequest()
	end, function()
		arg_3_0._navigateButtonView:_reallyHome()
	end)

	return false
end

function var_0_0.overrideClose(arg_6_0)
	if not VersionActivity1_3AstrologyModel.instance:isEffectiveAdjust() then
		arg_6_0:closeThis()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg2, MsgBoxEnum.BoxType.Yes_No, function()
		arg_6_0:sendUpdateProgressRequest()
	end, function()
		arg_6_0:closeThis()
	end)
end

function var_0_0.sendUpdateProgressRequest(arg_9_0)
	local var_9_0 = VersionActivity1_3Enum.ActivityId.Act310
	local var_9_1 = VersionActivity1_3AstrologyModel.instance:generateStarProgressStr()
	local var_9_2, var_9_3 = VersionActivity1_3AstrologyModel.instance:generateStarProgressCost()

	arg_9_0._sendPlanetList = var_9_3

	Activity126Rpc.instance:sendUpdateProgressRequest(var_9_0, var_9_1, var_9_2)
end

function var_0_0.getSendPlanetList(arg_10_0)
	return arg_10_0._sendPlanetList
end

function var_0_0.switchTab(arg_11_0, arg_11_1)
	arg_11_0:dispatchEvent(ViewEvent.ToSwitchTab, 3, arg_11_1)
end

return var_0_0
