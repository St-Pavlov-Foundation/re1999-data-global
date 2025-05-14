module("modules.logic.versionactivity2_2.eliminate.defines.EliminateEnum", package.seeall)

local var_0_0 = class("EliminateEnum")

var_0_0.ChessState = {
	Selected = 1,
	Die = 2,
	Normal = 0
}
var_0_0.StepWorkType = {
	StartShowView = 5,
	PlayAudio = 9,
	RefreshEliminate = 10,
	HandleData = 3,
	Die = 1,
	Arrange = 2,
	ShowEvaluate = 7,
	PlayEffect = 8,
	Debug = 4,
	EndShowView = 6,
	Move = 0
}
var_0_0.EffectType = {
	exchange_2 = 3,
	crossEliminate = 0,
	exchange_1 = 2,
	blockEliminate = 1
}
var_0_0.ChessBoardType = {
	Normal = 0,
	Empty = -1
}
var_0_0.RoundType = {
	Match3Chess = 0,
	TeamChess = 1
}
var_0_0.GetInfoType = {
	All = 0,
	OnlyMovePint = 1
}
var_0_0.AnimType = {
	drop = 1,
	init = 0,
	move = 2
}
var_0_0.AudioFightStep = {
	FightNormal = 1,
	ComeShow = 0,
	Victory = 2
}
var_0_0.ConditionType = {
	SettleAndToHaveDamage = "SettleAndToHaveDamage",
	TeamChessRoundBegin = "TeamChessRoundBegin",
	ClickMainCharacter = "ClickMainCharacter",
	MatchEvaluateViewClosed = "MatchEvaluateViewClosed",
	TeamChessEnemyPlaceBefore = "TeamChessEnemyPlaceBefore",
	MatchRoundBegin = "MatchRoundBegin"
}
var_0_0.ChessMaxRowValue = 7
var_0_0.ChessMaxLineValue = 6
var_0_0.ChessWidth = 124
var_0_0.ChessHeight = 124
var_0_0.AniTime = {
	Die = EliminateConfig.instance:getConstValue(24) / 1000,
	Move = EliminateConfig.instance:getConstValue(21) / 1000,
	MoveRevert = EliminateConfig.instance:getConstValue(22) / 1000,
	Drop = EliminateConfig.instance:getConstValue(23) / 1000,
	InitDrop = EliminateConfig.instance:getConstValue(28) / 1000
}
var_0_0.DotMoveTipInterval = EliminateConfig.instance:getConstValue(27) / 1000
var_0_0.ShowStartTime = EliminateConfig.instance:getConstValue(25) / 1000
var_0_0.ShowEndTime = EliminateConfig.instance:getConstValue(26) / 1000
var_0_0.ResourceFlyTime = EliminateConfig.instance:getConstValue(31) / 1000
var_0_0.DieToFlyOffsetTime = EliminateConfig.instance:getConstValue(32) / 1000
var_0_0.DieStepTime = EliminateConfig.instance:getConstValue(33) / 1000
var_0_0.ChessDropAngleThreshold = EliminateConfig.instance:getConstValue(29)
var_0_0.ShowEvaluateTime = EliminateConfig.instance:getConstValue(37) / 1000
var_0_0.chessFrameBgMaxWidth = 1140
var_0_0.chessFrameBgMaxHeight = 900
var_0_0.teamChessDescTipOffsetX = -140
var_0_0.teamChessDescTipOffsetY = -220
var_0_0.teamChessDescMinAnchorX = -737
var_0_0.levelTargetTipShowTime = EliminateConfig.instance:getConstValue(30) / 1000
var_0_0.levelTargetTipShowTimeInTeamChess = 0.5
var_0_0.dieEffectCacheCount = 30
var_0_0.damageCacheCount = 10
var_0_0.hpDamageCacheCount = 10

return var_0_0
