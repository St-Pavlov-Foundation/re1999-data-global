module("modules.logic.scene.room.comp.entitymgr.RoomBaseSceneUnitMgr", package.seeall)

local var_0_0 = class("RoomBaseSceneUnitMgr", BaseSceneUnitMgr)

function var_0_0.addUnit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getTag()
	local var_1_1 = arg_1_0._tagUnitDict[var_1_0]

	if not var_1_1 then
		var_1_1 = {}
		arg_1_0._tagUnitDict[var_1_0] = var_1_1
	end

	var_1_1[arg_1_1.id] = arg_1_1
end

return var_0_0
