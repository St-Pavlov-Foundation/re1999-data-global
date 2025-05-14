module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoBoxComp", package.seeall)

local var_0_0 = class("FeiLinShiDuoBoxComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.boxTrans = arg_1_0.go.transform
	arg_1_0.moveSpeed = FeiLinShiDuoEnum.PlayerMoveSpeed
	arg_1_0.fallAddSpeed = FeiLinShiDuoEnum.FallSpeed

	arg_1_0:resetData()
end

function var_0_0.resetData(arg_2_0)
	arg_2_0.isGround = true
	arg_2_0.fallYSpeed = 0
	arg_2_0.deltaMoveX = 0
	arg_2_0.curInPlaneItem = nil
	arg_2_0.planeStartPosX = 0
	arg_2_0.planeEndPosX = 0
	arg_2_0.isTopBox = false
	arg_2_0.topBoxOffset = -10000
	arg_2_0.topBoxDeltaMove = arg_2_0.deltaMoveX
	arg_2_0.bottomBoxMap = {}
end

function var_0_0.initData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.itemInfo = arg_3_1
	arg_3_0.sceneViewCls = arg_3_2
	arg_3_0.boxElementMap = FeiLinShiDuoGameModel.instance:getElementMap()[FeiLinShiDuoEnum.ObjectType.Box]
end

function var_0_0.addEventListeners(arg_4_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, arg_4_0.resetData, arg_4_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.CleanTopBoxBottomInfo, arg_4_0.cleanTopBoxBottomInfo, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, arg_5_0.resetData, arg_5_0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.CleanTopBoxBottomInfo, arg_5_0.cleanTopBoxBottomInfo, arg_5_0)
end

function var_0_0.cleanTopBoxBottomInfo(arg_6_0)
	if arg_6_0.isTopBox then
		arg_6_0.bottomBoxMap = {}
	end
end

function var_0_0.onTick(arg_7_0)
	arg_7_0:handleEvent()
end

function var_0_0.handleEvent(arg_8_0)
	if not arg_8_0.sceneViewCls then
		return
	end

	if FeiLinShiDuoGameModel.instance:getElementShowState(arg_8_0.itemInfo) and not arg_8_0:checkBoxInPlane() then
		arg_8_0:checkBoxFall()
	end
end

function var_0_0.checkBoxFall(arg_9_0, arg_9_1)
	if arg_9_0.deltaMoveX and arg_9_0.itemInfo or arg_9_0.isTopBox then
		local var_9_0 = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(arg_9_0.boxTrans.localPosition.x, arg_9_0.boxTrans.localPosition.y, arg_9_0.itemInfo, FeiLinShiDuoEnum.checkDir.Bottom, nil, {
			FeiLinShiDuoEnum.ObjectType.Option,
			FeiLinShiDuoEnum.ObjectType.Start
		})

		if #var_9_0 == 0 then
			arg_9_0.isGround = false
			arg_9_0.fallYSpeed = arg_9_0.fallYSpeed + arg_9_0.fallAddSpeed

			if not arg_9_0.isTopBox then
				local var_9_1 = FeiLinShiDuoGameModel.instance:getElementShowStateMap()
				local var_9_2 = arg_9_0.boxTrans.localPosition.x

				if arg_9_0.curInPlaneItem and var_9_1[arg_9_0.curInPlaneItem.id] and arg_9_0.deltaMoveX ~= 0 then
					var_9_2 = arg_9_0.deltaMoveX > 0 and arg_9_0.planeEndPosX or arg_9_0.planeStartPosX - arg_9_0.itemInfo.width
				end

				transformhelper.setLocalPosXY(arg_9_0.boxTrans, var_9_2, arg_9_0.boxTrans.localPosition.y - arg_9_0.fallYSpeed * Time.deltaTime)
			else
				local var_9_3 = arg_9_1 and arg_9_0.boxTrans.localPosition.y or arg_9_0.boxTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth
				local var_9_4 = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(arg_9_0.boxTrans.localPosition.x, var_9_3, arg_9_0.itemInfo, FeiLinShiDuoEnum.checkDir.Bottom, arg_9_0.boxElementMap)
				local var_9_5 = arg_9_0.boxTrans.localPosition.x

				if #var_9_4 == 0 then
					if not FeiLinShiDuoGameModel.instance:getElementShowState(arg_9_0.bottomBoxItemInfo) then
						var_9_5 = arg_9_0.boxTrans.localPosition.x
					elseif arg_9_0.bottomBoxItemInfo and Mathf.Abs(arg_9_0.boxTrans.localPosition.x + arg_9_0.itemInfo.width / 2 - (arg_9_0.bottomBoxItemInfo.pos[1] + arg_9_0.bottomBoxItemInfo.width / 2)) > arg_9_0.itemInfo.width / 2 + arg_9_0.bottomBoxItemInfo.width / 2 then
						var_9_5 = arg_9_0.boxTrans.localPosition.x
					else
						var_9_5 = arg_9_0.topBoxDeltaMove > 0 and arg_9_0.bottomBoxItemInfo.pos[1] + arg_9_0.bottomBoxItemInfo.width or arg_9_0.bottomBoxItemInfo.pos[1] - arg_9_0.itemInfo.width
					end
				end

				transformhelper.setLocalPosXY(arg_9_0.boxTrans, var_9_5, arg_9_0.boxTrans.localPosition.y - arg_9_0.fallYSpeed * Time.deltaTime)
			end
		else
			if not arg_9_0.isGround then
				arg_9_0.boxTrans.localPosition = arg_9_0:fixStandPos(var_9_0)

				AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_activity_organ_open)
				FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.CleanTopBoxBottomInfo)
			end

			arg_9_0.isGround = true
			arg_9_0.fallYSpeed = 0
			arg_9_0.deltaMoveX = 0
			arg_9_0.isTopBox = false

			for iter_9_0, iter_9_1 in ipairs(var_9_0) do
				if iter_9_1.type == FeiLinShiDuoEnum.ObjectType.Box then
					arg_9_0.isTopBox = true
					arg_9_0.topBoxOffset = iter_9_1.pos[1] - arg_9_0.boxTrans.localPosition.x
					arg_9_0.bottomBoxItemInfo = iter_9_1
					arg_9_0.bottomBoxMap[arg_9_0.bottomBoxItemInfo.id] = arg_9_0.topBoxOffset

					break
				end
			end

			if not arg_9_0.isTopBox then
				arg_9_0.bottomBoxMap = {}
			end
		end

		local var_9_6 = {
			arg_9_0.boxTrans.localPosition.x,
			arg_9_0.boxTrans.localPosition.y
		}

		FeiLinShiDuoGameModel.instance:updateBoxPos(arg_9_0.itemInfo.id, var_9_6)
	end
end

function var_0_0.setMove(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = arg_10_3 and arg_10_3.isBox
	local var_10_1 = arg_10_3 and arg_10_3.isTopBox

	if not arg_10_0.isGround or arg_10_0:checkBoxInPlane() then
		return
	end

	if arg_10_0.deltaMoveX == 0 then
		arg_10_0.deltaMoveX = arg_10_2
	end

	if arg_10_0.deltaMoveX ~= arg_10_2 then
		return
	end

	arg_10_0.isTopBox = var_10_1

	local var_10_2, var_10_3, var_10_4 = arg_10_0:getBoxInColorPlane(arg_10_0.boxTrans.localPosition.x + (arg_10_0.deltaMoveX >= 0 and -FeiLinShiDuoEnum.HalfSlotWidth or arg_10_0.itemInfo.width + FeiLinShiDuoEnum.HalfSlotWidth), arg_10_0.boxTrans.localPosition.y - 2, arg_10_0.curInPlaneItem)

	arg_10_0.curInPlaneItem = var_10_2
	arg_10_0.planeStartPosX = var_10_3 or arg_10_0.planeStartPosX
	arg_10_0.planeEndPosX = var_10_4 or arg_10_0.planeEndPosX

	if var_10_0 then
		local var_10_5, var_10_6 = FeiLinShiDuoGameModel.instance:checkForwardCanMove(arg_10_0.boxTrans.localPosition.x, arg_10_0.boxTrans.localPosition.y, arg_10_2, arg_10_0.itemInfo, var_10_0)

		arg_10_0.topBoxDeltaMove = arg_10_0.deltaMoveX

		if var_10_5 then
			if arg_10_0.isTopBox then
				arg_10_0.bottomBoxTrans = arg_10_1
				arg_10_0.bottomBoxItemInfo = arg_10_3.itemInfo

				local var_10_7 = arg_10_0.bottomBoxMap[arg_10_0.bottomBoxItemInfo.id]

				if not var_10_7 or arg_10_0.topBoxOffset == -10000 then
					arg_10_0.topBoxOffset = arg_10_0.bottomBoxItemInfo.pos[1] - arg_10_0.boxTrans.localPosition.x
					arg_10_0.bottomBoxMap[arg_10_0.bottomBoxItemInfo.id] = arg_10_0.topBoxOffset
					var_10_7 = arg_10_0.topBoxOffset
				end

				arg_10_0.topBoxOffset = var_10_7

				transformhelper.setLocalPosXY(arg_10_0.boxTrans, arg_10_0.bottomBoxItemInfo.pos[1] - arg_10_0.topBoxOffset, arg_10_0.boxTrans.localPosition.y)
			else
				transformhelper.setLocalPosXY(arg_10_0.boxTrans, arg_10_1.localPosition.x + (arg_10_0.deltaMoveX >= 0 and arg_10_3.itemInfo.width or -arg_10_0.itemInfo.width), arg_10_0.boxTrans.localPosition.y)
			end
		else
			arg_10_0.topBoxDeltaMove = arg_10_0.isTopBox and -arg_10_0.deltaMoveX or arg_10_0.deltaMoveX

			transformhelper.setLocalPosXY(arg_10_0.boxTrans, arg_10_0.deltaMoveX > 0 and var_10_6 - arg_10_0.itemInfo.width or var_10_6, arg_10_0.boxTrans.localPosition.y)
		end
	elseif FeiLinShiDuoGameModel.instance:checkForwardCanMove(arg_10_1.localPosition.x + arg_10_0.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth + 1), arg_10_1.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2, arg_10_0.deltaMoveX) and not arg_10_4 then
		transformhelper.setLocalPosXY(arg_10_0.boxTrans, arg_10_1.localPosition.x + arg_10_0.deltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 2 + (arg_10_0.deltaMoveX >= 0 and 0 or -arg_10_0.itemInfo.width), arg_10_0.boxTrans.localPosition.y)
	end

	local var_10_8 = {
		arg_10_0.boxTrans.localPosition.x,
		arg_10_0.boxTrans.localPosition.y
	}

	FeiLinShiDuoGameModel.instance:updateBoxPos(arg_10_0.itemInfo.id, var_10_8)
	arg_10_0:boxTouchElement()
end

function var_0_0.getBoxInColorPlane(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 then
		local var_11_0, var_11_1 = arg_11_0:getPlaneWidthRange(arg_11_3.id)

		if var_11_0 <= arg_11_1 and arg_11_1 <= var_11_1 then
			return arg_11_3, var_11_0, var_11_1
		end
	end

	local var_11_2 = FeiLinShiDuoGameModel.instance:getElementMap()
	local var_11_3 = {}
	local var_11_4 = var_11_2[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}
	local var_11_5 = var_11_2[FeiLinShiDuoEnum.ObjectType.Box] or {}
	local var_11_6 = var_11_2[FeiLinShiDuoEnum.ObjectType.Wall] or {}
	local var_11_7 = var_11_2[FeiLinShiDuoEnum.ObjectType.Trap] or {}
	local var_11_8 = var_11_2[FeiLinShiDuoEnum.ObjectType.Stairs] or {}

	for iter_11_0, iter_11_1 in pairs(var_11_6) do
		table.insert(var_11_3, iter_11_1)
	end

	for iter_11_2, iter_11_3 in pairs(var_11_4) do
		table.insert(var_11_3, iter_11_3)
	end

	for iter_11_4, iter_11_5 in pairs(var_11_5) do
		table.insert(var_11_3, iter_11_5)
	end

	for iter_11_6, iter_11_7 in pairs(var_11_7) do
		table.insert(var_11_3, iter_11_7)
	end

	for iter_11_8, iter_11_9 in pairs(var_11_8) do
		table.insert(var_11_3, iter_11_9)
	end

	for iter_11_10, iter_11_11 in pairs(var_11_3) do
		local var_11_9, var_11_10 = arg_11_0:getPlaneWidthRange(iter_11_11.id)

		if var_11_9 <= arg_11_1 and arg_11_1 <= var_11_10 and arg_11_2 > iter_11_11.pos[2] and arg_11_2 <= iter_11_11.pos[2] + iter_11_11.height then
			return iter_11_11, var_11_9, var_11_10
		end
	end
end

function var_0_0.getPlaneWidthRange(arg_12_0, arg_12_1)
	local var_12_0 = FeiLinShiDuoGameModel.instance:getInterElementMap()[arg_12_1] or {}
	local var_12_1 = var_12_0.pos[1]
	local var_12_2 = var_12_0.pos[1] + var_12_0.width

	return var_12_1, var_12_2
end

function var_0_0.fixStandPos(arg_13_0, arg_13_1)
	local var_13_0, var_13_1 = FeiLinShiDuoGameModel.instance:getFixStandePos(arg_13_1, arg_13_0.boxTrans.localPosition.x, arg_13_0.boxTrans.localPosition.y)

	if var_13_0 and var_13_1 then
		return Vector3(arg_13_0.boxTrans.localPosition.x, var_13_1.y, 0)
	end

	return arg_13_0.boxTrans.localPosition
end

function var_0_0.boxTouchElement(arg_14_0)
	if arg_14_0.isGround and arg_14_0.deltaMoveX ~= 0 then
		local var_14_0 = arg_14_0.deltaMoveX > 0 and FeiLinShiDuoEnum.checkDir.Right or FeiLinShiDuoEnum.checkDir.Left
		local var_14_1 = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(arg_14_0.boxTrans.localPosition.x + arg_14_0.deltaMoveX, arg_14_0.boxTrans.localPosition.y, arg_14_0.itemInfo, var_14_0)

		if #var_14_1 > 0 then
			for iter_14_0, iter_14_1 in pairs(var_14_1) do
				if iter_14_1.type == FeiLinShiDuoEnum.ObjectType.Box then
					local var_14_2 = {}
					local var_14_3 = arg_14_0.sceneViewCls:getBoxComp(iter_14_1.id)

					var_14_2.touchElementData = iter_14_1
					var_14_2.isBox = true
					var_14_2.isTopBox = false
					var_14_2.itemInfo = arg_14_0.itemInfo

					var_14_3:setMove(arg_14_0.boxTrans, arg_14_0.deltaMoveX, var_14_2)
				end
			end
		end

		local var_14_4 = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(arg_14_0.boxTrans.localPosition.x, arg_14_0.boxTrans.localPosition.y, arg_14_0.itemInfo, FeiLinShiDuoEnum.checkDir.Top)

		if #var_14_4 > 0 then
			for iter_14_2, iter_14_3 in pairs(var_14_4) do
				if iter_14_3.type == FeiLinShiDuoEnum.ObjectType.Box then
					local var_14_5 = {}
					local var_14_6 = arg_14_0.sceneViewCls:getBoxComp(iter_14_3.id)

					var_14_5.touchElementData = iter_14_3
					var_14_5.isBox = true
					var_14_5.isTopBox = true
					var_14_5.itemInfo = arg_14_0.itemInfo

					var_14_6:setMove(arg_14_0.boxTrans, arg_14_0.deltaMoveX, var_14_5)
				end
			end
		end
	end
end

function var_0_0.checkBoxInPlane(arg_15_0)
	local var_15_0 = FeiLinShiDuoGameModel.instance:getElementMap()
	local var_15_1 = {}
	local var_15_2 = var_15_0[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}

	for iter_15_0, iter_15_1 in pairs(var_15_2) do
		table.insert(var_15_1, iter_15_1)
	end

	for iter_15_2, iter_15_3 in pairs(var_15_1) do
		if FeiLinShiDuoGameModel.instance:getElementShowState(iter_15_3) and FeiLinShiDuoGameModel.instance:getElementShowState(arg_15_0.itemInfo) then
			local var_15_3 = arg_15_0.itemInfo.pos[1] + arg_15_0.itemInfo.width / 2
			local var_15_4 = iter_15_3.pos[1] + iter_15_3.width / 2

			if Mathf.Abs(var_15_3 - var_15_4) < arg_15_0.itemInfo.width / 2 + iter_15_3.width / 2 - 2 * FeiLinShiDuoEnum.touchCheckRange and Mathf.Abs(arg_15_0.itemInfo.pos[2] - iter_15_3.pos[2]) < FeiLinShiDuoEnum.HalfSlotWidth / 4 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getShowState(arg_16_0)
	return FeiLinShiDuoGameModel.instance:getElementShowState(arg_16_0.itemInfo)
end

return var_0_0
