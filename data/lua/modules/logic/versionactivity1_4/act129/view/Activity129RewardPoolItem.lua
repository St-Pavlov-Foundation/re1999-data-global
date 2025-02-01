module("modules.logic.versionactivity1_4.act129.view.Activity129RewardPoolItem", package.seeall)

slot0 = class("Activity129RewardPoolItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.goItem = slot1.goItem
	slot0.itemList = slot1.itemList
	slot0.rare = slot1.rare
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goGrid = gohelper.findChild(slot0.go, "Grid")
end

function slot0.setDict(slot0, slot1, slot2, slot3)
	if not slot1 then
		gohelper.setActive(slot0.go, false)

		return
	end

	slot0.actId = slot2
	slot0.poolId = slot3
	slot0.isNull = true
	slot0.count = 0
	slot4 = 1

	for slot8, slot9 in pairs(slot1) do
		for slot13, slot14 in ipairs(slot9) do
			slot0:tryAddReward(slot14, slot8, slot4)

			slot4 = slot4 + 1
		end
	end

	gohelper.setActive(slot0.go, not slot0.isNull)
	slot0:caleHeight()
end

function slot0.caleHeight(slot0)
	recthelper.setHeight(slot0.go.transform, math.ceil(slot0.count / 4) * 200 + 75)
end

function slot0.tryAddReward(slot0, slot1, slot2, slot3)
	if slot0.rare ~= slot2 then
		return
	end

	slot4 = slot0.itemList[slot3] or slot0:createReward(slot3)

	gohelper.addChild(slot0.goGrid, slot4.go)
	slot4:setData(slot1, slot0.actId, slot0.poolId, slot2)

	slot0.isNull = false
	slot0.count = slot0.count + 1
end

function slot0.createReward(slot0, slot1)
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0.goItem, slot0.goGrid), Activity129RewardItem)
	slot0.itemList[slot1] = slot3

	return slot3
end

function slot0.onDestroy(slot0)
end

return slot0
