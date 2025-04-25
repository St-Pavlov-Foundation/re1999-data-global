module("modules.logic.fight.view.FightViewAssistBoss", package.seeall)

slot0 = class("FightViewAssistBoss", BaseView)

function slot0.onInitView(slot0)
	slot0.goAssistBossContainer = gohelper.findChild(slot0.viewGO, "root/assistboss")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.assistBossId2Behaviour = {
		FightAssistBoss1,
		FightAssistBoss2,
		FightAssistBoss3,
		FightAssistBoss4,
		FightAssistBoss5
	}
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	if not FightDataHelper.fieldMgr:isPaTa() then
		return
	end

	gohelper.setActive(slot0.goAssistBossContainer, true)
	slot0:createAssistBossBehaviour()
	slot0:createAssistBossScore()
end

function slot0.createAssistBossBehaviour(slot0)
	if not FightDataHelper.entityMgr:getAssistBoss() then
		return
	end

	if slot0.bossBehaviour then
		slot0.bossBehaviour:refreshUI()

		return
	end

	if not slot0.assistBossId2Behaviour[slot1.modelId] then
		logError(string.format("boss id : %s, 没有对应的处理逻辑", slot2))

		slot3 = FightAssistBoss0
	end

	slot0.bossBehaviour = slot3.New()

	slot0.bossBehaviour:init(slot0.goAssistBossContainer)
end

function slot0.createAssistBossScore(slot0)
	if not FightDataHelper.fieldMgr:isTowerLimited() then
		return
	end

	if slot0.scoreComp then
		slot0.scoreComp:refreshScore()

		return
	end

	slot0.scoreComp = FightAssistBossScoreView.New()

	slot0.scoreComp:init(slot0.goAssistBossContainer)
end

function slot0.onDestroyView(slot0)
	if slot0.bossBehaviour then
		slot0.bossBehaviour:destroy()

		slot0.bossBehaviour = nil
	end

	if slot0.scoreComp then
		slot0.scoreComp:destroy()

		slot0.scoreComp = nil
	end
end

return slot0
