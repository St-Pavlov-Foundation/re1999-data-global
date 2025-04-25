module("modules.logic.fight.view.work.FightViewWorkAddUseCard", package.seeall)

slot0 = class("FightViewWorkAddUseCard", BaseWork)

function slot0.onStart(slot0)
	slot1 = 0.16 / FightModel.instance:getUISpeed()
	slot3 = #FightPlayCardModel.instance:getUsedCards()
	slot6 = {
		[tabletool.indexOf(slot2, slot11._cardInfoMO)] = recthelper.getAnchorX(slot11.go.transform.parent)
	}

	for slot10, slot11 in ipairs(slot0.context._cardItemList) do
		if slot11.go.activeInHierarchy then
			-- Nothing
		end
	end

	slot4:_onSetUseCards()

	slot0._flow = FlowParallel.New()

	for slot10, slot11 in ipairs(slot5) do
		slot12 = slot11.go.transform.parent

		if slot11.go.activeInHierarchy and slot6[slot10] then
			recthelper.setAnchorX(slot12, slot6[slot10])
			slot0._flow:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = slot12,
				to = FightViewWaitingAreaVersion1.getCardPos(slot10, slot3),
				t = slot1
			}))
		end

		recthelper.setAnchorY(slot12, 150)
	end

	slot7 = 0.2 / FightModel.instance:getUISpeed()
	slot8 = 0.25 / FightModel.instance:getUISpeed()

	for slot12, slot13 in ipairs(slot5) do
		if slot13.go.activeInHierarchy then
			slot13:hideCardAppearEffect()
			slot13:onCardAniFinish()

			gohelper.onceAddComponent(slot13.go, gohelper.Type_CanvasGroup).alpha = 1

			if slot13._cardInfoMO.CUSTOMADDUSECARD then
				gohelper.onceAddComponent(slot13.go, gohelper.Type_CanvasGroup).alpha = 0

				if not FightHelper.isASFDSkill(slot14.skillId) then
					slot13:playAppearEffect()
				end

				slot13:playCardAni(ViewAnim.FightCardAppear, "fightcard_apper")

				slot15 = FlowSequence.New()

				slot15:addWork(WorkWaitSeconds.New(slot7))

				slot16 = slot13.go.transform.parent

				recthelper.setAnchorY(slot16, 300)
				slot15:addWork(TweenWork.New({
					type = "DOAnchorPosY",
					to = 150,
					tr = slot16,
					t = slot8,
					ease = EaseType.OutQuart
				}))
				slot0._flow:addWork(slot15)
			end
		end
	end

	slot0._flow:addWork(FunctionWork.New(slot0._clearSign, slot0))
	AudioMgr.instance:trigger(20211406)
	slot0._flow:start()
end

function slot0._clearSign(slot0)
	for slot5, slot6 in ipairs(FightPlayCardModel.instance:getUsedCards()) do
		slot6.CUSTOMADDUSECARD = nil
	end
end

function slot0._delayDone(slot0)
end

function slot0.clearWork(slot0)
	if slot0._flow then
		slot0._flow:stop()

		slot0._flow = nil
	end
end

return slot0
