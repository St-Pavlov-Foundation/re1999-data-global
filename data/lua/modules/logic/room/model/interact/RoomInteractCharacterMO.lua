module("modules.logic.room.model.interact.RoomInteractCharacterMO", package.seeall)

local var_0_0 = pureTable("RoomInteractCharacterMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.heroId
	arg_1_0.use = arg_1_1.use
	arg_1_0.heroMO = HeroModel.instance:getByHeroId(arg_1_0.id)
	arg_1_0.heroId = arg_1_0.heroMO.heroId
	arg_1_0.skinId = arg_1_0.heroMO.skin
	arg_1_0.heroConfig = HeroConfig.instance:getHeroCO(arg_1_0.heroId)
	arg_1_0.skinConfig = SkinConfig.instance:getSkinCo(arg_1_0.skinId)
end

return var_0_0
