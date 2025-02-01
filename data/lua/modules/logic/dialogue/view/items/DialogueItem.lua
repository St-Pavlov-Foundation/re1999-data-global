module("modules.logic.dialogue.view.items.DialogueItem", package.seeall)

slot0 = class("DialogueItem", UserDataDispose)

function slot0.CreateItem(slot0, slot1, slot2)
	if not DialogueEnum.DialogueItemCls[slot0.type] then
		logError("un support type dialogue type : " .. tostring(slot0.type))

		return nil
	end

	slot4 = slot3.New()

	slot4:init(slot0, slot1, slot2)

	return slot4
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0:__onInit()

	slot0.stepCo = slot1
	slot0.go = slot2
	slot0.transform = slot0.go.transform

	recthelper.setAnchorY(slot0.transform, -slot3)
	gohelper.setActive(slot2, true)
	slot0:initView()
	slot0:refresh()
	slot0:calculateHeight()
end

function slot0.initView(slot0)
end

function slot0.refresh(slot0)
end

function slot0.calculateHeight(slot0)
end

function slot0.getHeight(slot0)
	return slot0.height
end

function slot0.onDestroy(slot0)
end

function slot0.destroy(slot0)
	slot0:onDestroy()
	slot0:__onDispose()
end

return slot0
