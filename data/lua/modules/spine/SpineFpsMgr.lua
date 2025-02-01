module("modules.spine.SpineFpsMgr", package.seeall)

slot0 = class("SpineFpsMgr")
slot1 = 30
slot0.FightScene = "FightScene"
slot0.Story = "Story"
slot0.Module = {
	[slot0.FightScene] = 60,
	[slot0.Story] = 60
}

function slot0.ctor(slot0)
	slot0._moduleKey2FpsDict = {}
end

function slot0.set(slot0, slot1)
	if uv0.Module[slot1] then
		slot0._moduleKey2FpsDict[slot1] = slot2

		slot0:_updateFps()
	else
		logError("key not in SpineFpsMgr.Module: " .. slot1)
	end
end

function slot0.remove(slot0, slot1)
	if slot0._moduleKey2FpsDict[slot1] then
		slot0._moduleKey2FpsDict[slot1] = nil

		slot0:_updateFps()
	end
end

function slot0._updateFps(slot0)
	for slot5, slot6 in pairs(slot0._moduleKey2FpsDict) do
		if uv0 < slot6 then
			slot1 = slot6
		end
	end

	Spine.Unity.SkeletonAnimation.SetTargetFps(slot1)
	Spine.Unity.SkeletonGraphic.SetTargetFps(slot1)
end

slot0.instance = slot0.New()

return slot0
