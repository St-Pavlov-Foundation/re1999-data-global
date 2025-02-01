module("modules.logic.scene.room.comp.RoomSceneFogComp", package.seeall)

slot0 = class("RoomSceneFogComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	slot0._scene.loader:makeSureLoaded({
		RoomScenePreloader.ResFogParticle
	}, slot0._OnGetInstance, slot0)
end

function slot0._OnGetInstance(slot0)
	slot0._fogGO = RoomGOPool.getInstance(RoomScenePreloader.ResFogParticle, slot0._scene.go.fogRoot, "fog")
	slot0._particleSystem = slot0._fogGO:GetComponent(typeof(UnityEngine.ParticleSystem))
	slot0._renderer = slot0._fogGO:GetComponent(typeof(UnityEngine.Renderer))
	slot0._materialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()

	slot0:_resetTempParam()
end

function slot0._resetTempParam(slot0)
	slot0._tempMaxParticles = nil
	slot0._tempFogParamCenterY = nil
	slot0._tempFogParamHeight = nil
	slot0._tempFogParamRangeZ = nil
	slot0._tempFogParamRangeW = nil
	slot0._tempFogViewType = nil
end

function slot0.setFogParam(slot0, slot1)
	slot2 = false

	if not slot0._tempMaxParticles or slot0._tempMaxParticles ~= slot1.maxParticles * 10 then
		slot0._tempMaxParticles = slot1.maxParticles * 10

		ZProj.ParticleSystemHelper.SetMaxParticles(slot0._particleSystem, slot0._tempMaxParticles)
	end

	if not slot0._tempFogParamCenterY or slot0._tempFogParamCenterY ~= slot1.centerY or not slot0._tempFogParamHeight or slot0._tempFogParamHeight ~= slot1.height or not slot0._tempFogParamRangeZ or slot0._tempFogParamRangeZ ~= slot1.fogRangeZ or not slot0._tempFogParamRangeW or slot0._tempFogParamRangeW ~= slot1.fogRangeW then
		slot0._tempFogParamCenterY = slot1.centerY
		slot0._tempFogParamHeight = slot1.height
		slot0._tempFogParamRangeZ = slot1.fogRangeZ
		slot0._tempFogParamRangeW = slot1.fogRangeW

		slot0._materialPropertyBlock:SetVector("_FogRange", Vector4(slot1.centerY, slot1.height, slot1.fogRangeZ, slot1.fogRangeW))

		slot2 = true
	end

	if not slot0._tempFogViewType or slot0._tempFogViewType ~= slot1.fogViewType then
		slot0._tempFogViewType = slot1.fogViewType
		slot2 = true

		slot0._materialPropertyBlock:SetFloat("_FogViewType", slot1.fogViewType)
	end

	if slot2 then
		slot0._renderer:SetPropertyBlock(slot0._materialPropertyBlock)
	end
end

function slot0.onSceneClose(slot0)
	slot0._fogGO = nil
	slot0._particleSystem = nil
	slot0._renderer = nil

	if slot0._materialPropertyBlock then
		slot0._materialPropertyBlock:Clear()

		slot0._materialPropertyBlock = nil
	end

	slot0:_resetTempParam()
end

return slot0
