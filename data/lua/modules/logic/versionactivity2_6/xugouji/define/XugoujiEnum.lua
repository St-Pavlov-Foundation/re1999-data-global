module("modules.logic.versionactivity2_6.xugouji.define.XugoujiEnum", package.seeall)

local var_0_0 = _M

var_0_0.LevelType = {
	Level = 2,
	Story = 1
}
var_0_0.ResultEnum = {
	Completed = 1,
	PowerUseup = 2,
	Quit = 3
}
var_0_0.GameViewState = {
	PlayerOperating = 1,
	PlayerOperaEnd = 3,
	PlayerOperaDisplay = 2,
	EnemyOperating = 4,
	GameEnd = 7,
	EnemyOperaDisplay = 5,
	EnemyOperaEnd = 6
}
var_0_0.DefaultOperateTime = 2
var_0_0.ResultType = {
	TimeOut = 3,
	Lose = 2,
	Win = 1
}
var_0_0.resultStatUse = {
	"成功",
	"失败",
	"回合耗尽"
}
var_0_0.GameStepType = {
	UpdateInitialCard = 102,
	UpdateCardEffectStatus = 9,
	WaitGameStart = 101,
	HpUpdate = 2,
	GameReStart = 103,
	OperateNumUpdate = 7,
	NewCards = 4,
	BuffUpdate = 8,
	Result = 3,
	UpdateCardStatus = 1,
	ChangeTurn = 5,
	GotCardPair = 6
}
var_0_0.GameStatus = {
	UnOperatable = 2,
	Operatable = 1
}
var_0_0.CardType = {
	Immediate = 2,
	Attack = 0,
	Func = 1
}
var_0_0.CardStatus = {
	Disappear = 3,
	Back = 1,
	Front = 2
}
var_0_0.CardEffectStatus = {
	PerspectiveEnemy = 2,
	Perspective = 1,
	Lock = 3,
	LockEnemy = 4
}
var_0_0.BuffType = {
	Round = 2,
	Layer = 1,
	None = 0
}
var_0_0.FirstEpisodeId = 20002
var_0_0.ChallengeEpisodeId = 20013
var_0_0.TaskMOAllFinishId = -100

return var_0_0
