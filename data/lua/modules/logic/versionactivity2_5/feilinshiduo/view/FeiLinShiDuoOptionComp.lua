module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoOptionComp", package.seeall)

local var_0_0 = class("FeiLinShiDuoOptionComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_0.go.transform
end

function var_0_0.initData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.itemInfo = arg_2_1
	arg_2_0.sceneViewCls = arg_2_2
	arg_2_0.playerGO = arg_2_2:getPlayerGO()
	arg_2_0.playerTrans = arg_2_0.playerGO.transform
	arg_2_0.refId = arg_2_0.itemInfo.refId
	arg_2_0.doorItemInfo = nil
	arg_2_0.curOpenState = false
end

function var_0_0.addEventListeners(arg_3_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, arg_3_0.resetData, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, arg_4_0.resetData, arg_4_0)
end

function var_0_0.resetData(arg_5_0)
	arg_5_0.curOpenState = false
end

function var_0_0.onTick(arg_6_0)
	arg_6_0:initDoorItem()
	arg_6_0:handleEvent()
end

function var_0_0.initDoorItem(arg_7_0)
	if not arg_7_0.doorItemInfo then
		local var_7_0 = FeiLinShiDuoGameModel.instance:getElementMap()
		local var_7_1 = var_7_0[FeiLinShiDuoEnum.ObjectType.Door] or {}

		for iter_7_0, iter_7_1 in pairs(var_7_1) do
			if iter_7_1.refId == arg_7_0.refId then
				arg_7_0.doorItemInfo = iter_7_1

				break
			end
		end

		if not arg_7_0.doorItemInfo then
			return
		end

		local var_7_2 = arg_7_0.sceneViewCls:getElementGOMap()

		arg_7_0.doorGO = var_7_2[arg_7_0.doorItemInfo.id].subGOList[1]
		arg_7_0.boxElementMap = var_7_0[FeiLinShiDuoEnum.ObjectType.Box]
		arg_7_0.doorAnim = arg_7_0.doorGO:GetComponent(gohelper.Type_Animator)
		arg_7_0.curOpenState = false
		arg_7_0.optionGO = var_7_2[arg_7_0.itemInfo.id].subGOList[1]
		arg_7_0.optionAnim = arg_7_0.optionGO:GetComponent(gohelper.Type_Animator)
	end
end

function var_0_0.handleEvent(arg_8_0)
	if not arg_8_0.sceneViewCls or not arg_8_0.doorItemInfo then
		return
	end

	arg_8_0:checkTouchBoxOrPlayer()
end

function var_0_0.checkTouchBoxOrPlayer(arg_9_0)
	local var_9_0 = false
	local var_9_1 = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(arg_9_0.trans.localPosition.x, arg_9_0.trans.localPosition.y - 1, arg_9_0.itemInfo, FeiLinShiDuoEnum.checkDir.Top, arg_9_0.boxElementMap)
	local var_9_2 = arg_9_0.playerTrans.localPosition.x > arg_9_0.itemInfo.pos[1] and arg_9_0.playerTrans.localPosition.x < arg_9_0.itemInfo.pos[1] + arg_9_0.itemInfo.width and arg_9_0.playerTrans.localPosition.y > arg_9_0.itemInfo.pos[2] - 1 and arg_9_0.playerTrans.localPosition.y < arg_9_0.itemInfo.pos[2] + arg_9_0.itemInfo.height

	if var_9_1 and #var_9_1 > 0 or var_9_2 then
		var_9_0 = true
	end

	arg_9_0:setOpenState(var_9_0)
end

function var_0_0.setOpenState(arg_10_0, arg_10_1)
	if arg_10_0.curOpenState ~= arg_10_1 then
		arg_10_0.curOpenState = arg_10_1

		arg_10_0.optionAnim:Play(arg_10_1 and "in" or "out")
		arg_10_0.doorAnim:Play(arg_10_1 and "out" or "in")

		if arg_10_1 then
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_door_open)
		else
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_door_close)
		end

		FeiLinShiDuoGameModel.instance:setDoorOpenState(arg_10_0.doorItemInfo.id, arg_10_0.curOpenState)
	end
end

return var_0_0
