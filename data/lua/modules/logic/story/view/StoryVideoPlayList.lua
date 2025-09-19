module("modules.logic.story.view.StoryVideoPlayList", package.seeall)

local var_0_0 = class("StoryVideoPlayList", UserDataDispose)

var_0_0.MaxIndexCount = 7
var_0_0.PlayPos = {
	CommonPlay = 0,
	CommonPlay2 = 6,
	CommonLoop = 1
}
var_0_0.Empty = ""

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._isPlaying = false
	arg_1_0.parentGO = arg_1_2
	arg_1_0.viewGO = arg_1_1

	if SettingsModel.instance:getVideoEnabled() == false then
		arg_1_0._uguiPlayList = AvProUGUIListPlayer_adjust.New()
		arg_1_0._mediaPlayList = PlaylistMediaPlayer_adjust.New()
	else
		arg_1_0._uguiPlayList = arg_1_0.viewGO:GetComponent(typeof(ZProj.AvProUGUIListPlayer))
		arg_1_0._mediaPlayList = arg_1_0.viewGO:GetComponent(typeof(RenderHeads.Media.AVProVideo.PlaylistMediaPlayer))
		arg_1_0._displayUGUI = arg_1_0.viewGO:GetComponent(typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	end

	arg_1_0._uguiPlayList:SetEventListener(arg_1_0._onVideoEvent, arg_1_0)
	recthelper.setSize(arg_1_0.viewGO.transform, 2592, 1080)
	gohelper.setActive(arg_1_0.viewGO, false)

	arg_1_0._path2StartCallback = {}
	arg_1_0._path2StartCallbackObj = {}
	arg_1_0._path2StartVideoItem = {}
	arg_1_0._currentPlayNameMap = {}

	for iter_1_0 = 0, var_0_0.MaxIndexCount - 1 do
		arg_1_0._currentPlayNameMap[iter_1_0] = var_0_0.Empty
	end
end

function var_0_0.buildAndStart(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	StoryController.instance:dispatchEvent(StoryEvent.VideoStart, arg_2_1, arg_2_2)

	local var_2_0

	if arg_2_2 then
		var_2_0 = var_0_0.PlayPos.CommonLoop
	else
		var_2_0 = arg_2_0:getNextNormalPlayIndex()
	end

	local var_2_1 = arg_2_0._currentPlayNameMap[var_2_0]

	logNormal(string.format("StoryVideoPlayList play set path : [%s] \nto index [%s], loop = %s", tostring(arg_2_1), tostring(var_2_0), tostring(arg_2_2)))

	arg_2_0._path2StartCallback[arg_2_1] = arg_2_3
	arg_2_0._path2StartCallbackObj[arg_2_1] = arg_2_4
	arg_2_0._path2StartVideoItem[arg_2_1] = arg_2_5

	gohelper.setActive(arg_2_0.viewGO, true)
	arg_2_0:setPathAtIndex(arg_2_1, var_2_0)
	arg_2_0._mediaPlayList:JumpToItem(var_2_0)

	if not arg_2_0._isPlaying then
		arg_2_0._mediaPlayList:Play()
		arg_2_0._mediaPlayList:JumpToItem(var_2_0)

		arg_2_0._isPlaying = true
	end

	if not string.nilorempty(var_2_1) then
		logNormal(string.format("video still playing : [%s], loop mode = [%s] will stop!", tostring(var_2_1), tostring(arg_2_2)))
		arg_2_0:stop(var_2_1)
	end

	arg_2_0:_startIOSDetectPause()
end

function var_0_0.setPauseState(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0._mediaPlayList.PlaylistIndex

	if arg_3_1 == arg_3_0._currentPlayNameMap[var_3_0] and arg_3_0._mediaPlayList then
		if arg_3_2 then
			arg_3_0._mediaPlayList:Play()
			arg_3_0:_startIOSDetectPause()
		else
			arg_3_0._mediaPlayList:Pause()
			arg_3_0:_stopIOSDetectPause()
		end
	end
end

function var_0_0.stop(arg_4_0, arg_4_1)
	if not arg_4_0._mediaPlayList then
		return
	end

	local var_4_0 = arg_4_0._mediaPlayList.PlaylistIndex

	if arg_4_0._currentPlayNameMap[var_4_0] == arg_4_1 or SettingsModel.instance:getVideoEnabled() == false then
		logNormal("targetName = " .. tostring(arg_4_1) .. " stop!")
		arg_4_0:_stopIOSDetectPause()

		if arg_4_0._mediaPlayList then
			arg_4_0._mediaPlayList:Stop()
		end

		arg_4_0:setParent(arg_4_0.parentGO)
		gohelper.setActive(arg_4_0.viewGO, false)
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0._currentPlayNameMap) do
		if iter_4_1 == arg_4_1 then
			arg_4_0:setPathAtIndex(var_0_0.Empty, iter_4_0)
		end
	end

	arg_4_0._path2StartCallback[arg_4_1] = nil
	arg_4_0._path2StartCallbackObj[arg_4_1] = nil
	arg_4_0._path2StartVideoItem[arg_4_1] = nil

	arg_4_0:checkAllStop()
end

function var_0_0.checkAllStop(arg_5_0)
	if not arg_5_0._currentPlayNameMap then
		logNormal("null playlist, now stop play.")

		arg_5_0._isPlaying = false
	else
		for iter_5_0, iter_5_1 in pairs(arg_5_0._currentPlayNameMap) do
			if iter_5_1 ~= var_0_0.Empty then
				return
			end
		end

		logNormal("empty playlist, now stop play.")

		arg_5_0._isPlaying = false
	end
end

function var_0_0.clearOtherIndex(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._currentPlayNameMap) do
		if iter_6_0 ~= arg_6_1 then
			local var_6_0 = arg_6_0._currentPlayNameMap[iter_6_0]

			arg_6_0._currentPlayNameMap[iter_6_0] = nil
			arg_6_0._path2StartCallback[var_6_0] = nil
			arg_6_0._path2StartCallbackObj[var_6_0] = nil
			arg_6_0._path2StartVideoItem[var_6_0] = nil
		end
	end
end

function var_0_0.fixNeedPlayVideo(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1

	for iter_7_0, iter_7_1 in pairs(arg_7_0._currentPlayNameMap) do
		if iter_7_1 ~= var_0_0.Empty then
			var_7_0 = iter_7_1
			var_7_1 = iter_7_0

			break
		end
	end

	logNormal(string.format("check need fix video curName [%s] evt [%s] curPos [%s] list [%s]", tostring(var_7_0), tostring(arg_7_1), tostring(var_7_1), tostring(arg_7_0._mediaPlayList.PlaylistIndex)))

	if var_7_0 ~= arg_7_1 and not gohelper.isNil(arg_7_0._mediaPlayList) and arg_7_0._mediaPlayList.PlaylistIndex == var_7_1 then
		arg_7_0._mediaPlayList:JumpToItem(var_7_1)
		arg_7_0._mediaPlayList:Play()
		arg_7_0._mediaPlayList:JumpToItem(var_7_1)
		logNormal("try fix play index : " .. tostring(var_7_1) .. " name : " .. tostring(var_7_0))
	end
end

function var_0_0.setPathAtIndex(arg_8_0, arg_8_1, arg_8_2)
	if string.nilorempty(arg_8_1) then
		arg_8_0._uguiPlayList:SetMediaPath(var_0_0.Empty, arg_8_2)

		arg_8_0._currentPlayNameMap[arg_8_2] = var_0_0.Empty
	else
		arg_8_0:clearOtherIndex(arg_8_2)
		arg_8_0._uguiPlayList:SetMediaPath(langVideoUrl(arg_8_1), arg_8_2)

		arg_8_0._currentPlayNameMap[arg_8_2] = arg_8_1
	end
end

function var_0_0.setParent(arg_9_0, arg_9_1)
	gohelper.addChildPosStay(arg_9_1, arg_9_0.viewGO)
end

function var_0_0._onVideoEvent(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = string.split(arg_10_1, "/")
	local var_10_1 = var_10_0[#var_10_0]

	var_10_1 = string.split(var_10_1, ".")[1] or var_10_1

	logNormal(string.format("StoryVideoPlayList:_onVideoEvent, path = %s \nstatus = %s errorCode = %s\ntime = %s", tostring(arg_10_1), tostring(AvProEnum.getPlayerStatusEnumName(arg_10_2)), AvProEnum.getErrorCodeEnumName(arg_10_3), tostring(Time.time)))

	if arg_10_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		arg_10_0:fixNeedPlayVideo(var_10_1)
		arg_10_0:_stopIOSDetectPause()
	elseif arg_10_2 == AvProEnum.PlayerStatus.FirstFrameReady and BootNativeUtil.isIOS() and arg_10_0._path2StartCallback[var_10_1] then
		arg_10_0._path2StartCallback[var_10_1](arg_10_0._path2StartCallbackObj[var_10_1], arg_10_0._path2StartVideoItem[var_10_1])
	end

	if arg_10_3 ~= AvProEnum.ErrorCode.None then
		arg_10_0:stop(var_10_1)
		arg_10_0:_stopIOSDetectPause()
	end
end

function var_0_0._detectPause(arg_11_0)
	if arg_11_0._mediaPlayList and arg_11_0._mediaPlayList:IsPaused() then
		arg_11_0._mediaPlayList:Play()
	end
end

function var_0_0._startIOSDetectPause(arg_12_0)
	if BootNativeUtil.isIOS() then
		TaskDispatcher.runRepeat(arg_12_0._detectPause, arg_12_0, 0.05)
	end
end

function var_0_0._stopIOSDetectPause(arg_13_0)
	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(arg_13_0._detectPause, arg_13_0)
	end
end

function var_0_0.getNextNormalPlayIndex(arg_14_0)
	if arg_14_0._lastNormalIndex == nil or arg_14_0._lastNormalIndex == var_0_0.PlayPos.CommonPlay2 then
		arg_14_0._lastNormalIndex = var_0_0.PlayPos.CommonPlay
	else
		arg_14_0._lastNormalIndex = var_0_0.PlayPos.CommonPlay2
	end

	return arg_14_0._lastNormalIndex
end

function var_0_0.dispose(arg_15_0)
	if arg_15_0._uguiPlayList then
		local var_15_0 = arg_15_0._uguiPlayList.PlaylistMediaPlayer

		arg_15_0._uguiPlayList:Clear()
	end

	arg_15_0:_stopIOSDetectPause()
	arg_15_0:__onDispose()
end

return var_0_0
