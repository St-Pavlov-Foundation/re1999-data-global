module("modules.logic.ressplit.work.ResSplitRoomWork", package.seeall)

local var_0_0 = class("ResSplitRoomWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = "scenes/m_s07_xiaowu/prefab/building/"
	local var_1_1 = ResSplitConfig.instance:getAppIncludeConfig()
	local var_1_2 = {}
	local var_1_3 = {}
	local var_1_4 = {}
	local var_1_5 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_1) do
		for iter_1_2, iter_1_3 in pairs(iter_1_1.roomTheme) do
			var_1_5[iter_1_3] = true
		end
	end

	local var_1_6 = RoomConfig.instance:getThemeConfigList()

	for iter_1_4, iter_1_5 in pairs(var_1_6) do
		if var_1_5[iter_1_5.id] ~= true then
			local var_1_7 = string.splitToNumber(iter_1_5.building, "|")
			local var_1_8 = string.splitToNumber(iter_1_5.packages, "|")

			for iter_1_6, iter_1_7 in pairs(var_1_7) do
				var_1_2[iter_1_7] = true
			end

			for iter_1_8, iter_1_9 in pairs(var_1_8) do
				var_1_3[iter_1_9] = true
			end
		end
	end

	local var_1_9 = {}
	local var_1_10 = {}
	local var_1_11 = {}

	for iter_1_10, iter_1_11 in pairs(lua_block_package_data.packageDict) do
		for iter_1_12, iter_1_13 in pairs(iter_1_11) do
			if var_1_3[iter_1_10] == nil then
				var_1_9[iter_1_13.defineId] = true
			elseif var_1_9[iter_1_13.defineId] == nil then
				var_1_9[iter_1_13.defineId] = false
			end
		end
	end

	local var_1_12 = {}

	for iter_1_14, iter_1_15 in pairs(var_1_9) do
		local var_1_13 = RoomConfig.instance:getBlockDefineConfig(iter_1_14)
		local var_1_14 = string.split(var_1_13.prefabPath, "/")[1]

		if iter_1_15 or tonumber(var_1_14) == nil then
			var_1_12[var_1_14] = true
		else
			var_1_12[var_1_14] = false
		end
	end

	for iter_1_16, iter_1_17 in pairs(var_1_12) do
		local var_1_15 = "room/block/" .. iter_1_16

		if iter_1_17 then
			var_1_10[var_1_15] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.InnerRoomAB, var_1_15, true)
		else
			var_1_11[var_1_15] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, var_1_15, true)
		end
	end

	for iter_1_18, iter_1_19 in pairs(var_1_2) do
		local var_1_16 = RoomConfig.instance:getBuildingConfig(iter_1_18)
		local var_1_17 = ResUrl.getRoomRes(var_1_16.path)

		var_1_11[var_1_17] = true

		ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, var_1_17, true)
	end

	local var_1_18 = RoomConfig.instance:getBuildingConfigList()

	for iter_1_20, iter_1_21 in pairs(var_1_18) do
		if not tabletool.indexOf(var_1_2, iter_1_21.id) then
			local var_1_19 = ResUrl.getRoomRes(iter_1_21.path)

			var_1_11[var_1_19] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, var_1_19, true)
		end
	end

	local var_1_20 = RoomConfig.instance:getAllBuildingSkinList()

	for iter_1_22, iter_1_23 in pairs(var_1_20) do
		if not tabletool.indexOf(var_1_2, iter_1_23.buildingId) then
			local var_1_21 = ResUrl.getRoomRes(iter_1_23.path)

			var_1_11[var_1_21] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, var_1_21, true)
		end
	end

	local var_1_22 = RoomConfig.instance:getVehicleConfigList()

	for iter_1_24, iter_1_25 in pairs(var_1_22) do
		local var_1_23 = ResUrl.getRoomRes(iter_1_25.path)

		var_1_11[var_1_23] = true

		ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, var_1_23, true)
	end

	local var_1_24 = lua_room_skin.configList

	for iter_1_26, iter_1_27 in pairs(var_1_24) do
		if iter_1_27.itemId ~= 0 then
			local var_1_25 = iter_1_27.model

			var_1_11[var_1_25] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, var_1_25, true)
		end
	end

	local var_1_26 = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.FullAssetRootDir .. "/scenes/m_s07_xiaowu/prefab", true)
	local var_1_27 = SLFramework.FileHelper.GetUnityPath(SLFramework.FrameworkSettings.FullAssetRootDir)

	for iter_1_28 = 0, var_1_26.Length - 1 do
		local var_1_28 = var_1_26[iter_1_28]

		if not string.find(var_1_28, ".meta") and not string.find(var_1_28, "scenes/m_s07_xiaowu/prefab/block/") then
			local var_1_29 = string.find(var_1_28, "scenes/m_s07_xiaowu/prefab")
			local var_1_30 = string.sub(var_1_28, var_1_29, string.len(var_1_28))

			if var_1_11[var_1_30] == nil then
				var_1_10[var_1_30] = true

				ResSplitModel.instance:setExclude(ResSplitEnum.InnerRoomAB, var_1_30, true)
			end
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
