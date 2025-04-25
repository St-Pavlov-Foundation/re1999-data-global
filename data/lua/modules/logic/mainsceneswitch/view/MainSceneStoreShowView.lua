module("modules.logic.mainsceneswitch.view.MainSceneStoreShowView", package.seeall)

slot0 = class("MainSceneStoreShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_close")
	slot0._goweatherRoot = gohelper.findChild(slot0.viewGO, "left/#go_weatherRoot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goweatherRoot, false)

	slot0._rawImage = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "RawImage"), gohelper.Type_RawImage)

	gohelper.setActive(slot0._rawImage, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._sceneId = slot0.viewParam.sceneId

	MainSceneSwitchCameraController.instance:showScene(slot0._sceneId, slot0._showSceneFinished, slot0)
end

function slot0._showSceneFinished(slot0, slot1)
	if not slot0._rawImage then
		return
	end

	gohelper.setActive(slot0._rawImage, true)
	MainSceneSwitchInfoDisplayView.adjustRt(slot0._rawImage, slot1)

	slot0._weatherSwitchControlComp = slot0._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goweatherRoot, WeatherSwitchControlComp)

	slot0._weatherSwitchControlComp:updateScene(slot0._sceneId, MainSceneSwitchCameraDisplayController.instance)
end

function slot0.onClose(slot0)
	if slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj, slot0.viewParam)

		slot0.viewParam.callback = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
