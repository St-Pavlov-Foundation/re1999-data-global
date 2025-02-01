module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryCollectViewContainer", package.seeall)

slot0 = class("VersionActivity_1_2_StoryCollectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity_1_2_StoryCollectView.New()
	}
end

function slot0.playCloseTransition(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_close)
	SLFramework.AnimatorPlayer.Get(gohelper.findChild(slot0.viewGO, "root")):Play("close", slot0.onPlayCloseTransitionFinish, slot0)
end

return slot0
