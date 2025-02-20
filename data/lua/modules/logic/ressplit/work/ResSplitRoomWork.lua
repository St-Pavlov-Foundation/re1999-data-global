module("modules.logic.ressplit.work.ResSplitRoomWork", package.seeall)

slot0 = class("ResSplitRoomWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot2 = "scenes/m_s07_xiaowu/prefab/building/"
	slot4 = {}
	slot5 = {}
	slot6 = {}
	slot7 = {}

	for slot11, slot12 in pairs(ResSplitConfig.instance:getAppIncludeConfig()) do
		for slot16, slot17 in pairs(slot12.roomTheme) do
			slot7[slot17] = true
		end
	end

	for slot12, slot13 in pairs(RoomConfig.instance:getThemeConfigList()) do
		if slot7[slot13.id] ~= true then
			slot15 = string.splitToNumber(slot13.packages, "|")

			for slot19, slot20 in pairs(string.splitToNumber(slot13.building, "|")) do
				slot4[slot20] = true
			end

			for slot19, slot20 in pairs(slot15) do
				slot5[slot20] = true
			end
		end
	end

	slot9 = {}
	slot10 = {}
	slot11 = {}

	for slot15, slot16 in pairs(lua_block_package_data.packageDict) do
		for slot20, slot21 in pairs(slot16) do
			if slot5[slot15] == nil then
				slot9[slot21.defineId] = true
			elseif slot9[slot21.defineId] == nil then
				slot9[slot21.defineId] = false
			end
		end
	end

	for slot16, slot17 in pairs(slot9) do
		if slot17 or tonumber(string.split(RoomConfig.instance:getBlockDefineConfig(slot16).prefabPath, "/")[1]) == nil then
			-- Nothing
		else
			slot12[slot19] = false
		end
	end

	for slot16, slot17 in pairs({
		[slot19] = true
	}) do
		slot18 = "room/block/" .. slot16

		if slot17 then
			slot10[slot18] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.InnerRoomAB, slot18, true)
		else
			slot11[slot18] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, slot18, true)
		end
	end

	for slot16, slot17 in pairs(slot4) do
		slot19 = ResUrl.getRoomRes(RoomConfig.instance:getBuildingConfig(slot16).path)
		slot11[slot19] = true

		ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, slot19, true)
	end

	for slot17, slot18 in pairs(RoomConfig.instance:getBuildingConfigList()) do
		if not tabletool.indexOf(slot4, slot18.id) then
			slot19 = ResUrl.getRoomRes(slot18.path)
			slot11[slot19] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, slot19, true)
		end
	end

	for slot17, slot18 in pairs(RoomConfig.instance:getAllBuildingSkinList()) do
		if not tabletool.indexOf(slot4, slot18.buildingId) then
			slot19 = ResUrl.getRoomRes(slot18.path)
			slot11[slot19] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, slot19, true)
		end
	end

	for slot17, slot18 in pairs(RoomConfig.instance:getVehicleConfigList()) do
		slot19 = ResUrl.getRoomRes(slot18.path)
		slot11[slot19] = true

		ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, slot19, true)
	end

	for slot17, slot18 in pairs(lua_room_skin.configList) do
		if slot18.itemId ~= 0 then
			slot19 = slot18.model
			slot11[slot19] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, slot19, true)
		end
	end

	slot15 = SLFramework.FileHelper.GetUnityPath(SLFramework.FrameworkSettings.FullAssetRootDir)

	for slot19 = 0, SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.FullAssetRootDir .. "/scenes/m_s07_xiaowu/prefab", true).Length - 1 do
		if not string.find(slot14[slot19], ".meta") and not string.find(slot20, "scenes/m_s07_xiaowu/prefab/block/") and slot11[string.sub(slot20, string.find(slot20, "scenes/m_s07_xiaowu/prefab"), string.len(slot20))] == nil then
			slot10[slot20] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.InnerRoomAB, slot20, true)
		end
	end

	slot0:onDone(true)
end

return slot0
