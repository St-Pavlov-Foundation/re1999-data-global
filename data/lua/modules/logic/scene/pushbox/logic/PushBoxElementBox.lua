module("modules.logic.scene.pushbox.logic.PushBoxElementBox", package.seeall)

slot0 = class("PushBoxElementBox", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	slot0._gameObject = slot1
	slot0._transform = slot1.transform
	slot0._cell = slot2

	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshElement, slot0._onRefreshElement, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.StepFinished, slot0._onStepFinished, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.RevertStep, slot0._onRevertStep, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.StartElement, slot0._onStartElement, slot0)
end

function slot0._onStartElement(slot0)
end

function slot0._onRevertStep(slot0)
end

function slot0._onRefreshElement(slot0)
end

function slot0._onStepFinished(slot0)
end

function slot0.hideLight(slot0)
	gohelper.setActive(gohelper.findChild(slot0._gameObject, "#vx_light_left"), false)
	gohelper.setActive(gohelper.findChild(slot0._gameObject, "#vx_light_right"), false)
	gohelper.setActive(gohelper.findChild(slot0._gameObject, "#vx_light_down"), false)
end

function slot0.refreshLightRenderer(slot0, slot1)
	if gohelper.findChild(slot0._gameObject, "#vx_light_left"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)) then
		for slot6 = 0, slot2.Length - 1 do
			slot2[slot6].sortingOrder = slot1 + 7
		end
	end

	if gohelper.findChild(slot0._gameObject, "#vx_light_right"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)) then
		for slot6 = 0, slot2.Length - 1 do
			slot2[slot6].sortingOrder = slot1 + 7
		end
	end

	if gohelper.findChild(slot0._gameObject, "#vx_light_down"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)) then
		for slot6 = 0, slot2.Length - 1 do
			slot2[slot6].sortingOrder = slot1 + 7
		end
	end
end

function slot0.getPosX(slot0)
	return slot0._cell:getPosX()
end

function slot0.getPosY(slot0)
	return slot0._cell:getPosY()
end

function slot0.getObj(slot0)
	return slot0._gameObject
end

function slot0.getCell(slot0)
	return slot0._cell
end

function slot0.releaseSelf(slot0)
	slot0:__onDispose()
end

return slot0
