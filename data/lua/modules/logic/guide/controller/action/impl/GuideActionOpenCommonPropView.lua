module("modules.logic.guide.controller.action.impl.GuideActionOpenCommonPropView", package.seeall)

slot0 = class("GuideActionOpenCommonPropView", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot8 = ","
	slot4 = {}

	for slot8, slot9 in ipairs(GameUtil.splitString2(slot0.actionParam, false, "$", slot8)) do
		slot10 = MaterialDataMO.New()

		slot10:initValue(slot9[1], slot9[2], slot9[3])
		table.insert(slot4, slot10)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot4)
	slot0:onDone(true)
end

return slot0
