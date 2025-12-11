module("modules.logic.versionactivity1_6.enter.view.VersionActivity1_6EnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_6EnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._subViewGroup = TabViewGroup.New(2, "#go_subview")

	return {
		TabViewGroup.New(1, "#go_topleft"),
		arg_1_0._subViewGroup,
		VersionActivity1_6EnterView.New()
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
		local var_2_0 = {}

		var_2_0[#var_2_0 + 1] = Va1_6DungeonEnterView.New()
		var_2_0[#var_2_0 + 1] = V1a6_CachotEnterView.New()
		var_2_0[#var_2_0 + 1] = ReactivityEnterview.New()
		var_2_0[#var_2_0 + 1] = Va1_6QuNiangEnterView.New()
		var_2_0[#var_2_0 + 1] = Va1_6GeTianEnterView.New()
		var_2_0[#var_2_0 + 1] = V1a6_BossRush_EnterView.New()
		var_2_0[#var_2_0 + 1] = Va1_6SeasonEnterView.New()
		var_2_0[#var_2_0 + 1] = RoleStoryEnterView.New()
		var_2_0[#var_2_0 + 1] = V1a6_ExploreEnterView.New()

		return var_2_0
	end
end

function var_0_0.selectActTab(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:modifyBgm(arg_3_2.actId)
	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_3_1)
end

function var_0_0.onContainerInit(arg_4_0)
	ActivityStageHelper.recordActivityStage(arg_4_0.viewParam.activityIdList)
end

function var_0_0.onContainerClose(arg_5_0)
	if arg_5_0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function var_0_0.modifyBgm(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0["onModifyBgmAct" .. arg_6_1]

	if var_6_0 then
		var_6_0(arg_6_0)

		return
	end

	local var_6_1 = ActivityConfig.instance:getActivityEnterViewBgm(arg_6_1)

	var_6_1 = var_6_1 ~= 0 and var_6_1 or AudioEnum.Bgm.Act1_6DungeonBgm1

	if arg_6_0._curBgmId == var_6_1 then
		return
	end

	arg_6_0._curBgmId = var_6_1

	if var_6_1 == AudioEnum.Bgm.Activity128LevelViewBgm then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_6Main, var_6_1, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm, nil, nil, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	else
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_6Main, var_6_1, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	end
end

return var_0_0
