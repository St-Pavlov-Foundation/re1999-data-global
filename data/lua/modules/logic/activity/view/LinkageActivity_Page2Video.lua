module("modules.logic.activity.view.LinkageActivity_Page2Video", package.seeall)

local var_0_0 = LinkageActivity_Page2VideoBase
local var_0_1 = class("LinkageActivity_Page2Video", var_0_0)

function var_0_1.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_2_0)
	return
end

function var_0_1.removeEvents(arg_3_0)
	return
end

function var_0_1.ctor(arg_4_0, ...)
	var_0_0.ctor(arg_4_0, ...)
end

function var_0_1.onDestroyView(arg_5_0)
	local var_5_0 = arg_5_0._mo

	if var_5_0 and var_5_0.videoAudioStopId then
		AudioMgr.instance:trigger(var_5_0.videoAudioStopId)
	end

	var_0_0.onDestroyView(arg_5_0)
end

function var_0_1._editableInitView(arg_6_0)
	var_0_1.super._editableInitView(arg_6_0)
	arg_6_0:setIsNeedLoadingCover(false)

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "Video")

	arg_6_0:createVideoPlayer(var_6_0)
end

function var_0_1.onUpdateMO(arg_7_0, arg_7_1)
	var_0_0.onUpdateMO(arg_7_0, arg_7_1)

	local var_7_0 = langVideoUrl(arg_7_1.videoName)

	arg_7_0:loadVideo(var_7_0)
	arg_7_0:run()
end

function var_0_1.run(arg_8_0)
	if not arg_8_0:_isPlaying() then
		arg_8_0:play()
	end
end

function var_0_1.play(arg_9_0)
	local var_9_0 = arg_9_0._mo.videoAudioId

	var_0_0.play(arg_9_0, var_9_0, true)
end

function var_0_1.stop(arg_10_0)
	local var_10_0 = arg_10_0._mo.videoAudioStopId

	var_0_0.stop(arg_10_0, var_10_0)
end

function var_0_1.setEnabled(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0:play()
	else
		arg_11_0:stop()
	end
end

return var_0_1
