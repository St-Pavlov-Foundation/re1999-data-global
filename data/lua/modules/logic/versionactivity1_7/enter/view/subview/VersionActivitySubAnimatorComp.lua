module("modules.logic.versionactivity1_7.enter.view.subview.VersionActivitySubAnimatorComp", package.seeall)

local var_0_0 = class("VersionActivitySubAnimatorComp", UserDataDispose)

function var_0_0.get(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:__onInit()

	arg_2_0.animatorGo = arg_2_1
	arg_2_0.animator = arg_2_0.animatorGo:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0.view = arg_2_2
	arg_2_0.viewContainer = arg_2_2.viewContainer
end

function var_0_0.playOpenAnim(arg_3_0)
	if arg_3_0.view.viewParam.skipOpenAnim then
		arg_3_0.animator:Play(UIAnimationName.Open, 0, 1)

		arg_3_0.view.viewParam.skipOpenAnim = false

		arg_3_0.viewContainer:markPlayedSubViewAnim()

		return
	end

	if arg_3_0.viewContainer:getIsFirstPlaySubViewAnim() then
		if arg_3_0.view.viewParam.playVideo then
			arg_3_0.viewContainer:markPlayedSubViewAnim()
			arg_3_0.animator:Play(UIAnimationName.Open, 0, 0)

			arg_3_0.animator.speed = 0

			arg_3_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_3_0.onPlayVideoDone, arg_3_0)
			arg_3_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_3_0.onPlayVideoDone, arg_3_0)
		else
			arg_3_0.animator:Play(UIAnimationName.Open, 0, 0)

			arg_3_0.animator.speed = 1
		end
	else
		arg_3_0.animator:Play(UIAnimationName.Open, 0, 0)

		arg_3_0.animator.speed = 1
	end
end

function var_0_0.onPlayVideoDone(arg_4_0)
	arg_4_0.animator.speed = 1

	arg_4_0.animator:Play(UIAnimationName.Open, 0, 0)
	arg_4_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_4_0.onPlayVideoDone, arg_4_0)
	arg_4_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_4_0.onPlayVideoDone, arg_4_0)
end

function var_0_0.destroy(arg_5_0)
	arg_5_0:__onDispose()
end

return var_0_0
