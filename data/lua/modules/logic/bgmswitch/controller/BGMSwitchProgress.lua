module("modules.logic.bgmswitch.controller.BGMSwitchProgress", package.seeall)

slot0 = class("BGMSwitchProgress")
slot1 = 0.03

function slot0.playMainBgm(slot0, slot1)
	slot0._bgmCO = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(slot1)

	if not slot0._bgmCO then
		slot0._progressTimeSec = 0

		WeatherController.instance:unregisterCallback(WeatherEvent.WeatherChanged, slot0._onWeatherChange, slot0)
		AudioMgr.instance:unregisterCallback(AudioMgr.Evt_Trigger, slot0._onTriggerEvent, slot0)
		TaskDispatcher.cancelTask(slot0._onTick, slot0)

		return
	end

	WeatherController.instance:registerCallback(WeatherEvent.WeatherChanged, slot0._onWeatherChange, slot0)
	AudioMgr.instance:registerCallback(AudioMgr.Evt_Trigger, slot0._onTriggerEvent, slot0)
	TaskDispatcher.runRepeat(slot0._onTick, slot0, uv0)

	slot0._bgmAudioLength = BGMSwitchModel.instance:getReportBgmAudioLength(slot0._bgmCO)
	slot0._progressTimeSec = 0

	slot0:_updateGMProgress()
end

function slot0.stopMainBgm(slot0)
	WeatherController.instance:unregisterCallback(WeatherEvent.WeatherChanged, slot0._onWeatherChange, slot0)
	AudioMgr.instance:unregisterCallback(AudioMgr.Evt_Trigger, slot0._onTriggerEvent, slot0)
	TaskDispatcher.cancelTask(slot0._onTick, slot0)

	slot0._progressTimeSec = 0

	slot0:_updateGMProgress()
end

function slot0.getProgress(slot0)
	return slot0._progressTimeSec
end

function slot0._onWeatherChange(slot0)
	if slot0._bgmCO and slot0._bgmCO.isReport == 1 then
		slot2 = WeatherController.instance:getCurLightMode()

		if WeatherController.instance:getPrevLightMode() and slot2 and slot1 ~= slot2 then
			slot0._bgmAudioLength = BGMSwitchModel.instance:getReportBgmAudioLength(slot0._bgmCO)
			slot0._progressTimeSec = 0
		end
	end
end

function slot0._onTriggerEvent(slot0, slot1)
	if slot1 == AudioEnum.UI.Pause_MainMusic then
		TaskDispatcher.cancelTask(slot0._onTick, slot0)
		slot0:_updateGMProgress()
	elseif slot1 == AudioEnum.UI.Resume_MainMusic then
		TaskDispatcher.runRepeat(slot0._onTick, slot0, uv0)
		slot0:_updateGMProgress()
	end
end

function slot0._onTick(slot0)
	if not BGMSwitchController.instance:getPlayingId() then
		return
	end

	if AudioMgr.instance:getSourcePlayPosition(slot1) / 1000 < 0 then
		return
	end

	slot0._progressTimeSec = slot2

	if (slot0._bgmAudioLength and slot0._bgmAudioLength > 0 and slot0._bgmAudioLength or 10) <= slot2 + 0.5 then
		slot0._progressTimeSec = 0

		if BGMSwitchModel.instance:getUsedBgmIdFromServer() == BGMSwitchModel.RandomBgmId and not ViewMgr.instance:isOpen(ViewName.BGMSwitchView) then
			BGMSwitchController.instance:checkStartMainBGM(false)
		end

		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmProgressEnd)
	end

	slot0:_updateGMProgress()
end

slot0.WeatherLight = {
	"白天",
	"阴天",
	"黄昏",
	"夜晚"
}
slot0.WeatherEffect = {
	"天气无",
	"阳光明媚",
	"小雨",
	"大雨",
	"暴风雨",
	"小雪",
	"大雪",
	"大雾",
	"白天烟花",
	"夜晚烟花"
}

function slot0._updateGMProgress(slot0)
	if not isDebugBuild then
		return
	end

	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0) == 0 then
		gohelper.setActive(slot0._progressGO, false)

		return
	end

	if not slot0._progressText then
		slot0._progressGO = GMController.instance:getGMNode("mainview", ViewMgr.instance:getUILayer(UILayerName.Top))
		slot0._progressGO.name = "bgm_progress"

		if slot0._progressGO then
			slot1 = gohelper.findChildImage(slot0._progressGO, "#btn_gm")
			slot1.raycastTarget = false
			slot1.color = Color.New(1, 1, 1, 0.3)

			recthelper.setWidth(slot1.transform, 500)

			slot0._progressText = gohelper.findChildText(slot0._progressGO, "#btn_gm/Text")
		end
	end

	slot1 = slot0._progressTimeSec ~= nil

	gohelper.setActive(slot0._progressGO, slot1)

	if slot1 and slot0._progressText and slot0._bgmCO then
		slot2 = ""

		if slot0._bgmCO.id == 1001 then
			slot2 = uv0.WeatherLight[WeatherController.instance:getCurrReport() and slot3.lightMode or 1] .. "-" .. uv0.WeatherEffect[slot3 and slot3.effect or 1]
		end

		slot0._progressText.text = string.format("bgm:%s %s\n%.1f/%.1f s", slot0._bgmCO.audioName, slot2, slot0._progressTimeSec > 0 and slot0._progressTimeSec or 0, slot0._bgmAudioLength)
	end
end

return slot0
