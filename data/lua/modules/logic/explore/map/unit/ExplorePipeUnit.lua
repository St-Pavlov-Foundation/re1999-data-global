module("modules.logic.explore.map.unit.ExplorePipeUnit", package.seeall)

local var_0_0 = class("ExplorePipeUnit", ExploreBaseDisplayUnit)

function var_0_0.initComponents(arg_1_0)
	var_0_0.super.initComponents(arg_1_0)
	arg_1_0:addComp("pipeComp", ExplorePipeComp)
end

function var_0_0.setupMO(arg_2_0)
	var_0_0.super.setupMO(arg_2_0)
	arg_2_0.pipeComp:initData()
end

function var_0_0.onRotateFinish(arg_3_0)
	ExploreController.instance:getMapPipe():initColors()
end

return var_0_0
