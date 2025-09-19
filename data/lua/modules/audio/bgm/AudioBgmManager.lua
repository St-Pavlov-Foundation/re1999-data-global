module("modules.audio.bgm.AudioBgmManager", package.seeall)

local var_0_0 = class("AudioBgmManager")

function var_0_0.ctor(arg_1_0)
	arg_1_0._bgmInfo = AudioBgmInfo.New()
	arg_1_0._curBgmData = nil
	arg_1_0._canPauseList = {}

	arg_1_0:_addEvents()
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0._addEvents(arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinsh, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, arg_3_0._onReOpenWhileOpen, arg_3_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterScene, arg_3_0._onEnterScene, arg_3_0)
end

function var_0_0._onEnterScene(arg_4_0)
	arg_4_0:_forceClearPauseBgm()
end

function var_0_0._onReOpenWhileOpen(arg_5_0, arg_5_1)
	arg_5_0:_startCheckBgm()
end

function var_0_0._onCloseViewFinish(arg_6_0, arg_6_1)
	arg_6_0:_startCheckBgm()
end

function var_0_0._onOpenViewFinsh(arg_7_0, arg_7_1)
	arg_7_0:_startCheckBgm()
end

function var_0_0.checkBgm(arg_8_0)
	arg_8_0:_startCheckBgm()
end

function var_0_0._startCheckBgm(arg_9_0)
	arg_9_0._startFromat = 0

	TaskDispatcher.cancelTask(arg_9_0._checkBgm, arg_9_0)
	TaskDispatcher.runRepeat(arg_9_0._checkBgm, arg_9_0, 0)
end

function var_0_0._checkBgm(arg_10_0)
	if arg_10_0._startFromat == 0 then
		arg_10_0._startFromat = arg_10_0._startFromat + 1

		return
	end

	local var_10_0 = arg_10_0:_getTopViewBgm() or arg_10_0:_getSceneBgm()

	if var_10_0 then
		local var_10_1 = var_10_0:getBgmLayer()

		arg_10_0:_clearPauseBgm(var_10_0)

		if var_10_1 then
			TaskDispatcher.cancelTask(arg_10_0._checkBgm, arg_10_0)
			arg_10_0:playBgm(var_10_1)
		end
	else
		TaskDispatcher.cancelTask(arg_10_0._checkBgm, arg_10_0)
		arg_10_0:_setBgmData(nil)
	end
end

function var_0_0._getTopViewBgm(arg_11_0)
	local var_11_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_11_0 = #var_11_0, 1, -1 do
		local var_11_1 = var_11_0[iter_11_0]

		if ViewMgr.instance:getContainer(var_11_1) then
			local var_11_2 = arg_11_0._bgmInfo:getViewBgmUsage(var_11_1)

			if var_11_2 then
				return var_11_2
			end
		end
	end
end

function var_0_0._getSceneBgm(arg_12_0)
	local var_12_0 = GameSceneMgr.instance:getCurSceneType()

	return (arg_12_0._bgmInfo:getSceneBgmUsage(var_12_0))
end

function var_0_0.modifyAndPlay(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7)
	if AudioMgr.instance:useDefaultBGM() then
		if arg_13_1 == AudioBgmEnum.Layer.Fight then
			arg_13_2 = AudioEnum.Default_Fight_Bgm
			arg_13_3 = AudioEnum.Default_Fight_Bgm_Stop
		else
			arg_13_2 = AudioEnum.Default_UI_Bgm
			arg_13_3 = AudioEnum.Default_UI_Bgm_Stop
		end
	end

	arg_13_0:stopBgm(arg_13_1)
	arg_13_0:modifyBgm(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7)
	arg_13_0:playBgm(arg_13_1)
end

function var_0_0.stopAndRemove(arg_14_0, arg_14_1)
	arg_14_0:stopBgm(arg_14_1)
	arg_14_0:removeBgm(arg_14_1)
end

function var_0_0.stopAndClear(arg_15_0, arg_15_1)
	arg_15_0:stopBgm(arg_15_1)
	arg_15_0:clearBgm(arg_15_1)
end

function var_0_0.modifyBgm(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7)
	arg_16_0._bgmInfo:modifyBgmData(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7)
end

function var_0_0.modifyBgmAudioId(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0._bgmInfo:modifyBgmAudioId(arg_17_1, arg_17_2) then
		local var_17_0 = arg_17_0._bgmInfo:getBgmData(arg_17_1)

		if arg_17_0._curBgmData == var_17_0 then
			arg_17_0:_stopBgm(var_17_0)
			arg_17_0:_playBgm(var_17_0)

			return true
		end
	end

	return false
end

function var_0_0.getCurPlayingId(arg_18_0)
	return arg_18_0._curBgmData and arg_18_0._curBgmData.playId or nil
end

function var_0_0.setSwitch(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._bgmInfo:getBgmData(arg_19_1)

	if var_19_0 then
		var_19_0:setSwitch()
	end
end

function var_0_0.setSwitchData(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0._bgmInfo:getBgmData(arg_20_1)

	if var_20_0 then
		if var_20_0.switchGroup == arg_20_2 and var_20_0.switchState == arg_20_3 then
			return false
		end

		var_20_0.switchGroup = arg_20_2
		var_20_0.switchState = arg_20_3

		return true
	end

	return false
end

function var_0_0.setStopId(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._bgmInfo:getBgmData(arg_21_1)

	if var_21_0 then
		var_21_0.stopId = arg_21_2
	end
end

function var_0_0.removeBgm(arg_22_0, arg_22_1)
	arg_22_0._bgmInfo:removeBgm(arg_22_1)
end

function var_0_0.clearBgm(arg_23_0, arg_23_1)
	arg_23_0._bgmInfo:clearBgm(arg_23_1)
end

function var_0_0.playBgm(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._bgmInfo:getBgmData(arg_24_1)

	arg_24_0:_setBgmData(var_24_0)
end

function var_0_0.stopBgm(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._bgmInfo:getBgmData(arg_25_1)

	if arg_25_0._curBgmData == var_25_0 then
		arg_25_0:_setBgmData(nil)
	end
end

function var_0_0._setBgmData(arg_26_0, arg_26_1)
	if arg_26_0._curBgmData == arg_26_1 then
		return
	end

	if arg_26_0:_getPlayId(arg_26_0._curBgmData) == arg_26_0:_getPlayId(arg_26_1) then
		arg_26_0._curBgmData = arg_26_1

		return
	end

	arg_26_0:_stopBgm(arg_26_0._curBgmData)

	arg_26_0._curBgmData = arg_26_1

	arg_26_0:_playBgm(arg_26_0._curBgmData)
end

function var_0_0._stopBgm(arg_27_0, arg_27_1)
	if not arg_27_1 then
		return nil
	end

	local var_27_0 = arg_27_0:_getStopId(arg_27_1)

	arg_27_0:dispatchEvent(AudioBgmEvent.onStopBgm, arg_27_1.layer, var_27_0)

	if var_27_0 > 0 then
		AudioMgr.instance:trigger(var_27_0)
	end

	arg_27_0:_stopBindList(arg_27_1)
end

function var_0_0._playBgm(arg_28_0, arg_28_1)
	if not arg_28_1 then
		return nil
	end

	local var_28_0 = arg_28_0:_getPlayId(arg_28_1)

	arg_28_0:dispatchEvent(AudioBgmEvent.onPlayBgm, arg_28_1.layer, var_28_0)

	if var_28_0 > 0 then
		AudioMgr.instance:trigger(var_28_0)
		arg_28_1:setSwitch()

		if arg_28_1.resumeId then
			arg_28_0._canPauseList[arg_28_1.layer] = arg_28_1
		end
	end

	arg_28_0:_playBindList(arg_28_1)
end

function var_0_0._playBindList(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0._bgmInfo:getBindList(arg_29_1.layer)

	if not var_29_0 then
		return
	end

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		local var_29_1 = arg_29_0._bgmInfo:getBgmData(iter_29_1)

		if var_29_1 then
			local var_29_2 = arg_29_0:_getPlayId(var_29_1)

			if var_29_2 > 0 then
				AudioMgr.instance:trigger(var_29_2)
			end
		end
	end
end

function var_0_0._stopBindList(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0._bgmInfo:getBindList(arg_30_1.layer)

	if not var_30_0 then
		return
	end

	for iter_30_0, iter_30_1 in ipairs(var_30_0) do
		local var_30_1 = arg_30_0._bgmInfo:getBgmData(iter_30_1)

		if var_30_1 then
			local var_30_2 = arg_30_0:_getStopId(var_30_1)

			if var_30_2 > 0 then
				AudioMgr.instance:trigger(var_30_2)
			end
		end
	end
end

function var_0_0._clearPauseBgm(arg_31_0, arg_31_1)
	if arg_31_1 and arg_31_1.clearPauseBgm then
		arg_31_0:_forceClearPauseBgm()
	end
end

function var_0_0._forceClearPauseBgm(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0._canPauseList) do
		AudioMgr.instance:trigger(iter_32_1.stopId)
		rawset(arg_32_0._canPauseList, iter_32_0, nil)
	end
end

function var_0_0._getPlayId(arg_33_0, arg_33_1)
	if not arg_33_1 then
		return nil
	end

	if arg_33_0._canPauseList[arg_33_1.layer] then
		return arg_33_1.resumeId
	else
		return arg_33_1.playId
	end
end

function var_0_0._getStopId(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return nil
	end

	if arg_34_0._canPauseList[arg_34_1.layer] then
		return arg_34_1.pauseId
	else
		return arg_34_1.stopId
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
