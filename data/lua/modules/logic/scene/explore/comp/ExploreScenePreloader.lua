module("modules.logic.scene.explore.comp.ExploreScenePreloader", package.seeall)

local var_0_0 = class("ExploreScenePreloader", BaseSceneComp)
local var_0_1 = typeof(UnityEngine.ShaderVariantCollection)
local var_0_2 = {
	[ModuleEnum.Performance.High] = "explore/shaders/svc_high.shadervariants",
	[ModuleEnum.Performance.Middle] = "explore/shaders/svc_medium.shadervariants",
	[ModuleEnum.Performance.Low] = "explore/shaders/svc_low.shadervariants"
}

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._loader = SequenceAbLoader.New()

	arg_1_0._loader:addPath(ResUrl.getExploreEffectPath(ExploreConstValue.ClickEffect))
	arg_1_0._loader:addPath(ResUrl.getExploreEffectPath(ExploreConstValue.PlaceEffect))
	arg_1_0._loader:addPath(ResUrl.getExploreEffectPath(ExploreConstValue.MapLightEffect))

	if not GameResMgr.IsFromEditorDir then
		arg_1_0._loader:addPath("explore/shaders")
	end

	arg_1_0._loader:setConcurrentCount(10)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0.getResByPath(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._loader:getAssetItem(arg_2_1)

	if not var_2_0 or not var_2_0.IsLoadSuccess then
		logError("资源加载失败 。。。 " .. arg_2_1)

		return
	end

	return var_2_0:GetResource()
end

function var_0_0._onPreloadFinish(arg_3_0)
	if not GameResMgr.IsFromEditorDir then
		arg_3_0:warmupShader()
	end

	arg_3_0:dispatchEvent(ExploreEvent.OnExplorePreloadFinish)
end

function var_0_0.warmupShader(arg_4_0)
	local var_4_0 = arg_4_0._loader:getAssetItem("explore/shaders")

	if not GameResMgr.IsFromEditorDir then
		local var_4_1 = GameGlobalMgr.instance:getScreenState():getLocalQuality()
		local var_4_2 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
		local var_4_3 = PlayerPrefsHelper.getString(PlayerPrefsKey.ExploreShaderWarmupVersion, "")
		local var_4_4 = {}

		if string.find(var_4_3, "^%[") then
			var_4_4 = cjson.decode(var_4_3)
		end

		if var_4_4[1] ~= var_4_2 then
			var_4_4 = {
				var_4_2
			}
		end

		if not tabletool.indexOf(var_4_4, var_0_2[var_4_1]) then
			if isDebugBuild then
				SLFramework.TimeWatch.Instance:Start()
				logWarn("开始密室Shader预热 。。。 ")
			end

			if var_4_0 and var_4_0.IsLoadSuccess then
				local var_4_5 = var_4_0:GetResource(var_0_2[var_4_1], var_0_1)

				if var_4_5 then
					var_4_5:WarmUp()
				end
			end

			table.insert(var_4_4, var_0_2[var_4_1])
			PlayerPrefsHelper.setString(PlayerPrefsKey.ExploreShaderWarmupVersion, cjson.encode(var_4_4))

			if isDebugBuild then
				logWarn("密室Shader预热结束 。。。 " .. SLFramework.TimeWatch.Instance:Watch())
			end
		end
	end
end

function var_0_0.onSceneClose(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._loader then
		arg_5_0._loader:dispose()

		arg_5_0._loader = nil
	end
end

return var_0_0
