module("modules.logic.versionactivity2_5.liangyue.view.LiangYueAttributeItem", package.seeall)

slot0 = class("LiangYueAttributeItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._go_Target1 = gohelper.findChild(slot1, "#go_Target1")
	slot0._go_Target2 = gohelper.findChild(slot1, "#go_Target2")
	slot0._go_Target3 = gohelper.findChild(slot1, "#go_Target3")

	slot0:initComp()
end

function slot0.initComp(slot0)
	slot0._descItemList = {}
	slot0._targetObjList = {
		slot0._go_Target1,
		slot0._go_Target2,
		slot0._go_Target3
	}

	for slot4, slot5 in ipairs(slot0._targetObjList) do
		slot6 = LiangYueAttributeDescItem.New()

		slot6:init(slot5)
		table.insert(slot0._descItemList, slot6)
	end
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.setInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._descItemList) do
		if not slot1[slot5] then
			slot6:setActive(false)
		else
			slot7 = slot1[slot5]

			slot6:setActive(true)
			slot6:setInfo(slot7[2], slot7[3])
		end
	end
end

function slot0.setItemPos(slot0, slot1, slot2)
	slot0.yPos = slot1
	slot0.columnCount = slot2
end

function slot0.onDestroy(slot0)
end

return slot0
