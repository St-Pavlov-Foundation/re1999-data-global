module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateUseItem", package.seeall)

local var_0_0 = class("YaXianStateUseItem", YaXianStateBase)

function var_0_0.start(arg_1_0)
	logError("Ya Xian use Item, not realize")
end

function var_0_0.onOpenViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.ActivityChessGame then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_2_0.onOpenViewFinish, arg_2_0)
		arg_2_0:startNotifyView()
	end
end

function var_0_0.startNotifyView(arg_3_0)
	local var_3_0 = arg_3_0.originData.activityId
	local var_3_1 = arg_3_0.originData.interactId
	local var_3_2 = arg_3_0.originData.createId
	local var_3_3 = arg_3_0.originData.range

	if not var_3_3 or not var_3_1 then
		logError("YaXianStateUseItem range = " .. tostring(var_3_3) .. ", interactId = " .. tostring(var_3_1))

		return
	end

	local var_3_4 = ActivityChessGameController.instance.interacts

	if var_3_4 then
		local var_3_5 = var_3_4:get(var_3_1)

		if var_3_5 then
			local var_3_6 = var_3_5.originData.posX
			local var_3_7 = var_3_5.originData.posY

			arg_3_0._centerX, arg_3_0._centerY = var_3_6, var_3_7

			arg_3_0:packEventObjs(var_3_6, var_3_7, var_3_3)
		end
	end
end

function var_0_0.packEventObjs(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = arg_4_1,
		selfPosY = arg_4_2
	}

	for iter_4_0 = arg_4_1 - arg_4_3, arg_4_1 + arg_4_3 do
		for iter_4_1 = arg_4_2 - arg_4_3, arg_4_2 + arg_4_3 do
			if arg_4_0:checkCanThrow(arg_4_1, arg_4_2, iter_4_0, iter_4_1) then
				table.insert(var_4_0.posXList, iter_4_0)
				table.insert(var_4_0.posYList, iter_4_1)
			end
		end
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, var_4_0)
end

function var_0_0.checkCanThrow(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_1 ~= arg_5_3 or arg_5_2 ~= arg_5_4 then
		return ActivityChessGameController.instance:posCanWalk(arg_5_3, arg_5_4)
	end

	return false
end

function var_0_0.onClickPos(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._centerX then
		logError("YaXianStateUseItem no interact pos found !")

		return
	end

	local var_6_0 = arg_6_0.originData.range
	local var_6_1 = math.abs(arg_6_1 - arg_6_0._centerX)
	local var_6_2 = math.abs(arg_6_2 - arg_6_0._centerY)

	if arg_6_0:checkCanThrow(arg_6_0._centerX, arg_6_0._centerY, arg_6_1, arg_6_2) and var_6_1 <= var_6_0 and var_6_2 <= var_6_0 then
		local var_6_3 = arg_6_0.originData.activityId

		Activity109Rpc.instance:sendAct109UseItemRequest(var_6_3, arg_6_1, arg_6_2, arg_6_0.onReceiveReply, arg_6_0)
	end
end

function var_0_0.onReceiveReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 ~= 0 then
		return
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.EventFinishPlay, arg_7_0)
end

function var_0_0.dispose(arg_8_0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_8_0.onOpenViewFinish, arg_8_0)
	var_0_0.super.dispose(arg_8_0)
end

return var_0_0
