module("modules.logic.survival.util.SurvivalBalanceHelper", package.seeall)

local var_0_0 = class("SurvivalBalanceHelper")

var_0_0.BalanceColor = "#bfdaff"
var_0_0.BalanceIconColor = "#81abe5"

local var_0_1
local var_0_2

function var_0_0.getBalanceLv()
	local var_1_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_1_0 then
		return
	end

	local var_1_1 = var_1_0:getAttr(SurvivalEnum.AttrType.BalanceRoleLv)
	local var_1_2 = var_1_0:getAttr(SurvivalEnum.AttrType.BalanceResonanceLv)
	local var_1_3 = var_1_0:getAttr(SurvivalEnum.AttrType.BalanceEquipLv)

	if var_0_1 == nil then
		var_0_1 = #lua_character_cosume.configDict
	end

	if var_0_2 == nil then
		var_0_2 = 1

		for iter_1_0, iter_1_1 in pairs(lua_character_talent.configList) do
			if iter_1_1.talentId > var_0_2 then
				var_0_2 = iter_1_1.talentId
			end
		end
	end

	local var_1_4 = Mathf.Clamp(var_1_1, 1, var_0_1)
	local var_1_5 = Mathf.Clamp(var_1_2, 1, var_0_2)
	local var_1_6 = Mathf.Clamp(var_1_3, 1, EquipConfig.MaxLevel)

	return var_1_4, var_1_5, var_1_6
end

function var_0_0.getHeroBalanceLv(arg_2_0)
	local var_2_0 = var_0_0.getBalanceLv()

	if not var_2_0 then
		return 0
	end

	local var_2_1 = 0
	local var_2_2 = SkillConfig.instance:getherolevelsCO(arg_2_0)

	for iter_2_0 in pairs(var_2_2) do
		if var_2_1 < iter_2_0 then
			var_2_1 = iter_2_0
		end
	end

	return (math.min(var_2_1, var_2_0))
end

function var_0_0.getHeroBalanceInfo(arg_3_0, arg_3_1)
	local var_3_0 = SurvivalShelterModel.instance:getWeekInfo()

	arg_3_1 = arg_3_1 or HeroModel.instance:getByHeroId(arg_3_0)

	if not arg_3_1 and var_3_0.inSurvival then
		local var_3_1 = SurvivalMapModel.instance:getSceneMo().teamInfo

		if var_3_1.assistMO and var_3_1.assistMO.heroId == arg_3_0 then
			arg_3_1 = var_3_1.assistMO.heroMO
		end
	end

	if not arg_3_1 then
		return
	end

	local var_3_2, var_3_3, var_3_4 = var_0_0.getBalanceLv()

	if not var_3_2 then
		return
	end

	local var_3_5 = 0
	local var_3_6 = SkillConfig.instance:getherolevelsCO(arg_3_0)

	for iter_3_0 in pairs(var_3_6) do
		if var_3_5 < iter_3_0 then
			var_3_5 = iter_3_0
		end
	end

	local var_3_7 = math.min(var_3_5, var_3_2)
	local var_3_8 = math.max(arg_3_1.level, var_3_7)
	local var_3_9, var_3_10 = SkillConfig.instance:getHeroExSkillLevelByLevel(arg_3_0, var_3_8)
	local var_3_11 = 1

	for iter_3_1 = var_3_3, 1, -1 do
		local var_3_12 = lua_character_talent.configDict[arg_3_0][iter_3_1]

		if var_3_12 and var_3_10 >= var_3_12.requirement then
			var_3_11 = iter_3_1

			break
		end
	end

	local var_3_13 = arg_3_1.talentCubeInfos

	if (var_3_11 > arg_3_1.talent or arg_3_1.rank < CharacterEnum.TalentRank) and var_3_10 >= CharacterEnum.TalentRank then
		local var_3_14 = {}
		local var_3_15 = lua_character_talent.configDict[arg_3_0][var_3_11]
		local var_3_16 = var_3_15.talentMould
		local var_3_17 = string.splitToNumber(var_3_15.exclusive, "#")[1]
		local var_3_18 = lua_talent_scheme.configDict[var_3_11][var_3_16][var_3_17].talenScheme
		local var_3_19 = GameUtil.splitString2(var_3_18, true, "#", ",")

		for iter_3_2, iter_3_3 in ipairs(var_3_19) do
			local var_3_20 = HeroDef_pb.TalentCubeInfo()

			var_3_20.cubeId = iter_3_3[1]
			var_3_20.direction = iter_3_3[2] or 0
			var_3_20.posX = iter_3_3[3] or 0
			var_3_20.posY = iter_3_3[4] or 0

			table.insert(var_3_14, var_3_20)
		end

		var_3_13 = HeroTalentCubeInfosMO.New()

		var_3_13:init(var_3_14)
		var_3_13:setOwnData(arg_3_0, var_3_11)
	end

	return var_3_8, var_3_10, var_3_11, var_3_13, var_3_4
end

return var_0_0
