module("modules.logic.fight.controller.FightMsgId", package.seeall)

for slot5, slot6 in pairs({
	PlayDouQuQu = GameUtil.getMsgId(),
	SetBossEvolution = GameUtil.getMsgId(),
	RestartGame = GameUtil.getMsgId(),
	PlayTimelineSkill = GameUtil.getMsgId(),
	PlayTimelineSkillFinish = GameUtil.getMsgId(),
	CameraFocusChanged = GameUtil.getMsgId(),
	ReleaseAllEntrustedEntity = GameUtil.getMsgId(),
	SpineLoadFinish = GameUtil.getMsgId(),
	IsEvolutionSkin = GameUtil.getMsgId(),
	ShowDouQuQuXianHouShou = GameUtil.getMsgId(),
	FightProgressValueChange = GameUtil.getMsgId(),
	FightMaxProgressValueChange = GameUtil.getMsgId(),
	FightAct174Reply = GameUtil.getMsgId(),
	Act174MonsterAiCard = GameUtil.getMsgId(),
	MaybeCrashed = GameUtil.getMsgId(),
	GMDouQuQuSkip2IndexRound = GameUtil.getMsgId()
}) do
	-- Nothing
end

slot0.id2Name = {
	[slot6] = slot5
}

return slot0
