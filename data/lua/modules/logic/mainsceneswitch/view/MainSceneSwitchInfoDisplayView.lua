module("modules.logic.mainsceneswitch.view.MainSceneSwitchInfoDisplayView", package.seeall)

slot0 = class("MainSceneSwitchInfoDisplayView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg1 = gohelper.findChild(slot0.viewGO, "#go_bg1")
	slot0._gobg2 = gohelper.findChild(slot0.viewGO, "#go_bg2")
	slot0._simageFullBG1 = gohelper.findChildSingleImage(slot0._gobg1, "img")
	slot0._simageFullBG2 = gohelper.findChildSingleImage(slot0._gobg2, "img")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._weatherRoot = gohelper.findChild(slot0.viewGO, "left/#go_weatherRoot")

	gohelper.setActive(slot0._weatherRoot, false)

	slot0._rawImage = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "RawImage"), gohelper.Type_RawImage)

	gohelper.setActive(slot0._rawImage, false)
	MainSceneSwitchCameraController.instance:clear()
	slot0:_clearPage()
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowPreviewSceneInfo, slot0._onShowSceneInfo, slot0)
end

function slot0._onShowSceneInfo(slot0, slot1)
	slot0:_hideMainScene()

	slot0._sceneId = slot1

	MainSceneSwitchCameraController.instance:showScene(slot1, slot0._showSceneFinished, slot0)
end

function slot0.adjustRt(slot0, slot1)
	slot0.texture = slot1

	slot0:SetNativeSize()

	slot5 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform) / slot1.width

	transformhelper.setLocalScale(slot0.transform, slot5, slot5, 1)
end

function slot0._showSceneFinished(slot0, slot1)
	gohelper.setActive(slot0._rawImage, true)
	uv0.adjustRt(slot0._rawImage, slot1)

	slot0._weatherSwitchControlComp = slot0._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(slot0._weatherRoot, WeatherSwitchControlComp)

	slot0._weatherSwitchControlComp:updateScene(slot0._sceneId, MainSceneSwitchCameraDisplayController.instance)
end

function slot0._clearPage(slot0)
	gohelper.setActive(slot0._simageFullBG1, false)
	gohelper.setActive(slot0._simageFullBG2, false)
end

function slot0._hideMainScene(slot0)
	slot0._isPreview = slot0.viewParam and slot0.viewParam.isPreview

	if slot0._isPreview then
		MainSceneSwitchDisplayController.instance:hideScene()
	end
end

function slot0.onClose(slot0)
	MainSceneSwitchCameraController.instance:clear()

	if slot0._isPreview then
		MainSceneSwitchDisplayController.instance:showCurScene()
	end
end

function slot0.onDestroyView(slot0)
	slot0:_clearPage()
end

return slot0
