module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryCollectViewContainer", package.seeall)

local var_0_0 = class("VersionActivity_1_2_StoryCollectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity_1_2_StoryCollectView.New()
	}
end

function var_0_0.playCloseTransition(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_close)

	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "root")

	SLFramework.AnimatorPlayer.Get(var_2_0):Play("close", arg_2_0.onPlayCloseTransitionFinish, arg_2_0)
end

return var_0_0
