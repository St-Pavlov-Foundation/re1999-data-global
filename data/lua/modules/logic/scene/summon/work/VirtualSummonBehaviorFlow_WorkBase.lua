module("modules.logic.scene.summon.work.VirtualSummonBehaviorFlow_WorkBase", package.seeall)

slot0 = class("VirtualSummonBehaviorFlow_WorkBase", BaseWork)
slot1 = 3

function slot0.startBlock(slot0, slot1, slot2)
	slot3 = slot1 or slot0.class.__cname

	UIBlockHelper.instance:startBlock(slot3, slot2 or uv0)

	return slot3
end

function slot0.endBlock(slot0, slot1)
	UIBlockHelper.instance:startBlock(slot1 or slot0.class.__cname)
end

return slot0
