module("modules.logic.scene.room.comp.RoomSceneBendingComp", package.seeall)

slot0 = class("RoomSceneBendingComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._bendingAmountId = UnityEngine.Shader.PropertyToID("_Curvature")
	slot0._bendingAmountScaledId = UnityEngine.Shader.PropertyToID("_CurvatureScaled")
	slot0._ambientColorId = UnityEngine.Shader.PropertyToID("_AmbientCol")
	slot0._fogColorId = UnityEngine.Shader.PropertyToID("_FogColor")
	slot0._bendingPositionId = UnityEngine.Shader.PropertyToID("_GameobjPosition")
	slot0._bendingNegaPositionId = UnityEngine.Shader.PropertyToID("_NegaGameobjPosition")
	slot0._skyMeshRenderer = nil
	slot0._skyPropertyBlock = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	slot0:setBendingAmount(0.25)
end

function slot0.setBendingAmount(slot0, slot1)
	RoomHelper.setGlobalFloat(slot0._bendingAmountId, slot1)
	RoomHelper.setGlobalFloat(slot0._bendingAmountScaledId, -slot1 * 0.08)
	RoomBendingHelper.setBendingAmount(RoomHelper.getGlobalFloat(slot0._bendingAmountId))
	RoomMapController.instance:dispatchEvent(RoomEvent.BendingAmountUpdate)
end

function slot0.setAmbientColor(slot0, slot1)
	RoomHelper.setGlobalColor(slot0._ambientColorId, slot1)
end

function slot0.getAmbientColor(slot0)
	return UnityEngine.Shader.GetGlobalColor(slot0._ambientColorId)
end

function slot0.setFogColor(slot0, slot1)
	RoomHelper.setGlobalColor(slot0._fogColorId, slot1)
end

function slot0.getFogColor(slot0)
	return UnityEngine.Shader.GetGlobalColor(slot0._fogColorId)
end

function slot0.setSkylineOffset(slot0, slot1)
	if not slot0._skyMeshRenderer then
		slot0._skyMeshRenderer = slot0._scene.go.skyGO and slot2:GetComponent(typeof(UnityEngine.MeshRenderer))
	end

	if not slot0._skyMeshRenderer then
		return
	end

	if not slot0._skyPropertyBlock then
		slot0._skyPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	end

	slot0._skyPropertyBlock:SetFloat("_OffsetHorizon", slot1)
	slot0._skyMeshRenderer:SetPropertyBlock(slot0._skyPropertyBlock)
end

function slot0.setBendingPosition(slot0, slot1)
	RoomBendingHelper.setBendingPosition(slot1)
	UnityEngine.Shader.SetGlobalVector(slot0._bendingPositionId, Vector4(slot1.x, slot1.y, slot1.z, 1))
	UnityEngine.Shader.SetGlobalVector(slot0._bendingNegaPositionId, Vector4(-slot1.x, -slot1.z, 1, 1))
end

function slot0.onSceneClose(slot0)
	slot0._skyMeshRenderer = nil

	if slot0._skyPropertyBlock then
		slot0._skyPropertyBlock:Clear()

		slot0._skyPropertyBlock = nil
	end
end

return slot0
