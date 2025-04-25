module("modules.logic.mainsceneswitch.view.MainSceneSwitchDisplayView", package.seeall)

slot0 = class("MainSceneSwitchDisplayView", BaseView)

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
	MainSceneSwitchDisplayController.instance:initMaps()
	slot0:_initSceneRoot()
	slot0:_clearPage()
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowSceneInfo, slot0._onShowSceneInfo, slot0)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, slot0._onStartSwitchScene, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenView, slot0)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.MainSceneSkinMaterialTipView then
		MainSceneSwitchDisplayController.instance:setSwitchCompContinue(slot0._curShowSceneId, true)
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.MainSceneSkinMaterialTipView then
		MainSceneSwitchDisplayController.instance:setSwitchCompContinue(slot0._curShowSceneId, false)
	end
end

function slot0._onShowScene(slot0, slot1)
	MainSceneSwitchDisplayController.instance:showScene(slot1, function ()
		WeatherController.instance:FakeShowScene(false)

		uv0._weatherSwitchControlComp = uv0._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(uv0._weatherRoot, WeatherSwitchControlComp)

		uv0._weatherSwitchControlComp:updateScene(uv1, MainSceneSwitchDisplayController.instance)
	end)
end

function slot0._initSceneRoot(slot0)
	MainSceneSwitchDisplayController.instance:setSceneRoot(slot0:_getSceneRoot(GameSceneMgr.instance:getCurScene() and slot1:getSceneContainerGO()))
end

function slot0._getSceneRoot(slot0, slot1)
	slot2 = "mainSceneSkinRoot"

	for slot8 = 1, slot1.transform.childCount do
		if slot3:GetChild(slot8 - 1).name == slot2 then
			return slot9.gameObject
		end
	end

	return gohelper.create3d(slot1, slot2)
end

function slot0._onStartSwitchScene(slot0)
	MainSceneSwitchDisplayController.instance:hideScene()
end

function slot0._onShowSceneInfo(slot0, slot1)
	slot0._curShowSceneId = slot1
	slot0._curSceneId = MainSceneSwitchModel.instance:getCurSceneId()

	slot0:_onShowScene(slot1)
end

function slot0._clearPage(slot0)
	gohelper.setActive(slot0._simageFullBG1, false)
	gohelper.setActive(slot0._simageFullBG2, false)
end

function slot0.onTabSwitchOpen(slot0)
	gohelper.setActive(slot0._weatherRoot, true)
	slot0:_changeToPrevScene()
end

function slot0._changeToPrevScene(slot0)
	WeatherController.instance:onSceneHide(true)

	if slot0._prevShowSceneId then
		slot0._prevShowSceneId = nil

		slot0:_onShowScene(slot0._prevShowSceneId)
	end
end

function slot0._changeToMainScene(slot0)
	slot0._prevShowSceneId = slot0._curShowSceneId

	MainSceneSwitchDisplayController.instance:hideScene()
	WeatherController.instance:onSceneShow()
end

function slot0.onTabSwitchClose(slot0)
	gohelper.setActive(slot0._weatherRoot, false)
	slot0:_changeToMainScene()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowSceneInfo, slot0._onShowSceneInfo, slot0)
	slot0:removeEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, slot0._onStartSwitchScene, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenView, slot0)
	MainSceneSwitchDisplayController.instance:clear()
end

function slot0.onDestroyView(slot0)
	slot0:_clearPage()
end

return slot0
