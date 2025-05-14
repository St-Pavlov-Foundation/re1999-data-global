module("modules.logic.bgmswitch.view.BGMSwitchView", package.seeall)

local var_0_0 = class("BGMSwitchView", BaseView)
local var_0_1 = {
	"singlebg/bgmtoggle_singlebg/bg_beijing.png",
	"singlebg/bgmtoggle_singlebg/bg_beijingyintian.png",
	"singlebg/bgmtoggle_singlebg/bg_beijingxiyang.png",
	"singlebg/bgmtoggle_singlebg/bg_beijingwanshang.png"
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomechine = gohelper.findChild(arg_1_0.viewGO, "#go_mechine")
	arg_1_0._gomusics = gohelper.findChild(arg_1_0.viewGO, "#go_musics")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(WeatherController.instance, WeatherEvent.WeatherChanged, arg_2_0._updateBg, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(WeatherController.instance, WeatherEvent.WeatherChanged, arg_3_0._updateBg, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._viewAnim = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0:_updateBg()
end

function var_0_0._updateBg(arg_5_0)
	local var_5_0, var_5_1 = WeatherController.instance:getCurrReport()
	local var_5_2 = var_5_0 and var_5_0.lightMode or 1

	if var_5_2 <= #var_0_1 then
		arg_5_0._simagebg:LoadImage(var_0_1[var_5_2])
	else
		logError("天气光照索引大于背景图数量")
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam

	if arg_7_0.viewParam then
		if arg_7_0.viewParam == true then
			arg_7_0._viewAnim:Play("thumbnail", 0, 0)
		elseif var_7_0.isGuide then
			arg_7_0:_initCamera()
			MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
			gohelper.setActive(arg_7_0._viewGO, false)
		end
	else
		arg_7_0:_initCamera()
	end

	BGMSwitchAudioTrigger.play_ui_replay_open()
end

function var_0_0._initCamera(arg_8_0)
	arg_8_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_8_0._cameraAnimator.enabled = true
	arg_8_0._cameraTrace = CameraMgr.instance:getCameraTrace()
	arg_8_0._cameraTrace.enabled = true

	local var_8_0 = arg_8_0.viewContainer:getSetting().otherRes[1]
	local var_8_1 = arg_8_0.viewContainer._abLoader:getAssetItem(var_8_0):GetResource()

	arg_8_0._cameraAnimator.runtimeAnimatorController = var_8_1

	arg_8_0._cameraAnimator:Play("bgm_open", 0, 0)
	arg_8_0._viewAnim:Play("open", 0, 0)
end

function var_0_0.onClose(arg_9_0)
	arg_9_0._viewAnim:Play("close", 0, 0)

	if not arg_9_0.viewParam then
		arg_9_0._cameraAnimator:Play("bgm_close")
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
	end

	BGMSwitchAudioTrigger.play_ui_replay_close()
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagebg:UnLoadImage()
end

return var_0_0
