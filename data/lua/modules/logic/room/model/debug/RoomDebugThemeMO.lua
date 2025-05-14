module("modules.logic.room.model.debug.RoomDebugThemeMO", package.seeall)

local var_0_0 = pureTable("RoomDebugThemeMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.config = arg_1_2 or RoomConfig.instance:getThemeConfig(arg_1_1)
end

return var_0_0
