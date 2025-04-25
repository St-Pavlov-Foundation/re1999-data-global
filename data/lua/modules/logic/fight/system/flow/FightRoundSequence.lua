module("modules.logic.fight.system.flow.FightRoundSequence", package.seeall)

slot0 = class("FightRoundSequence", BaseFightSequence)

function slot0.buildFlow(slot0, slot1)
	uv0.super.buildFlow(slot0)

	slot0.roundMO = slot1

	slot0:buildRoundFlows()
end

function slot0.stop(slot0)
	uv0.super.stop(slot0)

	if slot0._skillFlowList then
		for slot4, slot5 in ipairs(slot0._skillFlowList) do
			slot5:stopSkillFlow()
		end
	end
end

slot0.roundTempData = {}

function slot0.buildRoundFlows(slot0)
	uv0.roundTempData = {}

	slot0:addWork(WorkWaitSeconds.New(0.01))
	slot0:addWork(FightWork2Work.New(FightWorkDialogueBeforeRoundStart))
	slot0:addWork(FightWorkRoundStart.New())

	slot1, slot0._skillFlowList = FightStepBuilder.buildStepWorkList(slot0.roundMO and slot0.roundMO.fightStepMOs)

	if not slot1 or #slot1 == 0 then
		return
	end

	slot3 = 1

	while slot3 <= #slot1 do
		slot3 = slot3 + 1

		slot0:addWork(slot1[slot3])
	end

	slot0:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
	slot0:addWork(FightWorkWaitForSkillsDone.New(slot0._skillFlowList))
	slot0:addWork(FightWorkRoundEnd.New())
	slot0:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))

	if not FightModel.instance:isFinish() then
		if FightModel.instance:getVersion() < 4 then
			slot0:addWork(FightWorkDistributeCard.New())
			slot0:addWork(FunctionWork.New(function ()
				FightController.instance:setCurStage(FightEnum.Stage.Play)
			end))
		end

		slot5, slot6 = FightStepBuilder.buildStepWorkList(slot0.roundMO and slot0.roundMO.nextRoundBeginStepMOs)

		if slot5 and #slot5 > 0 then
			for slot10, slot11 in ipairs(slot5) do
				slot0:addWork(slot11)
			end
		end

		slot0:addWork(FightWorkShowRoundView.New())
		slot0:addWork(FunctionWork.New(function ()
			GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)
			GameSceneMgr.instance:getCurScene().camera:resetParam()
		end))
		slot0:addWork(FightWorkShowBuffDialog.New())
		slot0:addWork(FightWorkCorrectData.New())
	end

	slot0:addWork(FightWorkClearAfterRound.New())
	slot0:addWork(FunctionWork.New(function ()
		FightDataMgr.instance:afterPlayRoundProto(FightDataModel.instance.cacheRoundProto)
	end))
	slot0:addWork(FightWorkCompareDataAfterPlay.New())
	slot0:addWork(FunctionWork.New(slot0._refreshPosition, slot0))
end

function slot0._refreshPosition(slot0)
	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		slot6:resetStandPos()

		if slot6.nameUI then
			slot6.nameUI._nameUIVisible = true

			slot6.nameUI:setActive(true)
		end
	end
end

return slot0
