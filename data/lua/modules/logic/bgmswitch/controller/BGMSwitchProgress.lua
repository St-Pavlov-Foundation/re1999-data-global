module("modules.logic.bgmswitch.controller.BGMSwitchProgress", package.seeall)

local var_0_0 = class("BGMSwitchProgress")
local var_0_1 = 0.03

function var_0_0.playMainBgm(arg_1_0, arg_1_1)
	arg_1_0._bgmCO = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(arg_1_1)

	if not arg_1_0._bgmCO then
		arg_1_0._progressTimeSec = 0

		WeatherController.instance:unregisterCallback(WeatherEvent.WeatherChanged, arg_1_0._onWeatherChange, arg_1_0)
		AudioMgr.instance:unregisterCallback(AudioMgr.Evt_Trigger, arg_1_0._onTriggerEvent, arg_1_0)
		TaskDispatcher.cancelTask(arg_1_0._onTick, arg_1_0)

		return
	end

	WeatherController.instance:registerCallback(WeatherEvent.WeatherChanged, arg_1_0._onWeatherChange, arg_1_0)
	AudioMgr.instance:registerCallback(AudioMgr.Evt_Trigger, arg_1_0._onTriggerEvent, arg_1_0)
	TaskDispatcher.runRepeat(arg_1_0._onTick, arg_1_0, var_0_1)

	arg_1_0._bgmAudioLength = BGMSwitchModel.instance:getReportBgmAudioLength(arg_1_0._bgmCO)
	arg_1_0._progressTimeSec = 0

	arg_1_0:_updateGMProgress()
end

function var_0_0.stopMainBgm(arg_2_0)
	WeatherController.instance:unregisterCallback(WeatherEvent.WeatherChanged, arg_2_0._onWeatherChange, arg_2_0)
	AudioMgr.instance:unregisterCallback(AudioMgr.Evt_Trigger, arg_2_0._onTriggerEvent, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._onTick, arg_2_0)

	arg_2_0._progressTimeSec = 0

	arg_2_0:_updateGMProgress()
end

function var_0_0.getProgress(arg_3_0)
	return arg_3_0._progressTimeSec
end

function var_0_0._onWeatherChange(arg_4_0)
	if arg_4_0._bgmCO and arg_4_0._bgmCO.isReport == 1 then
		local var_4_0 = WeatherController.instance:getPrevLightMode()
		local var_4_1 = WeatherController.instance:getCurLightMode()

		if var_4_0 and var_4_1 and var_4_0 ~= var_4_1 then
			arg_4_0._bgmAudioLength = BGMSwitchModel.instance:getReportBgmAudioLength(arg_4_0._bgmCO)
			arg_4_0._progressTimeSec = 0
		end
	end
end

function var_0_0._onTriggerEvent(arg_5_0, arg_5_1)
	if arg_5_1 == AudioEnum.UI.Pause_MainMusic then
		TaskDispatcher.cancelTask(arg_5_0._onTick, arg_5_0)
		arg_5_0:_updateGMProgress()
	elseif arg_5_1 == AudioEnum.UI.Resume_MainMusic then
		TaskDispatcher.runRepeat(arg_5_0._onTick, arg_5_0, var_0_1)
		arg_5_0:_updateGMProgress()
	end
end

function var_0_0._onTick(arg_6_0)
	local var_6_0 = BGMSwitchController.instance:getPlayingId()

	if not var_6_0 then
		return
	end

	local var_6_1 = AudioMgr.instance:getSourcePlayPosition(var_6_0) / 1000

	if var_6_1 < 0 then
		return
	end

	local var_6_2 = arg_6_0._bgmAudioLength and arg_6_0._bgmAudioLength > 0 and arg_6_0._bgmAudioLength or 10

	arg_6_0._progressTimeSec = var_6_1

	if var_6_2 <= var_6_1 + 0.5 then
		local var_6_3 = BGMSwitchModel.instance:getUsedBgmIdFromServer() == BGMSwitchModel.RandomBgmId
		local var_6_4 = ViewMgr.instance:isOpen(ViewName.BGMSwitchView)

		arg_6_0._progressTimeSec = 0

		if var_6_3 and not var_6_4 then
			BGMSwitchController.instance:checkStartMainBGM(false)
		end

		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BgmProgressEnd)
	end

	arg_6_0:_updateGMProgress()
end

var_0_0.WeatherLight = {
	"白天",
	"阴天",
	"黄昏",
	"夜晚"
}
var_0_0.WeatherEffect = {
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

function var_0_0._updateGMProgress(arg_7_0)
	if not isDebugBuild then
		return
	end

	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0) == 0 then
		gohelper.setActive(arg_7_0._progressGO, false)

		return
	end

	if not arg_7_0._progressText then
		arg_7_0._progressGO = GMController.instance:getGMNode("mainview", ViewMgr.instance:getUILayer(UILayerName.Top))
		arg_7_0._progressGO.name = "bgm_progress"

		if arg_7_0._progressGO then
			local var_7_0 = gohelper.findChildImage(arg_7_0._progressGO, "#btn_gm")

			var_7_0.raycastTarget = false
			var_7_0.color = Color.New(1, 1, 1, 0.3)

			recthelper.setWidth(var_7_0.transform, 500)

			arg_7_0._progressText = gohelper.findChildText(arg_7_0._progressGO, "#btn_gm/Text")
		end
	end

	local var_7_1 = arg_7_0._progressTimeSec ~= nil

	gohelper.setActive(arg_7_0._progressGO, var_7_1)

	if var_7_1 and arg_7_0._progressText and arg_7_0._bgmCO then
		local var_7_2 = ""

		if arg_7_0._bgmCO.id == 1001 then
			local var_7_3 = WeatherController.instance:getCurrReport()
			local var_7_4 = var_7_3 and var_7_3.lightMode or 1
			local var_7_5 = var_7_3 and var_7_3.effect or 1
			local var_7_6 = var_0_0.WeatherLight[var_7_4]
			local var_7_7 = var_0_0.WeatherEffect[var_7_5]

			var_7_2 = var_7_6 .. "-" .. var_7_7
		end

		local var_7_8 = arg_7_0._progressTimeSec > 0 and arg_7_0._progressTimeSec or 0
		local var_7_9 = arg_7_0._bgmAudioLength

		arg_7_0._progressText.text = string.format("bgm:%s %s\n%.1f/%.1f s", arg_7_0._bgmCO.audioName, var_7_2, var_7_8, var_7_9)
	end
end

return var_0_0
