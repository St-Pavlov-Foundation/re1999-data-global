module("modules.logic.versionactivity2_1.enter.view.subview.VersionActivity2_1SubAnimatorComp", package.seeall)

local var_0_0 = class("VersionActivity2_1SubAnimatorComp", VersionActivitySubAnimatorComp)

function var_0_0.get(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.playOpenAnim(arg_2_0)
	if arg_2_0.view.viewParam.skipOpenAnim then
		arg_2_0.animator:Play(UIAnimationName.Open, 0, 1)

		arg_2_0.view.viewParam.skipOpenAnim = false

		arg_2_0.viewContainer:markPlayedSubViewAnim()

		return
	end

	if arg_2_0.viewContainer:getIsFirstPlaySubViewAnim() then
		if arg_2_0.view.viewParam.playVideo then
			arg_2_0.viewContainer:markPlayedSubViewAnim()
			arg_2_0:playFirstOpenAnim()

			arg_2_0.animator.speed = 0

			arg_2_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_2_0.onPlayVideoDone, arg_2_0)
			arg_2_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_2_0.onPlayVideoDone, arg_2_0)
		else
			arg_2_0.viewContainer:markPlayedSubViewAnim()
			arg_2_0:playFirstOpenAnim()

			arg_2_0.animator.speed = 1
		end
	else
		arg_2_0.animator:Play(UIAnimationName.Open, 0, 0)

		arg_2_0.animator.speed = 1
	end
end

function var_0_0.playFirstOpenAnim(arg_3_0)
	arg_3_0.animator:Play("open1", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1Enter.play_ui_open)
end

return var_0_0
