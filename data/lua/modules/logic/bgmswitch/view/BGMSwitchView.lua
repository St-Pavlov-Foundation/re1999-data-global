module("modules.logic.bgmswitch.view.BGMSwitchView", package.seeall)

slot0 = class("BGMSwitchView", BaseView)
slot1 = {
	"singlebg/bgmtoggle_singlebg/bg_beijing.png",
	"singlebg/bgmtoggle_singlebg/bg_beijingyintian.png",
	"singlebg/bgmtoggle_singlebg/bg_beijingxiyang.png",
	"singlebg/bgmtoggle_singlebg/bg_beijingwanshang.png"
}

function slot0.onInitView(slot0)
	slot0._gomechine = gohelper.findChild(slot0.viewGO, "#go_mechine")
	slot0._gomusics = gohelper.findChild(slot0.viewGO, "#go_musics")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(WeatherController.instance, WeatherEvent.WeatherChanged, slot0._updateBg, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(WeatherController.instance, WeatherEvent.WeatherChanged, slot0._updateBg, slot0)
end

function slot0._editableInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:_updateBg()
end

function slot0._updateBg(slot0)
	slot1, slot2 = WeatherController.instance:getCurrReport()

	if (slot1 and slot1.lightMode or 1) <= #uv0 then
		slot0._simagebg:LoadImage(uv0[slot3])
	else
		logError("天气光照索引大于背景图数量")
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam

	if slot0.viewParam then
		if slot0.viewParam == true then
			slot0._viewAnim:Play("thumbnail", 0, 0)
		elseif slot1.isGuide then
			slot0:_initCamera()
			MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
			gohelper.setActive(slot0._viewGO, false)
		end
	else
		slot0:_initCamera()
	end

	BGMSwitchAudioTrigger.play_ui_replay_open()
end

function slot0._initCamera(slot0)
	slot0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	slot0._cameraAnimator.enabled = true
	slot0._cameraTrace = CameraMgr.instance:getCameraTrace()
	slot0._cameraTrace.enabled = true
	slot0._cameraAnimator.runtimeAnimatorController = slot0.viewContainer._abLoader:getAssetItem(slot0.viewContainer:getSetting().otherRes[1]):GetResource()

	slot0._cameraAnimator:Play("bgm_open", 0, 0)
	slot0._viewAnim:Play("open", 0, 0)
end

function slot0.onClose(slot0)
	slot0._viewAnim:Play("close", 0, 0)

	if not slot0.viewParam then
		slot0._cameraAnimator:Play("bgm_close")
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
	end

	BGMSwitchAudioTrigger.play_ui_replay_close()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
