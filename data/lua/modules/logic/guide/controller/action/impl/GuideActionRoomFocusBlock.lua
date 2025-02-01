module("modules.logic.guide.controller.action.impl.GuideActionRoomFocusBlock", package.seeall)

slot0 = class("GuideActionRoomFocusBlock", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = slot0.actionParam and string.splitToNumber(slot0.actionParam, "#")

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		slot5 = gohelper.find(GuideModel.instance:getStepGOPath(slot0.guideId, slot0.stepId)) and MonoHelper.getLuaComFromGo(slot4, RoomMapBlockEntity) or slot4 and MonoHelper.getLuaComFromGo(slot4, RoomEmptyBlockEntity) or slot4 and MonoHelper.getLuaComFromGo(slot4, RoomBuildingEntity)

		if slot5 and slot5:getMO() then
			GameSceneMgr.instance:getCurScene().camera:tweenCamera({
				focusX = HexMath.hexToPosition(slot6.hexPoint, RoomBlockEnum.BlockSize).x + (slot2 and slot2[1] or 0),
				focusY = slot7.y + (slot2 and slot2[2] or 0)
			})
			TaskDispatcher.runDelay(slot0._onDone, slot0, 0.7)
		else
			slot0:onDone(true)
		end
	else
		logError("不在小屋场景，指引失败 " .. slot0.guideId .. "_" .. slot0.stepId)
		slot0:onDone(true)
	end
end

function slot0._onDone(slot0, slot1)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._onDone, slot0)
end

return slot0
