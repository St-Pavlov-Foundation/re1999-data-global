module("modules.logic.effect.model.EffectStatModel", package.seeall)

slot0 = class("EffectStatModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0.idCounter = 1
	slot0.toggleId = 1
	slot0.titleMO = {}
	slot0.maxMO = {}
	slot0.totalMO = {}
	slot0.type1MOList = {}
	slot0.type2MOList = {}
	slot0.type1MOCount = 0
	slot0.type2MOCount = 0

	slot0:clearStat()
end

function slot0.setCameraRootActive(slot0)
	slot1 = gohelper.find("cameraroot")

	gohelper.setActive(slot1, false)
	gohelper.setActive(slot1, true)
end

function slot0.switchTab(slot0, slot1)
	slot0.toggleId = slot1
end

function slot0.clearStat(slot0)
	slot0._maxParticleSystem = 0
	slot0._maxParticleCount = 0
	slot0._maxMaterialCount = 0
	slot0._maxTextureCount = 0
end

function slot0.statistic(slot0)
	slot0.type1MOCount = 0
	slot0.type2MOCount = 0
	slot0.idCounter = 1
	slot1 = 1
	slot2 = {}
	slot3 = {}
	slot4 = FightEffectPool.getId2UsingWrapDict()

	table.insert(slot2, gohelper.find("cameraroot"))

	slot6 = 0
	slot7 = 0
	slot8 = 0
	slot9 = 0

	for slot13, slot14 in ipairs(slot2) do
		slot15, slot16, slot17, slot18 = slot0:_statSingle(slot14)

		if slot15 > 0 or slot16 > 0 or slot17 > 0 or slot18 > 0 then
			slot0.type2MOCount = slot0.type2MOCount + 1

			if not slot0.type2MOList[slot0.type2MOCount] then
				slot0.type2MOList[slot0.type2MOCount] = {}
			end

			slot0:_setMO(slot19, slot14.name, slot14, slot15, slot16, slot17, slot18)
		end

		slot6 = slot6 + slot15
		slot7 = slot7 + slot16
		slot8 = slot8 + slot17
		slot9 = slot9 + slot18
	end

	slot0:_setMO(slot0.titleMO, "", nil, "粒子系统", "粒子数", "材质数", "贴图数")
	slot0:_setMO(slot0.totalMO, "总计", nil, slot6, slot7, slot8, slot9)

	slot0._maxParticleSystem = slot6 < slot0._maxParticleSystem and slot0._maxParticleSystem or slot6
	slot0._maxParticleCount = slot7 < slot0._maxParticleCount and slot0._maxParticleCount or slot7
	slot0._maxMaterialCount = slot8 < slot0._maxMaterialCount and slot0._maxMaterialCount or slot8
	slot0._maxTextureCount = slot9 < slot0._maxTextureCount and slot0._maxTextureCount or slot9

	slot0:_setMO(slot0.maxMO, "最大数", nil, slot0._maxParticleSystem, slot0._maxParticleCount, slot0._maxMaterialCount, slot0._maxTextureCount)

	slot10 = {}

	if slot0.toggleId == 1 then
		for slot14 = 1, slot0.type1MOCount do
			table.insert(slot10, slot0.type1MOList[slot14])
		end
	else
		for slot14 = 1, slot0.type2MOCount do
			table.insert(slot10, slot0.type2MOList[slot14])
		end
	end

	table.sort(slot10, function (slot0, slot1)
		if slot0.particleCount ~= slot1.particleCount then
			return slot1.particleCount < slot0.particleCount
		elseif slot0.particleSystem ~= slot1.particleSystem then
			return slot1.particleSystem < slot0.particleSystem
		else
			return slot0.id < slot1.id
		end
	end)
	table.insert(slot10, 1, slot0.totalMO)
	table.insert(slot10, 1, slot0.maxMO)
	table.insert(slot10, 1, slot0.titleMO)
	slot0:setList(slot10)
end

function slot0._statSingle(slot0, slot1)
	if not slot1.activeInHierarchy then
		return 0, 0, 0, 0
	end

	slot4 = 0
	slot5 = 0

	if slot1:GetComponent(typeof("UnityEngine.ParticleSystem")) then
		slot2 = 0 + 1
		slot3 = 0 + slot6.particleCount
	end

	if slot1:GetComponent(typeof("UnityEngine.Renderer")) then
		for slot13 = 0, slot7.sharedMaterials.Length - 1 do
			if not gohelper.isNil(slot8[slot13]) then
				slot4 = slot4 + 1

				for slot19 = 0, slot14:GetTexturePropertyNames().Length - 1 do
					if slot14:GetTexture(slot15[slot19]) then
						slot5 = slot5 + 1
					end
				end
			end
		end
	end

	if slot2 > 0 or slot3 > 0 or slot4 > 0 or slot5 > 0 then
		slot0.type1MOCount = slot0.type1MOCount + 1

		if not slot0.type1MOList[slot0.type1MOCount] then
			slot0.type1MOList[slot0.type1MOCount] = {}
		end

		slot0:_setMO(slot8, slot1.name, slot1, slot2, slot3, slot4, slot5)
	end

	for slot13 = 0, slot1.transform.childCount - 1 do
		slot14, slot15, slot16, slot17 = slot0:_statSingle(slot8:GetChild(slot13).gameObject)
		slot2 = slot2 + slot14
		slot3 = slot3 + slot15
		slot4 = slot4 + slot16
		slot5 = slot5 + slot17
	end

	return slot2, slot3, slot4, slot5
end

function slot0._setMO(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot1.name = slot2
	slot1.go = slot3
	slot1.particleSystem = slot4
	slot1.particleCount = slot5
	slot1.materialCount = slot6
	slot1.textureCount = slot7
	slot1.id = slot0.idCounter
	slot0.idCounter = slot0.idCounter + 1
end

slot0.instance = slot0.New()

return slot0
