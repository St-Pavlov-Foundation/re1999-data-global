module("modules.logic.explore.map.unit.ExplorePipeEntranceUnit", package.seeall)

local var_0_0 = class("ExplorePipeEntranceUnit", ExploreBaseDisplayUnit)

function var_0_0.initComponents(arg_1_0)
	var_0_0.super.initComponents(arg_1_0)
	arg_1_0:addComp("pipeComp", ExplorePipeComp)
end

function var_0_0.setupMO(arg_2_0)
	var_0_0.super.setupMO(arg_2_0)
	arg_2_0.pipeComp:initData()
end

function var_0_0.onMapInit(arg_3_0)
	var_0_0.super.onMapInit(arg_3_0)

	local var_3_0 = arg_3_0.mo:getBindPotId()
	local var_3_1 = ExploreController.instance:getMap():getUnit(var_3_0, true)

	if var_3_1 then
		var_3_1:setParent(arg_3_0.trans, ExploreEnum.ExplorePipePotHangType.Put)
	end
end

function var_0_0.tryTrigger(arg_4_0)
	local var_4_0 = tonumber(ExploreModel.instance:getUseItemUid())
	local var_4_1 = ExploreController.instance:getMap():getUnit(var_4_0, true)
	local var_4_2 = arg_4_0.mo:getBindPotId()

	if var_4_1 and var_4_1:getUnitType() == ExploreEnum.ItemType.PipePot and var_4_2 == 0 or var_4_2 > 0 and not var_4_1 then
		var_0_0.super.tryTrigger(arg_4_0)
	end
end

function var_0_0.onStatus2Change(arg_5_0, arg_5_1, arg_5_2)
	if ExploreHeroResetFlow.instance:isReseting() then
		return
	end

	local var_5_0 = arg_5_1.bindInteractId or 0
	local var_5_1 = arg_5_2.bindInteractId or 0

	if var_5_0 ~= var_5_1 then
		if var_5_0 == 0 then
			ExploreModel.instance:setStepPause(true)

			local var_5_2 = ExploreController.instance:getMap()
			local var_5_3 = var_5_2:getUnit(var_5_1)

			ExploreHeroCatchUnitFlow.instance:uncatchUnitFrom(var_5_3, arg_5_0, arg_5_0.onFlowEnd)
			ExploreModel.instance:setUseItemUid("0", true)
			var_5_2:getCatchComp():setCatchUnit(nil)
		elseif var_5_1 == 0 then
			ExploreModel.instance:setStepPause(true)

			local var_5_4 = ExploreController.instance:getMap()
			local var_5_5 = ExploreController.instance:getMap():getUnit(var_5_0)

			ExploreHeroCatchUnitFlow.instance:catchUnitFrom(var_5_5, arg_5_0, arg_5_0.onFlowEnd)
			ExploreModel.instance:setUseItemUid(tostring(var_5_0), true)
			var_5_4:getCatchComp():setCatchUnit(var_5_5)
		else
			logError("???")
		end
	end
end

function var_0_0.onFlowEnd(arg_6_0)
	ExploreModel.instance:setStepPause(false)
	ExploreController.instance:getMapPipe():initColors()
end

return var_0_0
