module("modules.logic.guide.controller.action.impl.GuideActionRoomFocusBlock", package.seeall)

local var_0_0 = class("GuideActionRoomFocusBlock", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.actionParam and string.splitToNumber(arg_1_0.actionParam, "#")

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		local var_1_1 = GuideModel.instance:getStepGOPath(arg_1_0.guideId, arg_1_0.stepId)
		local var_1_2 = gohelper.find(var_1_1)
		local var_1_3 = var_1_2 and MonoHelper.getLuaComFromGo(var_1_2, RoomMapBlockEntity)

		var_1_3 = var_1_3 or var_1_2 and MonoHelper.getLuaComFromGo(var_1_2, RoomEmptyBlockEntity)
		var_1_3 = var_1_3 or var_1_2 and MonoHelper.getLuaComFromGo(var_1_2, RoomBuildingEntity)

		local var_1_4 = var_1_3 and var_1_3:getMO()

		if var_1_4 then
			local var_1_5 = HexMath.hexToPosition(var_1_4.hexPoint, RoomBlockEnum.BlockSize)
			local var_1_6 = {
				focusX = var_1_5.x + (var_1_0 and var_1_0[1] or 0),
				focusY = var_1_5.y + (var_1_0 and var_1_0[2] or 0)
			}

			GameSceneMgr.instance:getCurScene().camera:tweenCamera(var_1_6)
			TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, 0.7)
		else
			arg_1_0:onDone(true)
		end
	else
		logError("不在小屋场景，指引失败 " .. arg_1_0.guideId .. "_" .. arg_1_0.stepId)
		arg_1_0:onDone(true)
	end
end

function var_0_0._onDone(arg_2_0, arg_2_1)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._onDone, arg_3_0)
end

return var_0_0
