module("modules.logic.scene.room.comp.RoomSceneBendingComp", package.seeall)

local var_0_0 = class("RoomSceneBendingComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._bendingAmountId = UnityEngine.Shader.PropertyToID("_Curvature")
	arg_1_0._bendingAmountScaledId = UnityEngine.Shader.PropertyToID("_CurvatureScaled")
	arg_1_0._ambientColorId = UnityEngine.Shader.PropertyToID("_AmbientCol")
	arg_1_0._fogColorId = UnityEngine.Shader.PropertyToID("_FogColor")
	arg_1_0._bendingPositionId = UnityEngine.Shader.PropertyToID("_GameobjPosition")
	arg_1_0._bendingNegaPositionId = UnityEngine.Shader.PropertyToID("_NegaGameobjPosition")
	arg_1_0._skyMeshRenderer = nil
	arg_1_0._skyPropertyBlock = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	local var_2_0 = 0.25

	arg_2_0:setBendingAmount(var_2_0)
end

function var_0_0.setBendingAmount(arg_3_0, arg_3_1)
	RoomHelper.setGlobalFloat(arg_3_0._bendingAmountId, arg_3_1)
	RoomHelper.setGlobalFloat(arg_3_0._bendingAmountScaledId, -arg_3_1 * 0.08)

	arg_3_1 = RoomHelper.getGlobalFloat(arg_3_0._bendingAmountId)

	RoomBendingHelper.setBendingAmount(arg_3_1)
	RoomMapController.instance:dispatchEvent(RoomEvent.BendingAmountUpdate)
end

function var_0_0.setAmbientColor(arg_4_0, arg_4_1)
	RoomHelper.setGlobalColor(arg_4_0._ambientColorId, arg_4_1)
end

function var_0_0.getAmbientColor(arg_5_0)
	return UnityEngine.Shader.GetGlobalColor(arg_5_0._ambientColorId)
end

function var_0_0.setFogColor(arg_6_0, arg_6_1)
	RoomHelper.setGlobalColor(arg_6_0._fogColorId, arg_6_1)
end

function var_0_0.getFogColor(arg_7_0)
	return UnityEngine.Shader.GetGlobalColor(arg_7_0._fogColorId)
end

function var_0_0.setSkylineOffset(arg_8_0, arg_8_1)
	if not arg_8_0._skyMeshRenderer then
		local var_8_0 = arg_8_0._scene.go.skyGO

		arg_8_0._skyMeshRenderer = var_8_0 and var_8_0:GetComponent(typeof(UnityEngine.MeshRenderer))
	end

	if not arg_8_0._skyMeshRenderer then
		return
	end

	if not arg_8_0._skyPropertyBlock then
		arg_8_0._skyPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	end

	arg_8_0._skyPropertyBlock:SetFloat("_OffsetHorizon", arg_8_1)
	arg_8_0._skyMeshRenderer:SetPropertyBlock(arg_8_0._skyPropertyBlock)
end

function var_0_0.setBendingPosition(arg_9_0, arg_9_1)
	RoomBendingHelper.setBendingPosition(arg_9_1)

	local var_9_0 = Vector4(arg_9_1.x, arg_9_1.y, arg_9_1.z, 1)

	UnityEngine.Shader.SetGlobalVector(arg_9_0._bendingPositionId, var_9_0)

	local var_9_1 = Vector4(-arg_9_1.x, -arg_9_1.z, 1, 1)

	UnityEngine.Shader.SetGlobalVector(arg_9_0._bendingNegaPositionId, var_9_1)
end

function var_0_0.onSceneClose(arg_10_0)
	arg_10_0._skyMeshRenderer = nil

	if arg_10_0._skyPropertyBlock then
		arg_10_0._skyPropertyBlock:Clear()

		arg_10_0._skyPropertyBlock = nil
	end
end

return var_0_0
