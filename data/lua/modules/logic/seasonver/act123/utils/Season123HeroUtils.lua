module("modules.logic.seasonver.act123.utils.Season123HeroUtils", package.seeall)

local var_0_0 = class("Season123HeroUtils")

function var_0_0.createHeroMOByAssistMO(arg_1_0, arg_1_1)
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

	var_1_10.destinyStoneMo = HeroDestinyStoneMO.New(arg_1_0.heroId)

	var_1_10.destinyStoneMo:refreshMo(arg_1_0.destinyRank, arg_1_0.destinyLevel, arg_1_0.destinyStone, arg_1_0.destinyStoneUnlock)

	return var_1_10
end

function var_0_0.createSeasonPickAssistMO(arg_2_0)
	if not arg_2_0 then
		return
	end

	local var_2_0 = arg_2_0:getHeroInfo()
	local var_2_1 = Season123PickAssistMO.New()

	var_2_1:init(var_2_0)

	return var_2_1
end

function var_0_0.getHeroMO(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = HeroModel.instance:getById(arg_3_1)

	if not var_3_0 and arg_3_2 ~= nil then
		local var_3_1, var_3_2 = Season123Model.instance:getAssistData(arg_3_0, arg_3_2)

		if var_3_2 and var_3_2.heroUid == arg_3_1 then
			return var_3_1
		end
	else
		return var_3_0
	end
end

return var_0_0
