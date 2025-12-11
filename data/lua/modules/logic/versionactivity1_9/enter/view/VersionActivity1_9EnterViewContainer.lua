module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_9EnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity1_9EnterView.New(),
		VersionActivity1_9EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	elseif arg_2_1 == 2 then
		return {
			V1a9_DungeonEnterView.New(),
			V1a6_BossRush_EnterView.New(),
			RoleStoryEnterView.New(),
			V1a9_Season123EnterView.New(),
			V1a9_LucyEnterView.New(),
			V1a9_KaKaNiaEnterView.New(),
			V1a9_RougeEnterView.New(),
			V1a9_ExploreEnterView.New()
		}
	end
end

function var_0_0.selectActTab(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.activityId = arg_3_2

	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_3_1)
end

function var_0_0.onContainerInit(arg_4_0)
	arg_4_0.isFirstPlaySubViewAnim = true
	arg_4_0.activityIdList = arg_4_0.viewParam.activityIdList

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.activityIdList) do
		local var_4_0 = VersionActivityEnterHelper.getActId(iter_4_1)

		ActivityStageHelper.recordOneActivityStage(var_4_0)
	end

	local var_4_1 = VersionActivityEnterHelper.getTabIndex(arg_4_0.activityIdList, arg_4_0.viewParam.jumpActId)

	if var_4_1 ~= 1 then
		arg_4_0.viewParam.defaultTabIds = {}
		arg_4_0.viewParam.defaultTabIds[2] = var_4_1
	else
		arg_4_0.viewParam.playVideo = true
	end

	local var_4_2 = VersionActivityEnterHelper.getActId(arg_4_0.activityIdList[var_4_1])

	ActivityEnterMgr.instance:enterActivity(var_4_2)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		var_4_2
	})
end

function var_0_0.onContainerClose(arg_5_0)
	if arg_5_0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) and not ViewMgr.instance:hasOpenFullView() then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function var_0_0.getIsFirstPlaySubViewAnim(arg_6_0)
	return arg_6_0.isFirstPlaySubViewAnim
end

function var_0_0.markPlayedSubViewAnim(arg_7_0)
	arg_7_0.isFirstPlaySubViewAnim = false
end

return var_0_0
