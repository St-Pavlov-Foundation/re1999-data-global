module("modules.logic.explore.map.unit.ExplorePipePotUnit", package.seeall)

local var_0_0 = class("ExplorePipePotUnit", ExploreBaseMoveUnit)

function var_0_0.setPosByNode(arg_1_0, ...)
	if not ExploreHeroResetFlow.instance:isReseting() and ExploreHeroCatchUnitFlow.instance:isInFlow(arg_1_0) then
		return
	end

	var_0_0.super.setPosByNode(arg_1_0, ...)
end

function var_0_0.setPosByFlow(arg_2_0)
	var_0_0.super.setPosByNode(arg_2_0, arg_2_0.nodePos)
end

function var_0_0.onStatus2Change(arg_3_0, arg_3_1, arg_3_2)
	if not ExploreHeroResetFlow.instance:isReseting() then
		return
	end

	local var_3_0 = ExploreController.instance:getMap()
	local var_3_1 = arg_3_2.bindInteractId or 0

	if var_3_1 > 0 then
		local var_3_2 = var_3_0:getUnit(var_3_1)

		arg_3_0:setParent(var_3_2.trans, ExploreEnum.ExplorePipePotHangType.Put)
	else
		arg_3_0:setParent(var_3_0:getUnitRoot().transform, ExploreEnum.ExplorePipePotHangType.UnCarry)
	end
end

function var_0_0.setParent(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.trans:SetParent(arg_4_1, false)

	if arg_4_2 == ExploreEnum.ExplorePipePotHangType.Carry then
		local var_4_0 = ExploreController.instance:getMap():getHero().dir

		arg_4_0._carryDir = var_4_0

		transformhelper.setLocalPos(arg_4_0.trans, 0, 0, 0)
		transformhelper.setLocalRotation(arg_4_0.trans, var_4_0 - 90 - arg_4_0.mo.unitDir, 0, 90)
		arg_4_0.clickComp:setEnable(false)
	elseif arg_4_2 == ExploreEnum.ExplorePipePotHangType.UnCarry then
		local var_4_1 = ExploreController.instance:getMap():getHero().dir - (arg_4_0._carryDir or 0)

		arg_4_0.mo.unitDir = var_4_1 + arg_4_0.mo.unitDir

		transformhelper.setLocalRotation(arg_4_0.trans, 0, arg_4_0.mo.unitDir, 0)
		arg_4_0:setPosByFlow()
		arg_4_0.clickComp:setEnable(true)
		ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitNodeChange, arg_4_0, arg_4_0.nodePos, arg_4_0.nodePos)
	elseif arg_4_2 == ExploreEnum.ExplorePipePotHangType.Pick then
		transformhelper.setLocalPos(arg_4_0.trans, 0, 0, 0)
		transformhelper.setLocalRotation(arg_4_0.trans, 0, arg_4_0.mo.unitDir, 0)
		arg_4_0.clickComp:setEnable(false)
	elseif arg_4_2 == ExploreEnum.ExplorePipePotHangType.Put then
		transformhelper.setLocalPos(arg_4_0.trans, 0, 0.65, 0)
		transformhelper.setLocalRotation(arg_4_0.trans, 180, 360 - arg_4_0.mo.unitDir, 0)
		arg_4_0.clickComp:setEnable(false)
	end
end

return var_0_0
