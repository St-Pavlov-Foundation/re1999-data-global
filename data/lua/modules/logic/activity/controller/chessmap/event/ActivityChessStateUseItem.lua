module("modules.logic.activity.controller.chessmap.event.ActivityChessStateUseItem", package.seeall)

local var_0_0 = class("ActivityChessStateUseItem", ActivityChessStateBase)

function var_0_0.start(arg_1_0)
	logNormal("ActivityChessStateUseItem start")

	if ViewMgr.instance:isOpenFinish(ViewName.ActivityChessGame) then
		arg_1_0:startNotifyView()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0.onOpenViewFinish, arg_1_0)
	end
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
		logError("ActivityChessStateUseItem range = " .. tostring(var_3_3) .. ", interactId = " .. tostring(var_3_1))

		return
	end

	local var_3_4 = ActivityChessGameController.instance.interacts

	if var_3_4 then
		local var_3_5 = var_3_4:get(var_3_1)

		if var_3_5 then
			local var_3_6 = var_3_5:tryGetGameObject()

			if not gohelper.isNil(var_3_6) then
				local var_3_7 = gohelper.findChild(var_3_6, "vx_daoju")

				gohelper.setActive(var_3_7, true)
			end

			if var_3_5.goToObject then
				var_3_5.goToObject:setMarkAttract(true)
			end
		end
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)
	TaskDispatcher.runDelay(arg_3_0.delayCallChoosePos, arg_3_0, 1)
end

function var_0_0.delayCallChoosePos(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.delayCallChoosePos, arg_4_0)

	local var_4_0 = arg_4_0.originData.activityId
	local var_4_1 = arg_4_0.originData.interactId
	local var_4_2 = arg_4_0.originData.createId
	local var_4_3 = arg_4_0.originData.range
	local var_4_4 = ActivityChessGameController.instance.interacts

	if var_4_4 then
		local var_4_5 = var_4_4:get(var_4_1)

		if var_4_5 then
			local var_4_6 = var_4_5.originData.posX
			local var_4_7 = var_4_5.originData.posY

			arg_4_0._centerX, arg_4_0._centerY = var_4_6, var_4_7

			arg_4_0:packEventObjs(var_4_6, var_4_7, var_4_3)
		end
	end
end

function var_0_0.packEventObjs(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = arg_5_1,
		selfPosY = arg_5_2,
		selectType = ActivityChessEnum.ChessSelectType.UseItem
	}

	for iter_5_0 = arg_5_1 - arg_5_3, arg_5_1 + arg_5_3 do
		for iter_5_1 = arg_5_2 - arg_5_3, arg_5_2 + arg_5_3 do
			if arg_5_0:checkCanThrow(arg_5_1, arg_5_2, iter_5_0, iter_5_1) then
				table.insert(var_5_0.posXList, iter_5_0)
				table.insert(var_5_0.posYList, iter_5_1)
			end
		end
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetCenterHintText, {
		visible = true,
		text = luaLang("versionact_109_itemplace_hint")
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, var_5_0)
end

function var_0_0.checkCanThrow(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_1 ~= arg_6_3 or arg_6_2 ~= arg_6_4 then
		return ActivityChessGameController.instance:posCanWalk(arg_6_3, arg_6_4)
	end

	return false
end

function var_0_0.onClickPos(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0._centerX then
		logNormal("ActivityChessStateUseItem no interact pos found !")

		return
	end

	local var_7_0 = arg_7_0.originData.range
	local var_7_1 = math.abs(arg_7_1 - arg_7_0._centerX)
	local var_7_2 = math.abs(arg_7_2 - arg_7_0._centerY)

	if arg_7_0:checkCanThrow(arg_7_0._centerX, arg_7_0._centerY, arg_7_1, arg_7_2) and var_7_1 <= var_7_0 and var_7_2 <= var_7_0 then
		local var_7_3 = arg_7_0.originData.activityId

		Activity109Rpc.instance:sendAct109UseItemRequest(var_7_3, arg_7_1, arg_7_2, arg_7_0.onReceiveReply, arg_7_0)
	end
end

function var_0_0.onReceiveReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 ~= 0 then
		return
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetCenterHintText, {
		visible = false
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.EventFinishPlay, arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.SetItem)
end

function var_0_0.hideAttractEffect(arg_9_0)
	local var_9_0 = arg_9_0.originData.interactId
	local var_9_1 = ActivityChessGameController.instance.interacts:get(var_9_0)

	if var_9_1 and var_9_1.goToObject then
		var_9_1.goToObject:setMarkAttract(false)
	end
end

function var_0_0.dispose(arg_10_0)
	arg_10_0:hideAttractEffect()
	TaskDispatcher.cancelTask(arg_10_0.delayCallChoosePos, arg_10_0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetCenterHintText, {
		visible = false
	})
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_10_0.onOpenViewFinish, arg_10_0)
	var_0_0.super.dispose(arg_10_0)
end

return var_0_0
