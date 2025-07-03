module("modules.logic.fight.view.FightViewExPoint", package.seeall)

local var_0_0 = class("FightViewExPoint", BaseView)

function var_0_0.addEvents(arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_1_0._onStartSequenceFinish, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_1_0._onRoundSequenceFinish, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnMoveHandCard, arg_1_0._onMoveHandCard, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnCombineOneCard, arg_1_0._onCombineOneCard, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, arg_1_0._onPlayHandCard, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnRevertCard, arg_1_0._onRevertCard, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.CancelOperation, arg_1_0._onCancelOperation, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnResetCard, arg_1_0._onResetCard, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.RespBeginRound, arg_1_0._respBeginRound, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnStageChange, arg_1_0._onStageChange, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_2_0._onStartSequenceFinish, arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.OnMoveHandCard, arg_2_0._onMoveHandCard, arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.OnCombineOneCard, arg_2_0._onCombineOneCard, arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.OnPlayHandCard, arg_2_0._onPlayHandCard, arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.OnRevertCard, arg_2_0._onRevertCard, arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.CancelOperation, arg_2_0._onCancelOperation, arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.OnResetCard, arg_2_0._onResetCard, arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.RespBeginRound, arg_2_0._respBeginRound, arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_2_0._onSkillPlayStart, arg_2_0)
	arg_2_0:removeEventCb(FightController.instance, FightEvent.OnStageChange, arg_2_0._onStageChange, arg_2_0)
end

function var_0_0._onStartSequenceFinish(arg_3_0)
	return
end

function var_0_0._onRoundSequenceFinish(arg_4_0)
	FightDataHelper.operationDataMgr:applyNextRoundActPoint()
end

function var_0_0._onMoveHandCard(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1.moveCanAddExpoint then
		return
	end

	local var_5_0 = FightDataHelper.operationDataMgr.extraMoveAct

	if var_5_0 > 0 then
		if var_5_0 < #FightDataHelper.operationDataMgr:getMoveCardOpCostActList() then
			arg_5_0:_onMoveOrCombine(arg_5_2.uid, true)
		end
	else
		arg_5_0:_onMoveOrCombine(arg_5_2.uid, true)
	end
end

function var_0_0._onCombineOneCard(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1.combineCanAddExpoint then
		return
	end

	if not arg_6_2 then
		arg_6_0:_onMoveOrCombine(arg_6_1.uid, false)
	end
end

function var_0_0._onMoveOrCombine(arg_7_0, arg_7_1, arg_7_2)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	local var_7_0 = FightDataHelper.entityMgr:getById(arg_7_1)

	if not var_7_0 then
		return
	end

	if var_7_0:getMoveCardAddExPoint() < 1 then
		return
	end

	local var_7_1 = FightBuffHelper.getTransferExPointUid(var_7_0)

	if var_7_1 then
		local var_7_2 = FightDataHelper.entityMgr:getById(var_7_1)

		if var_7_2 then
			var_7_2:onMoveCardExPoint(arg_7_2)
			FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, var_7_1)
		else
			var_7_0:onMoveCardExPoint(arg_7_2)
			FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, arg_7_1)
		end
	else
		var_7_0:onMoveCardExPoint(arg_7_2)
		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, arg_7_1)
	end
end

function var_0_0._onPlayHandCard(arg_8_0, arg_8_1)
	if not arg_8_1.playCanAddExpoint then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	local var_8_0 = FightDataHelper.entityMgr:getById(arg_8_1.uid)

	if not var_8_0 then
		return
	end

	if var_8_0:getPlayCardAddExPoint() < 1 then
		return
	end

	local var_8_1 = FightBuffHelper.getTransferExPointUid(var_8_0)

	if var_8_1 then
		local var_8_2 = FightDataHelper.entityMgr:getById(var_8_1)

		if var_8_2 then
			var_8_2:onPlayCardExPoint(arg_8_1.skillId)
			FightController.instance:dispatchEvent(FightEvent.AddPlayCardClientExPoint, var_8_1)
		else
			var_8_0:onPlayCardExPoint(arg_8_1.skillId)
			FightController.instance:dispatchEvent(FightEvent.AddPlayCardClientExPoint, arg_8_1.uid)
		end
	else
		var_8_0:onPlayCardExPoint(arg_8_1.skillId)
		FightController.instance:dispatchEvent(FightEvent.AddPlayCardClientExPoint, arg_8_1.uid)
	end
end

function var_0_0._onRevertCard(arg_9_0, arg_9_1)
	return
end

function var_0_0._onCancelOperation(arg_10_0)
	arg_10_0.last_move_point = {}

	local var_10_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = iter_10_1:getMO()

		if var_10_1 then
			arg_10_0.last_move_point[var_10_1.uid] = var_10_1.moveCardExPoint
		end
	end
end

function var_0_0._onResetCard(arg_11_0)
	local var_11_0 = FightDataHelper.entityMgr:getAllEntityData()

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, iter_11_1.id)
	end
end

function var_0_0._respBeginRound(arg_12_0)
	local var_12_0 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		iter_12_1:applyMoveCardExPoint()
	end

	local var_12_1 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)

	for iter_12_2, iter_12_3 in ipairs(var_12_1) do
		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, iter_12_3.id)
	end
end

function var_0_0._onSkillPlayStart(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	return
end

function var_0_0._onStageChange(arg_14_0, arg_14_1)
	if arg_14_1 ~= FightEnum.Stage.Card and arg_14_1 == FightEnum.Stage.AutoCard then
		-- block empty
	end
end

return var_0_0
