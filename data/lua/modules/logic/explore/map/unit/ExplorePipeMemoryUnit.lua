module("modules.logic.explore.map.unit.ExplorePipeMemoryUnit", package.seeall)

slot0 = class("ExplorePipeMemoryUnit", ExplorePipeUnit)

function slot0.onResLoaded(slot0)
	uv0.super.onResLoaded(slot0)

	if gohelper.findChild(slot0._displayGo, "#go_rotate/effect2/root") then
		if slot0.mo:getNeedColor() == ExploreEnum.PipeColor.None then
			gohelper.setActive(slot1, false)
		else
			for slot7 = 0, slot1:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem), true).Length - 1 do
				slot8 = ExploreEnum.PipeColorDef[slot0.mo:getNeedColor()]

				ZProj.ParticleSystemHelper.SetStartColor(slot3[slot7], slot8.r, slot8.g, slot8.b, 1)
			end
		end
	end
end

function slot0.initComponents(slot0)
	uv0.super.initComponents(slot0)
	slot0:addComp("pipeComp", ExplorePipeComp)
end

function slot0.setupMO(slot0)
	uv0.super.setupMO(slot0)
	slot0.pipeComp:initData()
end

function slot0.onStatus2Change(slot0, slot1, slot2)
	slot0.mo:setCacheColor(slot2.color or ExploreEnum.PipeColor.None)
end

function slot0.processMapIcon(slot0, slot1)
	for slot6, slot7 in pairs(GameUtil.splitString2(slot1)) do
		if tonumber(slot7[1]) == slot0.mo:getNeedColor() then
			return slot7[2]
		end
	end

	return nil
end

return slot0
