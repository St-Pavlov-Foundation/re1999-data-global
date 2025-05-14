module("modules.logic.season.model.Activity104Mo", package.seeall)

local var_0_0 = pureTable("Activity104Mo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.activityId = 0
	arg_1_0.activity104Items = {}
	arg_1_0.episodes = {}
	arg_1_0.retails = {}
	arg_1_0.specials = {}
	arg_1_0.unlockEquipIndexs = {}
	arg_1_0.optionalEquipCount = 0
	arg_1_0.heroGroupSnapshot = {}
	arg_1_0.tempHeroGroupSnapshot = {}
	arg_1_0.heroGroupSnapshotSubId = 1
	arg_1_0.retailStage = 1
	arg_1_0.unlockActivity104EquipIds = {}
	arg_1_0.activity104ItemCountDict = {}
	arg_1_0.trialId = 0
	arg_1_0.isPopSummary = true
	arg_1_0.lastMaxLayer = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.activityId = arg_2_1.activityId
	arg_2_0.activity104Items = arg_2_0:_buildItems(arg_2_1.activity104Items)
	arg_2_0.episodes = arg_2_0:_buildEpisodes(arg_2_1.episodes)
	arg_2_0.retails = arg_2_0:_buildRetails(arg_2_1.retails)
	arg_2_0.specials = arg_2_0:_buildSpecials(arg_2_1.specials)
	arg_2_0.unlockEquipIndexs = arg_2_0:_buildList(arg_2_1.unlockEquipIndexs)
	arg_2_0.optionalEquipCount = arg_2_1.optionalEquipCount
	arg_2_0.heroGroupSnapshot = arg_2_0:_buildSnapshot(arg_2_1.heroGroupSnapshot)
	arg_2_0.heroGroupSnapshotSubId = arg_2_1.heroGroupSnapshotSubId
	arg_2_0.retailStage = arg_2_1.retailStage

	arg_2_0:setUnlockActivity104EquipIds(arg_2_1.unlockActivity104EquipIds)

	arg_2_0.readActivity104Story = arg_2_1.readActivity104Story
	arg_2_0.trialId = arg_2_1.trial.id
	arg_2_0.isPopSummary = arg_2_1.preSummary.isPopSummary
	arg_2_0.lastMaxLayer = arg_2_1.preSummary.maxLayer

	arg_2_0:refreshItemCount()
end

function var_0_0.reset(arg_3_0, arg_3_1)
	arg_3_0.activityId = arg_3_1.activityId
	arg_3_0.trialId = arg_3_1.trial.id

	arg_3_0:_addUnlockEquipIndexs(arg_3_1.unlockEquipIndexs)

	arg_3_0.optionalEquipCount = arg_3_1.optionalEquipCount

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.updateEpisodes) do
		if not arg_3_0.episodes[iter_3_1.layer] then
			arg_3_0.episodes[iter_3_1.layer] = Activity104EpisodeMo.New()

			arg_3_0.episodes[iter_3_1.layer]:init(iter_3_1)
		else
			arg_3_0.episodes[iter_3_1.layer]:reset(iter_3_1)
		end
	end

	arg_3_0.retails = arg_3_0:_buildRetails(arg_3_1.retails)

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.updateSpecials) do
		if not arg_3_0.specials[iter_3_3.layer] then
			arg_3_0.specials[iter_3_3.layer] = Activity104SpecialMo.New()

			arg_3_0.specials[iter_3_3.layer]:init(iter_3_3)
		else
			arg_3_0.specials[iter_3_3.layer]:reset(iter_3_3)
		end
	end
end

function var_0_0._addUnlockEquipIndexs(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		table.insert(arg_4_0.unlockEquipIndexs, iter_4_1)
	end
end

function var_0_0.updateItems(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1.activity104Items) do
		if arg_5_0.activity104Items[iter_5_1.uid] then
			arg_5_0.activity104Items[iter_5_1.uid]:reset(iter_5_1)
		else
			local var_5_0 = Activity104ItemMo.New()

			var_5_0:init(iter_5_1)

			arg_5_0.activity104Items[iter_5_1.uid] = var_5_0
		end
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_1.deleteItems) do
		if arg_5_0.activity104Items[iter_5_3.uid] then
			arg_5_0.activity104Items[iter_5_3.uid] = nil
		end
	end

	arg_5_0:refreshItemCount()
end

function var_0_0._buildEpisodes(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_1 = Activity104EpisodeMo.New()

		var_6_1:init(iter_6_1)

		var_6_0[var_6_1.layer] = var_6_1
	end

	return var_6_0
end

function var_0_0._buildRetails(arg_7_0, arg_7_1)
	arg_7_0.lastRetails = arg_7_0.retails

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_1 = Activity104RetailMo.New()

		var_7_1:init(iter_7_1)
		table.insert(var_7_0, var_7_1)
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0.id < arg_8_1.id
	end)

	return var_7_0
end

function var_0_0._buildSpecials(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_1 = Activity104SpecialMo.New()

		var_9_1:init(iter_9_1)
		table.insert(var_9_0, var_9_1)
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0.layer < arg_10_1.layer
	end)

	return var_9_0
end

function var_0_0._buildItems(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_1 = Activity104ItemMo.New()

		var_11_1:init(iter_11_1)

		var_11_0[iter_11_1.uid] = var_11_1
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0.itemId < arg_12_1.itemId
	end)

	return var_11_0
end

function var_0_0._buildList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		table.insert(var_13_0, iter_13_1)
	end

	return var_13_0
end

function var_0_0._buildSnapshot(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_1 = HeroGroupMO.New()
		local var_14_2 = true

		for iter_14_2, iter_14_3 in ipairs(iter_14_1.heroList) do
			if tonumber(iter_14_3) ~= 0 then
				var_14_2 = false
			end

			break
		end

		if var_14_2 then
			local var_14_3 = HeroGroupModel.instance:getById(1)

			if iter_14_1.groupId == 1 and var_14_3 then
				var_14_1.id = iter_14_1.groupId
				var_14_1.groupId = iter_14_1.groupId
				var_14_1.name = var_14_3.name
				var_14_1.heroList = LuaUtil.deepCopy(var_14_3.heroList)
				var_14_1.aidDict = LuaUtil.deepCopy(var_14_3.aidDict)
				var_14_1.clothId = var_14_3.clothId
				var_14_1.equips = LuaUtil.deepCopy(var_14_3.equips)
				var_14_1.activity104Equips = LuaUtil.deepCopy(var_14_3.activity104Equips)
			else
				var_14_1.id = iter_14_1.groupId
				var_14_1.groupId = iter_14_1.groupId
				var_14_1.name = ""
				var_14_1.heroList = {
					"0",
					"0",
					"0",
					"0"
				}
				var_14_1.clothId = var_14_3.clothId
				var_14_1.equips = {}

				for iter_14_4 = 0, 3 do
					var_14_1:updatePosEquips({
						index = iter_14_4,
						equipUid = {
							"0"
						}
					})
				end

				var_14_1.activity104Equips = {}

				for iter_14_5 = 0, 3 do
					var_14_1:updatePosEquips({
						index = iter_14_5,
						equipUid = {
							"0"
						}
					})
				end

				local var_14_4 = HeroGroupActivity104EquipMo.New()

				var_14_4:init({
					index = 4,
					equipUid = {
						"0"
					}
				})

				var_14_1.activity104Equips[4] = var_14_4
			end
		else
			var_14_1:init(iter_14_1)
		end

		var_14_1:clearAidHero()

		var_14_0[iter_14_1.groupId] = var_14_1
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0.groupId < arg_15_1.groupId
	end)

	return var_14_0
end

function var_0_0.replaceRetails(arg_16_0, arg_16_1)
	arg_16_0.retails = arg_16_0:_buildRetails(arg_16_1)
end

function var_0_0.getLastRetails(arg_17_0)
	local var_17_0 = arg_17_0.lastRetails

	arg_17_0.lastRetails = nil

	return var_17_0
end

function var_0_0.setUnlockActivity104EquipIds(arg_18_0, arg_18_1)
	arg_18_0.unlockActivity104EquipIds = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		arg_18_0.unlockActivity104EquipIds[iter_18_1] = iter_18_1
	end
end

function var_0_0.markStory(arg_19_0, arg_19_1)
	arg_19_0.readActivity104Story = arg_19_1
end

function var_0_0.markEpisodeAfterStory(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.episodes[arg_20_1]

	if var_20_0 then
		var_20_0:markStory(true)
	end
end

function var_0_0.setBattleFinishLayer(arg_21_0, arg_21_1)
	if arg_21_1 > 0 then
		arg_21_0.battleFinishLayer = arg_21_1
	end
end

function var_0_0.getBattleFinishLayer(arg_22_0)
	return arg_22_0.battleFinishLayer
end

function var_0_0.refreshItemCount(arg_23_0)
	arg_23_0.activity104ItemCountDict = {}

	if arg_23_0.activity104Items then
		for iter_23_0, iter_23_1 in pairs(arg_23_0.activity104Items) do
			if arg_23_0.activity104ItemCountDict[iter_23_1.itemId] then
				arg_23_0.activity104ItemCountDict[iter_23_1.itemId] = arg_23_0.activity104ItemCountDict[iter_23_1.itemId] + 1
			else
				arg_23_0.activity104ItemCountDict[iter_23_1.itemId] = 1
			end
		end
	end
end

function var_0_0.getItemCount(arg_24_0, arg_24_1)
	return arg_24_0.activity104ItemCountDict[arg_24_1] or 0
end

function var_0_0.getSnapshotHeroGroupBySubId(arg_25_0, arg_25_1)
	arg_25_1 = arg_25_1 or arg_25_0.heroGroupSnapshotSubId

	local var_25_0 = arg_25_0.heroGroupSnapshot[arg_25_1]
	local var_25_1 = HeroGroupModel.instance.battleConfig

	if var_25_1 and (#string.splitToNumber(var_25_1.aid, "#") > 0 or var_25_1.trialLimit > 0) then
		return arg_25_0.tempHeroGroupSnapshot[arg_25_1]
	end

	return var_25_0
end

function var_0_0.getRealHeroGroupBySubId(arg_26_0, arg_26_1)
	arg_26_1 = arg_26_1 or arg_26_0.heroGroupSnapshotSubId

	return arg_26_0.heroGroupSnapshot[arg_26_1]
end

function var_0_0.getIsPopSummary(arg_27_0)
	return arg_27_0.isPopSummary
end

function var_0_0.setIsPopSummary(arg_28_0, arg_28_1)
	arg_28_0.isPopSummary = arg_28_1
end

function var_0_0.getLastMaxLayer(arg_29_0)
	return arg_29_0.lastMaxLayer
end

function var_0_0.getTrialId(arg_30_0)
	return arg_30_0.trialId
end

function var_0_0.buildHeroGroup(arg_31_0)
	local var_31_0 = HeroGroupModel.instance.battleConfig

	if var_31_0 and (#string.splitToNumber(var_31_0.aid, "#") > 0 or var_31_0.trialLimit > 0) then
		arg_31_0.tempHeroGroupSnapshot = {}

		for iter_31_0, iter_31_1 in ipairs(arg_31_0.heroGroupSnapshot) do
			arg_31_0.tempHeroGroupSnapshot[iter_31_0] = HeroGroupModel.instance:generateTempGroup(iter_31_1)

			arg_31_0.tempHeroGroupSnapshot[iter_31_0]:setTemp(false)
		end
	end
end

return var_0_0
