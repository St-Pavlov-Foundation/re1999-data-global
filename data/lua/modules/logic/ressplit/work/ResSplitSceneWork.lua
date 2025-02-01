module("modules.logic.ressplit.work.ResSplitSceneWork", package.seeall)

slot0 = class("ResSplitSceneWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot2 = {
		[13101.0] = true,
		[90001.0] = true,
		[501.0] = true,
		[601.0] = true,
		[101.0] = true
	}

	if ResSplitEnum.SplitAllScene then
		for slot6, slot7 in pairs(lua_scene.configDict) do
			if slot6 ~= 601 then
				for slot13, slot14 in ipairs(SceneConfig.instance:getSceneLevelCOs(slot6)) do
					ResSplitHelper.addSceneRes(slot14.id, slot2[slot6] ~= true)
				end
			end
		end
	end

	for slot7 = 0, SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.FullAssetRootDir .. "/scenes/m_s06_summon", true).Length - 1 do
		if not string.find(slot3[slot7], ".meta") and string.find(slot8, ".prefab") then
			slot8 = string.sub(slot8, string.find(slot8, "scenes/m_s06_summon"), string.len(slot8))

			ResSplitModel.instance:setExclude(ResSplitEnum.InnerSceneAB, slot8, true)
			ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, slot8, false)
		end
	end

	for slot9 = 0, SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.FullAssetRootDir .. "/scenes/").Length - 1 do
		if not string.find(slot5[slot9], ".meta") and string.find(slot10, ".prefab") and string.find(slot10, "Assets/ZResourcesLib/scenes/v") then
			ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, string.sub(slot10, string.find(slot10, SLFramework.FrameworkSettings.AssetRootDir) + string.len(SLFramework.FrameworkSettings.AssetRootDir) + 1, string.len(slot10)), true)
		end
	end

	slot0:onDone(true)
end

return slot0
