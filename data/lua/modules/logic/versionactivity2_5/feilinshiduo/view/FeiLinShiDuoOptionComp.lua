module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoOptionComp", package.seeall)

slot0 = class("FeiLinShiDuoOptionComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot0.go.transform
end

function slot0.initData(slot0, slot1, slot2)
	slot0.itemInfo = slot1
	slot0.sceneViewCls = slot2
	slot0.playerGO = slot2:getPlayerGO()
	slot0.playerTrans = slot0.playerGO.transform
	slot0.refId = slot0.itemInfo.refId
	slot0.doorItemInfo = nil
	slot0.curOpenState = false
end

function slot0.addEventListeners(slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, slot0.resetData, slot0)
end

function slot0.removeEventListeners(slot0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, slot0.resetData, slot0)
end

function slot0.resetData(slot0)
	slot0.curOpenState = false
end

function slot0.onTick(slot0)
	slot0:initDoorItem()
	slot0:handleEvent()
end

function slot0.initDoorItem(slot0)
	if not slot0.doorItemInfo then
		for slot6, slot7 in pairs(FeiLinShiDuoGameModel.instance:getElementMap()[FeiLinShiDuoEnum.ObjectType.Door] or {}) do
			if slot7.refId == slot0.refId then
				slot0.doorItemInfo = slot7

				break
			end
		end

		if not slot0.doorItemInfo then
			return
		end

		slot3 = slot0.sceneViewCls:getElementGOMap()
		slot0.doorGO = slot3[slot0.doorItemInfo.id].subGOList[1]
		slot0.boxElementMap = slot1[FeiLinShiDuoEnum.ObjectType.Box]
		slot0.doorAnim = slot0.doorGO:GetComponent(gohelper.Type_Animator)
		slot0.curOpenState = false
		slot0.optionGO = slot3[slot0.itemInfo.id].subGOList[1]
		slot0.optionAnim = slot0.optionGO:GetComponent(gohelper.Type_Animator)
	end
end

function slot0.handleEvent(slot0)
	if not slot0.sceneViewCls or not slot0.doorItemInfo then
		return
	end

	slot0:checkTouchBoxOrPlayer()
end

function slot0.checkTouchBoxOrPlayer(slot0)
	slot1 = false

	if FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(slot0.trans.localPosition.x, slot0.trans.localPosition.y - 1, slot0.itemInfo, FeiLinShiDuoEnum.checkDir.Top, slot0.boxElementMap) and #slot2 > 0 or slot0.itemInfo.pos[1] < slot0.playerTrans.localPosition.x and slot0.playerTrans.localPosition.x < slot0.itemInfo.pos[1] + slot0.itemInfo.width and slot0.playerTrans.localPosition.y > slot0.itemInfo.pos[2] - 1 and slot0.playerTrans.localPosition.y < slot0.itemInfo.pos[2] + slot0.itemInfo.height then
		slot1 = true
	end

	slot0:setOpenState(slot1)
end

function slot0.setOpenState(slot0, slot1)
	if slot0.curOpenState ~= slot1 then
		slot0.curOpenState = slot1

		slot0.optionAnim:Play(slot1 and "in" or "out")
		slot0.doorAnim:Play(slot1 and "out" or "in")

		if slot1 then
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_door_open)
		else
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_door_close)
		end

		FeiLinShiDuoGameModel.instance:setDoorOpenState(slot0.doorItemInfo.id, slot0.curOpenState)
	end
end

return slot0
