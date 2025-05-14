module("modules.logic.scene.room.comp.RoomSceneLevelComp", package.seeall)

local var_0_0 = class("RoomSceneLevelComp", CommonSceneLevelComp)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:loadLevel(arg_1_2)
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._sceneId = arg_2_1
	arg_2_0._levelId = arg_2_2
end

return var_0_0
