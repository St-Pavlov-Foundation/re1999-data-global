module("modules.logic.ressplit.work.ResSplitUIWork", package.seeall)

local var_0_0 = class("ResSplitUIWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = {
		"mainsceneswitch",
		"minors",
		"activity",
		"backpack",
		"battlepass",
		"character",
		"common",
		"commonbufftipview",
		"currency",
		"dungeon",
		"effect",
		"equip",
		"enemyinfo",
		"fight",
		"gift",
		"guide",
		"handbook",
		"help",
		"herogroup",
		"login",
		"mail",
		"main",
		"messagebox",
		"notice",
		"player",
		"power",
		"room",
		"rpcblock",
		"scene",
		"sdk",
		"settings",
		"signin",
		"skin",
		"social",
		"store",
		"story",
		"storynavigate",
		"summon",
		"summonresultview",
		"task",
		"teach",
		"tips",
		"toast",
		"video",
		"gm",
		"newwelfare",
		"share",
		"headicon_",
		"headskinicon_",
		"signature",
		"loading",
		"message",
		"nickname",
		"propitem",
		"textures",
		"data_pic",
		"mainsceneswitch"
	}
	local var_1_1 = {
		"",
		"/lang/common",
		"/lang/en",
		"/lang/jp",
		"/lang/kr",
		"/lang/tw",
		"/lang/zh"
	}
	local var_1_2 = {}
	local var_1_3 = {}
	local var_1_4 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_5 = "Assets/ZResourcesLib" .. iter_1_1 .. "/ui/viewres/"

		if SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.AssetRootDir .. iter_1_1 .. "/ui/viewres/") then
			local var_1_6 = SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. iter_1_1 .. "/ui/viewres/")

			for iter_1_2 = 0, var_1_6.Length - 1 do
				local var_1_7 = var_1_6[iter_1_2]

				if not string.find(var_1_7, ".meta") then
					local var_1_8 = false

					for iter_1_3, iter_1_4 in pairs(var_1_0) do
						if var_1_7 == var_1_5 .. iter_1_4 then
							var_1_8 = true

							break
						end
					end

					if var_1_8 == false then
						local var_1_9 = string.gsub(var_1_7, "Assets/ZResourcesLib/", "") .. "/"

						table.insert(var_1_2, var_1_9)
					end
				end
			end
		end

		if SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.AssetRootDir .. iter_1_1 .. "/singlebg/") then
			local var_1_10 = SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. iter_1_1 .. "/singlebg/")
			local var_1_11 = "Assets/ZResourcesLib" .. iter_1_1 .. "/singlebg/"

			for iter_1_5 = 0, var_1_10.Length - 1 do
				local var_1_12 = var_1_10[iter_1_5]

				if not string.find(var_1_12, ".meta") then
					local var_1_13 = false

					for iter_1_6, iter_1_7 in pairs(var_1_0) do
						if string.find(var_1_12, var_1_11 .. iter_1_7) then
							var_1_13 = true

							break
						end
					end

					if var_1_13 == false then
						local var_1_14 = string.gsub(var_1_12, "Assets/ZResourcesLib/", "") .. "/"

						table.insert(var_1_3, var_1_14)
					end
				end
			end
		end

		if SLFramework.FileHelper.IsDirExists(SLFramework.FrameworkSettings.AssetRootDir .. iter_1_1 .. "/singlebg_lang/") then
			local var_1_15 = SLFramework.FileHelper.GetSubdirectories(SLFramework.FrameworkSettings.AssetRootDir .. iter_1_1 .. "/singlebg_lang/")
			local var_1_16 = "Assets/ZResourcesLib" .. iter_1_1 .. "/singlebg_lang/"

			for iter_1_8 = 0, var_1_15.Length - 1 do
				local var_1_17 = var_1_15[iter_1_8]

				if not string.find(var_1_17, ".meta") then
					local var_1_18 = false

					for iter_1_9, iter_1_10 in pairs(var_1_0) do
						if string.find(var_1_17, iter_1_10) then
							var_1_18 = true

							break
						end
					end

					if var_1_18 == false then
						local var_1_19 = string.gsub(var_1_17, "Assets/ZResourcesLib/", "") .. "/"

						table.insert(var_1_4, var_1_19)
					end
				end
			end
		end
	end

	for iter_1_11, iter_1_12 in pairs(var_1_2) do
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, iter_1_12, true)
	end

	for iter_1_13, iter_1_14 in pairs(var_1_3) do
		ResSplitModel.instance:setExclude(ResSplitEnum.SinglebgFolder, iter_1_14, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, iter_1_14, true)
	end

	for iter_1_15, iter_1_16 in pairs(var_1_4) do
		ResSplitModel.instance:setExclude(ResSplitEnum.SinglebgFolder, iter_1_16, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.Folder, iter_1_16, true)
	end

	arg_1_0:onDone(true)
end

return var_0_0
