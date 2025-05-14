module("modules.logic.room.view.topright.RoomViewTopRightMaterialItem", package.seeall)

local var_0_0 = class("RoomViewTopRightMaterialItem", RoomViewTopRightBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
	arg_2_0._item = {
		type = arg_2_0._param.type,
		id = arg_2_0._param.id
	}
	arg_2_0._onlyShowEvent = arg_2_0._param.onlyShowEvent
	arg_2_0._supportFlyEffect = arg_2_0._param.supportFlyEffect
	arg_2_0._listeningItems = arg_2_0._param.listeningItems

	local var_2_0

	arg_2_0._resourceItem.simageicon = gohelper.findChildSingleImage(arg_2_0._resourceItem.go, "icon")
	arg_2_0._resourceItem.imageicon = gohelper.findChildImage(arg_2_0._resourceItem.go, "sicon")
	arg_2_0._resourceItem._animator = arg_2_0._resourceItem.go:GetComponent(typeof(UnityEngine.Animator))

	if arg_2_0._param.initAnim then
		arg_2_0._resourceItem._animator:Play(arg_2_0._param.initAnim, 0, 0)
	end

	if arg_2_0._item.type == MaterialEnum.MaterialType.Item then
		local var_2_1
		local var_2_2, var_2_3 = ItemModel.instance:getItemConfigAndIcon(arg_2_0._item.type, arg_2_0._item.id)

		arg_2_0._resourceItem.simageicon:LoadImage(var_2_3)
		gohelper.setActive(arg_2_0._resourceItem.simageicon.gameObject, true)
		gohelper.setActive(arg_2_0._resourceItem.imageicon.gameObject, false)
	elseif arg_2_0._item.type == MaterialEnum.MaterialType.Currency then
		local var_2_4 = CurrencyConfig.instance:getCurrencyCo(arg_2_0._item.id)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_2_0._resourceItem.imageicon, var_2_4.icon .. "_1")
		gohelper.setActive(arg_2_0._resourceItem.simageicon.gameObject, false)
		gohelper.setActive(arg_2_0._resourceItem.imageicon.gameObject, true)
	else
		logError("暂不支持显示其他类型")
	end

	arg_2_0:addEventListeners()
	arg_2_0:_setShow(not arg_2_0._onlyShowEvent)
	arg_2_0:_refreshUI(false)

	if arg_2_0._onlyShowEvent or arg_2_0._supportFlyEffect then
		arg_2_0._tweenEventParamList = {}
	end
end

function var_0_0._checkListeningItems(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._listeningItems then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._listeningItems) do
			if iter_3_1.type == arg_3_1 and iter_3_1.id == arg_3_2 then
				return true
			end
		end
	end

	return false
end

function var_0_0._onClick(arg_4_0)
	MaterialTipController.instance:showMaterialInfo(arg_4_0._item.type, arg_4_0._item.id)
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_5_0._updateItem, arg_5_0)
	arg_5_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_5_0._updateItem, arg_5_0)
	arg_5_0:addEventCb(RoomMapController.instance, RoomEvent.UIFlyEffect, arg_5_0._uiFlyEffect, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	return
end

function var_0_0._uiFlyEffect(arg_7_0, arg_7_1)
	if not arg_7_0._onlyShowEvent and not arg_7_0._supportFlyEffect then
		return
	end

	local var_7_0 = arg_7_1.itemType
	local var_7_1 = arg_7_1.itemId

	if not arg_7_0:_checkListeningItems(var_7_0, var_7_1) then
		return
	end

	local var_7_2 = var_7_0 == arg_7_0._item.type and var_7_1 == arg_7_0._item.id
	local var_7_3 = ItemModel.instance:getItemQuantity(arg_7_0._item.type, arg_7_0._item.id)

	if not arg_7_0._isCurShow then
		if var_7_2 then
			arg_7_0:_setQuantity(arg_7_1.startQuantity)
		else
			arg_7_0:_setQuantity(var_7_3)
		end
	end

	arg_7_0:_setShow(true)

	local var_7_4 = 3

	TaskDispatcher.cancelTask(arg_7_0._playCloseAnim, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._playCloseAnim, arg_7_0, var_7_4 - 0.2)
	TaskDispatcher.cancelTask(arg_7_0._hideShow, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._hideShow, arg_7_0, var_7_4)

	if var_7_2 then
		UIBlockMgr.instance:endAll()

		local var_7_5 = arg_7_0:getUserDataTb_()

		arg_7_0._startTime = arg_7_0._supportFlyEffect and 0 or 0.66
		arg_7_0._duration = 0.4
		arg_7_0._endTime = 0.93
		arg_7_0._allTime = arg_7_0._startTime + arg_7_0._duration + arg_7_0._endTime

		TaskDispatcher.cancelTask(arg_7_0._blockTouch, arg_7_0)
		TaskDispatcher.runDelay(arg_7_0._blockTouch, arg_7_0, arg_7_0._allTime)

		if arg_7_0._scene.tween then
			var_7_5.tweenId = arg_7_0._scene.tween:tweenFloat(0, arg_7_0._allTime, arg_7_0._allTime, arg_7_0._tweenEventFrameCallback, arg_7_0._tweenEventFinishCallback, arg_7_0, {
				paramIndex = #arg_7_0._tweenEventParamList + 1,
				startPos = arg_7_1.startPos,
				startQuantity = arg_7_1.startQuantity,
				endQuantity = var_7_3
			})
		else
			var_7_5.tweenId = ZProj.TweenHelper.DOTweenFloat(0, arg_7_0._allTime, arg_7_0._allTime, arg_7_0._tweenEventFrameCallback, arg_7_0._tweenEventFinishCallback, arg_7_0, {
				paramIndex = #arg_7_0._tweenEventParamList + 1,
				startPos = arg_7_1.startPos,
				startQuantity = arg_7_1.startQuantity,
				endQuantity = var_7_3
			})
		end

		table.insert(arg_7_0._tweenEventParamList, var_7_5)
	end
end

function var_0_0._tweenEventFrameCallback(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._tweenEventParamList[arg_8_2.paramIndex]

	if arg_8_1 <= arg_8_0._startTime then
		return
	end

	if arg_8_1 < arg_8_0._allTime then
		if not var_8_0.effect then
			var_8_0.effect = true

			gohelper.setActive(arg_8_0._resourceItem.goeffect, false)
			gohelper.setActive(arg_8_0._resourceItem.goeffect, true)
		end

		if not var_8_0.flyGO then
			var_8_0.flyGO = arg_8_0:_getFlyGO()
		end

		local var_8_1 = arg_8_0._resourceItem.goflypos.transform.position
		local var_8_2 = var_8_0.flyGO
		local var_8_3 = Mathf.Clamp((arg_8_1 - arg_8_0._startTime) / arg_8_0._duration, 0, 1)
		local var_8_4 = Mathf.Lerp(arg_8_2.startPos.x, var_8_1.x, var_8_3)
		local var_8_5 = Mathf.Lerp(arg_8_2.startPos.y, var_8_1.y, var_8_3)
		local var_8_6 = Mathf.Lerp(arg_8_2.startPos.z, var_8_1.z, var_8_3)

		transformhelper.setPos(var_8_2.transform, var_8_4, var_8_5, var_8_6)
	end

	if arg_8_1 > arg_8_0._startTime + arg_8_0._duration and not var_8_0.hasStartedQuantity then
		if arg_8_0._tweenId then
			if arg_8_0._scene.tween then
				arg_8_0._scene.tween:killById(arg_8_0._tweenId)
			else
				ZProj.TweenHelper.KillById(arg_8_0._tweenId)
			end

			arg_8_0._tweenId = nil
		end

		if arg_8_0._scene.tween then
			arg_8_0._tweenId = arg_8_0._scene.tween:tweenFloat(0, 2, 2, arg_8_0._tweenFrameCallback, arg_8_0._tweenFinishCallback, arg_8_0, {
				startQuantity = arg_8_2.startQuantity,
				endQuantity = arg_8_2.endQuantity
			})
		else
			arg_8_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 2, 2, arg_8_0._tweenFrameCallback, arg_8_0._tweenFinishCallback, arg_8_0, {
				startQuantity = arg_8_2.startQuantity,
				endQuantity = arg_8_2.endQuantity
			})
		end

		var_8_0.hasStartedQuantity = true
	end

	if arg_8_1 >= arg_8_0._allTime then
		gohelper.setActive(arg_8_0._resourceItem.goeffect, false)

		if var_8_0.flyGO then
			arg_8_0:_returnFlyGO(var_8_0.flyGO)

			var_8_0.flyGO = nil
		end
	end
end

function var_0_0._tweenEventFinishCallback(arg_9_0, arg_9_1)
	arg_9_0:_tweenEventFrameCallback(2, arg_9_1)
end

function var_0_0._playCloseAnim(arg_10_0)
	if not arg_10_0._supportFlyEffect then
		arg_10_0._resourceItem._animator:Play("close", 0, 0)
	end
end

function var_0_0._hideShow(arg_11_0)
	arg_11_0:_setShow(arg_11_0._supportFlyEffect)
end

function var_0_0._setShow(arg_12_0, arg_12_1)
	arg_12_0._isCurShow = arg_12_1

	var_0_0.super._setShow(arg_12_0, arg_12_1)
end

function var_0_0._blockTouch(arg_13_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("roomProductionBubbleGetReward")
end

function var_0_0._updateItem(arg_14_0)
	if arg_14_0._onlyShowEvent then
		return
	end

	arg_14_0:_refreshUI(true)
end

function var_0_0._refreshUI(arg_15_0, arg_15_1)
	if arg_15_0._tweenId then
		if arg_15_0._scene.tween then
			arg_15_0._scene.tween:killById(arg_15_0._tweenId)
		else
			ZProj.TweenHelper.KillById(arg_15_0._tweenId)
		end

		arg_15_0._tweenId = nil
	end

	local var_15_0 = ItemModel.instance:getItemQuantity(arg_15_0._item.type, arg_15_0._item.id)

	if arg_15_1 then
		if arg_15_0._scene.tween then
			arg_15_0._tweenId = arg_15_0._scene.tween:tweenFloat(0, 2, 2, arg_15_0._tweenFrameCallback, arg_15_0._tweenFinishCallback, arg_15_0, {
				startQuantity = arg_15_0._quantity,
				endQuantity = var_15_0
			})
		else
			arg_15_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 2, 2, arg_15_0._tweenFrameCallback, arg_15_0._tweenFinishCallback, arg_15_0, {
				startQuantity = arg_15_0._quantity,
				endQuantity = var_15_0
			})
		end
	else
		arg_15_0:_setQuantity(var_15_0)
	end
end

function var_0_0._tweenFrameCallback(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1 * (arg_16_2.endQuantity - arg_16_2.startQuantity) + arg_16_2.startQuantity

	if arg_16_1 >= 1 then
		var_16_0 = arg_16_2.endQuantity
	end

	arg_16_0:_setQuantity(var_16_0)
end

function var_0_0._setQuantity(arg_17_0, arg_17_1)
	arg_17_1 = math.floor(arg_17_1)
	arg_17_0._resourceItem.txtquantity.text = GameUtil.numberDisplay(arg_17_1)
	arg_17_0._quantity = arg_17_1
end

function var_0_0._tweenFinishCallback(arg_18_0)
	local var_18_0 = ItemModel.instance:getItemQuantity(arg_18_0._item.type, arg_18_0._item.id)

	arg_18_0._resourceItem.txtquantity.text = GameUtil.numberDisplay(var_18_0)
	arg_18_0._quantity = var_18_0
end

function var_0_0._customOnDestory(arg_19_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("roomProductionBubbleGetReward")
	TaskDispatcher.cancelTask(arg_19_0._blockTouch, arg_19_0)
	arg_19_0._resourceItem.simageicon:UnLoadImage()

	if arg_19_0._tweenId then
		if arg_19_0._scene.tween then
			arg_19_0._scene.tween:killById(arg_19_0._tweenId)
		else
			ZProj.TweenHelper.KillById(arg_19_0._tweenId)
		end

		arg_19_0._tweenId = nil
	end

	if arg_19_0._tweenEventParamList then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0._tweenEventParamList) do
			if arg_19_0._scene.tween then
				arg_19_0._scene.tween:killById(iter_19_1.tweenId)
			else
				ZProj.TweenHelper.KillById(iter_19_1.tweenId)
			end

			if iter_19_1.flyGO then
				arg_19_0:_returnFlyGO(iter_19_1.flyGO)

				iter_19_1 = nil
			end
		end
	end

	TaskDispatcher.cancelTask(arg_19_0._playCloseAnim, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._hideShow, arg_19_0)
end

function var_0_0._getFlyGO(arg_20_0)
	return arg_20_0._parent:getFlyGO()
end

function var_0_0._returnFlyGO(arg_21_0, arg_21_1)
	arg_21_0._parent:returnFlyGO(arg_21_1)
end

return var_0_0
