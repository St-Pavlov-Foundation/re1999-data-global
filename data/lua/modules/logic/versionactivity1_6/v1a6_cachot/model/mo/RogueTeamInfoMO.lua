module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueTeamInfoMO", package.seeall)

local var_0_0 = pureTable("RogueTeamInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.groupIdx = arg_1_1.groupIdx
	arg_1_0._allHeros = {}
	arg_1_0.fightHeros = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.fightHeros) do
		local var_1_0 = HeroMo.New()

		var_1_0:update(iter_1_1)
		table.insert(arg_1_0.fightHeros, var_1_0)

		arg_1_0._allHeros[iter_1_1.heroId] = true
	end

	arg_1_0.supportHeros = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.supportHeros) do
		local var_1_1 = HeroMo.New()

		var_1_1:update(iter_1_3)
		table.insert(arg_1_0.supportHeros, var_1_1)

		arg_1_0._allHeros[iter_1_3.heroId] = true
	end

	arg_1_0.lifes = {}
	arg_1_0.lifeMap = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.lifes) do
		local var_1_2 = RogueHeroLifeMO.New()

		var_1_2:init(iter_1_5)
		table.insert(arg_1_0.lifes, var_1_2)

		arg_1_0.lifeMap[var_1_2.heroId] = var_1_2
	end

	arg_1_0.groupInfos = {}
	arg_1_0.groupInfoMap = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.groupInfos) do
		local var_1_3 = RogueGroupInfoMO.New()

		var_1_3:init(iter_1_7)
		table.insert(arg_1_0.groupInfos, var_1_3)

		arg_1_0.groupInfoMap[var_1_3.id] = var_1_3
	end

	arg_1_0:updateGroupBoxStar(arg_1_1.groupBoxStar)

	arg_1_0.equipUids = {}
	arg_1_0.equipUidsMap = {}

	for iter_1_8, iter_1_9 in ipairs(arg_1_1.equipUids) do
		table.insert(arg_1_0.equipUids, iter_1_9)

		arg_1_0.equipUidsMap[iter_1_9] = true
	end
end

function var_0_0.hasEquip(arg_2_0, arg_2_1)
	return arg_2_0.equipUidsMap[arg_2_1]
end

function var_0_0.updateGroupBoxStar(arg_3_0, arg_3_1)
	arg_3_0.groupBoxStar = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(arg_3_0.groupBoxStar, iter_3_1)
	end
end

function var_0_0.getHeroHp(arg_4_0, arg_4_1)
	return arg_4_0.lifeMap[arg_4_1]
end

function var_0_0.getCurGroupInfo(arg_5_0)
	return arg_5_0.groupInfoMap[arg_5_0.groupIdx]
end

function var_0_0.getGroupInfos(arg_6_0)
	local var_6_0 = {}

	for iter_6_0 = 1, 4 do
		local var_6_1 = arg_6_0.groupInfos[iter_6_0]

		if not var_6_1 then
			var_6_1 = RogueGroupInfoMO.New()

			var_6_1:init({
				id = iter_6_0,
				heroList = {},
				equips = {}
			})
		end

		table.insert(var_6_0, var_6_1)
	end

	return var_6_0
end

function var_0_0.getAllHeroIdsMap(arg_7_0)
	return arg_7_0._allHeros
end

function var_0_0.getAllHeroUids(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.fightHeros) do
		local var_8_1 = HeroModel.instance:getByHeroId(iter_8_1.heroId)

		if var_8_1 then
			table.insert(var_8_0, var_8_1.uid)
		end
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.supportHeros) do
		local var_8_2 = HeroModel.instance:getByHeroId(iter_8_3.heroId)

		if var_8_2 then
			table.insert(var_8_0, var_8_2.uid)
		end
	end

	return var_8_0
end

function var_0_0.getGroupHeros(arg_9_0)
	local var_9_0 = arg_9_0:getCurGroupInfo()
	local var_9_1 = {}

	if not var_9_0 then
		return var_9_1
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_0.heroList) do
		local var_9_2 = HeroModel.instance:getById(iter_9_1)
		local var_9_3 = HeroSingleGroupMO.New()

		if var_9_2 then
			var_9_3.id = var_9_2.heroId
			var_9_3.heroUid = var_9_2.uid
		end

		table.insert(var_9_1, var_9_3)
	end

	return var_9_1
end

function var_0_0.getGroupLiveHeros(arg_10_0)
	local var_10_0 = arg_10_0:getCurGroupInfo()
	local var_10_1 = {}

	if not var_10_0 then
		return var_10_1
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0.heroList) do
		local var_10_2 = HeroModel.instance:getById(iter_10_1)
		local var_10_3 = HeroSingleGroupMO.New()
		local var_10_4 = var_10_2 and arg_10_0:getHeroHp(var_10_2.heroId)

		if var_10_4 and var_10_4.life > 0 then
			var_10_3.id = var_10_2.heroId
			var_10_3.heroUid = var_10_2.uid
		end

		table.insert(var_10_1, var_10_3)
	end

	return var_10_1
end

function var_0_0.getGroupEquips(arg_11_0)
	local var_11_0 = arg_11_0:getCurGroupInfo()
	local var_11_1 = {}

	if not var_11_0 then
		return var_11_1
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_0.equips) do
		local var_11_2 = iter_11_1.equipUid[1]

		var_11_1[iter_11_0] = EquipModel.instance:getEquip(var_11_2)
	end

	return var_11_1
end

function var_0_0.getFightHeros(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.fightHeros) do
		local var_12_1 = HeroModel.instance:getByHeroId(iter_12_1.heroId)
		local var_12_2 = HeroSingleGroupMO.New()

		if var_12_1 then
			var_12_2.id = var_12_1.heroId
			var_12_2.heroUid = var_12_1.uid
		end

		table.insert(var_12_0, var_12_2)
	end

	return var_12_0
end

function var_0_0.getSupportHeros(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.supportHeros) do
		local var_13_1 = HeroModel.instance:getByHeroId(iter_13_1.heroId)

		if var_13_1 then
			local var_13_2 = HeroSingleGroupMO.New()

			var_13_2.id = var_13_1.heroId
			var_13_2.heroUid = var_13_1.uid
			var_13_2._heroMO = var_13_1

			table.insert(var_13_0, var_13_2)
		end
	end

	return var_13_0
end

function var_0_0.getSupportLiveHeros(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.supportHeros) do
		local var_14_1 = HeroModel.instance:getByHeroId(iter_14_1.heroId)
		local var_14_2 = var_14_1 and arg_14_0:getHeroHp(var_14_1.heroId)

		if var_14_2 and var_14_2.life > 0 then
			local var_14_3 = HeroSingleGroupMO.New()

			var_14_3.id = var_14_1.heroId
			var_14_3.heroUid = var_14_1.uid
			var_14_3._heroMO = var_14_1
			var_14_3._hp = var_14_2.life

			table.insert(var_14_0, var_14_3)
		end
	end

	return var_14_0
end

return var_0_0
