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
		end
	end
end

function var_0_0.setSwitchData(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0._bgmInfo:getBgmData(arg_18_1)

	if var_18_0 then
		var_18_0.switchGroup = arg_18_2
		var_18_0.switchState = arg_18_3
	end
end

function var_0_0.removeBgm(arg_19_0, arg_19_1)
	arg_19_0._bgmInfo:removeBgm(arg_19_1)
end

function var_0_0.clearBgm(arg_20_0, arg_20_1)
	arg_20_0._bgmInfo:clearBgm(arg_20_1)
end

function var_0_0.playBgm(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._bgmInfo:getBgmData(arg_21_1)

	arg_21_0:_setBgmData(var_21_0)
end

function var_0_0.stopBgm(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._bgmInfo:getBgmData(arg_22_1)

	if arg_22_0._curBgmData == var_22_0 then
		arg_22_0:_setBgmData(nil)
	end
end

function var_0_0._setBgmData(arg_23_0, arg_23_1)
	if arg_23_0._curBgmData == arg_23_1 then
		return
	end

	if arg_23_0:_getPlayId(arg_23_0._curBgmData) == arg_23_0:_getPlayId(arg_23_1) then
		arg_23_0._curBgmData = arg_23_1

		return
	end

	arg_23_0:_stopBgm(arg_23_0._curBgmData)

	arg_23_0._curBgmData = arg_23_1

	arg_23_0:_playBgm(arg_23_0._curBgmData)
end

function var_0_0._stopBgm(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return nil
	end

	local var_24_0 = arg_24_0:_getStopId(arg_24_1)

	arg_24_0:dispatchEvent(AudioBgmEvent.onStopBgm, arg_24_1.layer, var_24_0)

	if var_24_0 > 0 then
		AudioMgr.instance:trigger(var_24_0)
	end

	arg_24_0:_stopBindList(arg_24_1)
end

function var_0_0._playBgm(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return nil
	end

	local var_25_0 = arg_25_0:_getPlayId(arg_25_1)

	arg_25_0:dispatchEvent(AudioBgmEvent.onPlayBgm, arg_25_1.layer, var_25_0)

	if var_25_0 > 0 then
		AudioMgr.instance:trigger(var_25_0)
		arg_25_1:setSwitch()

		if arg_25_1.resumeId then
			arg_25_0._canPauseList[arg_25_1.layer] = arg_25_1
		end
	end

	arg_25_0:_playBindList(arg_25_1)
end

function var_0_0._playBindList(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._bgmInfo:getBindList(arg_26_1.layer)

	if not var_26_0 then
		return
	end

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_1 = arg_26_0._bgmInfo:getBgmData(iter_26_1)

		if var_26_1 then
			local var_26_2 = arg_26_0:_getPlayId(var_26_1)

			if var_26_2 > 0 then
				AudioMgr.instance:trigger(var_26_2)
			end
		end
	end
end

function var_0_0._stopBindList(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._bgmInfo:getBindList(arg_27_1.layer)

	if not var_27_0 then
		return
	end

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		local var_27_1 = arg_27_0._bgmInfo:getBgmData(iter_27_1)

		if var_27_1 then
			local var_27_2 = arg_27_0:_getStopId(var_27_1)

			if var_27_2 > 0 then
				AudioMgr.instance:trigger(var_27_2)
			end
		end
	end
end

function var_0_0._clearPauseBgm(arg_28_0, arg_28_1)
	if arg_28_1 and arg_28_1.clearPauseBgm then
		arg_28_0:_forceClearPauseBgm()
	end
end

function var_0_0._forceClearPauseBgm(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0._canPauseList) do
		AudioMgr.instance:trigger(iter_29_1.stopId)
		rawset(arg_29_0._canPauseList, iter_29_0, nil)
	end
end

function var_0_0._getPlayId(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return nil
	end

	if arg_30_0._canPauseList[arg_30_1.layer] then
		return arg_30_1.resumeId
	else
		return arg_30_1.playId
	end
end

function var_0_0._getStopId(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return nil
	end

	if arg_31_0._canPauseList[arg_31_1.layer] then
		return arg_31_1.pauseId
	else
		return arg_31_1.stopId
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
