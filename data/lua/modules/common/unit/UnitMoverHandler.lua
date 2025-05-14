module("modules.common.unit.UnitMoverHandler", package.seeall)

local var_0_0 = class("UnitMoverHandler", LuaCompBase)
local var_0_1 = {
	UnitMoverEase,
	UnitMoverParabola,
	UnitMoverBezier,
	UnitMoverCurve,
	UnitMoverMmo,
	UnitMoverBezier3
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._moverList = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_1) do
		local var_1_0 = MonoHelper.getLuaComFromGo(arg_1_0.go, iter_1_1)

		if var_1_0 then
			table.insert(arg_1_0._moverList, var_1_0)
		end
	end
end

function var_0_0.addEventListeners(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._moverList) do
		iter_2_1:registerCallback(UnitMoveEvent.PosChanged, arg_2_0._onPosChange, arg_2_0)
	end
end

function var_0_0.removeEventListeners(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._moverList) do
		iter_3_1:unregisterCallback(UnitMoveEvent.PosChanged, arg_3_0._onPosChange, arg_3_0)
	end
end

function var_0_0._onPosChange(arg_4_0, arg_4_1)
	local var_4_0 = CameraMgr.instance:getSceneTransform()
	local var_4_1, var_4_2, var_4_3 = transformhelper.getPos(var_4_0)
	local var_4_4, var_4_5, var_4_6 = arg_4_1:getPos()

	transformhelper.setPos(arg_4_0.go.transform, var_4_4 + var_4_1, var_4_5 + var_4_2, var_4_6 + var_4_3)
end

return var_0_0
