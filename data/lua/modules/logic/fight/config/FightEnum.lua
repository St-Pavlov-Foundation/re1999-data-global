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
	shield_damage = 101,
	additional_damage = 16,
	shield_restrain = 102,
	crit_additional_damage = 17,
	equipeffect = 0,
	addShield = 18,
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
	MAGICCIRCLEDELETE = 139,
	DELCARDANDDAMAGE = 249,
	PASSIVESKILLINVALID = 99,
	ROGUECOINCHANGE = 143,
	CURECORRECT = 259,
	EXSKILLNOCONSUMPTION = 83,
	RESISTANCESATTR = 221,
	PLAYSETGRAY = 220,
	ROGUEESCAPE = 145,
	USECARDS = 159,
	DISPERSE = 14,
	PLAYAROUNDUPRANK = 218,
	HALOBASE = 92,
	FREEZE = 104,
	SKILLLEVELJUDGEADD = 209,
	FIXEDHURT = 74,
	ENTERTEAMSTAGE = 200,
	ADDTOATTACKER = 42,
	SHAREHURT = 282,
	USECARDFIXEXPOINT = 254,
	TAUNT = 37,
	MASTERADDHANDCARD = 197,
	HIDELIFE = 100,
	ATTR = 26,
	BUFFADDNOEFFECT = 55,
	RESONANCELEVEL = 184,
	RESONANCEDECCARD = 180,
	INDICATORCHANGE = 117,
	CLEARUNIVERSALCARD = 96,
	BUFFTYPENUMLIMITUPDATE = 204,
	MONSTERSPLIFE = 112,
	HEROUPGRADE = 171,
	POWERCANTDECR = 151,
	CARDACONVERTCARDB = 170,
	FIGHTSTEP = 162,
	ADDTOTARGET = 50,
	CURE2 = 43,
	SUBHEROLIFECHANGE = 235,
	ENCHANTBURNDAMAGE = 202,
	BUFFADD = 5,
	PROTECT = 22,
	MULTIHPCHANGE = 125,
	SAVEFIGHTRECORDUPDATE = 316,
	ORIGINDAMAGE = 130,
	PROGRESSCHANGE = 251,
	MAGICCIRCLEADD = 138,
	REGAINPOWER = 146,
	RIGID = 79,
	EMITTERNUMCHANGE = 285,
	MASTERPOWERCHANGE = 148,
	SUMMONEDADD = 134,
	CHANGEHERO = 107,
	ADDBUFFROUNDBYSKILL = 223,
	ADDCARDLIMIT = 102,
	RESONANCEADDLEVEL = 181,
	SHIELD = 25,
	ADDUSECARD = 215,
	ZXQREMOVECARD = 258,
	DIZZYRESIST = 49,
	POLARIZATIONADDLEVEL = 177,
	CURE = 27,
	TRIGGER = 999,
	ROUGESPCARDADD = 191,
	CARDSPUSH = 154,
	ASSISTBOSSSKILLCD = 252,
	POWERINFOCHANGE = 295,
	ALLOCATECARDENERGY = 276,
	BUFFDEL = 6,
	SHIELDCHANGE = 41,
	CARDLEVELADD = 65,
	ROUGEPOWERCHANGE = 189,
	ADDACT = 15,
	MAXHPCHANGE = 108,
	BURN = 137,
	DAMAGEEXTRA = 18,
	COPYBUFFBYKILL = 225,
	SKILLRATEUP = 90,
	RESONANCEACTIVE = 186,
	BREAKSHIELD = 229,
	LAYERSLAVEHALO = 232,
	ENTERFIGHTDEAL = 233,
	COLD = 80,
	PALSY = 81,
	IMMUNITY = 33,
	HARMSTATISTIC = 114,
	DEADLYPOISON = 255,
	EMITTERSPLITNUM = 300,
	ASSISTBOSSSKILLCHANGE = 265,
	ADDBUFFROUND = 64,
	ADDITIONALDAMAGE = 267,
	ACT174FIRST = 269,
	TRANSFERADDSTRESS = 245,
	ROUGEPOWERLIMITCHANGE = 188,
	ADDEXPOINT = 17,
	TRANSFERADDEXPOINT = 240,
	TOWERSCORECHANGE = 272,
	BLOODLUST = 12,
	DEADLYPOISONORIGINCRIT = 264,
	CARDREMOVE = 133,
	STRESSTRIGGER = 230,
	EXPOINTCARDMOVE = 72,
	EMITTERSKILLEND = 278,
	CARDDECKCLEAR = 279,
	CARDREMOVE2 = 155,
	EMITTERCAREERCHANGE = 284,
	SILENCE = 24,
	USESKILLTEAMADDEMITTERENERGY = 288,
	SMALLROUNDEND = 211,
	CALLMONSTERTOSUB = 293,
	FIXATTRTEAMENERGYANDBUFF = 294,
	ATTACKALTER = 10,
	POLARIZATIONACTIVE = 185,
	EMITTERMAINTARGET = 297,
	CONDITIONSPLITEMITTERNUM = 298,
	EMITTERTAG = 286,
	RESONANCEEXSKILLADD = 182,
	MUSTCRITBUFF = 301,
	MOVEFRONT = 207,
	DEADLYPOISONORIGINDAMAGE = 263,
	ADDSPLITEMITTERNUM = 299,
	MUSTCRIT = 302,
	POISONSETTLECANCRIT = 226,
	REDORBLUECOUNTCHANGE = 306,
	CARDDECKNUM = 310,
	EMITTERCREATE = 280,
	STORAGEDAMAGE = 312,
	MONSTERLABELBUFF = 126,
	BUFFUPDATE = 7,
	ENCHANTDEPRESSEDAMAGE = 314,
	NOTIFYUPGRADEHERO = 174,
	FIXEDDAMAGE = 98,
	SAVEFIGHTRECORDSTART = 315,
	EXPOINTCANTADD = 63,
	CHANGETOTEMPCARD = 141,
	SAVEFIGHTRECORDEND = 317,
	CONTRANCT = 242,
	CANTSELECT = 95,
	SAVEFIGHTRECORD = 319,
	ADDSPHANDCARD = 320,
	SUMMON = 86,
	PROGRESSMAXCHANGE = 256,
	KILL = 110,
	GUARDCHANGE = 236,
	LAYERMASTERHALO = 231,
	BFSGUSECARD = 157,
	EXTRAMOVEACT = 77,
	IGNORECOUNTER = 164,
	BFSGCONVERTCARD = 156,
	MOCKTAUNT = 201,
	ORIGINCRIT = 131,
	REDORBLUECOUNTEXSKILL = 311,
	ROUNDOFFSET = 318,
	TEAMENERGYCHANGE = 275,
	CHANGECAREER = 97,
	PURIFY = 13,
	INJURY = 34,
	SHIELDBROCKEN = 132,
	REBOUND = 36,
	CARDLEVELCHANGE = 75,
	CANTGETEXSKILL = 129,
	REDORBLUECHANGETRIGGER = 307,
	DEAD = 9,
	STORAGEINJURY = 167,
	EXPOINTFIX = 39,
	ASSISTBOSSCHANGE = 260,
	ROUGECOINCHANGE = 190,
	CRITPILEUP = 51,
	ROGUEHEARTCHANGE = 142,
	EMITTERREMOVE = 287,
	SIMPLEPOLARIZATIONLEVEL = 291,
	INJURYBANKHEAL = 195,
	DEALCARD2 = 60,
	MISS = 1,
	BUFFATTR = 71,
	SHIELDDEL = 62,
	FROZEN = 23,
	CHANGESHIELD = 271,
	SIMPLEPOLARIZATIONADDLEVEL = 292,
	DODGESPECSKILL2 = 53,
	SKILLPOWERUP = 88,
	ADDCARD = 16,
	FIXATTRTEAMENERGY = 289,
	POWERCHANGE = 128,
	DEALCARD1 = 59,
	CANTCRIT = 45,
	BFSGSKILLEND = 158,
	SPCARDADD = 78,
	CANTSELECTEX = 105,
	CARDEFFECTCHANGE = 85,
	SIMPLEPOLARIZATIONADDLIMIT = 296,
	ACT174MONSTERAICARD = 273,
	ADDHANDCARD = 149,
	BUFFDELNOEFFECT = 56,
	SLEEP = 31,
	CARDHEATVALUECHANGE = 309,
	AVERAGELIFE = 40,
	DAMAGESHAREHP = 253,
	LOCKBURN = 266,
	INJURYLOGBACK = 168,
	SLEEPRESIST = 47,
	UNIVERSALCARD = 58,
	REDORBLUECOUNT = 305,
	RETAINPERTRIFIED = 262,
	PLAYERFINISHERSKILLCHANGE = 283,
	RESISTANCES = 222,
	DAMAGEFROMABSORB = 192,
	IGNOREDODGESPECSKILL = 163,
	POLARIZATIONLEVEL = 183,
	EXSKILLPOINTCHANGE = 113,
	GUARDBREAK = 246,
	CARDAREAREDORBLUE = 303,
	PLAYCHANGERANKFAIL = 224,
	FROZENRESIST = 48,
	DAMAGEFROMLOSTHP = 193,
	MASTERCARDREMOVE = 196,
	CHANGEWAVE = 227,
	ADDITIONALDAMAGECRIT = 268,
	BECONTRANCTED = 243,
	REALHURTFIXWITHLIMIT = 203,
	CAREERRESTRAINT = 166,
	MOVE = 206,
	ABSORBHURT = 169,
	POLARIZATIONEXSKILLADD = 178,
	POLARIZATIONDECCARD = 176,
	CONFUSION = 261,
	DEFENSEALTER = 11,
	BUFFRATEUP = 89,
	EXPOINTADD = 68,
	SPEXPOINTMAXADD = 244,
	DISARM = 29,
	AFTERREDEALCARD = 274,
	CRIT = 3,
	RESONANCEADDLIMIT = 179,
	RECORDTEAMINJURYCOUNT = 194,
	EXPOINTCARDUPGRADE = 73,
	REMOVEENTITYCARDS = 152,
	BUFFREJECT = 19,
	SUMMONEDDELETE = 135,
	CARDDECKGENERATE = 247,
	CARDSCOMPOSE = 153,
	MOVEBACK = 208,
	DOT = 35,
	IMMUNITYEXPOINTCHANGE = 66,
	SELECTLAST = 94,
	EXPOINTMAXADD = 91,
	EXPOINTADDAFTERDELORABSORBEXPOINT = 84,
	CARDINVALID = 160,
	NONE = 0,
	PERTRIFIED = 32,
	LOCKHP = 205,
	EXPOINTOVERFLOWBANK = 214,
	TOCARDAREAREDORBLUE = 304,
	MONSTERCHANGE = 67,
	LAYERHALOSYNC = 234,
	CARDHEATINIT = 308,
	OVERFLOWPOWERADDBUFF = 150,
	POLARIZATIONADDLIMIT = 175,
	PLAYAROUNDDOWNRANK = 219,
	DUDUBONECONTINUECHANNEL = 257,
	ADDTOBUFFENTITY = 147,
	CURRENTHPCHANGE = 109,
	ADDBUFFROUNDBYTYPEID = 82,
	IGNOREBEATBACK = 199,
	SKILLWEIGHTSELECT = 87,
	BFSGSKILLSTART = 161,
	FORBID = 30,
	DAMAGE = 2,
	HALOSLAVE = 93,
	HEALCRIT = 57,
	EXPOINTCHANGE = 111,
	NOTIFIYHEROCONTRACT = 241,
	ELUSIVE = 313,
	BEATBACK = 38,
	SHIELDVALUECHANGE = 228,
	MAGICCIRCLEUPDATE = 140,
	DIZZY = 20,
	ROGUESAVECOIN = 144,
	ENTITYSYNC = 238,
	CATAPULTBUFF = 217,
	ROUGEREWARD = 187,
	POWERMAXADD = 127,
	CHANGEROUND = 212,
	ACT174USECARD = 270,
	ADDONCECARD = 281,
	CHARM = 250,
	EXPOINTDEL = 69,
	REDEALCARD = 54,
	PETRIFIEDRESIST = 46,
	BUFFREPLACE = 76,
	ADDSKILLBUFFCOUNTANDDURATION = 116,
	IGNOREREBOUND = 165,
	LOCKDOT = 216,
	INVINCIBLE = 21,
	TEAMMATEINJURYCOUNT = 210,
	EMITTERENERGYCHANGE = 277,
	ROUNDEND = 61,
	DODGESPECSKILL = 52,
	HEAL = 4,
	OVERFLOWHEALTOSHIELD = 115,
	SUMMONEDLEVELUP = 136,
	FIGHTCOUNTER = 198,
	SIMPLEPOLARIZATIONACTIVE = 290,
	FORBIDSPECEFFECT = 44,
	CARDDECKDELETE = 248,
	ADDBUFFROUNDBYTYPEGROUP = 103,
	SEAL = 28,
	PRECISIONREGION = 239,
	POISON = 213,
	LOCKBULLETCOUNTDECR = 237,
	CARDDISAPPEAR = 106,
	BUFFADDACT = 101,
	DAMAGENOTMORETHAN = 70,
	SLAVEHALO = 173,
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
	depresse = 10007,
	Frozen = 10001,
	Burn = 10002,
	Blockade = 10005,
	Chaos = 10003,
	Precision = 10006
}
slot0.EnchantNumLimit = 6
slot0.CardOpType = {
	Season2ChangeHero = 5,
	MoveCard = 1,
	SimulateDissolveCard = -99,
	AssistBoss = 4,
	PlayCard = 2,
	PlayerFinisherSkill = 6,
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
	EnemySideindex = {
		[226.0] = 1,
		[228.0] = 1,
		[227.0] = 1,
		[229.0] = 1
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
slot0.BuffType_DuduBoneContinueChannel = "DuduBoneContinueChannel"
slot0.BuffType_DeadlyPoison = "DeadlyPoison"
slot0.BuffType_UseCardFixExPoint = "UseCardFixExPoint"
slot0.BuffType_ExPointCardMove = "ExPointCardMove"
slot0.BuffType_FixAttrTeamEnergyAndBuff = "FixAttrTeamEnergyAndBuff"
slot0.BuffType_FixAttrTeamEnergy = "FixAttrTeamEnergy"
slot0.BuffType_EmitterCareerChange = "EmitterCareerChange"
slot0.BuffType_CardAreaRedOrBlue = "CardAreaRedOrBlue"
slot0.BuffType_RedOrBlueCount = "RedOrBlueCount"
slot0.BuffType_RedOrBlueChangeTrigger = "RedOrBlueChangeTrigger"
slot0.BuffType_SaveFightRecord = "SaveFightRecord"
slot0.BuffTypeId_CoverPerson = 8398
slot0.BuffTypeId_CelebrityCharm = 8399
slot0.BuffFeature = {
	AttrFixFromInjuryBank = "AttrFixFromInjuryBank",
	ResistancesAttr = "ResistancesAttr",
	FixAttrTeamEnergyAndBuff = "FixAttrTeamEnergyAndBuff",
	FixAttrTeamEnergy = "FixAttrTeamEnergy",
	StorageDamage = "StorageDamage",
	PrecisionRegion = "PrecisionRegion",
	Dream = "Dream",
	ModifyAttrByBuffLayer = "ModifyAttrByBuffLayer",
	CountUseSelfSkillContinueChannel = "CountUseSelfSkillContinueChannel",
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
	PaTaScore = 165,
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
	PlayerFinisherSkill = 5,
	AssistBoss = 4,
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
	DouQuQuXianHouShou = 3.6,
	CardAConvertCardB = 1.2
}
slot0.CacheProtoType = {
	Fight = 1,
	Round = 2
}
slot0.FightActType = {
	Sp = 2,
	Season2 = 3,
	Act174 = 4,
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
slot0.EntityStatus = {
	Dying = 1,
	Dead = 2,
	Normal = 0
}
slot0.EntityType = {
	Character = 1,
	ASFDEmitter = 6,
	Player = 3,
	AssistBoss = 5,
	Monster = 2
}
slot0.ConditionTarget = {
	Self = 103
}
slot0.ConditionType = {
	HasBuffId = "HasBuffId"
}
slot0.ASFDUnit = {
	Explosion = 3,
	Emitter = 1,
	Missile = 2,
	Born = 4
}
slot0.ASFDType = {
	Normal = 1
}
slot0.ASFDEffect = {
	Fission = 2,
	Normal = 1
}
slot0.ASFDReplyRule = {
	HasSkin = 1,
	HasBuffActId = 2
}
slot0.CardShowType = {
	Default = 0,
	HandCard = 1,
	BossAction = 4,
	Deck = 5,
	PlayCard = 3,
	Operation = 2
}
slot0.CardColor = {
	Blue = 1,
	Both = 3,
	Red = 2,
	None = 0
}
slot0.LYCardAreaWidthOffset = 45
slot0.LYPlayCardAreaOffset = 74
slot0.LYCardWaitAreaScale = 1.5
slot0.CardIconId = {
	PreDelete = 99999999
}

return slot0
