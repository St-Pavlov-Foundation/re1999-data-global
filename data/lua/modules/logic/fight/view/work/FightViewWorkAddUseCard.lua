module("modules.logic.fight.view.work.FightViewWorkAddUseCard", package.seeall)

slot0 = class("FightViewWorkAddUseCard", BaseWork)

function slot0.onStart(slot0)
	slot1 = 0.16 / FightModel.instance:getUISpeed()
	slot3 = #FightPlayCardModel.instance:getUsedCards()
	slot4 = slot0.context
	slot6 = slot4._startPosX
	slot7 = {
		[tabletool.indexOf(slot2, slot12._cardInfoMO)] = recthelper.getAnchorX(slot12.go.transform.parent)
	}

	for slot11, slot12 in ipairs(slot4._cardItemList) do
		if slot12.go.activeInHierarchy then
			-- Nothing
		end
	end

	slot4:_onSetUseCards()

	slot0._flow = FlowParallel.New()

	for slot11, slot12 in ipairs(slot5) do
		slot13 = slot12.go.transform.parent

		if slot12.go.activeInHierarchy and slot7[slot11] then
			recthelper.setAnchorX(slot13, slot7[slot11])
			slot0._flow:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = slot13,
				to = slot6 - 192 * (slot3 - slot11),
				t = slot1
			}))
		end

		recthelper.setAnchorY(slot13, 150)
	end

	for slot13, slot14 in ipairs(slot5) do
		if slot14.go.activeInHierarchy then
			slot14:hideCardAppearEffect()
			slot14:onCardAniFinish()

			gohelper.onceAddComponent(slot14.go, gohelper.Type_CanvasGroup).alpha = 1

			if slot14._cardInfoMO.CUSTOMADDUSECARD then
				gohelper.onceAddComponent(slot14.go, gohelper.Type_CanvasGroup).alpha = 0

				slot14:playAppearEffect()
				slot14:playCardAni(ViewAnim.FightCardAppear, "fightcard_apper")

				slot16 = FlowSequence.New()

				slot16:addWork(WorkWaitSeconds.New(0.2 / FightModel.instance:getUISpeed()))

				slot17 = slot14.go.transform.parent

				recthelper.setAnchorY(slot17, 300)
				slot16:addWork(TweenWork.New({
					type = "DOAnchorPosY",
					to = 150,
					tr = slot17,
					t = 0.25 / FightModel.instance:getUISpeed(),
					ease = EaseType.OutQuart
				}))
				slot0._flow:addWork(slot16)
			end
		end
	end

	AudioMgr.instance:trigger(20211406)
	slot0._flow:start()
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
