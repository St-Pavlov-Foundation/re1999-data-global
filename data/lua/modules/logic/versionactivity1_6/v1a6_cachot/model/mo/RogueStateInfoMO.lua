module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueStateInfoMO", package.seeall)

local var_0_0 = pureTable("RogueStateInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.start = arg_1_1.start
	arg_1_0.weekScore = arg_1_1.weekScore
	arg_1_0.totalScore = arg_1_1.totalScore
	arg_1_0.scoreLimit = arg_1_1.scoreLimit
	arg_1_0.stage = arg_1_1.stage
	arg_1_0.nextStageSecond = arg_1_1.nextStageSecond
	arg_1_0.difficulty = arg_1_1.difficulty
	arg_1_0.layer = arg_1_1.layer
	arg_1_0.hasCollections = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.hasCollections) do
		table.insert(arg_1_0.hasCollections, iter_1_1)
	end

	arg_1_0.unlockCollections = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.unlockCollections) do
		table.insert(arg_1_0.unlockCollections, iter_1_3)
	end

	arg_1_0.getRewards = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.getRewards) do
		table.insert(arg_1_0.getRewards, iter_1_5)
	end

	arg_1_0.passDifficulty = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.passDifficulty) do
		table.insert(arg_1_0.passDifficulty, iter_1_7)
	end

	arg_1_0:updateUnlockCollectionsNew(arg_1_1.unlockCollectionsNew)

	arg_1_0.lastGroup = RogueGroupInfoMO.New()

	arg_1_0.lastGroup:init(arg_1_1.lastGroup)

	arg_1_0.lastBackupGroup = RogueGroupInfoMO.New()

	arg_1_0.lastBackupGroup:init(arg_1_1.lastBackupGroup)
end

function var_0_0.getLastGroupInfo(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = {}

	arg_2_1 = arg_2_1 or 0

	tabletool.addValues(var_2_0, arg_2_0.lastGroup.heroList)
	tabletool.addValues(var_2_1, arg_2_0.lastGroup.equips)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.lastBackupGroup.heroList) do
		if iter_2_0 <= arg_2_1 then
			table.insert(var_2_0, iter_2_1)
		end
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_0.lastBackupGroup.equips) do
		if iter_2_2 <= arg_2_1 then
			table.insert(var_2_1, iter_2_3)
		end
	end

	local var_2_2 = {}

	for iter_2_4, iter_2_5 in ipairs(var_2_1) do
		var_2_2[iter_2_4 - 1] = iter_2_5
		iter_2_5.index = iter_2_4 - 1
	end

	return var_2_0, var_2_2
end

function var_0_0.isStart(arg_3_0)
	return arg_3_0.start
end

function var_0_0.updateUnlockCollectionsNew(arg_4_0, arg_4_1)
	arg_4_0.unlockCollectionsNew = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0.unlockCollectionsNew[iter_4_1] = true
	end
end

return var_0_0
