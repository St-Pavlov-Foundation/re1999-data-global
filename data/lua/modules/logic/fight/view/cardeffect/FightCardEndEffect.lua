module("modules.logic.fight.view.cardeffect.FightCardEndEffect", package.seeall)

local var_0_0 = class("FightCardEndEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	arg_2_0._dt = var_0_2 / FightModel.instance:getUISpeed()

	local var_2_0 = FightDataHelper.operationDataMgr:getOpList()

	arg_2_0._playCardCount = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if FightCardDataHelper.checkOpAsPlayCardHandle(iter_2_1) then
			arg_2_0._playCardCount = arg_2_0._playCardCount + 1
		end
	end

	FightViewPartVisible.set(true, true, true, false, false)

	arg_2_0._flow = FlowParallel.New()

	arg_2_0._flow:addWork(arg_2_0:_handCardFlow())
	arg_2_0._flow:addWork(arg_2_0:_playCardFlow())
	arg_2_0._flow:registerDoneListener(arg_2_0._onWorkDone, arg_2_0)
	arg_2_0._flow:start()
end

function var_0_0.onStop(arg_3_0)
	if arg_3_0._flow then
		arg_3_0._flow:stop()

		if arg_3_0._cloneItemGOs then
			for iter_3_0, iter_3_1 in ipairs(arg_3_0._cloneItemGOs) do
				gohelper.destroy(iter_3_1)
			end

			arg_3_0._cloneItemGOs = nil
		end
	end

	var_0_0.super.onStop(arg_3_0)
end

function var_0_0._handCardFlow(arg_4_0)
	local var_4_0 = FlowParallel.New()

	arg_4_0._handCardItemGOs = {}

	if arg_4_0._playCardCount > 0 then
		local var_4_1 = arg_4_0.context.handCardContainer
		local var_4_2 = var_4_1.transform.childCount
		local var_4_3 = 1

		for iter_4_0 = var_4_2, 1, -1 do
			local var_4_4 = gohelper.findChild(var_4_1, "cardItem" .. iter_4_0)

			if var_4_4 and var_4_4.activeInHierarchy then
				local var_4_5 = FlowSequence.New()

				var_4_5:addWork(WorkWaitSeconds.New(arg_4_0._dt * var_4_3 * 2))
				var_4_5:addWork(TweenWork.New({
					type = "DOAnchorPosY",
					to = 18,
					tr = var_4_4.transform,
					t = arg_4_0._dt * 6,
					ease = EaseType.InOutSine
				}))
				var_4_5:addWork(TweenWork.New({
					type = "DOAnchorPosY",
					to = -400,
					tr = var_4_4.transform,
					t = arg_4_0._dt * 8,
					ease = EaseType.InOutSine
				}))
				var_4_0:addWork(var_4_5)

				var_4_3 = var_4_3 + 1

				table.insert(arg_4_0._handCardItemGOs, var_4_4)
			end
		end
	else
		local var_4_6 = FightViewHandCard.handCardContainer
		local var_4_7 = FightWorkEffectDistributeCard.handCardScale
		local var_4_8 = FightWorkEffectDistributeCard.getHandCardScaleTime()

		ZProj.TweenHelper.DOScale(var_4_6.transform, var_4_7, var_4_7, var_4_7, var_4_8)
	end

	return var_4_0
end

function var_0_0._playCardFlow(arg_5_0)
	local var_5_0 = FlowSequence.New()

	if FightViewPlayCard.getMaxItemCount() > FightViewPlayCard.VisibleCount then
		var_5_0:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = arg_5_0.context.playCardContainer,
			t = arg_5_0._dt * 15
		}))

		return var_5_0
	end

	var_5_0:addWork(WorkWaitSeconds.New(0.2))

	local var_5_1 = FlowParallel.New()
	local var_5_2 = gohelper.findChild(arg_5_0.context.playCardContainer, "#scroll_cards/Viewport/Content")
	local var_5_3 = var_5_2.transform.childCount

	arg_5_0._playCardItemGOs = {}
	arg_5_0._cloneItemGOs = {}

	local var_5_4 = {}
	local var_5_5 = FightDataHelper.operationDataMgr:getOpList()
	local var_5_6 = ViewMgr.instance:getContainer(ViewName.FightView)

	if var_5_6 then
		local var_5_7 = var_5_6.fightViewPlayCard

		if var_5_7 then
			for iter_5_0, iter_5_1 in ipairs(var_5_5) do
				if FightCardDataHelper.checkOpAsPlayCardHandle(iter_5_1) then
					local var_5_8 = var_5_7:getShowIndex(iter_5_1)

					if var_5_8 then
						var_5_4[var_5_8] = true

						if iter_5_1:needCopyCard() then
							var_5_4[var_5_8 + 1] = true
						end
					else
						local var_5_9 = {}

						for iter_5_2, iter_5_3 in ipairs(var_5_5) do
							table.insert(var_5_9, string.format("{operType : %s, toId : %s, skillId : %s, belongToEntityId : %s, costActPoint: %s}", iter_5_3.operType, iter_5_3.toId, iter_5_3.skillId, iter_5_3.belongToEntityId, iter_5_3.costActPoint))
						end

						local var_5_10 = table.concat(var_5_9, "\n")

						tabletool.clear(var_5_9)

						for iter_5_4, iter_5_5 in ipairs(var_5_7._begin_round_ops) do
							table.insert(var_5_9, string.format("{operType : %s, toId : %s, skillId : %s, belongToEntityId : %s, costActPoint: %s}", iter_5_5.operType, iter_5_5.toId, iter_5_5.skillId, iter_5_5.belongToEntityId, iter_5_5.costActPoint))
						end

						local var_5_11 = table.concat(var_5_9, "\n")

						logError(string.format("get temp_index fail : %s, \n ops : {%s},\n begin_round_ops : {%s}", tostring(var_5_8), var_5_10, var_5_11))
					end
				end
			end
		end
	end

	for iter_5_6 = 1, var_5_3 do
		if var_5_4[iter_5_6] then
			local var_5_12 = gohelper.findChild(var_5_2, "cardItem" .. iter_5_6)

			if var_5_12 then
				local var_5_13 = gohelper.findChild(var_5_12, "card")

				gohelper.setActive(gohelper.findChild(var_5_12, "#go_Grade"), false)
				table.insert(arg_5_0._playCardItemGOs, var_5_13)

				local var_5_14 = gohelper.cloneInPlace(var_5_12)

				table.insert(arg_5_0._cloneItemGOs, var_5_14)
				var_5_14.transform:SetParent(arg_5_0.context.handCardContainer.transform, true)
				gohelper.setActive(gohelper.findChild(var_5_14, "effect1"), false)
				gohelper.setActive(gohelper.findChild(var_5_14, "effect2"), false)
				gohelper.setActive(gohelper.findChild(var_5_12, "lock"), false)
			end
		end
	end

	FightController.instance:dispatchEvent(FightEvent.FixWaitingAreaItemCount, #arg_5_0._playCardItemGOs)

	local var_5_15 = FightModel.instance:getVersion()

	for iter_5_7, iter_5_8 in ipairs(arg_5_0._playCardItemGOs) do
		local var_5_16 = arg_5_0._cloneItemGOs[iter_5_7].transform
		local var_5_17 = gohelper.findChild(arg_5_0.context.waitCardContainer, "cardItem" .. #arg_5_0._playCardItemGOs - iter_5_7 + 1)

		if var_5_15 >= 1 then
			var_5_17 = gohelper.findChild(arg_5_0.context.waitCardContainer, "cardItem" .. iter_5_7)
		end

		local var_5_18 = recthelper.rectToRelativeAnchorPos(var_5_17.transform.position, var_5_16.parent)
		local var_5_19 = FlowSequence.New()
		local var_5_20 = 2

		var_5_19:addWork(WorkWaitSeconds.New(arg_5_0._dt * var_5_20 * iter_5_7))
		var_5_19:addWork(FunctionWork.New(function()
			gohelper.setActive(iter_5_8, false)
		end))

		local var_5_21 = FlowParallel.New()
		local var_5_22 = 1.32

		var_5_21:addWork(TweenWork.New({
			type = "DOScale",
			tr = var_5_16,
			to = var_5_22,
			t = arg_5_0._dt * 5,
			ease = EaseType.easeOutQuad
		}))

		local var_5_23 = 15

		var_5_21:addWork(TweenWork.New({
			type = "DORotate",
			tox = 0,
			toy = 0,
			tr = var_5_16,
			toz = var_5_23,
			t = arg_5_0._dt * 5,
			ease = EaseType.easeOutQuad
		}))
		var_5_19:addWork(var_5_21)

		local var_5_24 = FlowParallel.New()
		local var_5_25 = -107

		var_5_24:addWork(TweenWork.New({
			type = "DOAnchorPos",
			tr = var_5_16,
			tox = var_5_18.x,
			toy = var_5_18.y + var_5_25,
			t = arg_5_0._dt * 10,
			ease = EaseType.OutCubic
		}))
		var_5_24:addWork(TweenWork.New({
			toz = 0,
			type = "DORotate",
			tox = 0,
			toy = 0,
			tr = var_5_16,
			t = arg_5_0._dt * 10,
			ease = EaseType.OutCubic
		}))
		var_5_19:addWork(var_5_24)
		var_5_1:addWork(var_5_19)
	end

	if GMFightShowState.cards then
		var_5_1:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = arg_5_0.context.playCardContainer,
			t = arg_5_0._dt * 15
		}))
	end

	var_5_0:addWork(var_5_1)
	var_5_0:addWork(FightWork2Work.New(FightWorkDetectUseCardSkillId))

	return var_5_0
end

function var_0_0._onWorkDone(arg_7_0)
	arg_7_0._flow:unregisterDoneListener(arg_7_0._onWorkDone, arg_7_0)
	gohelper.setActive(arg_7_0.context.playCardContainer, false)
	gohelper.setActive(arg_7_0.context.waitCardContainer, true)

	if GMFightShowState.cards then
		gohelper.onceAddComponent(arg_7_0.context.playCardContainer, typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	FightViewPartVisible.set(false, false, false, false, true)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._handCardItemGOs) do
		recthelper.setAnchorY(iter_7_1.transform, 0)
	end

	if arg_7_0._playCardItemGOs then
		for iter_7_2, iter_7_3 in ipairs(arg_7_0._playCardItemGOs) do
			recthelper.setAnchor(iter_7_3.transform, 0, 0)
		end
	end

	if arg_7_0._cloneItemGOs then
		for iter_7_4, iter_7_5 in ipairs(arg_7_0._cloneItemGOs) do
			gohelper.destroy(iter_7_5)
		end
	end

	arg_7_0._playCardItemGOs = nil
	arg_7_0._cloneItemGOs = nil

	arg_7_0:onDone(true)
end

return var_0_0
