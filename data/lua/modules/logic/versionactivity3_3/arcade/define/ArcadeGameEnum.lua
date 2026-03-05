-- chunkname: @modules/logic/versionactivity3_3/arcade/define/ArcadeGameEnum.lua

module("modules.logic.versionactivity3_3.arcade.define.ArcadeGameEnum", package.seeall)

local ArcadeGameEnum = _M

ArcadeGameEnum.Const = {
	GameSceneResName = "v3a3_m_s12_background_b_p",
	EntityZLevel = -0.1,
	DefaultCharacterTurnTime = 5000,
	EffectZLevel = -0.1,
	MonsterGroupColName = "column",
	DualWieldingCarryWeapon = 2,
	RoomSize = 8,
	AreaNodePortalName = "nodePortal",
	FightFloatWaitTime = 0.1,
	GuideDifficulty = 0,
	HpZLevel = -0.1,
	HpItemResName = "v3a3_m_s12_dj_a01",
	GameSceneAnim = "scenes/dynamic/scene_anim/v3a3_m_s12_arcade_game_scene.controller",
	NormalCarryWeapon = 1,
	RoomMinCoordinateValue = 1,
	MaxDropProbability = 1000,
	SkillBombLongPressTime = 0.5,
	GameSceneName = "ArcadeGameScene",
	MaxGenerateMonsterProbability = 1000,
	DefaultEntityDirection = ArcadeEnum.Direction.Right
}
ArcadeGameEnum.BaseAttr = {
	defense = 102,
	attack = 101,
	hp = 103,
	hpCap = 104
}
ArcadeGameEnum.GameAttribute = {
	AddSkillDamage = 301,
	AddBombDamage = 302,
	GoodsDiscount = 304,
	AddWeaponDurability = 305,
	ResetStoreCost = 306,
	AddBombRange = 303,
	ExtraMonster = 307
}
ArcadeGameEnum.GameSwitch = {
	BombNotAttackSelf = 401,
	DualWielding = 403,
	BombAddBurning = 404,
	CanResetStore = 402
}
ArcadeGameEnum.PlayerActType = {
	Move = 1,
	Attack = 2,
	UseBomb = 4,
	UseSkill = 3,
	None = 0
}
ArcadeGameEnum.DropItemType = {
	Collection = 2,
	Character = 3,
	Resource = 1
}
ArcadeGameEnum.CharacterResource = {
	Score = 205,
	Diamond = 202,
	GameCoin = 201,
	SkillEnergy = 203,
	Bomb = 204,
	RespawnTimes = 206,
	Cassette = 207
}
ArcadeGameEnum.CollectionType = {
	Weapon = "weapon",
	Jewelry = "jewelry"
}
ArcadeGameEnum.AttackType = {
	Bomb = 4,
	Skill = 3,
	Link = 2,
	Normal = 1
}
ArcadeGameEnum.RoomType = {
	Reward = "reward",
	Store = "store",
	Boss = "boss",
	Elite = "elite",
	Rest = "rest",
	Event = "event",
	Normal = "normal"
}
ArcadeGameEnum.RoomTypeCls = {
	[ArcadeGameEnum.RoomType.Normal] = ArcadeNormalRoom,
	[ArcadeGameEnum.RoomType.Store] = ArcadeStoreRoom,
	[ArcadeGameEnum.RoomType.Boss] = ArcadeBossRoom,
	[ArcadeGameEnum.RoomType.Elite] = ArcadeNormalRoom,
	[ArcadeGameEnum.RoomType.Reward] = ArcadeNormalRoom,
	[ArcadeGameEnum.RoomType.Event] = ArcadeInteractRoom,
	[ArcadeGameEnum.RoomType.Rest] = ArcadeInteractRoom
}
ArcadeGameEnum.RoomDropMethodType = {
	Fixed = "fixed",
	Random = "random"
}
ArcadeGameEnum.EventOptionType = {
	TriggerPassiveSkill = "triggerPassiveSkill",
	NextArea = "enterNextArea",
	ChangeRoom = "transmitRoom",
	Buy = "buy"
}
ArcadeGameEnum.EventOptionHandler = {
	[ArcadeGameEnum.EventOptionType.ChangeRoom] = ArcadeGameHelper._eventChangeRoom,
	[ArcadeGameEnum.EventOptionType.NextArea] = ArcadeGameHelper._eventNextArea,
	[ArcadeGameEnum.EventOptionType.Buy] = ArcadeGameHelper._eventBuy,
	[ArcadeGameEnum.EventOptionType.TriggerPassiveSkill] = ArcadeGameHelper._eventTriggerPassiveSkill
}
ArcadeGameEnum.EventOptionConditionCheck = {
	CheckCollection = "checkHaveCollection",
	CheckAttribute = "checkAttrValue"
}
ArcadeGameEnum.EventOptionConditionCheck = {
	[ArcadeGameEnum.EventOptionConditionCheck.CheckAttribute] = ArcadeGameHelper._checkAttribute,
	[ArcadeGameEnum.EventOptionConditionCheck.CheckCollection] = ArcadeGameHelper._checkCollection
}
ArcadeGameEnum.EntityType = {
	BaseInteractive = "baseInteractive",
	Grid = "grid",
	Character = "character",
	Floor = "floor",
	Bomb = "bomb",
	Portal = "portal",
	Monster = "monster",
	Goods = "goods"
}
ArcadeGameEnum.EntityTypeNotOccupyDict = {
	[ArcadeGameEnum.EntityType.Floor] = true
}
ArcadeGameEnum.HandBookType = {
	Floor = 3,
	Collection = 2,
	Character = 1,
	Monster = 4
}
ArcadeGameEnum.EntityTypeMOCls = {
	[ArcadeGameEnum.EntityType.Character] = ArcadeGameCharacterMO,
	[ArcadeGameEnum.EntityType.Monster] = ArcadeGameMonsterMO,
	[ArcadeGameEnum.EntityType.Bomb] = ArcadeGameBombMO,
	[ArcadeGameEnum.EntityType.BaseInteractive] = ArcadeGameBaseInteractiveMO,
	[ArcadeGameEnum.EntityType.Portal] = ArcadeGameBaseInteractiveMO,
	[ArcadeGameEnum.EntityType.Goods] = ArcadeGameGoodsMO,
	[ArcadeGameEnum.EntityType.Floor] = ArcadeGameFloorMO
}
ArcadeGameEnum.EntityTypeCls = {
	[ArcadeGameEnum.EntityType.Character] = ArcadeGameCharacterEntity,
	[ArcadeGameEnum.EntityType.Monster] = ArcadeGameMonsterEntity,
	[ArcadeGameEnum.EntityType.Bomb] = ArcadeGameBombEntity,
	[ArcadeGameEnum.EntityType.BaseInteractive] = ArcadeGameBaseInteractiveEntity,
	[ArcadeGameEnum.EntityType.Portal] = ArcadeGamePortalEntity,
	[ArcadeGameEnum.EntityType.Goods] = ArcadeGameGoodsEntity,
	[ArcadeGameEnum.EntityType.Floor] = ArcadeGameFloorEntity
}
ArcadeGameEnum.MonsterRace = {
	Boss = "boss"
}
ArcadeGameEnum.MoveType = {
	NoDrop = "noDrop",
	NormalDrop = "normalDrop"
}
ArcadeGameEnum.TriggerPoint = {
	Character801 = 801,
	HitBefor202 = 202,
	Monster804 = 804,
	EnterRoom = 10,
	Character803 = 803,
	Character813 = 813,
	Monster814 = 814,
	Monster802 = 802,
	Atk203 = 203,
	AtkBefor201 = 201,
	Death702 = 702,
	Bomb502 = 502,
	Monster805 = 805,
	DeathAtfer712 = 712,
	Death701 = 701,
	Character811 = 811,
	MoveEnd302 = 302,
	MoveEnd = 301,
	DeathAtfer720 = 720,
	GameStart = 1,
	Collection501 = 501,
	Monster812 = 812,
	HitBefor251 = 251,
	Hit204 = 204,
	None = 0
}
ArcadeGameEnum.SortType = {
	DownUpLeftRight = 1
}
ArcadeGameEnum.TriggerPoint2SortType = {
	[ArcadeGameEnum.TriggerPoint.Monster802] = ArcadeGameEnum.SortType.DownUpLiftRight,
	[ArcadeGameEnum.TriggerPoint.Monster804] = ArcadeGameEnum.SortType.DownUpLiftRight,
	[ArcadeGameEnum.TriggerPoint.Monster812] = ArcadeGameEnum.SortType.DownUpLiftRight,
	[ArcadeGameEnum.TriggerPoint.Monster814] = ArcadeGameEnum.SortType.DownUpLiftRight
}
ArcadeGameEnum.AttrType = {
	GameSwitch = 4,
	Attack = 1,
	GameAttr = 3,
	Resource = 2
}
ArcadeGameEnum.BuffEffectParam = {
	NotBeAttack_1 = "NotBeAttack_1",
	NotBeAttack_3 = "NotBeAttack_3",
	StopMove = "StopMove",
	NotBeCountered = "NotBeCountered",
	NotBeAttack_2 = "NotBeAttack_2",
	NotBeAttack_4 = "NotBeAttack_4"
}
ArcadeGameEnum.TriggerCfgKeys = {
	Condition = {
		"condition1",
		"condition2",
		"condition3",
		"condition4",
		"condition5"
	},
	Effect = {
		"effect1",
		"effect2",
		"effect3",
		"effect4",
		"effect5"
	},
	TriggerPoint = {
		"triggerPoint1",
		"triggerPoint2",
		"triggerPoint3",
		"triggerPoint4",
		"triggerPoint5"
	},
	Limit = {
		"limit1",
		"limit2",
		"limit3",
		"limit4",
		"limit5"
	},
	EffectId = {
		"effectId1",
		"effectId2",
		"effectId3",
		"effectId4",
		"effectId5"
	},
	AtkEffectId = {
		"atkEffectId1",
		"atkEffectId2",
		"atkEffectId3",
		"atkEffectId4",
		"atkEffectId5"
	}
}
ArcadeGameEnum.ActionShowId = {
	Remove = 6,
	BaseAttack = 3,
	AddHp = 8,
	BombWarn = 15,
	GainBuff = 13,
	Born = 1,
	BombAttack = 9,
	EnterDead = 5,
	ActiveSkillHit = 12,
	ActiveSkill = 11,
	DropCoin = 16,
	Interactive = 17,
	BombExposeRange = 14,
	BombHit = 7,
	Respawn = 10,
	BaseHit = 4,
	Move = 2
}
ArcadeGameEnum.StateShowId = {
	Idle = 1,
	Dead = 2
}
ArcadeGameEnum.SettleType = {
	Abandon = 1,
	Fail = 3,
	Win = 2
}
ArcadeGameEnum.TalkTriggerType = {
	EnterRoom = "3",
	BeBombAttack = "5",
	Interactive = "4",
	Near = "2"
}
ArcadeGameEnum.MaxSkillTriggerCount = 500
ArcadeGameEnum.PrintLog = false
ArcadeGameEnum.FloorIceID = 102

return ArcadeGameEnum
