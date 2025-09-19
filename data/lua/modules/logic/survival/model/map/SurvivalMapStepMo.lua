module("modules.logic.survival.model.map.SurvivalMapStepMo", package.seeall)

local var_0_0 = pureTable("SurvivalMapStepMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.type = arg_1_1.type
	arg_1_0.position = SurvivalHexNode.New(arg_1_1.position.hex.q, arg_1_1.position.hex.r)
	arg_1_0.dir = arg_1_1.position.dir
	arg_1_0.paramInt = arg_1_1.paramInt
	arg_1_0.panel = SurvivalPanelMo.New()

	arg_1_0.panel:init(arg_1_1.panel)

	arg_1_0.hex = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.hex) do
		arg_1_0.hex[iter_1_0] = SurvivalHexNode.New(iter_1_1.q, iter_1_1.r)
	end

	arg_1_0.unit = arg_1_1.unit
	arg_1_0.safeZone = arg_1_1.safeZone
	arg_1_0.hero = arg_1_1.hero
	arg_1_0.followTask = arg_1_1.followTask
end

return var_0_0
