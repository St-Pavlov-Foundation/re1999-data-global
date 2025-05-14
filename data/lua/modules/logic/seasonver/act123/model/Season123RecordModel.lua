module("modules.logic.seasonver.act123.model.Season123RecordModel", package.seeall)

local var_0_0 = class("Season123RecordModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.setServerDataVerifiableId(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._tmpVerifiableActId = arg_3_1
	arg_3_0._tmpVerifiableStage = arg_3_2
end

function var_0_0.setSeason123ServerRecordData(arg_4_0, arg_4_1)
	arg_4_0:clear()

	if not arg_4_1 then
		return
	end

	local var_4_0, var_4_1 = arg_4_0:getServerDataVerifiableId()

	if arg_4_1.activityId ~= var_4_0 or arg_4_1.stage ~= var_4_1 then
		return
	end

	arg_4_0:setServerDataVerifiableId()

	local var_4_2 = arg_4_1.stageRecords

	if not var_4_2 then
		return
	end

	for iter_4_0 = 1, Activity123Enum.RecordItemCount do
		local var_4_3 = {}
		local var_4_4 = var_4_2[iter_4_0]

		if var_4_4 then
			var_4_3.round = var_4_4.round
			var_4_3.isBest = var_4_4.isBest

			local var_4_5, var_4_6 = arg_4_0:_getHeroDataByServerData(var_4_4.stageRecordHeros)

			var_4_3.heroList = var_4_5
			var_4_3.attackStatistics = arg_4_0:_geAttackStatisticsByServerData(var_4_4.attackStatistics, var_4_6)
		else
			var_4_3.isEmpty = true
		end

		arg_4_0:addAtLast(var_4_3)
	end
end

function var_0_0.getServerDataVerifiableId(arg_5_0)
	return arg_5_0._tmpVerifiableActId, arg_5_0._tmpVerifiableStage
end

function var_0_0.getRecordList(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = arg_6_0:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = iter_6_1.isBest

		if arg_6_1 and var_6_2 or not arg_6_1 and not var_6_2 then
			var_6_0[#var_6_0 + 1] = iter_6_1
		end
	end

	return var_6_0
end

function var_0_0._getHeroDataByServerData(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = {}
	local var_7_1 = {}

	for iter_7_0 = 1, Activity123Enum.PickHeroCount do
		local var_7_2 = arg_7_1[iter_7_0]
		local var_7_3 = {
			heroId = 0,
			uid = 0
		}

		if var_7_2 then
			var_7_3.uid = var_7_2.heroUid
			var_7_3.heroId = var_7_2.heroId
			var_7_3.skinId = var_7_2.skinId
			var_7_3.isAssist = var_7_2.isAssist
			var_7_3.isBalance = var_7_2.isBalance
			var_7_3.level = var_7_2.level
		end

		var_7_0[iter_7_0] = var_7_3
		var_7_1[var_7_3.uid] = var_7_3
	end

	return var_7_0, var_7_1
end

function var_0_0._geAttackStatisticsByServerData(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 then
		return
	end

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_1 = {
			heroUid = iter_8_1.heroUid,
			harm = iter_8_1.harm,
			hurt = iter_8_1.hurt,
			heal = iter_8_1.heal
		}
		local var_8_2 = {}

		for iter_8_2, iter_8_3 in ipairs(iter_8_1.cards) do
			var_8_2[iter_8_2] = {
				skillId = iter_8_3.skillId,
				useCount = iter_8_3.useCount
			}
		end

		var_8_1.cards = var_8_2
		var_8_1.getBuffs = iter_8_1.getBuffs

		local var_8_3 = arg_8_2 and arg_8_2[var_8_1.heroUid] or {}
		local var_8_4 = var_8_3 and var_8_3.heroId or 0
		local var_8_5 = var_8_3 and var_8_3.level or 1
		local var_8_6 = var_8_3 and var_8_3.skinId

		var_8_1.entityMO = FightHelper.getEmptyFightEntityMO(var_8_1.heroUid, var_8_4, var_8_5, var_8_6)
		var_8_0[iter_8_0] = var_8_1
	end

	return var_8_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
