module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluViewContainer", package.seeall)

local var_0_0 = class("PeaceUluViewContainer", BaseViewContainer)
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.peaceUluView = PeaceUluView.New()
	arg_1_0.navigatetionview = TabViewGroup.New(1, "#go_topleft")
	arg_1_0.tabgroupviews = TabViewGroup.New(2, "#go_content")

	table.insert(var_1_0, arg_1_0.peaceUluView)
	table.insert(var_1_0, arg_1_0.navigatetionview)
	table.insert(var_1_0, arg_1_0.tabgroupviews)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonView:setCloseCheck(arg_2_0.defaultOverrideCloseCheck, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end

	if arg_2_1 == var_0_2 then
		return {
			PeaceUluMainView.New(),
			PeaceUluGameView.New(),
			PeaceUluResultView.New()
		}
	end
end

function var_0_0.getNavigateButtonView(arg_3_0)
	return arg_3_0._navigateButtonView
end

function var_0_0.defaultOverrideCloseCheck(arg_4_0)
	if arg_4_0.tabgroupviews:getCurTabId() ~= PeaceUluEnum.TabIndex.Main then
		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Main)
	else
		arg_4_0._navigateButtonView:_reallyClose()
	end
end

function var_0_0.onContainerInit(arg_5_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.PeaceUlu)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.PeaceUlu
	})
end

return var_0_0
