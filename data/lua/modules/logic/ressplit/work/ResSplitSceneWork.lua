module("modules.logic.ressplit.work.ResSplitSceneWork", package.seeall)

local var_0_0 = class("ResSplitSceneWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = {
		[13101] = true,
		[90001] = true,
		[501] = true,
		[601] = true,
		[101] = true
	}

	if ResSplitEnum.SplitAllScene then
		for iter_1_0, iter_1_1 in pairs(lua_scene.configDict) do
			if iter_1_0 ~= 601 then
				local var_1_1 = var_1_0[iter_1_0] ~= true
				local var_1_2 = SceneConfig.instance:getSceneLevelCOs(iter_1_0)

				for iter_1_2, iter_1_3 in ipairs(var_1_2) do
					ResSplitHelper.addSceneRes(iter_1_3.id, var_1_1)
				end
			end
		end
	end

	local var_1_3 = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.FullAssetRootDir .. "/scenes/m_s06_summon", true)

	for iter_1_4 = 0, var_1_3.Length - 1 do
		local var_1_4 = var_1_3[iter_1_4]

		if not string.find(var_1_4, ".meta") and string.find(var_1_4, ".prefab") then
			local var_1_5 = string.find(var_1_4, "scenes/m_s06_summon")
			local var_1_6 = string.sub(var_1_4, var_1_5, string.len(var_1_4))

			ResSplitModel.instance:setExclude(ResSplitEnum.InnerSceneAB, var_1_6, true)
			ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, var_1_6, false)
		end
	end

	local var_1_7 = string.len(SLFramework.FrameworkSettings.AssetRootDir) + 1
	local var_1_8 = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.FullAssetRootDir .. "/scenes/")

	for iter_1_5 = 0, var_1_8.Length - 1 do
		local var_1_9 = var_1_8[iter_1_5]

		if not string.find(var_1_9, ".meta") and string.find(var_1_9, ".prefab") and string.find(var_1_9, "Assets/ZResourcesLib/scenes/v") then
			local var_1_10 = string.find(var_1_9, SLFramework.FrameworkSettings.AssetRootDir)
			local var_1_11 = string.sub(var_1_9, var_1_10 + var_1_7, string.len(var_1_9))

			ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, var_1_11, true)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
