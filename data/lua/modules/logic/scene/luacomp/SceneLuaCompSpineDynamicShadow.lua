module("modules.logic.scene.luacomp.SceneLuaCompSpineDynamicShadow", package.seeall)

local var_0_0 = class("SceneLuaCompSpineDynamicShadow", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	if string.nilorempty(arg_1_1[1]) then
		logError("场景阴影贴图未配置，请检查 C场景表.xlsx-export_场景表现")

		return
	end

	arg_1_0._texturePath = ResUrl.getRoleSpineMatTex(arg_1_1[1])

	if arg_1_1[2] then
		local var_1_0 = string.splitToNumber(arg_1_1[2], "#")

		arg_1_0._vec_ShadowMap_ST = Vector4.New(var_1_0[1], var_1_0[2], var_1_0[3], var_1_0[4])
	end

	if arg_1_1[3] then
		local var_1_1 = string.splitToNumber(arg_1_1[3], "#")

		arg_1_0._vec_ShadowMapOffset = Vector4.New(var_1_1[1], var_1_1[2], var_1_1[3], var_1_1[4])
	end
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._loader = MultiAbLoader.New()
	arg_2_0._needSetMatDict = nil
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_3_0._onSpineLoaded, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSpineMaterialChange, arg_3_0._onSpineMatChange, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_4_0._onSpineLoaded, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSpineMaterialChange, arg_4_0._onSpineMatChange, arg_4_0)
end

function var_0_0.onStart(arg_5_0)
	if not arg_5_0._texturePath then
		return
	end

	arg_5_0._loader:addPath(arg_5_0._texturePath)
	arg_5_0._loader:startLoad(arg_5_0._onLoadCallback, arg_5_0)

	local var_5_0 = FightHelper.getAllEntitys()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_1.spine and iter_5_1.spine:getSpineGO() then
			arg_5_0:_setSpineMat(iter_5_1.spineRenderer:getReplaceMat())
		end
	end
end

function var_0_0._onLoadCallback(arg_6_0)
	if arg_6_0._needSetMatDict then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._needSetMatDict) do
			arg_6_0:_setSpineMat(iter_6_0)
		end

		arg_6_0._needSetMatDict = nil
	end
end

function var_0_0._onSpineLoaded(arg_7_0, arg_7_1)
	arg_7_0:_setSpineMat(arg_7_1.unitSpawn.spineRenderer:getReplaceMat())
end

function var_0_0._onSpineMatChange(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:_setSpineMat(arg_8_2)
end

function var_0_0._setSpineMat(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._loader and arg_9_0._loader:getFirstAssetItem()

	if var_9_0 then
		local var_9_1 = var_9_0:GetResource(arg_9_0._texturePath)

		arg_9_1:EnableKeyword("_SHADOW_DYNAMIC_ON")

		if arg_9_0._vec_ShadowMap_ST then
			arg_9_1:SetVector("_ShadowMap_ST", arg_9_0._vec_ShadowMap_ST)
		end

		if arg_9_0._vec_ShadowMapOffset then
			arg_9_1:SetVector("_ShadowMapOffset", arg_9_0._vec_ShadowMapOffset)
		end

		arg_9_1:SetTexture("_ShadowMap", var_9_1)
	else
		if not arg_9_0._needSetMatDict then
			arg_9_0._needSetMatDict = {}
		end

		arg_9_0._needSetMatDict[arg_9_1] = true
	end
end

function var_0_0.onDestroy(arg_10_0)
	if arg_10_0._loader then
		arg_10_0._loader:dispose()

		arg_10_0._loader = nil
	end

	arg_10_0._needSetMatDict = nil
end

return var_0_0
