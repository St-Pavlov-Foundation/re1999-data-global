module("modules.logic.versionactivity2_2.eliminate.defines.EliminateEnum", package.seeall)

slot0 = class("EliminateEnum")
slot0.ChessState = {
	Selected = 1,
	Die = 2,
	Normal = 0
}
slot0.StepWorkType = {
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
slot0.EffectType = {
	exchange_2 = 3,
	crossEliminate = 0,
	exchange_1 = 2,
	blockEliminate = 1
}
slot0.ChessBoardType = {
	Normal = 0,
	Empty = -1
}
slot0.RoundType = {
	Match3Chess = 0,
	TeamChess = 1
}
slot0.GetInfoType = {
	All = 0,
	OnlyMovePint = 1
}
slot0.AnimType = {
	drop = 1,
	init = 0,
	move = 2
}
slot0.AudioFightStep = {
	FightNormal = 1,
	ComeShow = 0,
	Victory = 2
}
slot0.ConditionType = {
	SettleAndToHaveDamage = "SettleAndToHaveDamage",
	TeamChessRoundBegin = "TeamChessRoundBegin",
	ClickMainCharacter = "ClickMainCharacter",
	MatchEvaluateViewClosed = "MatchEvaluateViewClosed",
	TeamChessEnemyPlaceBefore = "TeamChessEnemyPlaceBefore",
	MatchRoundBegin = "MatchRoundBegin"
}
slot0.ChessMaxRowValue = 7
slot0.ChessMaxLineValue = 6
slot0.ChessWidth = 124
slot0.ChessHeight = 124
slot0.AniTime = {
	Die = EliminateConfig.instance:getConstValue(24) / 1000,
	Move = EliminateConfig.instance:getConstValue(21) / 1000,
	MoveRevert = EliminateConfig.instance:getConstValue(22) / 1000,
	Drop = EliminateConfig.instance:getConstValue(23) / 1000,
	InitDrop = EliminateConfig.instance:getConstValue(28) / 1000
}
slot0.DotMoveTipInterval = EliminateConfig.instance:getConstValue(27) / 1000
slot0.ShowStartTime = EliminateConfig.instance:getConstValue(25) / 1000
slot0.ShowEndTime = EliminateConfig.instance:getConstValue(26) / 1000
slot0.ResourceFlyTime = EliminateConfig.instance:getConstValue(31) / 1000
slot0.DieToFlyOffsetTime = EliminateConfig.instance:getConstValue(32) / 1000
slot0.DieStepTime = EliminateConfig.instance:getConstValue(33) / 1000
slot0.ChessDropAngleThreshold = EliminateConfig.instance:getConstValue(29)
slot0.ShowEvaluateTime = EliminateConfig.instance:getConstValue(37) / 1000
slot0.chessFrameBgMaxWidth = 1140
slot0.chessFrameBgMaxHeight = 900
slot0.teamChessDescTipOffsetX = -140
slot0.teamChessDescTipOffsetY = -220
slot0.teamChessDescMinAnchorX = -737
slot0.levelTargetTipShowTime = EliminateConfig.instance:getConstValue(30) / 1000
slot0.levelTargetTipShowTimeInTeamChess = 0.5
slot0.dieEffectCacheCount = 30
slot0.damageCacheCount = 10
slot0.hpDamageCacheCount = 10

return slot0
