module("modules.logic.rouge.map.controller.RougeMapPieceTriggerHelper", package.seeall)

slot0 = class("RougeMapPieceTriggerHelper")

function slot0.triggerHandle(slot0, slot1)
	uv0._initHandle()

	if not lua_rouge_piece_select.configDict[slot1] then
		logError("not found rouge_piece_select config .. " .. tostring(slot1))

		return
	end

	if not uv0.handleDict[slot2.triggerType] then
		logError("not found handle .. " .. tostring(slot3))

		return
	end

	slot4(slot0, slot2)
end

function slot0.getTip(slot0, slot1, slot2)
	if slot1 == 0 then
		return ""
	end

	uv0._initGetTipHandle()

	if not lua_rouge_piece_select.configDict[slot1] then
		logError("not found rouge_piece_select config .. " .. tostring(slot1))

		return
	end

	return uv0.getTipHandleDict[slot3.triggerType] or uv0.defaultGetPieceTip(slot0, slot3, slot2)
end

function slot0.getChoiceStatus(slot0, slot1)
	uv0._initGetStatusHandle()

	if not lua_rouge_piece_select.configDict[slot1] then
		return RougeMapEnum.ChoiceStatus.Normal
	end

	return uv0.getStatusHandleDict[slot2.triggerType] or uv0.defaultGetStatus(slot0, slot2)
end

function slot0._initHandle()
	if uv0.handleDict then
		return
	end

	uv0.handleDict = {
		[RougeMapEnum.PieceTriggerType.Empty] = uv0.handleEmpty,
		[RougeMapEnum.PieceTriggerType.AcceptEntrust] = uv0.handleAcceptEntrust,
		[RougeMapEnum.PieceTriggerType.Reward] = uv0.handleReward,
		[RougeMapEnum.PieceTriggerType.Compound] = uv0.handleCompound,
		[RougeMapEnum.PieceTriggerType.Shop] = uv0.handleShop,
		[RougeMapEnum.PieceTriggerType.Exchange] = uv0.handleExchange,
		[RougeMapEnum.PieceTriggerType.EndFight] = uv0.handleEndFight,
		[RougeMapEnum.PieceTriggerType.LevelUpSp] = uv0.handleLevelUpSp
	}
end

function slot0.handleEmpty()
	logNormal("empty 类型")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function slot0.handleAcceptEntrust(slot0, slot1)
	logNormal("接受委托")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function slot0.handleReward(slot0, slot1)
	logNormal("奖励")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function slot0.handleCompound(slot0, slot1)
	logNormal("合成")
	ViewMgr.instance:openView(ViewName.RougeCollectionCompositeView)
end

function slot0.handleShop(slot0, slot1)
	logNormal("休整购物")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceViewStatusChange, RougeMapEnum.PieceChoiceViewStatus.Store)
end

function slot0.handleExchange(slot0, slot1)
	logNormal("交换")
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionExchangeView)
end

function slot0.handleEndFight(slot0, slot1)
	logNormal("结局战斗")

	slot3 = string.splitToNumber(slot1.triggerParam, "#")

	RougeMapModel.instance:setEndId(slot3[2])
	DungeonFightController.instance:enterFight(RougeMapEnum.ChapterId, slot3[1])
end

function slot0.handleLevelUpSp(slot0, slot1)
	logNormal("专武升级")
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionLevelUpView, {
		closeBtnVisible = true,
		maxLevelUpNum = slot0.triggerStr and slot0.triggerStr.collectionLevelUpNum or 0
	})
end

function slot0._initGetTipHandle()
	if uv0.getTipHandleDict then
		return
	end

	uv0.getTipHandleDict = {
		[RougeMapEnum.PieceTriggerType.Exchange] = uv0.getExchangeTip
	}
end

function slot0.defaultGetPieceTip(slot0, slot1, slot2)
	if slot2 ~= RougeMapEnum.ChoiceStatus.Lock then
		return ""
	end

	return RougeMapUnlockHelper.getLockTips(slot1.unlockType, slot1.unlockParam)
end

function slot0.getExchangeTip(slot0, slot1, slot2)
	if slot2 == RougeMapEnum.ChoiceStatus.Lock then
		return RougeMapUnlockHelper.getLockTips(slot1.unlockType, slot1.unlockParam)
	end

	return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_remain_exchange_time"), RougeMapModel.instance:getExchangeMaxDisplaceNum() - (slot0.triggerStr and slot0.triggerStr.displaceNum or 0))
end

function slot0._initGetStatusHandle()
	if uv0.getStatusHandleDict then
		return
	end

	uv0.getStatusHandleDict = {
		[RougeMapEnum.PieceTriggerType.Exchange] = uv0.getExchangeStatus
	}
end

function slot0.defaultGetStatus(slot0, slot1)
	if RougeMapUnlockHelper.checkIsUnlock(slot1.unlockType, slot1.unlockParam) then
		return RougeMapEnum.ChoiceStatus.Normal
	end

	return RougeMapEnum.ChoiceStatus.Lock
end

function slot0.getExchangeStatus(slot0, slot1)
	if not RougeMapUnlockHelper.checkIsUnlock(slot1.unlockType, slot1.unlockParam) then
		return RougeMapEnum.ChoiceStatus.Lock
	end

	if RougeMapModel.instance:getExchangeMaxDisplaceNum() - (slot0.triggerStr and slot0.triggerStr.displaceNum or 0) < 1 then
		return RougeMapEnum.ChoiceStatus.Bought
	end

	return RougeMapEnum.ChoiceStatus.Normal
end

return slot0
