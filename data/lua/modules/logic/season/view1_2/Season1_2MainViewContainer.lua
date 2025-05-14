module("modules.logic.season.view1_2.Season1_2MainViewContainer", package.seeall)

local var_0_0 = class("Season1_2MainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.scene = Season1_2MainScene.New()
	arg_1_0.view = Season1_2MainView.New()

	table.insert(var_1_0, arg_1_0.scene)
	table.insert(var_1_0, arg_1_0.view)
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))

	return var_1_0
end

function var_0_0.getScene(arg_2_0)
	return arg_2_0.scene
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	arg_3_0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, arg_3_0._closeCallback, arg_3_0._homeCallback, nil, arg_3_0)

	arg_3_0._navigateButtonView:setOverrideClose(arg_3_0._overrideClose, arg_3_0)
	arg_3_0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_2MainViewHelp)

	return {
		arg_3_0._navigateButtonView
	}
end

function var_0_0.onContainerInit(arg_4_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.Season
	})
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_goldcup_open)
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act104)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act104
	})
end

function var_0_0.onContainerOpenFinish(arg_5_0)
	arg_5_0._navigateButtonView:resetOnCloseViewAudio()
end

function var_0_0._closeCallback(arg_6_0)
	return
end

function var_0_0._homeCallback(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.stopUI(arg_8_0)
	arg_8_0:setVisibleInternal(true)

	arg_8_0._anim.speed = 0
	arg_8_0._animRetail.speed = 0

	arg_8_0.view:activeMask(true)
end

function var_0_0.playUI(arg_9_0)
	arg_9_0:setVisibleInternal(true)

	arg_9_0._anim.speed = 1
	arg_9_0._animRetail.speed = 1

	arg_9_0.view:activeMask(false)
end

function var_0_0.setVisibleInternal(arg_10_0, arg_10_1)
	if not arg_10_0.viewGO then
		return
	end

	if not arg_10_0._anim then
		arg_10_0._anim = arg_10_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if arg_10_1 then
		arg_10_0:_setVisible(true)
		arg_10_0._anim:Play(UIAnimationName.Switch, 0, 0)

		if not arg_10_0._animRetail then
			arg_10_0._animRetail = gohelper.findChild(arg_10_0.viewGO, "rightbtns/#go_retail"):GetComponent(typeof(UnityEngine.Animator))
		end

		arg_10_0._animRetail:Play(UIAnimationName.Switch, 0, 0)

		if arg_10_0.scene then
			arg_10_0.scene:initCamera()
		end
	else
		arg_10_0:_setVisible(false)
		arg_10_0._anim:Play(UIAnimationName.Close)
	end
end

return var_0_0
