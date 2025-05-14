module("modules.logic.dungeon.model.DungeonAssistHeroMO", package.seeall)

local var_0_0 = pureTable("DungeonAssistHeroMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_1 or not arg_1_2 then
		return false
	end

	arg_1_0.assistType = arg_1_1
	arg_1_0.heroUid = arg_1_2.heroUid
	arg_1_0.userId = arg_1_2.userId
	arg_1_0.name = arg_1_2.name
	arg_1_0.userLevel = arg_1_2.userLevel
	arg_1_0.portrait = arg_1_2.portrait
	arg_1_0.bg = arg_1_2.bg
	arg_1_0.isFriend = arg_1_2.isFriend
	arg_1_0.heroId = arg_1_2.heroId
	arg_1_0.level = arg_1_2.level
	arg_1_0.rank = arg_1_2.rank
	arg_1_0.skin = arg_1_2.skin
	arg_1_0.passiveSkillLevel = arg_1_2.passiveSkillLevel
	arg_1_0.exSkillLevel = arg_1_2.exSkillLevel
	arg_1_0.talent = arg_1_2.talent
	arg_1_0.balanceLevel = arg_1_2.balanceLevel
	arg_1_0.isOpenTalent = arg_1_2.isOpenTalent
	arg_1_0.style = arg_1_2.style
	arg_1_0.originalTalentCubeInfos = nil

	if arg_1_2.talentCubeInfos then
		arg_1_0.talentCubeInfos = HeroTalentCubeInfosMO.New()

		arg_1_0.talentCubeInfos:init(arg_1_2.talentCubeInfos)
		arg_1_0.talentCubeInfos:setOwnData(arg_1_0.heroId, arg_1_0.talent)

		arg_1_0.originalTalentCubeInfos = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_2.talentCubeInfos) do
			arg_1_0.originalTalentCubeInfos[iter_1_0] = {}
			arg_1_0.originalTalentCubeInfos[iter_1_0].cubeId = iter_1_1.cubeId
			arg_1_0.originalTalentCubeInfos[iter_1_0].direction = iter_1_1.direction
			arg_1_0.originalTalentCubeInfos[iter_1_0].posX = iter_1_1.posX
			arg_1_0.originalTalentCubeInfos[iter_1_0].posY = iter_1_1.posY
		end
	end

	arg_1_0.destinyRank = arg_1_2.destinyRank
	arg_1_0.destinyLevel = arg_1_2.destinyLevel
	arg_1_0.destinyStone = arg_1_2.destinyStone

	return true
end

function var_0_0.getHeroInfo(arg_2_0)
	return {
		heroUid = arg_2_0:getHeroUid(),
		userId = arg_2_0:getUserId(),
		name = arg_2_0:getName(),
		userLevel = arg_2_0:getUserLevel(),
		portrait = arg_2_0:getPortrait(),
		bg = arg_2_0:getBg(),
		isFriend = arg_2_0:getIsFriend(),
		heroId = arg_2_0:getHeroId(),
		level = arg_2_0:getLevel(),
		rank = arg_2_0:getRank(),
		skin = arg_2_0:getSkin(),
		passiveSkillLevel = arg_2_0:getPassiveSkillLevel(),
		exSkillLevel = arg_2_0:getExSkillLevel(),
		talent = arg_2_0:getTalent(),
		talentCubeInfos = arg_2_0:getOriginalTalentCubeInfos(),
		balanceLevel = arg_2_0:getBalanceLevel(),
		isOpenTalent = arg_2_0:getIsOpenTalent(),
		style = arg_2_0:getTalentStyle(),
		destinyRank = arg_2_0:getDestinyRank(),
		destinyLevel = arg_2_0:getDestinyLevel(),
		destinyStone = arg_2_0:getDestinyStone()
	}
end

function var_0_0.getHeroUid(arg_3_0)
	return arg_3_0.heroUid
end

function var_0_0.getUserId(arg_4_0)
	return arg_4_0.userId
end

function var_0_0.getName(arg_5_0)
	return arg_5_0.name
end

function var_0_0.getUserLevel(arg_6_0)
	return arg_6_0.userLevel or 0
end

function var_0_0.getPortrait(arg_7_0)
	return arg_7_0.portrait
end

function var_0_0.getBg(arg_8_0)
	return arg_8_0.bg
end

function var_0_0.getIsFriend(arg_9_0)
	return arg_9_0.isFriend
end

function var_0_0.getHeroId(arg_10_0)
	return arg_10_0.heroId
end

function var_0_0.getLevel(arg_11_0)
	return arg_11_0.level or 0
end

function var_0_0.getRank(arg_12_0)
	return arg_12_0.rank
end

function var_0_0.getSkin(arg_13_0)
	return arg_13_0.skin
end

function var_0_0.getPassiveSkillLevel(arg_14_0)
	return arg_14_0.passiveSkillLevel
end

function var_0_0.getExSkillLevel(arg_15_0)
	return arg_15_0.exSkillLevel
end

function var_0_0.getTalent(arg_16_0)
	return arg_16_0.talent
end

function var_0_0.getOriginalTalentCubeInfos(arg_17_0)
	return arg_17_0.originalTalentCubeInfos
end

function var_0_0.getTalentCubeInfos(arg_18_0)
	return arg_18_0.talentCubeInfos
end

function var_0_0.getBalanceLevel(arg_19_0)
	return arg_19_0.balanceLevel or 0
end

function var_0_0.getIsOpenTalent(arg_20_0)
	return arg_20_0.isOpenTalent
end

function var_0_0.getTalentStyle(arg_21_0)
	return arg_21_0.style
end

function var_0_0.getDestinyRank(arg_22_0)
	return arg_22_0.destinyRank
end

function var_0_0.getDestinyLevel(arg_23_0)
	return arg_23_0.destinyLevel
end

function var_0_0.getDestinyStone(arg_24_0)
	return arg_24_0.destinyStone
end

return var_0_0
