module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DungeonModel", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.dispatchInfoDict = {}
	arg_3_0.elementId2DispatchMoDict = {}
	arg_3_0.dispatchedHeroDict = {}
	arg_3_0.needCheckDispatchInfoList = {}
end

function var_0_0.checkDispatchFinish(arg_4_0)
	local var_4_0 = #arg_4_0.needCheckDispatchInfoList

	if var_4_0 <= 0 then
		return
	end

	local var_4_1 = false

	for iter_4_0 = var_4_0, 1, -1 do
		local var_4_2 = arg_4_0.needCheckDispatchInfoList[iter_4_0]

		if var_4_2:isFinish() then
			var_4_1 = true

			for iter_4_1, iter_4_2 in ipairs(var_4_2.heroIdList) do
				arg_4_0.dispatchedHeroDict[iter_4_2] = nil
			end

			table.remove(arg_4_0.needCheckDispatchInfoList, iter_4_0)
		end
	end

	if var_4_1 then
		VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnDispatchFinish)
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.V1a5DungeonExploreTask
		})
	end
end

function var_0_0.addDispatchInfos(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = arg_5_0.dispatchInfoDict[iter_5_1.id]

		if not var_5_0 then
			var_5_0 = VersionActivity1_5DispatchMo.New()

			var_5_0:init(iter_5_1)

			arg_5_0.dispatchInfoDict[iter_5_1.id] = var_5_0
		else
			var_5_0:update(iter_5_1)
		end

		if var_5_0:isRunning() then
			for iter_5_2, iter_5_3 in ipairs(iter_5_1.heroIds) do
				arg_5_0.dispatchedHeroDict[iter_5_3] = true
			end

			table.insert(arg_5_0.needCheckDispatchInfoList, var_5_0)
		end
	end
end

function var_0_0.addOneDispatchInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = VersionActivity1_5DispatchMo.New()

	var_6_0:init({
		id = arg_6_1,
		endTime = arg_6_2,
		heroIds = arg_6_3
	})

	arg_6_0.dispatchInfoDict[arg_6_1] = var_6_0

	if var_6_0:isRunning() then
		for iter_6_0, iter_6_1 in ipairs(arg_6_3) do
			arg_6_0.dispatchedHeroDict[iter_6_1] = true
		end

		table.insert(arg_6_0.needCheckDispatchInfoList, var_6_0)
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.AddDispatchInfo, arg_6_1)
end

function var_0_0.removeOneDispatchInfo(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.dispatchInfoDict[arg_7_1]

	arg_7_0.dispatchInfoDict[arg_7_1] = nil

	for iter_7_0, iter_7_1 in ipairs(var_7_0.heroIdList) do
		arg_7_0.dispatchedHeroDict[iter_7_1] = nil
	end

	tabletool.removeValue(arg_7_0.needCheckDispatchInfoList, var_7_0)

	for iter_7_2, iter_7_3 in pairs(arg_7_0.elementId2DispatchMoDict) do
		if iter_7_3.id == arg_7_1 then
			arg_7_0.elementId2DispatchMoDict[iter_7_2] = nil

			break
		end
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.RemoveDispatchInfo, arg_7_1)
end

function var_0_0.getDispatchMo(arg_8_0, arg_8_1)
	return arg_8_0.dispatchInfoDict[arg_8_1]
end

function var_0_0.getDispatchStatus(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.dispatchInfoDict[arg_9_1]

	if not var_9_0 then
		return VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch
	elseif var_9_0:isFinish() then
		return VersionActivity1_5DungeonEnum.DispatchStatus.Finished
	else
		return VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching
	end
end

function var_0_0.isDispatched(arg_10_0, arg_10_1)
	return arg_10_0.dispatchedHeroDict[arg_10_1]
end

function var_0_0.getElementCoList(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = DungeonMapModel.instance:getAllElements()

	for iter_11_0, iter_11_1 in pairs(var_11_2) do
		local var_11_3 = DungeonConfig.instance:getChapterMapElement(iter_11_1)
		local var_11_4 = lua_chapter_map.configDict[var_11_3.mapId]

		if var_11_4 and var_11_4.chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Story then
			local var_11_5 = lua_activity11502_episode_element.configDict[var_11_3.id]

			if var_11_5 and not string.nilorempty(var_11_5.mapIds) then
				local var_11_6 = string.splitToNumber(var_11_5.mapIds, "#")

				if tabletool.indexOf(var_11_6, arg_11_1) then
					table.insert(var_11_1, var_11_3)
				end
			elseif arg_11_1 == var_11_3.mapId then
				table.insert(var_11_0, var_11_3)
			end
		end
	end

	return var_11_0, var_11_1
end

function var_0_0.getDispatchMoByElementId(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.elementId2DispatchMoDict[arg_12_1]

	if var_12_0 then
		return var_12_0
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.dispatchInfoDict) do
		if iter_12_1.config.elementId == arg_12_1 then
			arg_12_0.elementId2DispatchMoDict[arg_12_1] = iter_12_1

			return iter_12_1
		end
	end
end

function var_0_0.setShowInteractView(arg_13_0, arg_13_1)
	arg_13_0.isShowInteractView = arg_13_1
end

function var_0_0.checkIsShowInteractView(arg_14_0)
	return arg_14_0.isShowInteractView
end

var_0_0.instance = var_0_0.New()

return var_0_0
