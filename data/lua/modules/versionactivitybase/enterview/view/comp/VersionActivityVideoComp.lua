module("modules.versionactivitybase.enterview.view.comp.VersionActivityVideoComp", package.seeall)

local var_0_0 = class("VersionActivityVideoComp", UserDataDispose)

function var_0_0.get(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:__onInit()

	arg_2_0.videoRootGO = arg_2_1
	arg_2_0.view = arg_2_2
	arg_2_0.viewContainer = arg_2_2.viewContainer
end

function var_0_0._initVideo(arg_3_0)
	if not arg_3_0._initFinish then
		arg_3_0._initFinish = true
		arg_3_0._videoPlayer, arg_3_0._displayUGUI, arg_3_0._videoGo = AvProMgr.instance:getVideoPlayer(arg_3_0.videoRootGO, "videoplayer")

		local var_3_0 = arg_3_0._videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter))

		if var_3_0 then
			var_3_0.enabled = false
		end
	end
end

function var_0_0._destroyVideo(arg_4_0)
	if arg_4_0._videoPlayer then
		arg_4_0._videoPlayer:Stop()
		arg_4_0._videoPlayer:Clear()

		arg_4_0._videoPlayer = nil
		arg_4_0._displayUGUI = nil
		arg_4_0._videoGo = nil
	end
end

function var_0_0.loadMedia(arg_5_0, arg_5_1)
	if string.nilorempty(arg_5_1) then
		return
	end

	arg_5_0:_initVideo()

	if arg_5_0._videoPlayer then
		arg_5_0._videoPlayer:LoadMedia(arg_5_1)
	end
end

function var_0_0.play(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:_initVideo()
	arg_6_0:_playByPath(arg_6_1, arg_6_2)
end

function var_0_0.resetStart(arg_7_0)
	arg_7_0:_playByPath(arg_7_0._curPlayVideoPath, arg_7_0._curLoop, true)
end

function var_0_0._playByPath(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2 == true

	if not arg_8_1 or string.nilorempty(arg_8_1) or arg_8_3 ~= true and arg_8_0._curPlayVideoPath == arg_8_1 and arg_8_0._curLoop == var_8_0 then
		return
	end

	if arg_8_0._videoPlayer then
		arg_8_0._curPlayVideoPath = arg_8_1
		arg_8_0._curLoop = var_8_0

		arg_8_0._videoPlayer:Play(arg_8_0._displayUGUI, arg_8_1, arg_8_0._curLoop, arg_8_0._videoStatusUpdate, arg_8_0)
	end
end

function var_0_0._videoStatusUpdate(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	logNormal(string.format("VersionActivityVideoComp:_videoStatusUpdate status:%s name:%s ", arg_9_2, AvProEnum.getPlayerStatusEnumName(arg_9_2)))
end

function var_0_0.destroy(arg_10_0)
	arg_10_0:__onDispose()
	arg_10_0:_destroyVideo()
end

return var_0_0
