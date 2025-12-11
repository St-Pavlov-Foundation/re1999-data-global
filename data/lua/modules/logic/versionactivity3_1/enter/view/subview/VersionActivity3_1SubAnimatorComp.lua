module("modules.logic.versionactivity3_1.enter.view.subview.VersionActivity3_1SubAnimatorComp", package.seeall)

local var_0_0 = class("VersionActivity3_1SubAnimatorComp", VersionActivityFixedSubAnimatorComp)

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
			arg_2_0.animator:Play("open1", 0, 0)

			arg_2_0.animator.speed = 0

			arg_2_0.view:playLogoAnim("open1")
			arg_2_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_2_0.onPlayVideoDone, arg_2_0)
			arg_2_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_2_0.onPlayVideoDone, arg_2_0)
			arg_2_0:addEventCb(VideoController.instance, VideoEvent.OnVideoStarted, arg_2_0._delayPlayOpen1Anim, arg_2_0)
		else
			arg_2_0.viewContainer:markPlayedSubViewAnim()
			arg_2_0.animator:Play("open1", 0, 0)

			arg_2_0.animator.speed = 1

			arg_2_0.view:playLogoAnim("open1")
			arg_2_0:_playAudio()
		end
	else
		arg_2_0.animator:Play(UIAnimationName.Open, 0, 0)

		arg_2_0.animator.speed = 1

		arg_2_0.view:playLogoAnim(UIAnimationName.Open)
		arg_2_0:_playAudio()
	end
end

function var_0_0._playAudio(arg_3_0)
	if not arg_3_0.view.viewParam.isExitFight then
		AudioMgr.instance:trigger(AudioEnum3_1.VersionActivity3_1Enter.play_ui_mingdi_entrance)
	end
end

function var_0_0.onPlayVideoDone(arg_4_0)
	arg_4_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_4_0.onPlayVideoDone, arg_4_0)
	arg_4_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_4_0.onPlayVideoDone, arg_4_0)

	if arg_4_0.animator.speed == 1 then
		return
	end

	arg_4_0:_playOpen1Anim()
end

function var_0_0._delayPlayOpen1Anim(arg_5_0)
	arg_5_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoStarted, arg_5_0._delayPlayOpen1Anim, arg_5_0)

	if arg_5_0.animator.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(arg_5_0._playOpen1Anim, arg_5_0, 4)
end

function var_0_0._playOpen1Anim(arg_6_0)
	arg_6_0.animator.speed = 1

	arg_6_0.animator:Play("open1", 0, 0)
	arg_6_0.view:playLogoAnim("open1")
	arg_6_0:_playAudio()
end

function var_0_0.destroy(arg_7_0)
	var_0_0.super.destroy(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._playOpen1Anim, arg_7_0)
end

return var_0_0
