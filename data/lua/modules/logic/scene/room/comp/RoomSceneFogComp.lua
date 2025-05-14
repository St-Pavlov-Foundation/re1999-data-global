module("modules.logic.scene.room.comp.RoomSceneFogComp", package.seeall)

local var_0_0 = class("RoomSceneFogComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	arg_2_0._scene.loader:makeSureLoaded({
		RoomScenePreloader.ResFogParticle
	}, arg_2_0._OnGetInstance, arg_2_0)
end

function var_0_0._OnGetInstance(arg_3_0)
	arg_3_0._fogGO = RoomGOPool.getInstance(RoomScenePreloader.ResFogParticle, arg_3_0._scene.go.fogRoot, "fog")
	arg_3_0._particleSystem = arg_3_0._fogGO:GetComponent(typeof(UnityEngine.ParticleSystem))
	arg_3_0._renderer = arg_3_0._fogGO:GetComponent(typeof(UnityEngine.Renderer))
	arg_3_0._materialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()

	arg_3_0:_resetTempParam()
end

function var_0_0._resetTempParam(arg_4_0)
	arg_4_0._tempMaxParticles = nil
	arg_4_0._tempFogParamCenterY = nil
	arg_4_0._tempFogParamHeight = nil
	arg_4_0._tempFogParamRangeZ = nil
	arg_4_0._tempFogParamRangeW = nil
	arg_4_0._tempFogViewType = nil
end

function var_0_0.setFogParam(arg_5_0, arg_5_1)
	local var_5_0 = false

	if not arg_5_0._tempMaxParticles or arg_5_0._tempMaxParticles ~= arg_5_1.maxParticles * 10 then
		arg_5_0._tempMaxParticles = arg_5_1.maxParticles * 10

		ZProj.ParticleSystemHelper.SetMaxParticles(arg_5_0._particleSystem, arg_5_0._tempMaxParticles)
	end

	if not arg_5_0._tempFogParamCenterY or arg_5_0._tempFogParamCenterY ~= arg_5_1.centerY or not arg_5_0._tempFogParamHeight or arg_5_0._tempFogParamHeight ~= arg_5_1.height or not arg_5_0._tempFogParamRangeZ or arg_5_0._tempFogParamRangeZ ~= arg_5_1.fogRangeZ or not arg_5_0._tempFogParamRangeW or arg_5_0._tempFogParamRangeW ~= arg_5_1.fogRangeW then
		arg_5_0._tempFogParamCenterY = arg_5_1.centerY
		arg_5_0._tempFogParamHeight = arg_5_1.height
		arg_5_0._tempFogParamRangeZ = arg_5_1.fogRangeZ
		arg_5_0._tempFogParamRangeW = arg_5_1.fogRangeW

		arg_5_0._materialPropertyBlock:SetVector("_FogRange", Vector4(arg_5_1.centerY, arg_5_1.height, arg_5_1.fogRangeZ, arg_5_1.fogRangeW))

		var_5_0 = true
	end

	if not arg_5_0._tempFogViewType or arg_5_0._tempFogViewType ~= arg_5_1.fogViewType then
		arg_5_0._tempFogViewType = arg_5_1.fogViewType
		var_5_0 = true

		arg_5_0._materialPropertyBlock:SetFloat("_FogViewType", arg_5_1.fogViewType)
	end

	if var_5_0 then
		arg_5_0._renderer:SetPropertyBlock(arg_5_0._materialPropertyBlock)
	end
end

function var_0_0.onSceneClose(arg_6_0)
	arg_6_0._fogGO = nil
	arg_6_0._particleSystem = nil
	arg_6_0._renderer = nil

	if arg_6_0._materialPropertyBlock then
		arg_6_0._materialPropertyBlock:Clear()

		arg_6_0._materialPropertyBlock = nil
	end

	arg_6_0:_resetTempParam()
end

return var_0_0
