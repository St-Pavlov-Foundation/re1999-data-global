module("modules.logic.scene.explore.comp.ExploreScenePreloader", package.seeall)

slot0 = class("ExploreScenePreloader", BaseSceneComp)
slot1 = typeof(UnityEngine.ShaderVariantCollection)
slot2 = {
	[ModuleEnum.Performance.High] = "explore/shaders/svc_high.shadervariants",
	[ModuleEnum.Performance.Middle] = "explore/shaders/svc_medium.shadervariants",
	[ModuleEnum.Performance.Low] = "explore/shaders/svc_low.shadervariants"
}

function slot0.init(slot0, slot1, slot2)
	slot0._loader = SequenceAbLoader.New()

	slot0._loader:addPath(ResUrl.getExploreEffectPath(ExploreConstValue.ClickEffect))
	slot0._loader:addPath(ResUrl.getExploreEffectPath(ExploreConstValue.PlaceEffect))
	slot0._loader:addPath(ResUrl.getExploreEffectPath(ExploreConstValue.MapLightEffect))

	if not GameResMgr.IsFromEditorDir then
		slot0._loader:addPath("explore/shaders")
	end

	slot0._loader:setConcurrentCount(10)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0.getResByPath(slot0, slot1)
	if not slot0._loader:getAssetItem(slot1) or not slot2.IsLoadSuccess then
		logError("资源加载失败 。。。 " .. slot1)

		return
	end

	return slot2:GetResource()
end

function slot0._onPreloadFinish(slot0)
	if not GameResMgr.IsFromEditorDir then
		slot0:warmupShader()
	end

	slot0:dispatchEvent(ExploreEvent.OnExplorePreloadFinish)
end

function slot0.warmupShader(slot0)
	slot1 = slot0._loader:getAssetItem("explore/shaders")

	if not GameResMgr.IsFromEditorDir then
		slot2 = GameGlobalMgr.instance:getScreenState():getLocalQuality()
		slot3 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
		slot5 = {}

		if string.find(PlayerPrefsHelper.getString(PlayerPrefsKey.ExploreShaderWarmupVersion, ""), "^%[") then
			slot5 = cjson.decode(slot4)
		end

		if slot5[1] ~= slot3 then
			slot5 = {
				slot3
			}
		end

		if not tabletool.indexOf(slot5, uv0[slot2]) then
			if isDebugBuild then
				SLFramework.TimeWatch.Instance:Start()
				logWarn("开始密室Shader预热 。。。 ")
			end

			if slot1 and slot1.IsLoadSuccess and slot1:GetResource(uv0[slot2], uv1) then
				slot6:WarmUp()
			end

			table.insert(slot5, uv0[slot2])
			PlayerPrefsHelper.setString(PlayerPrefsKey.ExploreShaderWarmupVersion, cjson.encode(slot5))

			if isDebugBuild then
				logWarn("密室Shader预热结束 。。。 " .. SLFramework.TimeWatch.Instance:Watch())
			end
		end
	end
end

function slot0.onSceneClose(slot0, slot1, slot2)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
