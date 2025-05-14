module("modules.logic.fight.controller.FightMsgId", package.seeall)

local var_0_0 = {
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
	AfterInitDataMgrRef = GameUtil.getMsgId(),
	AddHandCardWork = GameUtil.getMsgId(),
	Distribute1Card = GameUtil.getMsgId(),
	Distribute2Card = GameUtil.getMsgId(),
	SimulateAddExPoint = GameUtil.getMsgId(),
	PlayCard = GameUtil.getMsgId(),
	RequestOperation = GameUtil.getMsgId(),
	CancelOperation = GameUtil.getMsgId(),
	MoveCard = GameUtil.getMsgId(),
	DragCard = GameUtil.getMsgId(),
	DragCardEnd = GameUtil.getMsgId(),
	LongPressCardEnd = GameUtil.getMsgId(),
	CardFly2OperateView = GameUtil.getMsgId(),
	DiscardHandCardAfterPlayCard = GameUtil.getMsgId(),
	RefreshPlayerFinisherSkill = GameUtil.getMsgId(),
	RefreshSimplePolarizationLevel = GameUtil.getMsgId(),
	RefreshAllHandCardItemName = GameUtil.getMsgId(),
	GetUIHandCardDataList = GameUtil.getMsgId(),
	SetHandCardScale = GameUtil.getMsgId(),
	CheckAliveOperationWork = GameUtil.getMsgId(),
	PlayAtOperationView = GameUtil.getMsgId(),
	RegistPlayAtOperationView = GameUtil.getMsgId(),
	EntrustFightWork = GameUtil.getMsgId(),
	GMDouQuQuSkip2IndexRound = GameUtil.getMsgId()
}
local var_0_1 = {}

for iter_0_0, iter_0_1 in pairs(var_0_0) do
	var_0_1[iter_0_1] = iter_0_0
end

var_0_0.id2Name = var_0_1

return var_0_0
