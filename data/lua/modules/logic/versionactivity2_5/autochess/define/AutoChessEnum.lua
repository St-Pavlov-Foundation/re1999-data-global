﻿module("modules.logic.versionactivity2_5.autochess.define.AutoChessEnum", package.seeall)

local var_0_0 = _M

var_0_0.ModuleId = {
	PVE = 0,
	PVP = 1
}
var_0_0.PvpEpisodeId = 11010
var_0_0.SpecialMaster = {
	Role37 = 30020
}
var_0_0.MallType = {
	Free = 2,
	Normal = 1
}
var_0_0.ActionType = {
	StartBuy = 8,
	EndBuy = 7,
	ChessSkill = 3,
	RoundStart = 1,
	ChangeSide = 6,
	ChessMove = 4,
	Immediately = 9,
	ChessAct = 2,
	FightData = 10,
	NewStart = 5
}
var_0_0.EffectType = {
	ExpChange = 13,
	NextFightStep = 1,
	FightUpdate = 20,
	LeaderSkillUpdate = 22,
	DelBuff = 10,
	BattleChange = 16,
	LeaderChange = 23,
	ChessMove = 6,
	LeaderHpFloat = 3,
	LeaderHp = 2,
	UpdateBuff = 9,
	Summon = 15,
	CoinChange = 11,
	StarChange = 14,
	UpdateChessPos = 19,
	Explore = 12,
	AddBuff = 8,
	MallUpdate = 17,
	ChessDie = 7,
	ChessHp = 4,
	PlayAttack = 18,
	ChessHpFloat = 5
}
var_0_0.BuildType = {
	Exchange = 1,
	Sell = 2
}
var_0_0.TeamType = {
	Player = 1,
	Enemy = 2
}
var_0_0.WarZone = {
	Two = 2,
	One = 1,
	Three = 3
}
var_0_0.WarZoneType = {
	AutoChessStrEnum.ChessType.Support,
	AutoChessStrEnum.ChessType.Attack
}
var_0_0.ConstKey = {
	ChessSellPrice = 6,
	BoardSize = 1,
	DoubleScoreCnt = 16,
	DoubleScoreRank = 15,
	UnlockLeaderSlot = 12,
	UnlockLeaderRefresh = 13,
	RewardMaxStar = 3
}
var_0_0.FreeZeType = {
	UnFreeze = 2,
	Freeze = 1
}
var_0_0.BoardSize = {
	Row = 3,
	Column = 5
}
var_0_0.ViewType = {
	All = 3,
	Player = 1,
	Enemy = 2
}
var_0_0.TileSize = {
	[var_0_0.ViewType.Player] = {
		Vector2(202, 160),
		Vector2(210, 166),
		(Vector2(217, 180))
	},
	[var_0_0.ViewType.Enemy] = {
		Vector2(202, 160),
		Vector2(210, 166),
		(Vector2(217, 180))
	},
	[var_0_0.ViewType.All] = {
		Vector2(170, 132),
		Vector2(176, 144),
		(Vector2(184, 154))
	}
}
var_0_0.TileStartPos = {
	[var_0_0.ViewType.Player] = {
		Vector2(-377, 256),
		Vector2(-405, 76),
		(Vector2(-432, -102))
	},
	[var_0_0.ViewType.Enemy] = {
		Vector2(-436, 259),
		Vector2(-440, 78),
		(Vector2(-442, -102))
	},
	[var_0_0.ViewType.All] = {
		Vector2(-791, 119),
		Vector2(-820, -40),
		(Vector2(-850, -195))
	}
}
var_0_0.TileOffsetX = {
	[var_0_0.ViewType.Player] = 3,
	[var_0_0.ViewType.Enemy] = 3,
	[var_0_0.ViewType.All] = 6
}
var_0_0.LeaderPos = {
	[var_0_0.ViewType.Player] = {
		[var_0_0.TeamType.Player] = Vector2(-650, 200)
	},
	[var_0_0.ViewType.Enemy] = {
		[var_0_0.TeamType.Enemy] = Vector2(700, 200)
	},
	[var_0_0.ViewType.All] = {
		[var_0_0.TeamType.Player] = Vector2(-770, 316),
		[var_0_0.TeamType.Enemy] = Vector2(770, 316)
	}
}
var_0_0.ChessAniTime = {
	Die = 0.67,
	Attack = 0.5,
	Melee = 0.6,
	Jump = 0.35
}
var_0_0.EffectPos = {
	Vector2(0, -60),
	Vector2(0, 0),
	(Vector2(0, 60))
}
var_0_0.DamageType = {
	Ranged = 2,
	MeleeAoe = 3,
	Melee = 1,
	Skill = 4
}
var_0_0.EffectTag2Id = {
	Die = 10002,
	Raw = 10001,
	BattleFury = 20003,
	Ranged = 20002,
	GrowUp = 10003,
	Melee = 20001
}
var_0_0.ContextType = {
	StartBuy = 2,
	EndBuy = 3,
	Fight = 4,
	Immediately = 1
}
var_0_0.MaterialPath = {
	Player = "ui/materials/dynamic/outlinesprite_lw_ui_01.mat",
	Enemy = "ui/materials/dynamic/outlinesprite_lw_ui_00.mat"
}
var_0_0.ChessEntityPath = "ui/viewres/versionactivity_2_5/autochess/item/autochessentity.prefab"
var_0_0.ChessLeaderEntityPath = "ui/viewres/versionactivity_2_5/autochess/item/autochessleaderentity.prefab"
var_0_0.LeaderItemPath = "ui/viewres/versionactivity_2_5/autochess/item/autochessleaderitem.prefab"
var_0_0.ChessCardPath = "ui/viewres/versionactivity_2_5/autochess/item/autochesscard.prefab"
var_0_0.LeaderCardPath = "ui/viewres/versionactivity_2_5/autochess/item/autochessleadercard.prefab"
var_0_0.BadgeItemPath = "ui/viewres/versionactivity_2_5/autochess/item/autochessbadgeitem.prefab"
var_0_0.LevelItemPath = "ui/viewres/versionactivity_2_5/autochess/item/autochesslevelitem.prefab"

return var_0_0
