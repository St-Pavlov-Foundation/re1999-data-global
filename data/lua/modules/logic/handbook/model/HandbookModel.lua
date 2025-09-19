module("modules.logic.handbook.model.HandbookModel", package.seeall)

local var_0_0 = class("HandbookModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._cgReadDict = {}
	arg_1_0._fragmentDict = {}
	arg_1_0._characterReadDict = {}
	arg_1_0._equipDict = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._cgReadDict = {}
	arg_2_0._fragmentDict = {}
	arg_2_0._characterReadDict = {}
	arg_2_0._equipDict = {}
end

function var_0_0.setReadInfos(arg_3_0, arg_3_1)
	arg_3_0._cgReadDict = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0:setReadInfo(iter_3_1)
	end
end

function var_0_0.setReadInfo(arg_4_0, arg_4_1)
	if arg_4_1.type == HandbookEnum.Type.CG then
		if arg_4_1.isRead then
			arg_4_0._cgReadDict[arg_4_1.id] = true
		elseif arg_4_0._cgReadDict[arg_4_1.id] then
			arg_4_0._cgReadDict[arg_4_1.id] = nil
		end
	elseif arg_4_1.type == HandbookEnum.Type.Character then
		if arg_4_1.isRead then
			arg_4_0._characterReadDict[arg_4_1.id] = true
		end
	elseif arg_4_1.type == HandbookEnum.Type.Equip then
		local var_4_0 = lua_handbook_equip.configDict[arg_4_1.id]

		if not var_4_0 then
			logError(string.format("handbook equip not found id : %s config", arg_4_1.id))

			return
		end

		arg_4_0._equipDict[var_4_0.equipId] = true
	end
end

function var_0_0.setFragmentInfo(arg_5_0, arg_5_1)
	arg_5_0._fragmentDict = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = lua_chapter_map_element.configDict[iter_5_1.element]

		if var_5_0 and var_5_0.fragment ~= 0 then
			local var_5_1 = {}

			for iter_5_2, iter_5_3 in ipairs(iter_5_1.dialogIds) do
				table.insert(var_5_1, iter_5_3)
			end

			arg_5_0._fragmentDict[var_5_0.fragment] = var_5_1
		end
	end
end

function var_0_0.isRead(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == HandbookEnum.Type.CG then
		return arg_6_0._cgReadDict[arg_6_2]
	elseif arg_6_1 == HandbookEnum.Type.Character then
		return arg_6_0._characterReadDict[arg_6_2]
	end

	return false
end

function var_0_0.isCGUnlock(arg_7_0, arg_7_1)
	local var_7_0 = HandbookConfig.instance:getCGConfig(arg_7_1).episodeId

	return var_7_0 == 0 or DungeonModel.instance:hasPassLevelAndStory(var_7_0)
end

function var_0_0.getCGUnlockCount(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0
	local var_8_1 = HandbookConfig.instance:getCGList(arg_8_2)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if (not arg_8_1 or iter_8_1.storyChapterId == arg_8_1) and var_0_0.instance:isCGUnlock(iter_8_1.id) then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_0.getCGUnlockIndex(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 1
	local var_9_1 = HandbookConfig.instance:getCGList(arg_9_2)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if iter_9_1.id == arg_9_1 then
			return var_9_0
		end

		if var_0_0.instance:isCGUnlock(iter_9_1.id) then
			var_9_0 = var_9_0 + 1
		end
	end
end

function var_0_0.getCGUnlockIndexInChapter(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = 1
	local var_10_1 = HandbookConfig.instance:getCGDictByChapter(arg_10_1, arg_10_3)

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if iter_10_1.id == arg_10_2 then
			return var_10_0
		end

		if var_0_0.instance:isCGUnlock(iter_10_1.id) then
			var_10_0 = var_10_0 + 1
		end
	end
end

function var_0_0.getNextCG(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = HandbookConfig.instance:getCGIndex(arg_11_1, arg_11_2)
	local var_11_1 = HandbookConfig.instance:getCGList(arg_11_2)

	for iter_11_0 = var_11_0 + 1, #var_11_1 do
		local var_11_2 = var_11_1[iter_11_0]

		if arg_11_0:isCGUnlock(var_11_2.id) then
			return var_11_2
		end
	end

	for iter_11_1 = 1, var_11_0 - 1 do
		local var_11_3 = var_11_1[iter_11_1]

		if arg_11_0:isCGUnlock(var_11_3.id) then
			return var_11_3
		end
	end

	return nil
end

function var_0_0.getPrevCG(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = HandbookConfig.instance:getCGIndex(arg_12_1, arg_12_2)
	local var_12_1 = HandbookConfig.instance:getCGList(arg_12_2)

	for iter_12_0 = var_12_0 - 1, 1, -1 do
		local var_12_2 = var_12_1[iter_12_0]

		if arg_12_0:isCGUnlock(var_12_2.id) then
			return var_12_2
		end
	end

	for iter_12_1 = #var_12_1, var_12_0 + 1, -1 do
		local var_12_3 = var_12_1[iter_12_1]

		if arg_12_0:isCGUnlock(var_12_3.id) then
			return var_12_3
		end
	end

	return nil
end

function var_0_0.isStoryGroupUnlock(arg_13_0, arg_13_1)
	local var_13_0 = HandbookConfig.instance:getStoryGroupConfig(arg_13_1).episodeId

	return var_13_0 == 0 or DungeonModel.instance:hasPassLevelAndStory(var_13_0)
end

function var_0_0.getStoryGroupUnlockCount(arg_14_0, arg_14_1)
	local var_14_0 = 0
	local var_14_1 = HandbookConfig.instance:getStoryGroupList()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if (not arg_14_1 or iter_14_1.storyChapterId == arg_14_1) and var_0_0.instance:isStoryGroupUnlock(iter_14_1.id) then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0
end

function var_0_0.getFragmentDialogIdList(arg_15_0, arg_15_1)
	return arg_15_0._fragmentDict[arg_15_1]
end

function var_0_0.haveEquip(arg_16_0, arg_16_1)
	return arg_16_0._equipDict[arg_16_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
