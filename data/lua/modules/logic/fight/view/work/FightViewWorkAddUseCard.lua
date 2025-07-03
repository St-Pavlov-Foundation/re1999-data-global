module("modules.logic.fight.view.work.FightViewWorkAddUseCard", package.seeall)

local var_0_0 = class("FightViewWorkAddUseCard", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = 0.16 / FightModel.instance:getUISpeed()
	local var_1_1 = FightPlayCardModel.instance:getUsedCards()
	local var_1_2 = #var_1_1
	local var_1_3 = arg_1_0.context
	local var_1_4 = var_1_3._cardItemList
	local var_1_5 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_4) do
		if iter_1_1.go.activeInHierarchy then
			var_1_5[tabletool.indexOf(var_1_1, iter_1_1._cardInfoMO)] = recthelper.getAnchorX(iter_1_1.go.transform.parent)
		end
	end

	var_1_3:_onSetUseCards()

	arg_1_0._flow = FlowParallel.New()

	for iter_1_2, iter_1_3 in ipairs(var_1_4) do
		local var_1_6 = iter_1_3.go.transform.parent

		if iter_1_3.go.activeInHierarchy and var_1_5[iter_1_2] then
			recthelper.setAnchorX(var_1_6, var_1_5[iter_1_2])

			local var_1_7 = FightViewWaitingAreaVersion1.getCardPos(iter_1_2, var_1_2)

			arg_1_0._flow:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = var_1_6,
				to = var_1_7,
				t = var_1_0
			}))
		end

		recthelper.setAnchorY(var_1_6, 150)
	end

	local var_1_8 = 0.2 / FightModel.instance:getUISpeed()
	local var_1_9 = 0.25 / FightModel.instance:getUISpeed()

	for iter_1_4, iter_1_5 in ipairs(var_1_4) do
		if iter_1_5.go.activeInHierarchy then
			iter_1_5:hideCardAppearEffect()
			iter_1_5:onCardAniFinish()

			gohelper.onceAddComponent(iter_1_5.go, gohelper.Type_CanvasGroup).alpha = 1

			local var_1_10 = iter_1_5._cardInfoMO

			if var_1_10.CUSTOMADDUSECARD then
				gohelper.onceAddComponent(iter_1_5.go, gohelper.Type_CanvasGroup).alpha = 0

				if arg_1_0:checkCanPlayAppearEffect(var_1_10) then
					iter_1_5:playAppearEffect()
				end

				iter_1_5:playCardAni(ViewAnim.FightCardAppear, "fightcard_apper")
				iter_1_5:tryPlayAlfEffect()

				local var_1_11 = FlowSequence.New()

				var_1_11:addWork(WorkWaitSeconds.New(var_1_8))

				local var_1_12 = iter_1_5.go.transform.parent

				recthelper.setAnchorY(var_1_12, 300)
				var_1_11:addWork(TweenWork.New({
					type = "DOAnchorPosY",
					to = 150,
					tr = var_1_12,
					t = var_1_9,
					ease = EaseType.OutQuart
				}))
				arg_1_0._flow:addWork(var_1_11)
			end
		end
	end

	arg_1_0._flow:addWork(FunctionWork.New(arg_1_0._clearSign, arg_1_0))
	AudioMgr.instance:trigger(20211406)
	arg_1_0._flow:start()
end

function var_0_0.checkCanPlayAppearEffect(arg_2_0, arg_2_1)
	if FightHelper.isASFDSkill(arg_2_1.skillId) then
		return false
	end

	if arg_2_1.clientData.custom_fromSkillId and FightHeroALFComp.ALFSkillDict[arg_2_1.clientData.custom_fromSkillId] then
		return false
	end

	return true
end

function var_0_0._clearSign(arg_3_0)
	local var_3_0 = FightPlayCardModel.instance:getUsedCards()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		iter_3_1.CUSTOMADDUSECARD = nil
	end
end

function var_0_0._delayDone(arg_4_0)
	return
end

function var_0_0.clearWork(arg_5_0)
	if arg_5_0._flow then
		arg_5_0._flow:stop()

		arg_5_0._flow = nil
	end
end

return var_0_0
