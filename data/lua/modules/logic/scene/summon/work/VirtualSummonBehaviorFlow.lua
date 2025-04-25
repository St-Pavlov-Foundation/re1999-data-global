module("modules.logic.scene.summon.work.VirtualSummonBehaviorFlow", package.seeall)

slot0 = class("VirtualSummonBehaviorFlow", FlowParallel)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
	slot0:addWork(VirtualSummonBehaviorFlow_Work1.New())
end

function slot0.start(slot0, slot1, slot2)
	assert(slot1 and #slot1 > 0)

	slot0._heroIdList = slot1
	slot0._backToMainSceneCallBack = slot2

	uv0.super.start(slot0)
end

function slot0.heroIdList(slot0)
	return slot0._heroIdList
end

function slot0.backToMainSceneCallBack(slot0)
	return slot0._backToMainSceneCallBack
end

function slot0.onDestroyView(slot0)
	slot0:destroy()
end

function slot0.addWork(slot0, slot1)
	uv0.super.addWork(slot0, slot1)
	slot1:setRootInternal(slot0)

	return slot1
end

return slot0
