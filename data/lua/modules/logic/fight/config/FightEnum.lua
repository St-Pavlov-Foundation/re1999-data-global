module("modules.logic.fight.config.FightEnum", package.seeall)

slot0 = _M
slot0.StepEffectCountLimit = 50
slot0.UniversalCard1 = 30000001
slot0.UniversalCard2 = 30000002
slot0.UniversalCard = {
	[slot0.UniversalCard1] = slot0.UniversalCard1,
	[slot0.UniversalCard2] = slot0.UniversalCard2
}
slot0.MaxBehavior = 9
slot0.MaxBuffIconCount = 8
slot0.Stage = {
	End = 8,
	FillCard = 6,
	Card = 3,
	Play = 5,
	StartRound = 1,
	AutoCard = 4,
	ClothSkill = 9,
	EndRound = 7,
	Distribute = 2
}
slot0.FightReason = {
	Dungeon = 2,
	DungeonRecord = 3,
	None = 1
}
slot0.EffectLookDir = {
	Left = 0,
	Right = 180
}
slot0.Rotation = {
	Thas = 270,
	Ohae = 180,
	Ninety = 90,
	Zero = 0
}
slot0.RotationQuaternion = {
	Zero = Quaternion.AngleAxis(0, Vector3.up),
	Ninety = Quaternion.AngleAxis(90, Vector3.up),
	Ohae = Quaternion.AngleAxis(180, Vector3.up),
	Thas = Quaternion.AngleAxis(270, Vector3.up)
}
slot0.SideUid = {
	MySide = "0",
	EnemySide = "-99999"
}
slot0.EntitySide = {
	EnemySide = 2,
	BothSide = 3,
	MySide = 1
}
slot0.TeamType = {
	MySide = 1,
	EnemySide = 2
}
slot0.EntityGOName = {
	MySide = "Player",
	EnemySide = "Monster"
}
slot0.PurifyId = {
	PurifyX = 20020,
	Purify1 = 20003,
	Purify2 = 20004
}
slot0.PurifyName = {
	[slot0.PurifyId.Purify1] = "Purify1",
	[slot0.PurifyId.Purify2] = "Purify2",
	[slot0.PurifyId.PurifyX] = "PurifyX"
}
slot0.FloatType = {
	restrain = 5,
	crit_heal = 3,
	crit_berestrain = 2,
	buff = 9,
	shield_berestrain = 103,
	shield_restrain = 102,
	shield_damage = 101,
	equipeffect = 0,
	total_origin = 14,
	damage_origin = 12,
	crit_restrain = 1,
	berestrain = 6,
	damage = 8,
	crit_damage = 4,
	total = 11,
	stress = 15,
	crit_damage_origin = 13,
	miss = 10,
	heal = 7
}
slot0.UniformDefAudioId = 440000130
slot0.AudioSwitchGroup = "Checkpointstate"
slot0.AudioSwitch = {
	Fightboss = "Fightboss",
	Victory = "Victory",
	Fightend = "Fightend",
	Plotcg = "Plotcg",
	Checkpointend = "Checkpointend",
	Losing = "Losing",
	Fightnormal = "Fightnormal",
	Plotdialogue = "Plotdialogue",
	Comeshow = "Comeshow",
	Bosswarning = "Bosswarning"
}
slot0.WeaponHitSwitchGroup = "bigka_common_group"
slot0.WeaponHitSwitchNames = {
	[0] = "nothing",
	"air",
	"arrow",
	"arrow_air",
	"arrow_fire",
	"arrow_wind",
	"bite",
	"dagger",
	"electric",
	"explode",
	"fire",
	"glass",
	"grass",
	"light",
	"little",
	"metal",
	"mud",
	"punch",
	"snow",
	"star",
	"stone_heavy",
	"stone_light",
	"sword",
	"water",
	"wind"
}
slot0.RenderOrderType = {
	ZPos = 2,
	StandPos = 1,
	SameOrder = 3
}
slot0.ActType = {
	CHANGEWAVE = 5,
	EFFECT = 3,
	CHANGEHERO = 4,
	SKILL = 1,
	BUFF = 2
}
slot0.EffectType = {
	MASTERHALO = 172,
	HARMSTATISTIC = 114,
	IMMUNITY = 33,
	PASSIVESKILLINVALID = 99,
	ROGUECOINCHANGE = 143,
	SKILLPOWERUP = 88,
	EXSKILLNOCONSUMPTION = 83,
	BUFFDELNOEFFECT = 56,
	SLEEP = 31,
	OVERFLOWHEALTOSHIELD = 115,
	USECARDS = 159,
	SKILLRATEUP = 90,
	DAMAGEEXTRA = 18,
	MAXHPCHANGE = 108,
	INJURY = 34,
	ADDACT = 15,
	AVERAGELIFE = 40,
	ROUGEPOWERCHANGE = 189,
	ADDTOATTACKER = 42,
	HEALCRIT = 57,
	COLD = 80,
	BUFFDEL = 6,
	EXPOINTCARDMOVE = 72,
	HIDELIFE = 100,
	ATTR = 26,
	BUFFADDNOEFFECT = 55,
	BLOODLUST = 12,
	UNIVERSALCARD = 58,
	SUMMON = 86,
	EXSKILLPOINTCHANGE = 113,
	CURE = 27,
	MONSTERSPLIFE = 112,
	FROZEN = 23,
	HALOBASE = 92,
	SHIELD = 25,
	ADDCARDLIMIT = 102,
	CHANGEHERO = 107,
	RESISTANCES = 222,
	SUBHEROLIFECHANGE = 235,
	SILENCE = 24,
	DAMAGEFROMABSORB = 192,
	IGNOREDODGESPECSKILL = 163,
	POLARIZATIONLEVEL = 183,
	MAGICCIRCLEADD = 138,
	ORIGINDAMAGE = 130,
	MAGICCIRCLEDELETE = 139,
	CHANGETOTEMPCARD = 141,
	REGAINPOWER = 146,
	RIGID = 79,
	MULTIHPCHANGE = 125,
	PROTECT = 22,
	MASTERPOWERCHANGE = 148,
	PLAYCHANGERANKFAIL = 224,
	FROZENRESIST = 48,
	DAMAGEFROMLOSTHP = 193,
	BUFFADD = 5,
	ENCHANTBURNDAMAGE = 202,
	BFSGCONVERTCARD = 156,
	BFSGUSECARD = 157,
	DIZZYRESIST = 49,
	SUMMONEDADD = 134,
	REALHURTFIXWITHLIMIT = 203,
	CAREERRESTRAINT = 166,
	MOVE = 206,
	IGNOREREBOUND = 165,
	CURE2 = 43,
	ABSORBHURT = 169,
	ADDTOTARGET = 50,
	INJURYLOGBACK = 168,
	FIGHTSTEP = 162,
	CARDACONVERTCARDB = 170,
	POLARIZATIONDECCARD = 176,
	POWERCANTDECR = 151,
	MONSTERLABELBUFF = 126,
	DEFENSEALTER = 11,
	SLAVEHALO = 173,
	BUFFRATEUP = 89,
	HEROUPGRADE = 171,
	EXPOINTADD = 68,
	POLARIZATIONADDLEVEL = 177,
	POLARIZATIONEXSKILLADD = 178,
	CLEARUNIVERSALCARD = 96,
	INDICATORCHANGE = 117,
	RESONANCEADDLIMIT = 179,
	DISARM = 29,
	RESONANCEDECCARD = 180,
	RESONANCEADDLEVEL = 181,
	CRIT = 3,
	RESONANCEEXSKILLADD = 182,
	ADDBUFFROUND = 64,
	BURN = 137,
	RESONANCELEVEL = 184,
	RECORDTEAMINJURYCOUNT = 194,
	ROUGEPOWERLIMITCHANGE = 188,
	ADDEXPOINT = 17,
	TRANSFERADDEXPOINT = 240,
	ROUGESPCARDADD = 191,
	EXPOINTCARDUPGRADE = 73,
	REMOVEENTITYCARDS = 152,
	CARDREMOVE = 133,
	STRESSTRIGGER = 230,
	CARDSPUSH = 154,
	BUFFREJECT = 19,
	SUMMONEDDELETE = 135,
	POLARIZATIONACTIVE = 185,
	CARDDECKGENERATE = 247,
	MASTERADDHANDCARD = 197,
	ENTERTEAMSTAGE = 200,
	SHIELDCHANGE = 41,
	CARDSCOMPOSE = 153,
	CARDREMOVE2 = 155,
	ATTACKALTER = 10,
	CARDLEVELADD = 65,
	BUFFTYPENUMLIMITUPDATE = 204,
	LOCKHP = 205,
	PERTRIFIED = 32,
	DOT = 35,
	IMMUNITYEXPOINTCHANGE = 66,
	TAUNT = 37,
	SELECTLAST = 94,
	EXPOINTMAXADD = 91,
	EXPOINTADDAFTERDELORABSORBEXPOINT = 84,
	FIXEDHURT = 74,
	MOVEFRONT = 207,
	MOVEBACK = 208,
	SKILLLEVELJUDGEADD = 209,
	CARDINVALID = 160,
	NONE = 0,
	BUFFUPDATE = 7,
	SMALLROUNDEND = 211,
	NOTIFYUPGRADEHERO = 174,
	FIXEDDAMAGE = 98,
	CHANGEROUND = 212,
	EXPOINTCANTADD = 63,
	EXPOINTOVERFLOWBANK = 214,
	MONSTERCHANGE = 67,
	FREEZE = 104,
	CANTSELECT = 95,
	ADDUSECARD = 215,
	LAYERHALOSYNC = 234,
	CATAPULTBUFF = 217,
	PLAYAROUNDUPRANK = 218,
	DISPERSE = 14,
	OVERFLOWPOWERADDBUFF = 150,
	POLARIZATIONADDLIMIT = 175,
	KILL = 110,
	RESONANCEACTIVE = 186,
	LAYERMASTERHALO = 231,
	ROGUEESCAPE = 145,
	PLAYSETGRAY = 220,
	RESISTANCESATTR = 221,
	DEALCARD2 = 60,
	ADDBUFFROUNDBYSKILL = 223,
	ADDHANDCARD = 149,
	COPYBUFFBYKILL = 225,
	POISONSETTLECANCRIT = 226,
	CHANGEWAVE = 227,
	EXTRAMOVEACT = 77,
	SHIELDVALUECHANGE = 228,
	ADDTOBUFFENTITY = 147,
	IGNORECOUNTER = 164,
	CURRENTHPCHANGE = 109,
	ADDBUFFROUNDBYTYPEID = 82,
	IGNOREBEATBACK = 199,
	SKILLWEIGHTSELECT = 87,
	MOCKTAUNT = 201,
	ORIGINCRIT = 131,
	BFSGSKILLSTART = 161,
	BREAKSHIELD = 229,
	FORBID = 30,
	DAMAGE = 2,
	CARDEFFECTCHANGE = 85,
	PLAYAROUNDDOWNRANK = 219,
	CHANGECAREER = 97,
	HALOSLAVE = 93,
	PURIFY = 13,
	EXPOINTCHANGE = 111,
	LAYERSLAVEHALO = 232,
	SHIELDBROCKEN = 132,
	REBOUND = 36,
	BEATBACK = 38,
	CARDLEVELCHANGE = 75,
	ENTERFIGHTDEAL = 233,
	LOCKDOT = 216,
	CANTGETEXSKILL = 129,
	MAGICCIRCLEUPDATE = 140,
	DIZZY = 20,
	SLEEPRESIST = 47,
	ROGUESAVECOIN = 144,
	GUARDCHANGE = 236,
	ENTITYSYNC = 238,
	DEAD = 9,
	ROUGEREWARD = 187,
	STORAGEINJURY = 167,
	POWERMAXADD = 127,
	EXPOINTFIX = 39,
	LOCKBULLETCOUNTDECR = 237,
	PALSY = 81,
	NOTIFIYHEROCONTRACT = 241,
	CONTRANCT = 242,
	ROUGECOINCHANGE = 190,
	CRITPILEUP = 51,
	ROGUEHEARTCHANGE = 142,
	EXPOINTDEL = 69,
	BECONTRANCTED = 243,
	SPEXPOINTMAXADD = 244,
	REDEALCARD = 54,
	INJURYBANKHEAL = 195,
	PETRIFIEDRESIST = 46,
	TRANSFERADDSTRESS = 245,
	BUFFREPLACE = 76,
	ADDSKILLBUFFCOUNTANDDURATION = 116,
	MISS = 1,
	GUARDBREAK = 246,
	BUFFATTR = 71,
	SHIELDDEL = 62,
	INVINCIBLE = 21,
	TEAMMATEINJURYCOUNT = 210,
	MASTERCARDREMOVE = 196,
	DELCARDANDDAMAGE = 249,
	TRIGGER = 999,
	DODGESPECSKILL2 = 53,
	ROUNDEND = 61,
	DODGESPECSKILL = 52,
	HEAL = 4,
	ADDCARD = 16,
	SUMMONEDLEVELUP = 136,
	FIGHTCOUNTER = 198,
	FORBIDSPECEFFECT = 44,
	CARDDECKDELETE = 248,
	ADDBUFFROUNDBYTYPEGROUP = 103,
	POWERCHANGE = 128,
	DEALCARD1 = 59,
	CANTCRIT = 45,
	SEAL = 28,
	PRECISIONREGION = 239,
	POISON = 213,
	BFSGSKILLEND = 158,
	CARDDISAPPEAR = 106,
	BUFFADDACT = 101,
	SPCARDADD = 78,
	DAMAGENOTMORETHAN = 70,
	CANTSELECTEX = 105,
	BUFFEFFECT = 8
}
slot0.BuffEffectType = {
	[slot0.EffectType.BUFFADD] = true,
	[slot0.EffectType.BUFFDEL] = true,
	[slot0.EffectType.BUFFUPDATE] = true,
	[slot0.EffectType.BUFFDELNOEFFECT] = true
}
slot0.EnchantedType = {
	Discard = 10004,
	Chaos = 10003,
	Frozen = 10001,
	Burn = 10002,
	Blockade = 10005,
	Precision = 10006
}
slot0.EnchantNumLimit = 6
slot0.CardOpType = {
	PlayCard = 2,
	MoveCard = 1,
	SimulateDissolveCard = -99,
	MoveUniversal = 3
}
slot0.FightResult = {
	Abort = -1,
	OutOfRoundFail = 2,
	Fail = 0,
	Succ = 1
}
slot0.TargetLimit = {
	EnemySide = 1,
	MySide = 2,
	None = 0
}
slot0.ShowLogicTargetView = {
	[1.0] = true
}
slot0.CondTargetHpMin = 109
slot0.LogicTargetClassify = {
	Special = {
		[0] = 1
	},
	MySideAll = {
		[102.0] = 1,
		[101.0] = 1,
		[104.0] = 1,
		[105.0] = 1
	},
	Me = {
		[103.0] = 1
	},
	Single = {
		1,
		[107.0] = 1,
		[106.0] = 1,
		[108.0] = 1,
		[303.0] = 1,
		[205.0] = 1,
		[204.0] = 1,
		[109.0] = 1,
		[207.0] = 1
	},
	SingleAndRandom = {
		[206.0] = 1,
		[201.0] = 1
	},
	EnemySideAll = {
		[301.0] = 1,
		[202.0] = 1,
		[302.0] = 1
	},
	EnemyMostHp = {
		[208.0] = 1
	},
	EnemyWith101Buff = {
		[4101.0] = 1
	},
	SecondaryTarget = {
		[216.0] = 1
	},
	StanceAndBefore = {
		[120.0] = 1
	},
	StanceAndAfter = {
		[122.0] = 1
	},
	Position = {
		[223.0] = 2,
		[225.0] = 4,
		[222.0] = 1,
		[224.0] = 3
	},
	EnemyWith795Feature = {
		[307.0] = 1
	}
}
slot0.FightBonusTag = {
	AdvencedBonus = 3,
	NormalBonus = 2,
	AdditionBonus = 4,
	EquipDailyFreeBonus = -1,
	TimeFirstBonus = 5,
	FirstBonus = 1,
	SimpleBouns = 6,
	ActBonus = 100
}
slot0.FightBonusTagPriority = {
	[slot0.FightBonusTag.TimeFirstBonus] = 1,
	[slot0.FightBonusTag.AdditionBonus] = 2,
	[slot0.FightBonusTag.NormalBonus] = 3,
	[slot0.FightBonusTag.FirstBonus] = 4,
	[slot0.FightBonusTag.AdvencedBonus] = 5
}
slot0.DropType = {
	Act158 = 5,
	Normal2Simple = 6,
	Act153 = 4,
	TurnBack = 1,
	Act155 = 3,
	Act135 = 2
}
slot0.MySideDefaultStanceId = 100
slot0.EnemySideDefaultStanceId = 3
slot0.StanceCount = 3
slot0.MaxSkillCardLv = 3
slot0.UniqueSkillCardLv = 4
slot0.TopOrderFactor = 100
slot0.OrderRegion = 200
slot0.GameSpeedRTPC = "GameSpeed"
slot0.HitStatusGroupName = "Hit_Status_Group"
slot0.HitStatusArr = {
	"General_attack",
	"Critical_strike"
}
slot0.HitMaterialGroupName = "Hit_Material_Group"
slot0.HitMaterialArr = {
	[0] = "nothing",
	"Metal",
	"Succulent",
	"Ligneous"
}
slot0.SkillShowTag = {
	Counter = 5,
	SpiritualDamage = 2,
	Buff = 4,
	Debuff = 3,
	RealDamage = 1,
	HealEffect = 6
}
slot0.NeedShowRestrainTag = {
	[slot0.SkillShowTag.RealDamage] = true,
	[slot0.SkillShowTag.SpiritualDamage] = true,
	[slot0.SkillShowTag.Debuff] = true
}
slot0.LogicTargetDesc = {}
slot1 = {
	"logic_target_single",
	[104.0] = "logic_target_area",
	[202.0] = "logic_target_area",
	[108.0] = "logic_target_single",
	[206.0] = "logic_target_single",
	[301.0] = "logic_target_area",
	[101.0] = "logic_target_area",
	[107.0] = "logic_target_single",
	[207.0] = "logic_target_single",
	[302.0] = "logic_target_area",
	[102.0] = "logic_target_area",
	[106.0] = "logic_target_single",
	[201.0] = "logic_target_area",
	[103.0] = "logic_target_single",
	[105.0] = "logic_target_area"
}

setmetatable(slot0.LogicTargetDesc, {
	__index = function (slot0, slot1)
		if uv0[slot1] then
			return luaLang(uv0[slot1])
		end

		return ""
	end
})

slot0.EffectTag = {
	SpiritAttack = 2,
	CounterSpell = 5,
	Buff = 4,
	Debuff = 3,
	Heal = 6,
	Control = 7,
	RealAttack = 1
}
slot0.EffectTagDesc = {}
slot2 = {
	[slot0.EffectTag.RealAttack] = "effect_tag_attack",
	[slot0.EffectTag.SpiritAttack] = "effect_tag_attack",
	[slot0.EffectTag.Debuff] = "effect_tag_debuff",
	[slot0.EffectTag.Buff] = "effect_tag_buff",
	[slot0.EffectTag.CounterSpell] = "effect_tag_counterspell",
	[slot0.EffectTag.Heal] = "effect_tag_heal",
	[slot0.EffectTag.Control] = "effect_tag_control"
}

setmetatable(slot0.EffectTagDesc, {
	__index = function (slot0, slot1)
		if uv0[slot1] then
			return luaLang(uv0[slot1])
		end

		return ""
	end
})

slot0.BuffIncludeTypes = {
	Stacked15 = "15",
	Stacked12 = "12",
	Count = 9,
	Stacked14 = "14",
	Stacked = "10"
}
slot0.FactionToSkin = {
	430001,
	430002,
	430003,
	430004,
	430005,
	430006,
	430007,
	430008,
	430009
}
slot0.SpecialFaction = {
	[DungeonEnum.ChapterType.Gold] = true,
	[DungeonEnum.ChapterType.Exp] = true,
	[DungeonEnum.ChapterType.Equip] = true,
	[DungeonEnum.ChapterType.Break] = true,
	[DungeonEnum.ChapterType.SpecialEquip] = true
}
slot0.BuffFloatEffectType = {
	Counter = 4,
	Good = 1,
	Poisoning = 5,
	Heal = 3,
	Debuffs = 2
}
slot0.Behavior_AddExPoint = "AddExPoint"
slot0.Behavior_DelExPoint = "DelExPoint"
slot0.Behavior_LostLife = "LostLife"
slot0.Behavior_CatapultBuff = "CatapultBuff"
slot0.BuffType_Dizzy = "Dizzy"
slot0.BuffType_Charm = "Charm"
slot0.BuffType_Petrified = "Petrified"
slot0.BuffType_Sleep = "Sleep"
slot0.BuffType_Frozen = "Frozen"
slot0.BuffType_Disarm = "Disarm"
slot0.BuffType_Forbid = "Forbid"
slot0.BuffType_Seal = "Seal"
slot0.BuffType_Dot = "Dot"
slot0.BuffType_Immunity = "Immunity"
slot0.BuffType_Freeze = "Freeze"
slot0.BuffType_CantSelect = "CantSelect"
slot0.BuffType_CantSelectEx = "CantSelectEx"
slot0.BuffType_HideLife = "HideLife"
slot0.ExPointCantAdd = "ExPointCantAdd"
slot0.BuffType_CastChannel = "CastChannel"
slot0.BuffType_NoneCastChannel = "NoneCastChannel"
slot0.BuffType_ContractCastChannel = "ContractCastChannel"
slot0.BuffType_ExPointOverflowBank = "ExPointOverflowBank"
slot0.BuffType_SpExPointMaxAdd = "SpExPointMaxAdd"
slot0.BuffType_TransferAddExPoint = "TransferAddExPoint"
slot0.BuffType_ContractBuff = "ContractBuff"
slot0.BuffType_BeContractedBuff = "BeContractedBuff"
slot0.BuffType_CountContinueChannel = "CountContinueChannel"
slot0.BuffTypeId_CoverPerson = 8398
slot0.BuffTypeId_CelebrityCharm = 8399
slot0.BuffFeature = {
	AttrFixFromInjuryBank = "AttrFixFromInjuryBank",
	ResistancesAttr = "ResistancesAttr",
	PrecisionRegion = "PrecisionRegion",
	Dream = "Dream",
	ModifyAttrByBuffLayer = "ModifyAttrByBuffLayer",
	UseSkillHasBuffCond = "UseSkillHasBuffCond",
	SkillLevelJudgeAdd = "SkillLevelJudgeAdd",
	InjuryBank = "InjuryBank",
	None = "None"
}
slot0.BuffFeatureMap = {
	[slot0.BuffType_Dizzy] = true,
	[slot0.BuffType_Charm] = true,
	[slot0.BuffType_Petrified] = true,
	[slot0.BuffType_Sleep] = true,
	[slot0.BuffType_Frozen] = true,
	[slot0.BuffType_Disarm] = true,
	[slot0.BuffType_Forbid] = true,
	[slot0.BuffType_Seal] = true,
	[slot0.BuffType_Dot] = true,
	[slot0.BuffType_Immunity] = true,
	[slot0.BuffType_Freeze] = true,
	[slot0.BuffType_CastChannel] = true
}
slot0.BuffPriorityTypeDict = {
	[slot0.BuffType_Freeze] = 5,
	[slot0.BuffType_Immunity] = 4,
	[slot0.BuffType_Dizzy] = 3,
	[slot0.BuffType_Charm] = 3,
	[slot0.BuffType_Petrified] = 2,
	[slot0.BuffType_Sleep] = 1,
	[slot0.BuffType_Frozen] = 2
}
slot0.CardLockPriorityDict = {
	[slot0.BuffType_CastChannel] = 4,
	[slot0.BuffType_Dizzy] = 3,
	[slot0.BuffType_Charm] = 3,
	[slot0.BuffType_Petrified] = 2,
	[slot0.BuffType_Sleep] = 1,
	[slot0.BuffType_Frozen] = 2,
	[slot0.BuffType_Disarm] = 0,
	[slot0.BuffType_Forbid] = 0,
	[slot0.BuffType_Seal] = 0
}
slot0.FightSpecialTipsType = {
	Addition = 2,
	Special = 1
}
slot0.FightConstId = {
	TechnicCriticalRatio = 11,
	TechnicTargetLevelRatio = 14,
	TechnicCriticalDamageRatio = 12,
	TechnicCorrectConst = 13
}
slot0.DirectDamageType = -1
slot0.FightBuffType = {
	GoodBuff = 2,
	BadBuff = 1,
	NormalBuff = 3
}
slot0.BuffTypeList = {
	GoodBuffList = {
		1,
		3,
		5
	},
	BadBuffList = {
		2,
		4,
		6
	}
}
slot0.FightStatType = {
	DataView = 1,
	SkillView = 2
}
slot0.AtkRenderOrderIgnore = {
	[60111] = {
		[slot0.EntitySide.MySide] = {
			5
		}
	}
}
slot0.DeadEffectType = {
	NoEffect = 1,
	NormalEffect = 0,
	Abjqr4 = 3,
	ZaoWu = 2
}
slot0.DissolveType = {
	Player = 1,
	Abjqr4 = 4,
	Monster = 2,
	ZaoWu = 3
}
slot0.IndicatorId = {
	NewSeasonScoreOffset = 163,
	Season1_2 = 3,
	BossInfiniteHPCount = 5,
	Act1_6DungeonBoss = 161,
	Season = 1,
	V1a4_BossRush_ig_ScoreTips = 4,
	NewSeasonScore = 162,
	Id4140004 = 4140004,
	Id6181 = 6181,
	Id6201 = 6201,
	Id6202 = 6202,
	FightSucc = 2,
	Id6182 = 6182
}
slot0.AppearTimelineSkillId = -111
slot0.SkillTargetType = {
	All = 4,
	Single = 1,
	Side = 3,
	Multi = 2
}
slot0.SkillLineColor = {
	Yellow = 2,
	Red = 1
}
slot0.ClothSkillType = {
	HeroUpgrade = 1,
	ClothSkill = 0,
	Contract = 3,
	Rouge = 2
}
slot0.CardType = {
	SUPPORT_NORMAL = 2,
	USE_ACT_POINT = 5,
	ROUGE_SP = 1,
	SUPPORT_EX = 3,
	NONE = 0
}
slot0.PowerType = {
	Energy = 2,
	Stress = 3,
	Power = 1
}
slot0.ClothSkillPerformanceType = {
	Rouge = 1,
	ToughBattle = 2,
	Normal = 0
}
slot0.ExIndexForRouge = {
	Coin = 1,
	Magic = 2,
	SupportHeroSkill = 4,
	MagicLimit = 3
}
slot0.PerformanceTime = {
	CardLevelChange = 1.3,
	CardAConvertCardB = 1.2
}
slot0.CacheProtoType = {
	Fight = 1,
	Round = 2
}
slot0.FightActType = {
	Sp = 2,
	Season2 = 3,
	Normal = 1
}
slot0.CardInfoStatus = {
	STATUS_NONE = 0,
	STATUS_PLAYSETGRAY = 1
}
slot0.BuffActId = {
	ExSkillNoConsumption = 514,
	ExPointCantAdd = 603
}
slot0.ExPointState = {
	Server = 2,
	Client = 3,
	ServerFull = 4,
	Stored = 7,
	UsingUnique = 5,
	Lock = 6,
	Empty = 1
}
slot0.CardRankChangeFail = {
	DownFail = "0",
	UpFail = "1"
}
slot0.Resistance = {
	forbid = 406,
	sleep = 402,
	dizzy = 401,
	frozen = 404,
	petrified = 403,
	delExPointResilience = 502,
	stressUp = 410,
	charm = 411,
	controlResilience = 501,
	delExPoint = 409,
	stressUpResilience = 503,
	seal = 407,
	disarm = 405,
	cantGetExskill = 408
}
slot0.ToughnessToResistance = {
	[slot0.Resistance.controlResilience] = {
		slot0.Resistance.dizzy,
		slot0.Resistance.sleep,
		slot0.Resistance.petrified,
		slot0.Resistance.frozen,
		slot0.Resistance.disarm,
		slot0.Resistance.forbid,
		slot0.Resistance.seal,
		slot0.Resistance.cantGetExskill,
		slot0.Resistance.charm
	},
	[slot0.Resistance.delExPointResilience] = {
		slot0.Resistance.delExPoint
	},
	[slot0.Resistance.stressUpResilience] = {
		slot0.Resistance.stressUp
	}
}
slot0.ResistanceKeyToSpAttributeMoField = {
	forbid = "forbidResistances",
	sleep = "sleepResistances",
	dizzy = "dizzyResistances",
	frozen = "frozenResistances",
	petrified = "petrifiedResistances",
	delExPointResilience = "delExPointResilience",
	stressUp = "stressUpResistances",
	charm = "charmResistances",
	controlResilience = "controlResilience",
	delExPoint = "delExPointResistances",
	stressUpResilience = "stressUpResilience",
	seal = "sealResistances",
	disarm = "disarmResistances",
	cantGetExskill = "cantGetExskillResistances"
}
slot0.DeadPerformanceMaxNum = 8
slot0.StressBehaviour = {
	Resolute = 4,
	BaseResolute = 7,
	Positive = 1,
	BaseReduce = 6,
	BaseAdd = 5,
	Negative = 2,
	BaseMeltdown = 8,
	Meltdown = 3
}
slot0.StressBehaviourString = {
	[slot0.StressBehaviour.Positive] = "positive",
	[slot0.StressBehaviour.Negative] = "negative",
	[slot0.StressBehaviour.Resolute] = "resolute",
	[slot0.StressBehaviour.Meltdown] = "meltdown",
	[slot0.StressBehaviour.BaseAdd] = "baseAdd",
	[slot0.StressBehaviour.BaseReduce] = "baseReduce",
	[slot0.StressBehaviour.BaseResolute] = "baseResolute",
	[slot0.StressBehaviour.BaseMeltdown] = "baseMeltdown"
}
slot0.StressBehaviourConstId = {
	[slot0.StressBehaviour.Positive] = 6,
	[slot0.StressBehaviour.Negative] = 7,
	[slot0.StressBehaviour.Resolute] = 8,
	[slot0.StressBehaviour.Meltdown] = 9
}
slot0.Status = {
	Positive = 1,
	Negative = 2
}
slot0.StressThreshold = {
	[slot0.Status.Positive] = 24,
	[slot0.Status.Negative] = 50
}
slot0.BuffType = {
	LayerMasterHalo = 1,
	LayerSalveHalo = 2,
	Normal = 0
}
slot0.IdentityType = {
	BattleTag = "battleTag",
	HeroId = "id",
	HeroType = "heroType",
	Base = "base",
	Career = "career",
	Custom = "custom"
}
slot0.EnemyActionStatus = {
	Lock = 3,
	NotOpen = 0,
	Select = 2,
	Normal = 1
}

return slot0
