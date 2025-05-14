module("modules.logic.rouge.map.controller.RougeMapPieceTriggerHelper", package.seeall)

local var_0_0 = class("RougeMapPieceTriggerHelper")

function var_0_0.triggerHandle(arg_1_0, arg_1_1)
	var_0_0._initHandle()

	local var_1_0 = lua_rouge_piece_select.configDict[arg_1_1]

	if not var_1_0 then
		logError("not found rouge_piece_select config .. " .. tostring(arg_1_1))

		return
	end

	local var_1_1 = var_1_0.triggerType
	local var_1_2 = var_0_0.handleDict[var_1_1]

	if not var_1_2 then
		logError("not found handle .. " .. tostring(var_1_1))

		return
	end

	var_1_2(arg_1_0, var_1_0)
end

function var_0_0.getTip(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		return ""
	end

	var_0_0._initGetTipHandle()

	local var_2_0 = lua_rouge_piece_select.configDict[arg_2_1]

	if not var_2_0 then
		logError("not found rouge_piece_select config .. " .. tostring(arg_2_1))

		return
	end

	local var_2_1 = var_2_0.triggerType

	return (var_0_0.getTipHandleDict[var_2_1] or var_0_0.defaultGetPieceTip)(arg_2_0, var_2_0, arg_2_2)
end

function var_0_0.getChoiceStatus(arg_3_0, arg_3_1)
	var_0_0._initGetStatusHandle()

	local var_3_0 = lua_rouge_piece_select.configDict[arg_3_1]

	if not var_3_0 then
		return RougeMapEnum.ChoiceStatus.Normal
	end

	local var_3_1 = var_3_0.triggerType

	return (var_0_0.getStatusHandleDict[var_3_1] or var_0_0.defaultGetStatus)(arg_3_0, var_3_0)
end

function var_0_0._initHandle()
	if var_0_0.handleDict then
		return
	end

	var_0_0.handleDict = {
		[RougeMapEnum.PieceTriggerType.Empty] = var_0_0.handleEmpty,
		[RougeMapEnum.PieceTriggerType.AcceptEntrust] = var_0_0.handleAcceptEntrust,
		[RougeMapEnum.PieceTriggerType.Reward] = var_0_0.handleReward,
		[RougeMapEnum.PieceTriggerType.Compound] = var_0_0.handleCompound,
		[RougeMapEnum.PieceTriggerType.Shop] = var_0_0.handleShop,
		[RougeMapEnum.PieceTriggerType.Exchange] = var_0_0.handleExchange,
		[RougeMapEnum.PieceTriggerType.EndFight] = var_0_0.handleEndFight,
		[RougeMapEnum.PieceTriggerType.LevelUpSp] = var_0_0.handleLevelUpSp
	}
end

function var_0_0.handleEmpty()
	logNormal("empty 类型")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function var_0_0.handleAcceptEntrust(arg_6_0, arg_6_1)
	logNormal("接受委托")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function var_0_0.handleReward(arg_7_0, arg_7_1)
	logNormal("奖励")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function var_0_0.handleCompound(arg_8_0, arg_8_1)
	logNormal("合成")
	ViewMgr.instance:openView(ViewName.RougeCollectionCompositeView)
end

function var_0_0.handleShop(arg_9_0, arg_9_1)
	logNormal("休整购物")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceViewStatusChange, RougeMapEnum.PieceChoiceViewStatus.Store)
end

function var_0_0.handleExchange(arg_10_0, arg_10_1)
	logNormal("交换")
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionExchangeView)
end

function var_0_0.handleEndFight(arg_11_0, arg_11_1)
	logNormal("结局战斗")

	local var_11_0 = RougeMapEnum.ChapterId
	local var_11_1 = string.splitToNumber(arg_11_1.triggerParam, "#")
	local var_11_2 = var_11_1[1]

	RougeMapModel.instance:setEndId(var_11_1[2])
	DungeonFightController.instance:enterFight(var_11_0, var_11_2)
end

function var_0_0.handleLevelUpSp(arg_12_0, arg_12_1)
	logNormal("专武升级")

	local var_12_0 = arg_12_0.triggerStr and arg_12_0.triggerStr.collectionLevelUpNum or 0
	local var_12_1 = {
		closeBtnVisible = true,
		maxLevelUpNum = var_12_0
	}

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionLevelUpView, var_12_1)
end

function var_0_0._initGetTipHandle()
	if var_0_0.getTipHandleDict then
		return
	end

	var_0_0.getTipHandleDict = {
		[RougeMapEnum.PieceTriggerType.Exchange] = var_0_0.getExchangeTip
	}
end

function var_0_0.defaultGetPieceTip(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 ~= RougeMapEnum.ChoiceStatus.Lock then
		return ""
	end

	return RougeMapUnlockHelper.getLockTips(arg_14_1.unlockType, arg_14_1.unlockParam)
end

function var_0_0.getExchangeTip(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 == RougeMapEnum.ChoiceStatus.Lock then
		return RougeMapUnlockHelper.getLockTips(arg_15_1.unlockType, arg_15_1.unlockParam)
	end

	local var_15_0 = RougeMapModel.instance:getExchangeMaxDisplaceNum() - (arg_15_0.triggerStr and arg_15_0.triggerStr.displaceNum or 0)

	return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_remain_exchange_time"), var_15_0)
end

function var_0_0._initGetStatusHandle()
	if var_0_0.getStatusHandleDict then
		return
	end

	var_0_0.getStatusHandleDict = {
		[RougeMapEnum.PieceTriggerType.Exchange] = var_0_0.getExchangeStatus
	}
end

function var_0_0.defaultGetStatus(arg_17_0, arg_17_1)
	if RougeMapUnlockHelper.checkIsUnlock(arg_17_1.unlockType, arg_17_1.unlockParam) then
		return RougeMapEnum.ChoiceStatus.Normal
	end

	return RougeMapEnum.ChoiceStatus.Lock
end

function var_0_0.getExchangeStatus(arg_18_0, arg_18_1)
	if not RougeMapUnlockHelper.checkIsUnlock(arg_18_1.unlockType, arg_18_1.unlockParam) then
		return RougeMapEnum.ChoiceStatus.Lock
	end

	if RougeMapModel.instance:getExchangeMaxDisplaceNum() - (arg_18_0.triggerStr and arg_18_0.triggerStr.displaceNum or 0) < 1 then
		return RougeMapEnum.ChoiceStatus.Bought
	end

	return RougeMapEnum.ChoiceStatus.Normal
end

return var_0_0
