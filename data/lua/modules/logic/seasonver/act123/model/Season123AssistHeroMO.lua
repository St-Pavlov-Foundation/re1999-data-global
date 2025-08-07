module("modules.logic.seasonver.act123.model.Season123AssistHeroMO", package.seeall)

local var_0_0 = pureTable("Season123AssistHeroMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.heroId = arg_1_1.heroId
	arg_1_0.heroUid = tostring(arg_1_1.heroUid)
	arg_1_0.userId = tostring(arg_1_1.userId)
	arg_1_0.name = arg_1_1.name
	arg_1_0.userLevel = arg_1_1.userLevel
	arg_1_0.portrait = arg_1_1.portrait
	arg_1_0.bg = arg_1_1.bg
	arg_1_0.isFriend = arg_1_1.isFriend
	arg_1_0.heroId = tonumber(arg_1_1.heroId)
	arg_1_0.level = tonumber(arg_1_1.level)
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.skin = arg_1_1.skin
	arg_1_0.passiveSkillLevel = arg_1_1.passiveSkillLevel
	arg_1_0.exSkillLevel = arg_1_1.exSkillLevel
	arg_1_0.balanceLevel = arg_1_1.balanceLevel
	arg_1_0.isOpenTalent = arg_1_1.isOpenTalent
	arg_1_0.talent = arg_1_1.talent
	arg_1_0.talentCubeInfos = HeroTalentCubeInfosMO.New()

	arg_1_0.talentCubeInfos:init(arg_1_1.talentCubeInfos)
	arg_1_0.talentCubeInfos:setOwnData(arg_1_0.heroId, arg_1_0.talent)

	arg_1_0.style = arg_1_1.style
	arg_1_0.destinyRank = arg_1_1.destinyRank
	arg_1_0.destinyLevel = arg_1_1.destinyLevel
	arg_1_0.destinyStone = arg_1_1.destinyStone
	arg_1_0.extraStr = arg_1_1.extraStr
end

return var_0_0
