module("modules.logic.seasonver.act123.model.Season123PickHeroEntryMO", package.seeall)

local var_0_0 = pureTable("Season123PickHeroEntryMO")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.heroMO = nil
	arg_1_0.isSupport = false
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.heroId = arg_2_2
	arg_2_0.heroUid = arg_2_1
	arg_2_0.heroMO = HeroModel.instance:getById(arg_2_0.heroUid)
end

function var_0_0.getIsEmpty(arg_3_0)
	return arg_3_0.heroUid == nil or arg_3_0.heroUid == 0
end

function var_0_0.updateByPickMO(arg_4_0, arg_4_1)
	arg_4_0.heroUid = arg_4_1.uid
	arg_4_0.heroId = arg_4_1.heroId
	arg_4_0.skinId = arg_4_1.skin
	arg_4_0.isSupport = false
	arg_4_0.heroMO = HeroModel.instance:getById(arg_4_0.heroUid)
end

function var_0_0.updateByPickAssistMO(arg_5_0, arg_5_1)
	arg_5_0.heroUid = arg_5_1.id
	arg_5_0.heroId = arg_5_1.heroMO.heroId
	arg_5_0.skinId = arg_5_1.heroMO.skin
	arg_5_0.isSupport = true
	arg_5_0.heroMO = arg_5_1.heroMO
end

function var_0_0.updateByHeroMO(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.heroId = arg_6_1.heroId
	arg_6_0.heroUid = arg_6_1.uid
	arg_6_0.skinId = arg_6_1.skin
	arg_6_0.heroMO = arg_6_1
	arg_6_0.isSupport = arg_6_2
end

function var_0_0.setEmpty(arg_7_0)
	arg_7_0.heroUid = nil
	arg_7_0.heroId = nil
	arg_7_0.heroMO = nil
	arg_7_0.skinId = nil
	arg_7_0.isSupport = false
end

return var_0_0
