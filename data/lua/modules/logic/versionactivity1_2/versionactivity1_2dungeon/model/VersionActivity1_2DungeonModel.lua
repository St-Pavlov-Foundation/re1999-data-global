module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.model.VersionActivity1_2DungeonModel", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getTrapPutting(arg_3_0)
	return arg_3_0.putTrap ~= 0 and arg_3_0.putTrap
end

function var_0_0.onReceiveGet116InfosReply(arg_4_0, arg_4_1)
	arg_4_0._activity_id = arg_4_1.activityId
	arg_4_0.element_data = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.infos) do
		local var_4_0 = iter_4_1.elementId
		local var_4_1 = {
			elementId = iter_4_1.elementId,
			level = iter_4_1.level
		}

		arg_4_0.element_data[var_4_0] = var_4_1
	end

	arg_4_0.trapIds = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.trapIds) do
		arg_4_0.trapIds[iter_4_3] = iter_4_3
	end

	arg_4_0.putTrap = arg_4_1.putTrap
	arg_4_0.spStatus = {}

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.spStatus) do
		local var_4_2 = iter_4_5.episodeId
		local var_4_3 = {
			episodeId = iter_4_5.episodeId,
			chapterId = iter_4_5.chapterId,
			status = iter_4_5.status,
			refreshTime = iter_4_5.refreshTime
		}

		arg_4_0.spStatus[var_4_2] = var_4_3
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveGet116InfosReply)
end

function var_0_0.getSpStatus(arg_5_0, arg_5_1)
	return arg_5_0.spStatus and arg_5_0.spStatus[arg_5_1]
end

function var_0_0.onReceiveAct116InfoUpdatePush(arg_6_0, arg_6_1)
	arg_6_0.newSp = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.spStatus) do
		if arg_6_0.spStatus then
			if iter_6_1.status == 1 and arg_6_0.spStatus[iter_6_1.episodeId].status ~= 1 then
				arg_6_0.newSp[iter_6_1.episodeId] = true
			end
		else
			arg_6_0.newSp[iter_6_1.episodeId] = true
		end
	end

	arg_6_0:onReceiveGet116InfosReply(arg_6_1)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveAct116InfoUpdatePush)
end

function var_0_0.onReceiveUpgradeElementReply(arg_7_0, arg_7_1)
	arg_7_0.element_data = arg_7_0.element_data or {}
	arg_7_0.element_data[arg_7_1.elementId] = {}
	arg_7_0.element_data[arg_7_1.elementId].elementId = arg_7_1.elementId
	arg_7_0.element_data[arg_7_1.elementId].level = arg_7_1.level

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveUpgradeElementReply, arg_7_1.elementId)
end

function var_0_0.getElementData(arg_8_0, arg_8_1)
	return arg_8_0.element_data and arg_8_0.element_data[arg_8_1]
end

function var_0_0.onReceiveBuildTrapReply(arg_9_0, arg_9_1)
	arg_9_0.trapIds = arg_9_0.trapIds or {}
	arg_9_0.trapIds[arg_9_1.trapId] = arg_9_1.trapId

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveBuildTrapReply, arg_9_1.trapId)
end

function var_0_0.onReceivePutTrapReply(arg_10_0, arg_10_1)
	arg_10_0.putTrap = arg_10_1.trapId

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceivePutTrapReply)
end

function var_0_0.getCurActivityID(arg_11_0)
	return arg_11_0._activity_id or VersionActivity1_2Enum.ActivityId.Dungeon
end

function var_0_0.getAttrUpDic(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.element_data) do
		if iter_12_1.level > 0 then
			local var_12_1 = VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(iter_12_1.elementId)

			for iter_12_2, iter_12_3 in pairs(var_12_1) do
				if iter_12_3.level == iter_12_1.level then
					table.insert(var_12_0, iter_12_3)

					break
				end
			end
		end
	end

	local var_12_2 = {}

	for iter_12_4, iter_12_5 in ipairs(var_12_0) do
		if iter_12_5.buildingType == 2 then
			local var_12_3 = string.split(iter_12_5.configType, "|")

			for iter_12_6, iter_12_7 in ipairs(var_12_3) do
				local var_12_4 = string.splitToNumber(iter_12_7, "#")
				local var_12_5 = var_12_4[1]
				local var_12_6 = var_12_4[2]

				var_12_2[var_12_5] = (var_12_2[var_12_5] or 0) + var_12_6
			end
		end
	end

	return var_12_2
end

function var_0_0.getBuildingGainList(arg_13_0)
	local var_13_0 = {}

	if arg_13_0.element_data then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.element_data) do
			if iter_13_1.level > 0 then
				local var_13_1 = VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(iter_13_1.elementId)

				for iter_13_2, iter_13_3 in pairs(var_13_1) do
					if (iter_13_3.buildingType == 2 or iter_13_3.buildingType == 3) and iter_13_3.level == iter_13_1.level then
						table.insert(var_13_0, iter_13_3)

						break
					end
				end
			end
		end
	end

	if arg_13_0.putTrap ~= 0 then
		table.insert(var_13_0, lua_activity116_building.configDict[arg_13_0.putTrap])
	end

	return var_13_0
end

function var_0_0.haveNextLevel(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getElementData(arg_14_1)

	if not var_14_0 then
		return true
	end

	local var_14_1 = {}

	for iter_14_0, iter_14_1 in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(arg_14_1)) do
		table.insert(var_14_1, iter_14_1)
	end

	table.sort(var_14_1, function(arg_15_0, arg_15_1)
		return arg_15_0.level < arg_15_1.level
	end)

	return var_14_1[var_14_0.level + 2]
end

function var_0_0.getDailyEpisodeConfigByElementId(arg_16_0, arg_16_1)
	local var_16_0 = lua_chapter_map_element.configDict[arg_16_1]

	if var_16_0.type == DungeonEnum.ElementType.DailyEpisode then
		local var_16_1 = VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(var_16_0.id)
		local var_16_2

		if var_16_1 then
			for iter_16_0, iter_16_1 in pairs(var_16_1) do
				var_16_2 = iter_16_1

				break
			end
		end

		if var_16_2 then
			local var_16_3 = string.splitToNumber(var_16_2.configType, "#")

			for iter_16_2, iter_16_3 in ipairs(var_16_3) do
				local var_16_4 = var_0_0.instance:getSpStatus(iter_16_3)

				if var_16_4 and var_16_4.status == 1 then
					return DungeonConfig.instance:getEpisodeCO(iter_16_3)
				end
			end
		end
	end
end

function var_0_0.jump2DailyEpisode(arg_17_0, arg_17_1)
	local var_17_0 = JumpConfig.instance:getJumpConfig(arg_17_1)
	local var_17_1 = string.splitToNumber(var_17_0.param, "#")

	if var_17_1[1] == 100 and var_17_1[2] == JumpEnum.ActIdEnum.Act1_2Dungeon and var_17_1[3] == JumpEnum.Activity1_2DungeonJump.Jump2Daily then
		local var_17_2 = var_17_1[4]
		local var_17_3 = VersionActivity1_2DungeonConfig.instance:getConfigByEpisodeId(var_17_2)

		if var_17_3 then
			local var_17_4 = var_17_3.elementId

			if not DungeonMapModel.instance:getElementById(var_17_4) then
				local var_17_5 = lua_chapter_map_element.configDict[var_17_4]
				local var_17_6 = string.splitToNumber(var_17_5.condition, "=")[2]
				local var_17_7 = DungeonConfig.instance:getEpisodeCO(var_17_6)
				local var_17_8 = DungeonConfig.instance:getChapterCO(var_17_7.chapterId)
				local var_17_9 = string.format(luaLang("dungeon_unlock_episode_mode"), luaLang("dungeon_story_mode") .. var_17_8.chapterIndex .. "-" .. VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(var_17_6))

				GameFacade.showToastString(var_17_9)
			else
				local var_17_10 = arg_17_0:getDailyEpisodeConfigByElementId(var_17_4)

				if var_17_10 then
					if var_17_10.id == var_17_2 then
						ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
						VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.clickDailyEpisode, var_17_4)
					else
						GameFacade.showMessageBox(MessageBoxIdDefine.Dungeon1_2Jump2Daily, MsgBoxEnum.BoxType.Yes_No, function()
							ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
							VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.clickDailyEpisode, var_17_4)
						end)
					end
				else
					for iter_17_0, iter_17_1 in ipairs(VersionActivity1_2DungeonConfig.instance:getType4List()) do
						if arg_17_0:getDailyEpisodeConfigByElementId(iter_17_1.elementId) then
							GameFacade.showMessageBox(MessageBoxIdDefine.Dungeon1_2Jump2Daily, MsgBoxEnum.BoxType.Yes_No, function()
								ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
								VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.clickDailyEpisode, iter_17_1.elementId)
							end)

							return true
						end
					end

					GameFacade.showToast(ToastEnum.Dungeon1_2CanNotJump2Daily)
				end
			end
		end

		return true
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
