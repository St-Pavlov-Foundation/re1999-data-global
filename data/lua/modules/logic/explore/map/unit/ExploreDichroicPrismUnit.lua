module("modules.logic.explore.map.unit.ExploreDichroicPrismUnit", package.seeall)

local var_0_0 = class("ExploreDichroicPrismUnit", ExplorePrismUnit)

function var_0_0.addLights(arg_1_0)
	arg_1_0.lightComp:addLight(arg_1_0.mo.unitDir - 45)
	arg_1_0.lightComp:addLight(arg_1_0.mo.unitDir + 45)
end

return var_0_0
