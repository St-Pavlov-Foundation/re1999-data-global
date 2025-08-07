module("modules.logic.sp01.assassin2.define.AssassinEnum", package.seeall)

local var_0_0 = _M

var_0_0.ConstId = {
	DialogId_EyeGame = 9,
	FocusEpisodeId = 17,
	RequireAssassinHeroId = 4,
	EpisodeId_PointGame = 8,
	AttachedEpisodeIds = 16,
	QuestMapTweenTime = 12,
	EpisodeId_EyeGame = 6,
	MapSize = 3,
	DialogId_PointGame = 11,
	StealthGameGridPoint = 5,
	MaxBagCapacity = 2,
	AfterStoryId_EyeGame = 13,
	AfterStoryId_PointGame = 15,
	AfterStoryId_LineGame = 14,
	DialogId_LineGame = 10,
	EpisodeId_LineGame = 7
}
var_0_0.Const = {
	EmptyAssassinItemType = 0,
	MapQuestMaxProgress = 1
}
var_0_0.BlockKey = {
	FinishMission = "AssassinStealthGameFinishMission",
	ClosingLoginView = "AssassinClosingLoginView",
	SelectedEnemy = "AssassinStealthGameSelectEnemy",
	PlayAttackEff = "AssassinStealthGamePlayAttackEff",
	EnterStealthGameEff = "AssassinEnterStealthGameEff",
	EnemyOperation = "AssassinStealthGameEnemyOperation",
	QuestMapTween = "AssassinQuestMapTween",
	LoadGameRes = "AssassinStealthGameLoadResBlockKey",
	PlayRoundAnim = "AssassinStealthGamePlayRoundAnim",
	TweenMapPos = "AssassinStealthGameTweenMapPos",
	EnemyScanEffPlaying = "AssassinStealthGameEnemyScanEffPlaying"
}
var_0_0.MapStatus = {
	Finished = 3,
	Locked = 1,
	Unlocked = 2
}
var_0_0.QuestType = {
	Fight = 1,
	Stealth = 3,
	Dialog = 2
}
var_0_0.PlayerCacheDataKey = {
	AssassinHeroGroupCache = "AssassinHeroGroupCache",
	QuestItemOpenAnim = "ASSASSIN2_QUEST_HAS_PLAYED_OPEN_ANIM",
	MapPlayUnlockAnim = "ASSASSIN2_MAP_HAS_PLAYED_UNLOCK_ANIM",
	NewAssassinItem = "ASSASSIN2_NEW_ASSASSIN_ITEM",
	QuestItemFinishAnim = "ASSASSIN2_QUEST_HAS_PLAYED_FINISH_ANIM"
}
var_0_0.StealthConstId = {
	MaxRound = 1
}
var_0_0.StealthConst = {
	AdjacentDis = 1,
	ConfigExposeRatePoint = 10000,
	ShowExposeRatePoint = 100,
	MinMapScale = 0.35,
	MaxMapScale = 1,
	QuestMapGuide = 130527,
	HideMoveDis = 0,
	HpRatePoint = 100,
	MapTweenPosTime = 0.26,
	EnemyTurnWaitTime = 1.2,
	MinExposeRate = 0,
	HorWallSign = 1,
	MaxExposeRate = 1,
	MoveDis = 1,
	FirstStealthMap = 3011,
	VerWallSign = 2
}
var_0_0.EffectId = {
	GridFog = 18,
	EnemyAttack = 21,
	ScanEffectId = 3
}
var_0_0.StealthGameGridType = {
	Water = 3,
	Plain = 1,
	Roof = 2
}
var_0_0.StealthGamePointType = {
	HayStack = 1,
	Garden = 2,
	Tower = 3,
	Empty = 0
}
var_0_0.EventType = {
	NotExpose = 5,
	ChangExposeRate = 3
}
var_0_0.MissionType = {
	TargetEnemy = 3,
	TargetGrid2 = 5,
	TargetGrid3 = 7,
	TargetGrid1 = 4
}
var_0_0.ItemType = {
	AirCraft = 5,
	ThrowingKnife = 2,
	PoisonKnife = 4
}
var_0_0.StealGameBuffType = {
	Confuse = 1,
	Petrifaction = 2
}
var_0_0.EnemyType = {
	Heavy = 3
}
var_0_0.EnemyMoveType = {
	NotMove = 2,
	Normal = 1
}
var_0_0.StealGameTrapType = {
	Smog = 3,
	Locked = 2,
	Poison = 1
}
var_0_0.RoofEntranceDir = {
	Down = 2,
	Up = 1,
	Left = 3,
	Right = 4
}
var_0_0.HeroStatus = {
	Dead = 4,
	Stealth = 1,
	Hide = 3,
	Expose = 2
}
var_0_0.HeroAct = {
	LeaveHide = 3,
	ClimbTower = 9,
	Hide = 2,
	AirAssassinate = 12,
	Ambush = 5,
	AttackTogether = 7,
	HideAssassinate = 13,
	HandleBody = 14,
	Attack = 4,
	AmbushTogether = 8,
	Jump = 11,
	Assassinate = 6,
	LeaveTower = 10,
	Move = 1
}
var_0_0.StealthRes = {
	HeroEntity = "ui/viewres/sp01/assassin2/assassinstealthgameheroitem.prefab",
	EnemyEntity = "ui/viewres/sp01/assassin2/assassinstealthgameemenyitem.prefab"
}
var_0_0.GameState = {
	Win = 1,
	Fail = 2,
	InProgress = 0
}
var_0_0.Skill = {
	Transfer = 11,
	CureAll = 7,
	LightGrid = 10,
	AddAp = 14,
	Petrifaction = 8,
	Cure = 6
}
var_0_0.SkillCostType = {
	AP = "actionability"
}
var_0_0.SkillPropTargetType = {
	Grid = "grid",
	Hero = "friend",
	Enemy = "enemy",
	None = ""
}
var_0_0.SkillPropTargetCheckType = {
	GridType = 1,
	EnemyRefreshPoint = 2
}
var_0_0.RangeType = {
	StraightLine = "StraightLine"
}
var_0_0.TowerPointIndex = {
	LeftTop = 13,
	RightBottom = 1,
	LeftBottom = 3,
	RightTop = 11
}
var_0_0.TowerPointPos = {
	[var_0_0.TowerPointIndex.RightBottom] = {
		x = 12,
		y = -12
	},
	[var_0_0.TowerPointIndex.RightTop] = {
		x = 12,
		y = 12
	},
	[var_0_0.TowerPointIndex.LeftBottom] = {
		x = -12,
		y = -12
	},
	[var_0_0.TowerPointIndex.LeftTop] = {
		x = -12,
		y = 12
	}
}
var_0_0.BuildingType = {
	Church = 5,
	Guild = 4,
	Barrack = 3,
	Mansion = 1,
	Hospital = 2
}
var_0_0.BuildingType2IconCls = {
	[var_0_0.BuildingType.Mansion] = AssassinBuildingItemIcon,
	[var_0_0.BuildingType.Hospital] = AssassinBuildingItemIcon,
	[var_0_0.BuildingType.Barrack] = AssassinBuildingItemIcon,
	[var_0_0.BuildingType.Guild] = AssassinBuildingItemIcon,
	[var_0_0.BuildingType.Church] = AssassinBuildingItemIcon
}
var_0_0.NeedPlayOpenAnimBuildingCount = 4
var_0_0.BuildingDelayOpenAnim = 0.06
var_0_0.BuildingStatus = {
	Unlocked = 2,
	Locked = 1,
	LevelUp = 3
}
var_0_0.LibraryType = {
	Geology = 2,
	Hero = 1,
	Culture = 3,
	Video = 4
}
var_0_0.LibraryType2LangId = {
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Hero)] = "assassinlibrary_type_Hero_1",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Geology)] = "assassinlibrary_type_Geology",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Culture)] = "assassinlibrary_type_Culture",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Video)] = "assassinlibrary_type_Video",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Hero)] = "assassinlibrary_type_Hero_2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Geology)] = "assassinlibrary_type_Geology",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Culture)] = "assassinlibrary_type_Culture",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Video)] = "assassinlibrary_type_Video"
}
var_0_0.LibraryStatus = {
	New = 2,
	Locked = 1,
	Unlocked = 3
}
var_0_0.LibraryInfoViewTabId = 2
var_0_0.LibraryType2TabViewId = {
	[var_0_0.LibraryType.Hero] = 1,
	[var_0_0.LibraryType.Geology] = 2,
	[var_0_0.LibraryType.Culture] = 2,
	[var_0_0.LibraryType.Video] = 3
}
var_0_0.LibrarySubItemTweenDuration = 0.03
var_0_0.LibraryReddotStyle = RedDotEnum.Style.Green
var_0_0.LibraryToastPath = "ui/viewres/sp01/assassin2/assassinlibrarytoastitem.prefab"
var_0_0.CurrencyToolPrefabPath = "ui/viewres/sp01/assassin2/assassincurrencyitem.prefab"
var_0_0.LibraryCategoryCameraParams = {
	perspFOV = 35,
	cameraPos = Vector3(0, 0, -18.5)
}
var_0_0.ActId2LibraryInfoBgName = {
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Hero)] = "assassinlibrary_aitemempty",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Geology)] = "assassinlibrary_citembg",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Culture)] = "assassinlibrary_citembg",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Video)] = "assassinlibrary_bitemempty",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Hero)] = "assassinlibrary_aitemempty2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Geology)] = "assassinlibrary_citembg2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Culture)] = "assassinlibrary_citembg2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Video)] = "assassinlibrary_bitemempty2"
}
var_0_0.ActId2LibraryCategoryIconName = {
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Hero)] = "assassinlibrary_leftlisticon",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Geology)] = "assassinlibrary_leftlisticon",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Culture)] = "assassinlibrary_leftlisticon",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, var_0_0.LibraryType.Video)] = "assassinlibrary_leftlisticon",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Hero)] = "assassinlibrary_leftlisticon2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Geology)] = "assassinlibrary_leftlisticon2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Culture)] = "assassinlibrary_leftlisticon2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, var_0_0.LibraryType.Video)] = "assassinlibrary_leftlisticon2"
}

return var_0_0
