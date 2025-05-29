module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkVer2SettleInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.harmHero = WeekwalkVer2SettleHeroInfoMO.New()

	arg_1_0.harmHero:init(arg_1_1.harmHero)

	arg_1_0.healHero = WeekwalkVer2SettleHeroInfoMO.New()

	arg_1_0.healHero:init(arg_1_1.healHero)

	arg_1_0.hurtHero = WeekwalkVer2SettleHeroInfoMO.New()

	arg_1_0.hurtHero:init(arg_1_1.hurtHero)

	arg_1_0.layerInfos = GameUtil.rpcInfosToMap(arg_1_1.layerInfos, WeekwalkVer2SettleLayerInfoMO, "layerId")
end

return var_0_0
