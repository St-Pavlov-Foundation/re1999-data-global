module("modules.logic.versionactivity1_2.yaxian.controller.game.interacts.YaXianInteractPlayerHandle", package.seeall)

slot0 = class("YaXianInteractPlayerHandle", YaXianInteractHandleBase)

function slot0.onSelectCall(slot0)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.ShowCanWalkGround, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractStatus, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshAllInteractAlertArea, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractPath, true)
end

function slot0.onCancelSelect(slot0)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.ShowCanWalkGround, false)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractStatus, false)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshAllInteractAlertArea, false)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractPath, false)
end

function slot0.onSelectPos(slot0, slot1, slot2)
	slot5 = YaXianGameModel.instance
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.getCanWalkTargetPosDict(slot7)) do
		if slot7.x == slot1 and slot7.y == slot2 then
			Activity115Rpc.instance:sendAct115BeginRoundRequest(YaXianGameEnum.ActivityId, {
				{
					id = slot0._interactObject.interactMo.id,
					dir = slot6
				}
			})
			YaXianGameController.instance:setSelectObj()

			return
		end
	end

	return true
end

return slot0
