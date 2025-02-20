module("modules.logic.explore.map.unit.ExplorePipeSensorUnit", package.seeall)

slot0 = class("ExplorePipeSensorUnit", ExplorePipeUnit)

function slot0.onResLoaded(slot0)
	uv0.super.onResLoaded(slot0)

	if gohelper.findChild(slot0._displayGo, "#go_rotate/effect2/root") then
		slot6 = true

		for slot6 = 0, slot1:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem), slot6).Length - 1 do
			slot7 = ExploreEnum.PipeColorDef[slot0.mo:getNeedColor()]

			ZProj.ParticleSystemHelper.SetStartColor(slot2[slot6], slot7.r, slot7.g, slot7.b, 1)
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

function slot0.processMapIcon(slot0, slot1)
	for slot6, slot7 in pairs(GameUtil.splitString2(slot1)) do
		if tonumber(slot7[1]) == slot0.mo:getNeedColor() then
			return slot7[2]
		end
	end

	return nil
end

return slot0
