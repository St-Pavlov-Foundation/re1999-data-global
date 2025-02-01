module("modules.logic.scene.pushbox.logic.PushBoxElementMechanics", package.seeall)

slot0 = class("PushBoxElementMechanics", UserDataDispose)

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

function slot0.setRendererIndex(slot0)
	slot1 = slot0._cell:getRendererIndex()

	for slot5 = 0, slot0._transform.childCount - 1 do
		for slot11 = 0, slot0._transform:GetChild(slot5):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)).Length - 1 do
			slot7[slot11].sortingOrder = slot1
		end
	end
end

function slot0.refreshMechanicsState(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot0._gameObject, "Enabled"), slot1)
	gohelper.setActive(gohelper.findChild(slot0._gameObject, "Normal"), not slot1)

	if slot1 and slot1 ~= slot0._last_has_box then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_organ_open)
	end

	slot0._last_has_box = slot1
end

function slot0._onStartElement(slot0)
end

function slot0._onRevertStep(slot0)
end

function slot0._onRefreshElement(slot0)
end

function slot0._onStepFinished(slot0)
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
