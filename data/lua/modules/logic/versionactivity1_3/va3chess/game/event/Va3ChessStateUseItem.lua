module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateUseItem", package.seeall)

local var_0_0 = class("Va3ChessStateUseItem", Va3ChessStateBase)

function var_0_0.start(arg_1_0)
	logNormal("Va3ChessStateUseItem start")
	arg_1_0:startNotifyView()
end

function var_0_0.startNotifyView(arg_2_0)
	local var_2_0 = arg_2_0.originData.activityId
	local var_2_1 = arg_2_0.originData.interactId
	local var_2_2 = arg_2_0.originData.createId
	local var_2_3 = arg_2_0.originData.range

	if not var_2_3 or not var_2_1 then
		logError("Va3ChessStateUseItem range = " .. tostring(var_2_3) .. ", interactId = " .. tostring(var_2_1))

		return
	end

	local var_2_4 = Va3ChessGameController.instance.interacts

	if var_2_4 then
		local var_2_5 = var_2_4:get(var_2_1)

		if var_2_5 then
			local var_2_6 = var_2_5:tryGetGameObject()

			if not gohelper.isNil(var_2_6) then
				local var_2_7 = gohelper.findChild(var_2_6, "vx_daoju")

				gohelper.setActive(var_2_7, true)
			end

			if var_2_5.goToObject then
				var_2_5.goToObject:setMarkAttract(true)
			end
		end
	end

	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpBottle)
	TaskDispatcher.runDelay(arg_2_0.delayCallChoosePos, arg_2_0, 1)
end

function var_0_0.delayCallChoosePos(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.delayCallChoosePos, arg_3_0)

	local var_3_0 = arg_3_0.originData.activityId
	local var_3_1 = arg_3_0.originData.interactId
	local var_3_2 = arg_3_0.originData.createId
	local var_3_3 = arg_3_0.originData.range
	local var_3_4 = Va3ChessGameController.instance.interacts

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
		selfPosY = arg_4_2,
		selectType = Va3ChessEnum.ChessSelectType.UseItem
	}

	for iter_4_0 = arg_4_1 - arg_4_3, arg_4_1 + arg_4_3 do
		for iter_4_1 = arg_4_2 - arg_4_3, arg_4_2 + arg_4_3 do
			if arg_4_0:checkCanThrow(arg_4_1, arg_4_2, iter_4_0, iter_4_1) then
				table.insert(var_4_0.posXList, iter_4_0)
				table.insert(var_4_0.posYList, iter_4_1)
			end
		end
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetCenterHintText, {
		visible = true,
		text = luaLang("versionact_109_itemplace_hint")
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, var_4_0)
end

function var_0_0.checkCanThrow(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_1 ~= arg_5_3 or arg_5_2 ~= arg_5_4 then
		return Va3ChessGameController.instance:posCanWalk(arg_5_3, arg_5_4)
	end

	return false
end

function var_0_0.onClickPos(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_0._centerX then
		logNormal("Va3ChessStateUseItem no interact pos found !")

		return
	end

	local var_6_0 = arg_6_0.originData.range
	local var_6_1 = math.abs(arg_6_1 - arg_6_0._centerX)
	local var_6_2 = math.abs(arg_6_2 - arg_6_0._centerY)

	if arg_6_0:checkCanThrow(arg_6_0._centerX, arg_6_0._centerY, arg_6_1, arg_6_2) and var_6_1 <= var_6_0 and var_6_2 <= var_6_0 then
		local var_6_3 = arg_6_0.originData.activityId

		Va3ChessRpcController.instance:sendActUseItemRequest(var_6_3, arg_6_1, arg_6_2, arg_6_0.onReceiveReply, arg_6_0)
	end
end

function var_0_0.onReceiveReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 ~= 0 then
		return
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetCenterHintText, {
		visible = false
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay, arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.SetItem)
end

function var_0_0.hideAttractEffect(arg_8_0)
	local var_8_0 = arg_8_0.originData.interactId
	local var_8_1 = Va3ChessGameController.instance.interacts:get(var_8_0)

	if var_8_1 and var_8_1.goToObject then
		var_8_1.goToObject:setMarkAttract(false)
	end
end

function var_0_0.dispose(arg_9_0)
	arg_9_0:hideAttractEffect()
	TaskDispatcher.cancelTask(arg_9_0.delayCallChoosePos, arg_9_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetCenterHintText, {
		visible = false
	})
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
	var_0_0.super.dispose(arg_9_0)
end

return var_0_0
