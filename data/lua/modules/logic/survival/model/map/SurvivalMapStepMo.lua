module("modules.logic.survival.model.map.SurvivalMapStepMo", package.seeall)

local var_0_0 = pureTable("SurvivalMapStepMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.type = arg_1_1.type
	arg_1_0.position = SurvivalHexNode.New(arg_1_1.position.hex.q, arg_1_1.position.hex.r)
	arg_1_0.dir = arg_1_1.position.dir
	arg_1_0.paramInt = arg_1_1.paramInt
	arg_1_0.paramLong = arg_1_1.paramLong
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

	local var_1_0 = SurvivalMapModel.instance:getSceneMo()

	arg_1_0.extraBlock = {}

	if var_1_0 then
		for iter_1_2, iter_1_3 in ipairs(arg_1_1.cells) do
			local var_1_1 = SurvivalHexCellMo.New()

			var_1_1:init(iter_1_3, var_1_0.mapType)
			table.insert(arg_1_0.extraBlock, var_1_1)
		end
	end

	arg_1_0.items = GameUtil.rpcInfosToList(arg_1_1.items, SurvivalBagItemMo)
end

return var_0_0
