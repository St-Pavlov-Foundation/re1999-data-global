﻿module("modules.logic.room.view.layout.RoomLayoutFindShareViewContainer", package.seeall)

local var_0_0 = class("RoomLayoutFindShareViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomLayoutFindShareView.New())

	return var_1_0
end

return var_0_0
