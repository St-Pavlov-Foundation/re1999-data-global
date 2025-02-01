module("modules.logic.guide.controller.action.impl.GuideActionExploreShowOutline", package.seeall)

slot0 = class("GuideActionExploreShowOutline", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	slot2 = string.splitToNumber(slot0.actionParam, "#")

	if ExploreController.instance:getMap() then
		if slot5:getUnit(slot2[1]) then
			slot6:forceOutLine(slot2[2] == 1)
		end
	else
		logError("不在密室中？？？")
	end

	slot0:onDone(true)
end

return slot0
