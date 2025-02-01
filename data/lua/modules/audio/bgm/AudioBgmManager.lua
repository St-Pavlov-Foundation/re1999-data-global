module("modules.audio.bgm.AudioBgmManager", package.seeall)

slot0 = class("AudioBgmManager")

function slot0.ctor(slot0)
	slot0._bgmInfo = AudioBgmInfo.New()
	slot0._curBgmData = nil
	slot0._canPauseList = {}

	slot0:_addEvents()
end

function slot0.init(slot0)
end

function slot0._addEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinsh, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, slot0._onReOpenWhileOpen, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterScene, slot0._onEnterScene, slot0)
end

function slot0._onEnterScene(slot0)
	slot0:_forceClearPauseBgm()
end

function slot0._onReOpenWhileOpen(slot0, slot1)
	slot0:_startCheckBgm()
end

function slot0._onCloseViewFinish(slot0, slot1)
	slot0:_startCheckBgm()
end

function slot0._onOpenViewFinsh(slot0, slot1)
	slot0:_startCheckBgm()
end

function slot0.checkBgm(slot0)
	slot0:_startCheckBgm()
end

function slot0._startCheckBgm(slot0)
	slot0._startFromat = 0

	TaskDispatcher.cancelTask(slot0._checkBgm, slot0)
	TaskDispatcher.runRepeat(slot0._checkBgm, slot0, 0)
end

function slot0._checkBgm(slot0)
	if slot0._startFromat == 0 then
		slot0._startFromat = slot0._startFromat + 1

		return
	end

	if slot0:_getTopViewBgm() or slot0:_getSceneBgm() then
		slot0:_clearPauseBgm(slot1)

		if slot1:getBgmLayer() then
			TaskDispatcher.cancelTask(slot0._checkBgm, slot0)
			slot0:playBgm(slot2)
		end
	else
		TaskDispatcher.cancelTask(slot0._checkBgm, slot0)
		slot0:_setBgmData(nil)
	end
end

function slot0._getTopViewBgm(slot0)
	for slot5 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
		if ViewMgr.instance:getContainer(slot1[slot5]) and slot0._bgmInfo:getViewBgmUsage(slot6) then
			return slot8
		end
	end
end

function slot0._getSceneBgm(slot0)
	return slot0._bgmInfo:getSceneBgmUsage(GameSceneMgr.instance:getCurSceneType())
end

function slot0.modifyAndPlay(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if AudioMgr.instance:useDefaultBGM() then
		if slot1 == AudioBgmEnum.Layer.Fight then
			slot2 = AudioEnum.Default_Fight_Bgm
			slot3 = AudioEnum.Default_Fight_Bgm_Stop
		else
			slot2 = AudioEnum.Default_UI_Bgm
			slot3 = AudioEnum.Default_UI_Bgm_Stop
		end
	end

	slot0:stopBgm(slot1)
	slot0:modifyBgm(slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0:playBgm(slot1)
end

function slot0.stopAndRemove(slot0, slot1)
	slot0:stopBgm(slot1)
	slot0:removeBgm(slot1)
end

function slot0.stopAndClear(slot0, slot1)
	slot0:stopBgm(slot1)
	slot0:clearBgm(slot1)
end

function slot0.modifyBgm(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0._bgmInfo:modifyBgmData(slot1, slot2, slot3, slot4, slot5, slot6, slot7)
end

function slot0.modifyBgmAudioId(slot0, slot1, slot2)
	if slot0._bgmInfo:modifyBgmAudioId(slot1, slot2) and slot0._curBgmData == slot0._bgmInfo:getBgmData(slot1) then
		slot0:_stopBgm(slot3)
		slot0:_playBgm(slot3)
	end
end

function slot0.setSwitchData(slot0, slot1, slot2, slot3)
	if slot0._bgmInfo:getBgmData(slot1) then
		slot4.switchGroup = slot2
		slot4.switchState = slot3
	end
end

function slot0.removeBgm(slot0, slot1)
	slot0._bgmInfo:removeBgm(slot1)
end

function slot0.clearBgm(slot0, slot1)
	slot0._bgmInfo:clearBgm(slot1)
end

function slot0.playBgm(slot0, slot1)
	slot0:_setBgmData(slot0._bgmInfo:getBgmData(slot1))
end

function slot0.stopBgm(slot0, slot1)
	if slot0._curBgmData == slot0._bgmInfo:getBgmData(slot1) then
		slot0:_setBgmData(nil)
	end
end

function slot0._setBgmData(slot0, slot1)
	if slot0._curBgmData == slot1 then
		return
	end

	if slot0:_getPlayId(slot0._curBgmData) == slot0:_getPlayId(slot1) then
		slot0._curBgmData = slot1

		return
	end

	slot0:_stopBgm(slot0._curBgmData)

	slot0._curBgmData = slot1

	slot0:_playBgm(slot0._curBgmData)
end

function slot0._stopBgm(slot0, slot1)
	if not slot1 then
		return nil
	end

	slot2 = slot0:_getStopId(slot1)

	slot0:dispatchEvent(AudioBgmEvent.onStopBgm, slot1.layer, slot2)

	if slot2 > 0 then
		AudioMgr.instance:trigger(slot2)
	end

	slot0:_stopBindList(slot1)
end

function slot0._playBgm(slot0, slot1)
	if not slot1 then
		return nil
	end

	slot2 = slot0:_getPlayId(slot1)

	slot0:dispatchEvent(AudioBgmEvent.onPlayBgm, slot1.layer, slot2)

	if slot2 > 0 then
		AudioMgr.instance:trigger(slot2)
		slot1:setSwitch()

		if slot1.resumeId then
			slot0._canPauseList[slot1.layer] = slot1
		end
	end

	slot0:_playBindList(slot1)
end

function slot0._playBindList(slot0, slot1)
	if not slot0._bgmInfo:getBindList(slot1.layer) then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot0._bgmInfo:getBgmData(slot7) and slot0:_getPlayId(slot8) > 0 then
			AudioMgr.instance:trigger(slot9)
		end
	end
end

function slot0._stopBindList(slot0, slot1)
	if not slot0._bgmInfo:getBindList(slot1.layer) then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot0._bgmInfo:getBgmData(slot7) and slot0:_getStopId(slot8) > 0 then
			AudioMgr.instance:trigger(slot9)
		end
	end
end

function slot0._clearPauseBgm(slot0, slot1)
	if slot1 and slot1.clearPauseBgm then
		slot0:_forceClearPauseBgm()
	end
end

function slot0._forceClearPauseBgm(slot0)
	for slot4, slot5 in pairs(slot0._canPauseList) do
		AudioMgr.instance:trigger(slot5.stopId)
		rawset(slot0._canPauseList, slot4, nil)
	end
end

function slot0._getPlayId(slot0, slot1)
	if not slot1 then
		return nil
	end

	if slot0._canPauseList[slot1.layer] then
		return slot1.resumeId
	else
		return slot1.playId
	end
end

function slot0._getStopId(slot0, slot1)
	if not slot1 then
		return nil
	end

	if slot0._canPauseList[slot1.layer] then
		return slot1.pauseId
	else
		return slot1.stopId
	end
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
