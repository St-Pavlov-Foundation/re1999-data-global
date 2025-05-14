module("modules.logic.seasonver.act166.utils.Season166HeroGroupUtils", package.seeall)

local var_0_0 = class("Season166HeroGroupUtils")

function var_0_0.buildSnapshotHeroGroups(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = #arg_1_0 == 0 and {
		arg_1_0
	} or arg_1_0

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = Season166HeroGroupMO.New()

		if iter_1_1.heroList == nil or #iter_1_1.heroList <= 0 then
			if not var_0_0.checkFirstCopyHeroGroup(iter_1_1, var_1_2) then
				var_0_0.createEmptyGroup(iter_1_1, var_1_2)

				var_1_0[var_1_2.groupId] = var_1_2
			end
		else
			var_1_2:init(iter_1_1)

			var_1_0[iter_1_1.groupId] = var_1_2
		end
	end

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		return arg_2_0.groupId < arg_2_1.groupId
	end)

	return var_1_0
end

function var_0_0.checkFirstCopyHeroGroup(arg_3_0, arg_3_1)
	if arg_3_0.groupId == 1 then
		local var_3_0 = Season166HeroGroupModel.instance:getById(1)

		if var_3_0 then
			arg_3_1.id = arg_3_0.groupId
			arg_3_1.groupId = arg_3_0.groupId
			arg_3_1.name = var_3_0.name
			arg_3_1.heroList = {}

			for iter_3_0 = 1, Season166Enum.MaxHeroCount do
				table.insert(arg_3_1.heroList, Season166Enum.EmptyUid)
			end

			arg_3_1.aidDict = LuaUtil.deepCopy(var_3_0.aidDict)
			arg_3_1.clothId = var_3_0.clothId
			arg_3_1.equips = LuaUtil.deepCopy(var_3_0.equips)

			return true
		end
	end

	return false
end

function var_0_0.createEmptyGroup(arg_4_0, arg_4_1)
	local var_4_0 = Season166HeroGroupModel.instance:getById(1)

	arg_4_1.id = arg_4_0.groupId or 1
	arg_4_1.groupId = arg_4_0.groupId or 1
	arg_4_1.name = ""
	arg_4_1.heroList = {}

	for iter_4_0 = 1, Season166Enum.MaxHeroCount do
		table.insert(arg_4_1.heroList, Season166Enum.EmptyUid)
	end

	if var_4_0 then
		arg_4_1.clothId = var_4_0.clothId
	end

	arg_4_1.equips = {}

	local var_4_1 = Season166Enum.MaxHeroCount

	for iter_4_1 = 0, var_4_1 - 1 do
		local var_4_2 = HeroGroupEquipMO.New()

		var_4_2:init({
			index = iter_4_1,
			equipUid = {
				Season166Enum.EmptyUid
			}
		})

		arg_4_1.equips[iter_4_1] = var_4_2
	end
end

function var_0_0.buildFightGroupAssistHero(arg_5_0, arg_5_1)
	if arg_5_0 == ModuleEnum.HeroGroupType.Season166Train then
		local var_5_0 = Season166HeroSingleGroupModel.instance.assistMO

		if var_5_0 and tonumber(var_5_0.pickAssistHeroMO.heroUid) ~= 0 then
			arg_5_1.assistUserId = var_5_0.userId
			arg_5_1.assistHeroUid = var_5_0.pickAssistHeroMO.heroUid
		end
	end
end

return var_0_0
