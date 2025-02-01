module("modules.logic.room.view.topright.RoomViewTopRightMaterialItem", package.seeall)

slot0 = class("RoomViewTopRightMaterialItem", RoomViewTopRightBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
end

function slot0._customOnInit(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._item = {
		type = slot0._param.type,
		id = slot0._param.id
	}
	slot0._onlyShowEvent = slot0._param.onlyShowEvent
	slot0._supportFlyEffect = slot0._param.supportFlyEffect
	slot0._listeningItems = slot0._param.listeningItems
	slot1 = nil
	slot0._resourceItem.simageicon = gohelper.findChildSingleImage(slot0._resourceItem.go, "icon")
	slot0._resourceItem.imageicon = gohelper.findChildImage(slot0._resourceItem.go, "sicon")
	slot0._resourceItem._animator = slot0._resourceItem.go:GetComponent(typeof(UnityEngine.Animator))

	if slot0._param.initAnim then
		slot0._resourceItem._animator:Play(slot0._param.initAnim, 0, 0)
	end

	if slot0._item.type == MaterialEnum.MaterialType.Item then
		slot2 = nil
		slot2, slot4 = ItemModel.instance:getItemConfigAndIcon(slot0._item.type, slot0._item.id)

		slot0._resourceItem.simageicon:LoadImage(slot4)
		gohelper.setActive(slot0._resourceItem.simageicon.gameObject, true)
		gohelper.setActive(slot0._resourceItem.imageicon.gameObject, false)
	elseif slot0._item.type == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._resourceItem.imageicon, CurrencyConfig.instance:getCurrencyCo(slot0._item.id).icon .. "_1")
		gohelper.setActive(slot0._resourceItem.simageicon.gameObject, false)
		gohelper.setActive(slot0._resourceItem.imageicon.gameObject, true)
	else
		logError("暂不支持显示其他类型")
	end

	slot0:addEventListeners()
	slot0:_setShow(not slot0._onlyShowEvent)
	slot0:_refreshUI(false)

	if slot0._onlyShowEvent or slot0._supportFlyEffect then
		slot0._tweenEventParamList = {}
	end
end

function slot0._checkListeningItems(slot0, slot1, slot2)
	if slot0._listeningItems then
		for slot6, slot7 in ipairs(slot0._listeningItems) do
			if slot7.type == slot1 and slot7.id == slot2 then
				return true
			end
		end
	end

	return false
end

function slot0._onClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._item.type, slot0._item.id)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._updateItem, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._updateItem, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UIFlyEffect, slot0._uiFlyEffect, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._uiFlyEffect(slot0, slot1)
	if not slot0._onlyShowEvent and not slot0._supportFlyEffect then
		return
	end

	if not slot0:_checkListeningItems(slot1.itemType, slot1.itemId) then
		return
	end

	slot5 = ItemModel.instance:getItemQuantity(slot0._item.type, slot0._item.id)

	if not slot0._isCurShow then
		if slot2 == slot0._item.type and slot3 == slot0._item.id then
			slot0:_setQuantity(slot1.startQuantity)
		else
			slot0:_setQuantity(slot5)
		end
	end

	slot0:_setShow(true)

	slot6 = 3

	TaskDispatcher.cancelTask(slot0._playCloseAnim, slot0)
	TaskDispatcher.runDelay(slot0._playCloseAnim, slot0, slot6 - 0.2)
	TaskDispatcher.cancelTask(slot0._hideShow, slot0)
	TaskDispatcher.runDelay(slot0._hideShow, slot0, slot6)

	if slot4 then
		UIBlockMgr.instance:endAll()

		slot0._startTime = slot0._supportFlyEffect and 0 or 0.66
		slot0._duration = 0.4
		slot0._endTime = 0.93
		slot0._allTime = slot0._startTime + slot0._duration + slot0._endTime

		TaskDispatcher.cancelTask(slot0._blockTouch, slot0)
		TaskDispatcher.runDelay(slot0._blockTouch, slot0, slot0._allTime)

		if slot0._scene.tween then
			slot0:getUserDataTb_().tweenId = slot0._scene.tween:tweenFloat(0, slot0._allTime, slot0._allTime, slot0._tweenEventFrameCallback, slot0._tweenEventFinishCallback, slot0, {
				paramIndex = #slot0._tweenEventParamList + 1,
				startPos = slot1.startPos,
				startQuantity = slot1.startQuantity,
				endQuantity = slot5
			})
		else
			slot7.tweenId = ZProj.TweenHelper.DOTweenFloat(0, slot0._allTime, slot0._allTime, slot0._tweenEventFrameCallback, slot0._tweenEventFinishCallback, slot0, {
				paramIndex = #slot0._tweenEventParamList + 1,
				startPos = slot1.startPos,
				startQuantity = slot1.startQuantity,
				endQuantity = slot5
			})
		end

		table.insert(slot0._tweenEventParamList, slot7)
	end
end

function slot0._tweenEventFrameCallback(slot0, slot1, slot2)
	slot3 = slot0._tweenEventParamList[slot2.paramIndex]

	if slot1 <= slot0._startTime then
		return
	end

	if slot1 < slot0._allTime then
		if not slot3.effect then
			slot3.effect = true

			gohelper.setActive(slot0._resourceItem.goeffect, false)
			gohelper.setActive(slot0._resourceItem.goeffect, true)
		end

		if not slot3.flyGO then
			slot3.flyGO = slot0:_getFlyGO()
		end

		slot4 = slot0._resourceItem.goflypos.transform.position
		slot6 = Mathf.Clamp((slot1 - slot0._startTime) / slot0._duration, 0, 1)

		transformhelper.setPos(slot3.flyGO.transform, Mathf.Lerp(slot2.startPos.x, slot4.x, slot6), Mathf.Lerp(slot2.startPos.y, slot4.y, slot6), Mathf.Lerp(slot2.startPos.z, slot4.z, slot6))
	end

	if slot1 > slot0._startTime + slot0._duration and not slot3.hasStartedQuantity then
		if slot0._tweenId then
			if slot0._scene.tween then
				slot0._scene.tween:killById(slot0._tweenId)
			else
				ZProj.TweenHelper.KillById(slot0._tweenId)
			end

			slot0._tweenId = nil
		end

		if slot0._scene.tween then
			slot0._tweenId = slot0._scene.tween:tweenFloat(0, 2, 2, slot0._tweenFrameCallback, slot0._tweenFinishCallback, slot0, {
				startQuantity = slot2.startQuantity,
				endQuantity = slot2.endQuantity
			})
		else
			slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 2, 2, slot0._tweenFrameCallback, slot0._tweenFinishCallback, slot0, {
				startQuantity = slot2.startQuantity,
				endQuantity = slot2.endQuantity
			})
		end

		slot3.hasStartedQuantity = true
	end

	if slot0._allTime <= slot1 then
		gohelper.setActive(slot0._resourceItem.goeffect, false)

		if slot3.flyGO then
			slot0:_returnFlyGO(slot3.flyGO)

			slot3.flyGO = nil
		end
	end
end

function slot0._tweenEventFinishCallback(slot0, slot1)
	slot0:_tweenEventFrameCallback(2, slot1)
end

function slot0._playCloseAnim(slot0)
	if not slot0._supportFlyEffect then
		slot0._resourceItem._animator:Play("close", 0, 0)
	end
end

function slot0._hideShow(slot0)
	slot0:_setShow(slot0._supportFlyEffect)
end

function slot0._setShow(slot0, slot1)
	slot0._isCurShow = slot1

	uv0.super._setShow(slot0, slot1)
end

function slot0._blockTouch(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("roomProductionBubbleGetReward")
end

function slot0._updateItem(slot0)
	if slot0._onlyShowEvent then
		return
	end

	slot0:_refreshUI(true)
end

function slot0._refreshUI(slot0, slot1)
	if slot0._tweenId then
		if slot0._scene.tween then
			slot0._scene.tween:killById(slot0._tweenId)
		else
			ZProj.TweenHelper.KillById(slot0._tweenId)
		end

		slot0._tweenId = nil
	end

	if slot1 then
		if slot0._scene.tween then
			slot0._tweenId = slot0._scene.tween:tweenFloat(0, 2, 2, slot0._tweenFrameCallback, slot0._tweenFinishCallback, slot0, {
				startQuantity = slot0._quantity,
				endQuantity = ItemModel.instance:getItemQuantity(slot0._item.type, slot0._item.id)
			})
		else
			slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 2, 2, slot0._tweenFrameCallback, slot0._tweenFinishCallback, slot0, {
				startQuantity = slot0._quantity,
				endQuantity = slot2
			})
		end
	else
		slot0:_setQuantity(slot2)
	end
end

function slot0._tweenFrameCallback(slot0, slot1, slot2)
	slot3 = slot1 * (slot2.endQuantity - slot2.startQuantity) + slot2.startQuantity

	if slot1 >= 1 then
		slot3 = slot2.endQuantity
	end

	slot0:_setQuantity(slot3)
end

function slot0._setQuantity(slot0, slot1)
	slot1 = math.floor(slot1)
	slot0._resourceItem.txtquantity.text = GameUtil.numberDisplay(slot1)
	slot0._quantity = slot1
end

function slot0._tweenFinishCallback(slot0)
	slot1 = ItemModel.instance:getItemQuantity(slot0._item.type, slot0._item.id)
	slot0._resourceItem.txtquantity.text = GameUtil.numberDisplay(slot1)
	slot0._quantity = slot1
end

function slot0._customOnDestory(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("roomProductionBubbleGetReward")
	TaskDispatcher.cancelTask(slot0._blockTouch, slot0)
	slot0._resourceItem.simageicon:UnLoadImage()

	if slot0._tweenId then
		if slot0._scene.tween then
			slot0._scene.tween:killById(slot0._tweenId)
		else
			ZProj.TweenHelper.KillById(slot0._tweenId)
		end

		slot0._tweenId = nil
	end

	if slot0._tweenEventParamList then
		for slot4, slot5 in ipairs(slot0._tweenEventParamList) do
			if slot0._scene.tween then
				slot0._scene.tween:killById(slot5.tweenId)
			else
				ZProj.TweenHelper.KillById(slot5.tweenId)
			end

			if slot5.flyGO then
				slot0:_returnFlyGO(slot5.flyGO)

				slot5 = nil
			end
		end
	end

	TaskDispatcher.cancelTask(slot0._playCloseAnim, slot0)
	TaskDispatcher.cancelTask(slot0._hideShow, slot0)
end

function slot0._getFlyGO(slot0)
	return slot0._parent:getFlyGO()
end

function slot0._returnFlyGO(slot0, slot1)
	slot0._parent:returnFlyGO(slot1)
end

return slot0
