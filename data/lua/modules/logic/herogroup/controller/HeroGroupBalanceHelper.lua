module("modules.logic.herogroup.controller.HeroGroupBalanceHelper", package.seeall)

local var_0_0 = class("HeroGroupBalanceHelper")

var_0_0.BalanceColor = "#bfdaff"
var_0_0.BalanceIconColor = "#81abe5"

function var_0_0.canShowBalanceSwitchBtn()
	local var_1_0 = FightModel.instance:getFightParam()

	if not var_1_0 or not var_1_0.episodeId then
		return false
	end

	local var_1_1 = DungeonConfig.instance:getEpisodeCO(var_1_0.episodeId).firstBattleId

	if var_1_1 and var_1_1 > 0 then
		local var_1_2 = DungeonModel.instance:getEpisodeInfo(var_1_0.episodeId)

		if var_1_2 and var_1_2.star > DungeonEnum.StarType.None then
			local var_1_3 = lua_battle.configDict[var_1_1]

			if var_1_3 then
				return not string.nilorempty(var_1_3.balance)
			end
		end
	end

	return false
end

function var_0_0.switchBalanceMode()
	var_0_0._isClickBalance = false

	local var_2_0 = FightModel.instance:getFightParam()

	if not var_2_0 then
		return
	end

	local var_2_1 = var_0_0.getIsBalanceMode()
	local var_2_2 = DungeonConfig.instance:getEpisodeCO(var_2_0.episodeId)

	if var_2_1 then
		var_2_0.battleId = var_2_2.battleId
	else
		var_0_0._isClickBalance = true
		var_2_0.battleId = var_2_2.firstBattleId
	end

	var_2_0:setBattleId(var_2_0.battleId)

	HeroGroupModel.instance.battleId = var_2_0.battleId

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)
end

function var_0_0.clearBalanceStatus()
	var_0_0._isClickBalance = false
end

function var_0_0.isClickBalance()
	return var_0_0._isClickBalance
end

function var_0_0.getIsBalanceMode()
	local var_5_0 = FightModel.instance:getFightParam()

	if not var_5_0 then
		return false
	end

	local var_5_1 = lua_battle.configDict[var_5_0.battleId]

	return var_5_1 and not string.nilorempty(var_5_1.balance) or false
end

local var_0_1
local var_0_2

function var_0_0.getBalanceLv()
	local var_6_0 = FightModel.instance:getFightParam()

	if not var_6_0 then
		return
	end

	local var_6_1 = lua_battle.configDict[var_6_0.battleId]

	if not var_6_1 or string.nilorempty(var_6_1.balance) then
		return
	end

	local var_6_2 = string.splitToNumber(var_6_1.balance, "#")
	local var_6_3 = var_6_2[1] or 0
	local var_6_4 = var_6_2[2] or 0
	local var_6_5 = var_6_2[3] or 0

	if var_0_1 == nil then
		var_0_1 = #lua_character_cosume.configDict
	end

	if var_0_2 == nil then
		var_0_2 = 1

		for iter_6_0, iter_6_1 in pairs(lua_character_talent.configList) do
			if iter_6_1.talentId > var_0_2 then
				var_0_2 = iter_6_1.talentId
			end
		end
	end

	local var_6_6 = Mathf.Clamp(var_6_3, 1, var_0_1)
	local var_6_7 = Mathf.Clamp(var_6_4, 1, var_0_2)
	local var_6_8 = Mathf.Clamp(var_6_5, 1, EquipConfig.MaxLevel)

	return var_6_6, var_6_7, var_6_8
end

function var_0_0.getHeroBalanceLv(arg_7_0)
	local var_7_0 = var_0_0.getBalanceLv()

	if not var_7_0 then
		return 0
	end

	local var_7_1 = 0
	local var_7_2 = SkillConfig.instance:getherolevelsCO(arg_7_0)

	for iter_7_0 in pairs(var_7_2) do
		if var_7_1 < iter_7_0 then
			var_7_1 = iter_7_0
		end
	end

	return (math.min(var_7_1, var_7_0))
end

function var_0_0.getHeroBalanceInfo(arg_8_0)
	local var_8_0 = HeroModel.instance:getByHeroId(arg_8_0)

	if not var_8_0 then
		return
	end

	local var_8_1, var_8_2, var_8_3 = var_0_0.getBalanceLv()

	if not var_8_1 then
		return
	end

	local var_8_4 = 0
	local var_8_5 = SkillConfig.instance:getherolevelsCO(arg_8_0)

	for iter_8_0 in pairs(var_8_5) do
		if var_8_4 < iter_8_0 then
			var_8_4 = iter_8_0
		end
	end

	local var_8_6 = math.min(var_8_4, var_8_1)
	local var_8_7 = math.max(var_8_0.level, var_8_6)
	local var_8_8, var_8_9 = SkillConfig.instance:getHeroExSkillLevelByLevel(arg_8_0, var_8_7)
	local var_8_10 = 1

	for iter_8_1 = var_8_2, 1, -1 do
		local var_8_11 = lua_character_talent.configDict[arg_8_0][iter_8_1]

		if var_8_11 and var_8_9 >= var_8_11.requirement then
			var_8_10 = iter_8_1

			break
		end
	end

	local var_8_12 = var_8_0.talentCubeInfos

	if (var_8_10 > var_8_0.talent or var_8_0.rank < CharacterEnum.TalentRank) and var_8_9 >= CharacterEnum.TalentRank then
		local var_8_13 = {}
		local var_8_14 = lua_character_talent.configDict[arg_8_0][var_8_10]
		local var_8_15 = var_8_14.talentMould
		local var_8_16 = string.splitToNumber(var_8_14.exclusive, "#")[1]
		local var_8_17 = lua_talent_scheme.configDict[var_8_10][var_8_15][var_8_16].talenScheme
		local var_8_18 = GameUtil.splitString2(var_8_17, true, "#", ",")

		for iter_8_2, iter_8_3 in ipairs(var_8_18) do
			local var_8_19 = HeroDef_pb.TalentCubeInfo()

			var_8_19.cubeId = iter_8_3[1]
			var_8_19.direction = iter_8_3[2] or 0
			var_8_19.posX = iter_8_3[3] or 0
			var_8_19.posY = iter_8_3[4] or 0

			table.insert(var_8_13, var_8_19)
		end

		var_8_12 = HeroTalentCubeInfosMO.New()

		var_8_12:init(var_8_13)
		var_8_12:setOwnData(arg_8_0, var_8_10)
	end

	return var_8_7, var_8_9, var_8_10, var_8_12, var_8_3
end

return var_0_0
