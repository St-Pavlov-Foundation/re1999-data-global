module("modules.logic.guide.controller.action.impl.GuideActionFinishMapElement", package.seeall)

slot0 = class("GuideActionFinishMapElement", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	DungeonRpc.instance:sendMapElementRequest(tonumber(slot0.actionParam))
	slot0:onDone(true)
end

return slot0
