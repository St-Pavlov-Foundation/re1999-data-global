module("modules.logic.fight.view.cardeffect.FightCardResetEffect", package.seeall)

local var_0_0 = class("FightCardResetEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._dt = var_0_2 / FightModel.instance:getUISpeed()

	FightController.instance:dispatchEvent(FightEvent.CorrectPlayCardVisible)

	arg_1_0._flow = FlowParallel.New()

	local var_1_0 = FlowSequence.New()

	var_1_0:addWork(arg_1_0:_buildPlayCardFadeOut())
	var_1_0:addWork(arg_1_0:_buildPlayCardMove())
	arg_1_0._flow:addWork(var_1_0)
	arg_1_0._flow:addWork(arg_1_0:_buildHandCardMove())
	arg_1_0._flow:registerDoneListener(arg_1_0._onWorkDone, arg_1_0)
	arg_1_0._flow:start()
end

function var_0_0._buildPlayCardFadeOut(arg_2_0)
	local var_2_0 = FlowParallel.New()

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.context.playCardItemList) do
		local var_2_1 = iter_2_1.go
		local var_2_2 = gohelper.findChild(var_2_1, "imgEmpty")
		local var_2_3 = gohelper.findChild(var_2_1, "card")
		local var_2_4 = gohelper.findChild(var_2_1, "imgMove")
		local var_2_5 = gohelper.findChild(var_2_1, "lock")

		gohelper.setActive(var_2_5, false)
		var_2_0:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = var_2_3,
			t = arg_2_0._dt * 3
		}))
		var_2_0:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = var_2_4,
			t = arg_2_0._dt * 3
		}))

		local var_2_6 = iter_2_1.fightBeginRoundOp

		if var_2_6 and var_2_6:isAssistBossPlayCard() then
			gohelper.setActive(var_2_2, false)
		elseif var_2_6 and var_2_6:isPlayerFinisherSkill() then
			gohelper.setActive(var_2_2, false)
		elseif var_2_6 then
			local var_2_7 = not var_2_6:isPlayCard() or var_2_6.costActPoint >= 1

			gohelper.setActive(var_2_2, var_2_7)
		else
			gohelper.setActive(var_2_2, true)
		end

		iter_2_1:playASFDCloseAnim()
	end

	return var_2_0
end

function var_0_0._buildPlayCardMove(arg_3_0)
	local var_3_0 = FightCardModel.instance:getCardMO().actPoint
	local var_3_1 = FightCardModel.instance:getCardMO().extraMoveAct

	var_3_1 = var_3_1 == -1 and 0 or var_3_1

	local var_3_2 = 1
	local var_3_3 = FlowParallel.New()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.context.playCardItemList) do
		local var_3_4 = iter_3_1.go
		local var_3_5 = iter_3_1.fightBeginRoundOp

		if var_3_5 and var_3_5:isPlayCard() and var_3_5.costActPoint == 0 then
			-- block empty
		elseif var_3_5 and var_3_5:isAssistBossPlayCard() then
			-- block empty
		elseif var_3_5 and var_3_5:isPlayerFinisherSkill() then
			-- block empty
		else
			local var_3_6, var_3_7 = FightViewPlayCard.calcCardPosX(var_3_2, var_3_0 + var_3_1)

			var_3_3:addWork(TweenWork.New({
				type = "DOAnchorPos",
				tr = var_3_4.transform,
				tox = var_3_6,
				toy = var_3_7,
				t = arg_3_0._dt * 3
			}))

			var_3_2 = var_3_2 + 1
		end
	end

	return var_3_3
end

function var_0_0._buildHandCardMove(arg_4_0)
	local var_4_0 = arg_4_0:_buildCardRelation()
	local var_4_1 = {}
	local var_4_2 = FlowSequence.New()
	local var_4_3 = arg_4_0.context.view.viewContainer.fightViewHandCard._handCardItemList
	local var_4_4 = FlowParallel.New()

	var_4_2:addWork(var_4_4)

	for iter_4_0 = 1, #var_4_3 do
		local var_4_5 = var_4_3[iter_4_0]

		if var_4_0[iter_4_0] then
			local var_4_6 = var_4_0[iter_4_0].origin

			if var_4_6 then
				var_4_1[var_4_6] = true

				local var_4_7 = FightViewHandCard.calcCardPosX(var_4_6)

				var_4_4:addWork(TweenWork.New({
					type = "DOAnchorPos",
					toy = 0,
					tr = var_4_5.tr,
					tox = var_4_7,
					t = arg_4_0._dt * 4
				}))
			end
		end
	end

	var_4_2:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.UpdateHandCards, FightCardModel.instance:getHandCards())

		for iter_5_0, iter_5_1 in ipairs(var_4_3) do
			if not var_4_1[iter_5_0] then
				TweenWork.New({
					from = 0,
					type = "DOFadeCanvasGroup",
					to = 1,
					go = iter_5_1.go,
					t = arg_4_0._dt * 4
				}):onStart()
			end
		end
	end))
	var_4_2:addWork(WorkWaitSeconds.New(arg_4_0._dt * 5))

	return var_4_2
end

function var_0_0._buildCardRelation(arg_6_0)
	local var_6_0 = FightCardModel.instance:getHandCards()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		var_6_0[iter_6_0] = iter_6_1:clone()
		var_6_0[iter_6_0].origin = iter_6_0
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.context.oldCardOps) do
		if iter_6_3:isPlayCard() then
			table.remove(var_6_0, iter_6_3.param1)
			arg_6_0:_dealCombineRelation(var_6_0)
		elseif iter_6_3:isMoveCard() then
			FightCardModel.moveOnly(var_6_0, iter_6_3.param1, iter_6_3.param2)
			arg_6_0:_dealCombineRelation(var_6_0)
		elseif iter_6_3:isMoveUniversal() then
			local var_6_1 = var_6_0[iter_6_3.param1]
			local var_6_2 = var_6_0[iter_6_3.param2]

			var_6_2.skillId = FightCardModel.getCombineSkillId(var_6_1, var_6_2, var_6_2)

			table.remove(var_6_0, iter_6_3.param1)
			arg_6_0:_dealCombineRelation(var_6_0)
		end
	end

	return var_6_0
end

function var_0_0._dealCombineRelation(arg_7_0, arg_7_1)
	local var_7_0 = FightCardModel.getCombineIndexOnce(arg_7_1)

	while #arg_7_1 >= 2 and var_7_0 do
		arg_7_1[var_7_0].skillId = FightCardModel.getCombineSkillId(arg_7_1[var_7_0], arg_7_1[var_7_0 + 1])

		table.remove(arg_7_1, var_7_0 + 1)

		var_7_0 = FightCardModel.getCombineIndexOnce(arg_7_1)
	end
end

function var_0_0._matchSkill(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 or not arg_8_2 then
		return false
	end

	if arg_8_1.uid ~= arg_8_2.uid then
		return false
	end

	if arg_8_1.skillId == arg_8_2.skillId then
		return true
	end

	local var_8_0 = FightCardModel.instance:getSkillPrevLvId(arg_8_1.uid, arg_8_1.skillId)

	if var_8_0 then
		if var_8_0 == arg_8_2.skillId then
			return true
		else
			local var_8_1 = FightCardModel.instance:getSkillPrevLvId(arg_8_1.uid, var_8_0)

			if var_8_1 and var_8_1 == arg_8_2.skillId then
				return true
			end
		end
	end

	return false
end

function var_0_0.clearWork(arg_9_0)
	if arg_9_0._flow then
		arg_9_0._flow:stop()
		arg_9_0._flow:unregisterDoneListener(arg_9_0._onWorkDone, arg_9_0)

		arg_9_0._flow = nil
	end
end

function var_0_0._onWorkDone(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.context.playCardItemList) do
		local var_10_0 = iter_10_1.go
		local var_10_1 = gohelper.findChild(var_10_0, "imgEmpty")
		local var_10_2 = gohelper.findChild(var_10_0, "card")
		local var_10_3 = gohelper.findChild(var_10_0, "imgMove")

		gohelper.onceAddComponent(var_10_2, typeof(UnityEngine.CanvasGroup)).alpha = 1
		gohelper.onceAddComponent(var_10_3, typeof(UnityEngine.CanvasGroup)).alpha = 1

		gohelper.setActive(var_10_1, true)
	end

	arg_10_0:onDone(true)
end

return var_0_0
