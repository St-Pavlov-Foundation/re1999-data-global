module("modules.logic.guide.controller.action.impl.GuideActionExploreUseItem", package.seeall)

slot0 = class("GuideActionExploreUseItem", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	slot2 = string.splitToNumber(slot0.actionParam, "#")

	if ExploreBackpackModel.instance:getItem(slot2[1]) and ExploreModel.instance:getUseItemUid() == slot5.id ~= (slot2[2] == 1) then
		ExploreRpc.instance:sendExploreUseItemRequest(slot5.id, 0, 0)
	end

	slot0:onDone(true)
end

return slot0
