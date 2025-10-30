module("modules.logic.versionactivity3_0.enter.view.subview.VersionActivity3_0SubAnimatorComp", package.seeall)

local var_0_0 = class("VersionActivity3_0SubAnimatorComp", VersionActivitySubAnimatorComp)

function var_0_0.get(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.playOpenAnim(arg_2_0)
	local var_2_0 = arg_2_0.view and arg_2_0.view.viewParam

	if var_2_0 and var_2_0.skipOpenAnim then
		arg_2_0.animator:Play(UIAnimationName.Open, 0, 1)

		arg_2_0.view.viewParam.skipOpenAnim = false

		arg_2_0.viewContainer:markPlayedSubViewAnim()

		return
	end

	if arg_2_0.viewContainer:getIsFirstPlaySubViewAnim() then
		arg_2_0.viewContainer:markPlayedSubViewAnim()
	end

	if var_2_0 and var_2_0.playVideo then
		arg_2_0.animator.speed = 0

		arg_2_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_2_0.onPlayVideoDone, arg_2_0)
		arg_2_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_2_0.onPlayVideoDone, arg_2_0)
	else
		arg_2_0.animator.speed = 1

		arg_2_0.animator:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0.onPlayVideoDone(arg_3_0)
	arg_3_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_3_0.onPlayVideoDone, arg_3_0)
	arg_3_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_3_0.onPlayVideoDone, arg_3_0)

	arg_3_0.animator.speed = 1

	arg_3_0.animator:Play("open1", 0, 0)
end

return var_0_0
