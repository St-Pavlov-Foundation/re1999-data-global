module("modules.logic.pickassist.model.PickAssistHeroMO", package.seeall)

local var_0_0 = pureTable("PickAssistHeroMO")

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = HeroConfig.instance:getHeroCO(arg_1_0.heroId)
	local var_1_1 = HeroDef_pb.HeroInfo()

	var_1_1.uid = arg_1_0.heroUid

	local var_1_2 = arg_1_0.level
	local var_1_3 = arg_1_0.rank
	local var_1_4 = arg_1_0.balanceLevel
	local var_1_5 = false

	if arg_1_1 and var_1_4 ~= var_1_2 then
		var_1_2 = var_1_4

		local var_1_6, var_1_7 = HeroConfig.instance:getShowLevel(var_1_4)

		var_1_3 = var_1_7
		var_1_5 = true
	end

	var_1_1.level = var_1_2
	var_1_1.heroId = arg_1_0.heroId
	var_1_1.skin = arg_1_0.skin
	var_1_1.defaultEquipUid = "0"
	var_1_1.rank = var_1_3
	var_1_1.talent = arg_1_0.talent
	var_1_1.exSkillLevel = arg_1_0.exSkillLevel

	if arg_1_0.passiveSkillLevel then
		for iter_1_0 = 1, #arg_1_0.passiveSkillLevel do
			table.insert(var_1_1.passiveSkillLevel, arg_1_0.passiveSkillLevel[iter_1_0])
		end
	else
		local var_1_8 = SkillConfig.instance:getHeroExSkillLevelByLevel(arg_1_0.heroId, var_1_2)

		for iter_1_1 = 1, var_1_8 do
			table.insert(var_1_1.passiveSkillLevel, iter_1_1)
		end
	end

	local var_1_9 = SkillConfig.instance:getBaseAttr(arg_1_0.heroId, var_1_2)

	var_1_1.baseAttr.attack = var_1_9.atk
	var_1_1.baseAttr.defense = var_1_9.def
	var_1_1.baseAttr.hp = var_1_9.hp
	var_1_1.baseAttr.mdefense = var_1_9.mdef
	var_1_1.baseAttr.technic = var_1_9.technic
	var_1_1.exAttr.addDmg = var_1_9.add_dmg
	var_1_1.exAttr.cri = var_1_9.cri
	var_1_1.exAttr.criDef = var_1_9.cri_def
	var_1_1.exAttr.dropDmg = var_1_9.drop_dmg
	var_1_1.exAttr.recri = var_1_9.recri
	var_1_1.exAttr.criDmg = var_1_9.cri_dmg

	local var_1_10 = HeroMo.New()

	var_1_10:init(var_1_1, var_1_0)

	var_1_10.talentCubeInfos = arg_1_0.talentCubeInfos

	var_1_10:setIsBelongOtherPlayer(true)
	var_1_10:setIsBalance(var_1_5)
	var_1_10:setOtherPlayerIsOpenTalent(arg_1_0.isOpenTalent)
	var_1_10:setOtherPlayerTalentStyle(arg_1_0.style)

	var_1_10.destinyRank = arg_1_0.destinyRank
	var_1_10.destinyLevel = arg_1_0.destinyLevel
	var_1_10.destinyStone = arg_1_0.destinyStone
	var_1_10.destinyStoneMo = var_1_10.destinyStoneMo or HeroDestinyStoneMO.New(var_1_1.heroId)

	var_1_10.destinyStoneMo:refreshMo(arg_1_0.destinyRank, arg_1_0.destinyLevel, arg_1_0.destinyStone, arg_1_0.destinyStoneUnlock)

	return var_1_10
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.heroUid

	arg_2_0:setHeroInfo(arg_2_1)

	arg_2_0.heroMO = var_0_1(arg_2_0, true)
end

function var_0_0.setHeroInfo(arg_3_0, arg_3_1)
	arg_3_0.heroId = arg_3_1.heroId
	arg_3_0.heroUid = tostring(arg_3_1.heroUid)
	arg_3_0.userId = tostring(arg_3_1.userId)
	arg_3_0.name = arg_3_1.name
	arg_3_0.userLevel = arg_3_1.userLevel
	arg_3_0.portrait = arg_3_1.portrait
	arg_3_0.bg = arg_3_1.bg
	arg_3_0.isFriend = arg_3_1.isFriend
	arg_3_0.heroId = tonumber(arg_3_1.heroId)
	arg_3_0.level = tonumber(arg_3_1.level)
	arg_3_0.rank = arg_3_1.rank
	arg_3_0.skin = arg_3_1.skin
	arg_3_0.passiveSkillLevel = arg_3_1.passiveSkillLevel
	arg_3_0.exSkillLevel = arg_3_1.exSkillLevel
	arg_3_0.balanceLevel = arg_3_1.balanceLevel
	arg_3_0.isOpenTalent = arg_3_1.isOpenTalent
	arg_3_0.talent = arg_3_1.talent
	arg_3_0.talentCubeInfos = HeroTalentCubeInfosMO.New()

	arg_3_0.talentCubeInfos:init(arg_3_1.talentCubeInfos)
	arg_3_0.talentCubeInfos:setOwnData(arg_3_0.heroId, arg_3_0.talent)

	arg_3_0.destinyRank = arg_3_1.destinyRank
	arg_3_0.destinyLevel = arg_3_1.destinyLevel
	arg_3_0.destinyStone = arg_3_1.destinyStone
	arg_3_0.style = arg_3_1.style
end

function var_0_0.getId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.isSameHero(arg_5_0, arg_5_1)
	local var_5_0 = false

	if arg_5_1 then
		var_5_0 = arg_5_0:getId() == arg_5_1:getId()
	end

	return var_5_0
end

function var_0_0.getPlayerInfo(arg_6_0)
	return {
		userId = arg_6_0.userId,
		name = arg_6_0.name,
		level = arg_6_0.userLevel,
		portrait = arg_6_0.portrait,
		bg = arg_6_0.bg
	}
end

function var_0_0.getCareer(arg_7_0)
	local var_7_0

	if arg_7_0.heroMO and arg_7_0.heroMO.config then
		var_7_0 = arg_7_0.heroMO.config.career
	end

	return var_7_0
end

return var_0_0
