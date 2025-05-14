module("modules.logic.versionactivity2_2.eliminate.defines.EliminateTeamChessEnum", package.seeall)

local var_0_0 = class("EliminateTeamChessEnum")

var_0_0.TeamChessTeamType = {
	enemy = 2,
	player = 1
}
var_0_0.StepActionType = {
	roundBegin = 0,
	chessSkill = 1,
	strongHoldSkill = 4,
	chessMove = 6,
	placeChess = 3,
	useMainCharacterSkill = 5,
	chessSettle = 2
}
var_0_0.StepEffectType = {
	placeChess = 6
}
var_0_0.ChessPlaceType = {
	activeMove = 1,
	place = 0
}
var_0_0.SoliderSkillType = {
	Die = "Die",
	GrowUp = "GrowUp",
	Raw = "Raw"
}
var_0_0.StepWorkType = {
	removeChess = 10,
	mainCharacterHpChange = 2,
	chessGrowUpChange = 15,
	teamChessBeginViewShow = 10004,
	teamChessCheckRoundState = 10003,
	chessPowerChange = 1,
	strongHoldPowerChange = 9,
	teamChessShowVxEffect = 10005,
	teamChessUpdateForecast = 10006,
	effectNestStruct = 7,
	teamChessFightResult = 10000,
	callChess = 4,
	strongHoldSettle = 11,
	resourceChange = 8,
	mainCharacterPowerChange = 3,
	chessActiveMove = 12,
	chessDie = 5,
	teamChessServerDataDiff = 10001,
	placeChess = 6,
	strongHoldSettleFinish = 13
}
var_0_0.ResourceType = {
	blue = "blue",
	green = "green",
	yellow = "yellow",
	red = "red"
}
var_0_0.ResourceTypeToImagePath = {
	blue = "v2a2_eliminate_chess_energy_quality_02",
	yellow = "v2a2_eliminate_chess_energy_quality_04",
	brown = "v2a2_eliminate_chess_energy_quality_03",
	red = "v2a2_eliminate_chess_energy_quality_05",
	green = "v2a2_eliminate_chess_energy_quality_01"
}
var_0_0.ResourceTypeToCircleImagePath = {
	blue = "v2a2_eliminate_chess_resource_quality_02",
	yellow = "v2a2_eliminate_chess_resource_quality_04",
	brown = "v2a2_eliminate_chess_resource_quality_03",
	red = "v2a2_eliminate_chess_resource_quality_05",
	green = "v2a2_eliminate_chess_resource_quality_01"
}
var_0_0.SoliderChessQualityImage = {
	"v2a2_eliminate_builditem_quality_01",
	"v2a2_eliminate_builditem_quality_02",
	"v2a2_eliminate_builditem_quality_03",
	"v2a2_eliminate_builditem_quality_04",
	"v2a2_eliminate_builditem_quality_05"
}
var_0_0.TeamChessRoundType = {
	settlement = 3,
	enemy = 2,
	player = 1
}
var_0_0.StrongHoldState = {
	enemySide = 2,
	neutral = 3,
	mySide = 1
}
var_0_0.ChessTipType = {
	showSell = 2,
	showDesc = 1,
	showDragTip = 3
}
var_0_0.FightResult = {
	win = 1,
	lose = 2,
	draw = 3,
	notSettlement = 0
}
var_0_0.ResultRewardType = {
	slot = 3,
	character = 1,
	chessPiece = 2
}
var_0_0.placeSkillEffectParamConfigEnum = {
	Move = {
		["8"] = {
			limitStrongHold = false,
			count = 1,
			teamType = var_0_0.TeamChessTeamType.player
		},
		["9"] = {
			limitStrongHold = false,
			count = 1,
			teamType = var_0_0.TeamChessTeamType.player
		},
		["10"] = {
			limitStrongHold = false,
			count = 1,
			teamType = var_0_0.TeamChessTeamType.player
		},
		["11"] = {
			limitStrongHold = false,
			count = 1,
			teamType = var_0_0.TeamChessTeamType.enemy
		}
	},
	PowerDecrease = {
		["1"] = {
			limitStrongHold = true,
			count = 1,
			teamType = var_0_0.TeamChessTeamType.enemy
		},
		["5"] = {
			limitStrongHold = true,
			count = 1,
			teamType = var_0_0.TeamChessTeamType.player
		}
	},
	TriggerRaw = {
		["1"] = {
			limitStrongHold = true,
			count = 1,
			teamType = var_0_0.TeamChessTeamType.player
		}
	},
	Kill = {
		["1"] = {
			limitStrongHold = true,
			count = 1,
			teamType = var_0_0.TeamChessTeamType.enemy
		},
		["2"] = {
			limitStrongHold = true,
			count = 1,
			teamType = var_0_0.TeamChessTeamType.player
		}
	}
}
var_0_0.battleFormatType = {
	["0"] = "<b>%s</b>",
	["1"] = "<color=#18636d>%s</color>",
	["2"] = "<color=#206524>%s</color>",
	["5"] = "<color=#5e3d1d>%s</color>",
	["3"] = "<color=#645501>%s</color>",
	["4"] = "<color=#933f2b>%s</color>"
}
var_0_0.PreBattleFormatType = {
	["0"] = "<b>%s</b>",
	["1"] = "<color=#9ecbeb>%s</color>",
	["2"] = "<color=#addeae>%s</color>",
	["5"] = "<color=#e4b991>%s</color>",
	["3"] = "<color=#ffdc8f>%s</color>",
	["4"] = "<color=#ffa896>%s</color>"
}
var_0_0.ModeType = {
	Gray = 1,
	Outline = 2,
	Normal = 0
}
var_0_0.HpDamageType = {
	Chess = 1,
	GrowUpToChess = 3,
	Character = 2
}
var_0_0.tempPieceUid = 9999
var_0_0.beginViewShowTime = 1.5
var_0_0.addResourceTipTime = 1
var_0_0.teamChessPlaceStep = 0.4
var_0_0.soliderChessOutAniTime = 0.4
var_0_0.StrongHoldBattleVxTime = 1.4
var_0_0.entityMoveTime = 1
var_0_0.teamChessUpdateActiveMoveStepTime = var_0_0.entityMoveTime
var_0_0.powerChangeTime = 1
var_0_0.hpChangeTime = 0.5
var_0_0.hpDamageJumpTime = 1
var_0_0.characterHpDamageFlyTime = 1
var_0_0.characterHpDamageFlyTimeTipHpChange = 0.6
var_0_0.teamChessHpChangeStepTime = var_0_0.hpChangeTime + var_0_0.characterHpDamageFlyTime
var_0_0.teamChessPowerJumpTime = 0.7
var_0_0.teamChessPowerChangeStepTime = 0.7
var_0_0.teamChessWinOpenTime = 1
var_0_0.chessShowMoveStateAniTime = 0.33
var_0_0.teamChessGrowUpChangeStepTime = 0.5
var_0_0.teamChessForecastUpdateStep = 0.45
var_0_0.CharacterHpDamageSize = 80
var_0_0.ChessDamageSize = 32
var_0_0.VxEffectType = {
	PowerUp = "PowerUp",
	StrongHoldBattle = "StrongHoldBattle",
	Die = "Die",
	Move = "Move",
	PowerDown = "PowerDown",
	WangYu = "WangYu",
	ZhanHou = "ZhanHou"
}
var_0_0.VxEffectTypePlayTime = {
	WangYu = 1.5,
	ZhanHou = 0.7,
	StrongHoldBattle = var_0_0.StrongHoldBattleVxTime,
	PowerDown = var_0_0.teamChessPowerChangeStepTime,
	PowerUp = var_0_0.teamChessPowerChangeStepTime
}
var_0_0.VxEffectTypeToPath = {
	Move = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_qianjin_jiantou.prefab",
	StrongHoldBattle = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_fight.prefab",
	PowerUp = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_shuxingzengjia.prefab",
	Die = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_siwang.prefab",
	PowerDown = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_shuxingjiangdi.prefab",
	WangYu = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_wangyu.prefab",
	ZhanHou = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_zhanhou.prefab"
}
var_0_0.powerItemRectPosX = 110
var_0_0.powerItemRectPosY = -10
var_0_0.soliderTipOffsetX = 1
var_0_0.soliderTipOffsetY = 0.9
var_0_0.soliderSellTipOffsetX = 1.4
var_0_0.soliderSellTipOffsetY = 3.1
var_0_0.playerSoliderWatchTipOffsetX = 1.4
var_0_0.playerSoliderWatchTipOffsetY = 2.5
var_0_0.soliderItemTipOffsetX = -1.6
var_0_0.soliderItemTipOffsetY = 2.4
var_0_0.soliderItemDragTipOffsetX = 1.1
var_0_0.soliderItemDragTipOffsetY = 0.9
var_0_0.powerOffsetY = -25
var_0_0.chessMoveOffsetX = 0.9
var_0_0.chessMoveOffsetY = 0.8
var_0_0.teamChessGrowUpToChangePowerStepTime = 0.1
var_0_0.teamChessGrowUpZhanHouStepTime = 0.1
var_0_0.teamChessGrowUpToChangePowerJumpTime = 0.1
var_0_0.teamChessToMatchStepTime = 1
var_0_0.matchToTeamChessStepTime = 0.5

return var_0_0
