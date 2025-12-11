module("modules.logic.fight.config.FightEnum", package.seeall)

local var_0_0 = _M

var_0_0.StepEffectCountLimit = 50
var_0_0.UniversalCard1 = 30000001
var_0_0.UniversalCard2 = 30000002
var_0_0.UniversalCard = {
	[var_0_0.UniversalCard1] = var_0_0.UniversalCard1,
	[var_0_0.UniversalCard2] = var_0_0.UniversalCard2
}
var_0_0.MaxBehavior = 9
var_0_0.MaxBuffIconCount = 8
var_0_0.FightReason = {
	Dungeon = 2,
	DungeonRecord = 3,
	None = 1
}
var_0_0.EffectLookDir = {
	Left = 0,
	Right = 180
}
var_0_0.Rotation = {
	Thas = 270,
	Ohae = 180,
	Ninety = 90,
	Zero = 0
}
var_0_0.RotationQuaternion = {
	Zero = Quaternion.AngleAxis(0, Vector3.up),
	Ninety = Quaternion.AngleAxis(90, Vector3.up),
	Ohae = Quaternion.AngleAxis(180, Vector3.up),
	Thas = Quaternion.AngleAxis(270, Vector3.up)
}
var_0_0.SideUid = {
	MySide = "0",
	EnemySide = "-99999"
}
var_0_0.EntitySide = {
	EnemySide = 2,
	BothSide = 3,
	MySide = 1
}
var_0_0.TeamType = {
	MySide = 1,
	EnemySide = 2
}
var_0_0.EntityGOName = {
	MySide = "Player",
	EnemySide = "Monster"
}
var_0_0.PurifyId = {
	PurifyX = 20020,
	Purify1 = 20003,
	Purify2 = 20004
}
var_0_0.PurifyName = {
	[var_0_0.PurifyId.Purify1] = "Purify1",
	[var_0_0.PurifyId.Purify2] = "Purify2",
	[var_0_0.PurifyId.PurifyX] = "PurifyX"
}
var_0_0.FloatType = {
	restrain = 5,
	crit_heal = 3,
	crit_berestrain = 2,
	buff = 9,
	shield_berestrain = 103,
	secret_key = 19,
	additional_damage = 16,
	shield_damage = 101,
	shield_restrain = 102,
	equipeffect = 0,
	crit_additional_damage = 17,
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
var_0_0.UniformDefAudioId = 440000130
var_0_0.AudioSwitchGroup = "Checkpointstate"
var_0_0.AudioSwitch = {
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
var_0_0.WeaponHitSwitchGroup = "bigka_common_group"
var_0_0.WeaponHitSwitchNames = {
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
var_0_0.RenderOrderType = {
	ZPos = 2,
	StandPos = 1,
	SameOrder = 3
}
var_0_0.ActType = {
	CHANGEWAVE = 5,
	EFFECT = 3,
	CHANGEHERO = 4,
	SKILL = 1,
	BUFF = 2
}
var_0_0.EffectType = {
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
	CUREUPBYLOSTHP = 347,
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
	EZIOBIGSKILLDAMAGE = 1000,
	CARDLEVELADD = 65,
	ROUGEPOWERCHANGE = 189,
	ADDACT = 15,
	EZIOBIGSKILLEXIT = 1003,
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
	DEADLYPOISONORIGINDAMAGE = 263,
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
	EMITTERFIGHTNOTIFY = 300,
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
	NONCAREERRESTRAINT = 321,
	CLEARMONSTERSUB = 322,
	PROGRESSMAXCHANGE = 256,
	FIGHTTASKUPDATE = 323,
	RETAINSLEEP = 324,
	KILL = 110,
	GUARDCHANGE = 236,
	LAYERMASTERHALO = 231,
	BFSGUSECARD = 157,
	REMOVEMONSTERSUB = 325,
	DIRECTUSEEXSKILL = 327,
	FIGHTPARAMCHANGE = 330,
	BLOODPOOLMAXCREATE = 333,
	BLOODPOOLMAXCHANGE = 334,
	BLOODPOOLVALUECHANGE = 335,
	CLIENTEFFECT = 339,
	NUODIKARANDOMATTACK = 341,
	EXTRAMOVEACT = 77,
	NUODIKATEAMATTACK = 342,
	TRIGGERANALYSIS = 343,
	IGNORECOUNTER = 164,
	SURVIVALHEALTHCHANGE = 345,
	BFSGCONVERTCARD = 156,
	PROGRESSCHANGE = 251,
	RANDOMDICEUSESKILL = 353,
	MOCKTAUNT = 201,
	ORIGINCRIT = 131,
	REDORBLUECOUNTEXSKILL = 311,
	TOWERDEEPCHANGE = 354,
	ROUNDOFFSET = 318,
	TEAMENERGYCHANGE = 275,
	FIGHTHURTDETAIL = 355,
	SUMMON = 86,
	CHANGECAREER = 97,
	SHIELDCHANGE = 41,
	PURIFY = 13,
	INJURY = 34,
	EZIOBIGSKILLORIGINDAMAGE = 1001,
	SHIELDBROCKEN = 132,
	REBOUND = 36,
	MAXHPCHANGE = 108,
	CARDLEVELCHANGE = 75,
	CANTGETEXSKILL = 129,
	UPDATEITEMPLAYERSKILL = 1002,
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
	GETSECRETKEY = 344,
	SKILLPOWERUP = 88,
	ADDCARD = 16,
	FIXATTRTEAMENERGY = 289,
	POWERCHANGE = 128,
	DEALCARD1 = 59,
	CANTCRIT = 45,
	COLDSATURDAYHURT = 336,
	BFSGSKILLEND = 158,
	SPCARDADD = 78,
	CANTSELECTEX = 105,
	REALDAMAGEKILL = 351,
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
	NOUSECARDENERGYRECORDBYROUND = 348,
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
	CHANGECARDENERGY = 338,
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
	ADDCARDRECORDBYROUND = 326,
	EXPOINTCARDUPGRADE = 73,
	REMOVEENTITYCARDS = 152,
	SPLITEND = 329,
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
	MAGICCIRCLEUPGRADE = 340,
	LAYERHALOSYNC = 234,
	NEWCHANGEWAVE = 337,
	BUFFACTINFOUPDATE = 350,
	CARDHEATINIT = 308,
	OVERFLOWPOWERADDBUFF = 150,
	POLARIZATIONADDLIMIT = 175,
	PLAYAROUNDDOWNRANK = 219,
	NUODIKARANDOMATTACKNUM = 349,
	DUDUBONECONTINUECHANNEL = 257,
	BUFFDELREASON = 352,
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
	LOCKHPMAX = 346,
	FIGHTCOUNTER = 198,
	SIMPLEPOLARIZATIONACTIVE = 290,
	FORBIDSPECEFFECT = 44,
	CARDDECKDELETE = 248,
	ADDBUFFROUNDBYTYPEGROUP = 103,
	SPLITSTART = 328,
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
var_0_0.BuffEffectType = {
	[var_0_0.EffectType.BUFFADD] = true,
	[var_0_0.EffectType.BUFFDEL] = true,
	[var_0_0.EffectType.BUFFUPDATE] = true,
	[var_0_0.EffectType.BUFFDELNOEFFECT] = true
}
var_0_0.EnchantedType = {
	Discard = 10004,
	depresse = 10007,
	Frozen = 10001,
	Burn = 10002,
	Blockade = 10005,
	Chaos = 10003,
	Precision = 10006
}
var_0_0.EnchantNumLimit = 6
var_0_0.CardOpType = {
	Season2ChangeHero = 5,
	MoveCard = 1,
	SimulateDissolveCard = -99,
	AssistBoss = 4,
	PlayCard = 2,
	BloodPool = 7,
	PlayerFinisherSkill = 6,
	MoveUniversal = 3
}
var_0_0.FightResult = {
	Abort = -1,
	OutOfRoundFail = 2,
	Fail = 0,
	Succ = 1
}
var_0_0.TargetLimit = {
	EnemySide = 1,
	MySide = 2,
	None = 0
}
var_0_0.ShowLogicTargetView = {
	[1] = true
}
var_0_0.CondTargetHpMin = 109
var_0_0.LogicTargetClassify = {
	Special = {
		[0] = 1
	},
	MySideAll = {
		[102] = 1,
		[101] = 1,
		[104] = 1,
		[105] = 1
	},
	Me = {
		[103] = 1
	},
	Single = {
		1,
		[107] = 1,
		[106] = 1,
		[108] = 1,
		[303] = 1,
		[205] = 1,
		[204] = 1,
		[109] = 1,
		[207] = 1
	},
	SingleAndRandom = {
		[206] = 1,
		[201] = 1
	},
	EnemySideAll = {
		[301] = 1,
		[202] = 1,
		[302] = 1
	},
	EnemySideindex = {
		[226] = 1,
		[228] = 1,
		[227] = 1,
		[229] = 1
	},
	EnemyMostHp = {
		[208] = 1
	},
	EnemyWith101Buff = {
		[4101] = 1
	},
	SecondaryTarget = {
		[216] = 1
	},
	StanceAndBefore = {
		[120] = 1
	},
	StanceAndAfter = {
		[122] = 1
	},
	Position = {
		[223] = 2,
		[225] = 4,
		[222] = 1,
		[224] = 3
	},
	EnemyWith795Feature = {
		[307] = 1
	}
}
var_0_0.FightBonusTag = {
	AdvencedBonus = 3,
	NormalBonus = 2,
	AdditionBonus = 4,
	EquipDailyFreeBonus = -1,
	TimeFirstBonus = 5,
	FirstBonus = 1,
	SimpleBouns = 6,
	ActBonus = 100
}
var_0_0.FightBonusTagPriority = {
	[var_0_0.FightBonusTag.TimeFirstBonus] = 1,
	[var_0_0.FightBonusTag.AdditionBonus] = 2,
	[var_0_0.FightBonusTag.NormalBonus] = 3,
	[var_0_0.FightBonusTag.FirstBonus] = 4,
	[var_0_0.FightBonusTag.AdvencedBonus] = 5
}
var_0_0.DropType = {
	Act158 = 5,
	Normal2Simple = 6,
	Act153 = 4,
	TurnBack = 1,
	Act155 = 3,
	Act135 = 2
}
var_0_0.MySideDefaultStanceId = 100
var_0_0.EnemySideDefaultStanceId = 3
var_0_0.StanceCount = 3
var_0_0.MaxSkillCardLv = 3
var_0_0.UniqueSkillCardLv = 4
var_0_0.TopOrderFactor = 100
var_0_0.OrderRegion = 200
var_0_0.GameSpeedRTPC = "GameSpeed"
var_0_0.HitStatusGroupName = "Hit_Status_Group"
var_0_0.HitStatusArr = {
	"General_attack",
	"Critical_strike"
}
var_0_0.HitMaterialGroupName = "Hit_Material_Group"
var_0_0.HitMaterialArr = {
	[0] = "nothing",
	"Metal",
	"Succulent",
	"Ligneous"
}
var_0_0.SkillShowTag = {
	Counter = 5,
	SpiritualDamage = 2,
	Buff = 4,
	Debuff = 3,
	Universal = 11,
	RealDamage = 1,
	HealEffect = 6
}
var_0_0.NeedShowRestrainTag = {
	[var_0_0.SkillShowTag.RealDamage] = true,
	[var_0_0.SkillShowTag.SpiritualDamage] = true,
	[var_0_0.SkillShowTag.Debuff] = true,
	[var_0_0.SkillShowTag.Universal] = true
}
var_0_0.LogicTargetDesc = {}

local var_0_1 = {
	"logic_target_single",
	[104] = "logic_target_area",
	[202] = "logic_target_area",
	[108] = "logic_target_single",
	[206] = "logic_target_single",
	[301] = "logic_target_area",
	[101] = "logic_target_area",
	[107] = "logic_target_single",
	[207] = "logic_target_single",
	[302] = "logic_target_area",
	[102] = "logic_target_area",
	[106] = "logic_target_single",
	[201] = "logic_target_area",
	[103] = "logic_target_single",
	[105] = "logic_target_area"
}

setmetatable(var_0_0.LogicTargetDesc, {
	__index = function(arg_1_0, arg_1_1)
		if var_0_1[arg_1_1] then
			return luaLang(var_0_1[arg_1_1])
		end

		return ""
	end
})

var_0_0.EffectTag = {
	SpiritAttack = 2,
	CounterSpell = 5,
	Buff = 4,
	Debuff = 3,
	Heal = 6,
	Control = 7,
	RealAttack = 1,
	Choice = 13
}
var_0_0.EffectTagDesc = {}

local var_0_2 = {
	[var_0_0.EffectTag.RealAttack] = "effect_tag_attack",
	[var_0_0.EffectTag.SpiritAttack] = "effect_tag_attack",
	[var_0_0.EffectTag.Debuff] = "effect_tag_debuff",
	[var_0_0.EffectTag.Buff] = "effect_tag_buff",
	[var_0_0.EffectTag.CounterSpell] = "effect_tag_counterspell",
	[var_0_0.EffectTag.Heal] = "effect_tag_heal",
	[var_0_0.EffectTag.Control] = "effect_tag_control"
}

setmetatable(var_0_0.EffectTagDesc, {
	__index = function(arg_2_0, arg_2_1)
		if var_0_2[arg_2_1] then
			return luaLang(var_0_2[arg_2_1])
		end

		return ""
	end
})

var_0_0.BuffIncludeTypes = {
	Stacked15 = "15",
	Stacked12 = "12",
	Count = 9,
	Stacked14 = "14",
	Stacked = "10"
}
var_0_0.FactionToSkin = {
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
var_0_0.SpecialFaction = {
	[DungeonEnum.ChapterType.Gold] = true,
	[DungeonEnum.ChapterType.Exp] = true,
	[DungeonEnum.ChapterType.Equip] = true,
	[DungeonEnum.ChapterType.Break] = true,
	[DungeonEnum.ChapterType.SpecialEquip] = true
}
var_0_0.BuffFloatEffectType = {
	Counter = 4,
	Good = 1,
	Poisoning = 5,
	Heal = 3,
	Debuffs = 2
}
var_0_0.Behavior_AddExPoint = "AddExPoint"
var_0_0.Behavior_DelExPoint = "DelExPoint"
var_0_0.Behavior_LostLife = "LostLife"
var_0_0.Behavior_CatapultBuff = "CatapultBuff"
var_0_0.BuffType_Dizzy = "Dizzy"
var_0_0.BuffType_Charm = "Charm"
var_0_0.BuffType_Petrified = "Petrified"
var_0_0.BuffType_Sleep = "Sleep"
var_0_0.BuffType_Frozen = "Frozen"
var_0_0.BuffType_Disarm = "Disarm"
var_0_0.BuffType_Forbid = "Forbid"
var_0_0.BuffType_Seal = "Seal"
var_0_0.BuffType_Dot = "Dot"
var_0_0.BuffType_Immunity = "Immunity"
var_0_0.BuffType_Freeze = "Freeze"
var_0_0.BuffType_CantSelect = "CantSelect"
var_0_0.BuffType_CantSelectEx = "CantSelectEx"
var_0_0.BuffType_HideLife = "HideLife"
var_0_0.ExPointCantAdd = "ExPointCantAdd"
var_0_0.BuffType_CastChannel = "CastChannel"
var_0_0.BuffType_NoneCastChannel = "NoneCastChannel"
var_0_0.BuffType_ContractCastChannel = "ContractCastChannel"
var_0_0.BuffType_ExPointOverflowBank = "ExPointOverflowBank"
var_0_0.BuffType_SpExPointMaxAdd = "SpExPointMaxAdd"
var_0_0.BuffType_TransferAddExPoint = "TransferAddExPoint"
var_0_0.BuffType_ContractBuff = "ContractBuff"
var_0_0.BuffType_BeContractedBuff = "BeContractedBuff"
var_0_0.BuffType_CountContinueChannel = "CountContinueChannel"
var_0_0.BuffType_DuduBoneContinueChannel = "DuduBoneContinueChannel"
var_0_0.BuffType_DeadlyPoison = "DeadlyPoison"
var_0_0.BuffType_UseCardFixExPoint = "UseCardFixExPoint"
var_0_0.BuffType_ExPointCardMove = "ExPointCardMove"
var_0_0.BuffType_FixAttrTeamEnergyAndBuff = "FixAttrTeamEnergyAndBuff"
var_0_0.BuffType_FixAttrTeamEnergy = "FixAttrTeamEnergy"
var_0_0.BuffType_EmitterCareerChange = "EmitterCareerChange"
var_0_0.BuffType_CardAreaRedOrBlue = "CardAreaRedOrBlue"
var_0_0.BuffType_RedOrBlueCount = "RedOrBlueCount"
var_0_0.BuffType_RedOrBlueChangeTrigger = "RedOrBlueChangeTrigger"
var_0_0.BuffType_SaveFightRecord = "SaveFightRecord"
var_0_0.BuffType_SubBuff = "SubBuff"
var_0_0.BuffType_AddCardRecordByRound = "AddCardRecordByRound"
var_0_0.BuffType_AddCardCastChannel = "AddCardCastChannel"
var_0_0.BuffType_BigSkillNoUseActPoint = "BigSkillNoUseActPoint"
var_0_0.BuffType_NotBigSkillNoUseActPoint = "NotBigSkillNoUseActPoint"
var_0_0.BuffType_SpecialCountCastBuff = "SpecialCountCastBuff"
var_0_0.BuffType_SpecialCountCastChannel = "SpecialCountCastChannel"
var_0_0.BuffType_SpecialCountContinueChannelBuff = "SpecialCountContinueChannelBuff"
var_0_0.BuffType_LockHpMax = "LockHpMax"
var_0_0.BuffType_NoUseCardEnergyRecordByRound = "NoUseCardEnergyRecordByRound"
var_0_0.BuffType_RealDamageKill = "RealDamageKill"
var_0_0.BuffTypeId_CoverPerson = 8398
var_0_0.BuffTypeId_CelebrityCharm = 8399
var_0_0.BuffFeature = {
	CountUseSelfSkillContinueChannel = "CountUseSelfSkillContinueChannel",
	PrecisionRegion = "PrecisionRegion",
	FixAttrTeamEnergyAndBuff = "FixAttrTeamEnergyAndBuff",
	FixAttrTeamEnergy = "FixAttrTeamEnergy",
	AddAttrBySpecialCount = "AddAttrBySpecialCount",
	AttrFixFromInjuryBank = "AttrFixFromInjuryBank",
	SpecialCountCastChannel = "SpecialCountCastChannel",
	EzioBigSkill = "EzioBigSkill",
	ResistancesAttr = "ResistancesAttr",
	RaspberryBigSkill = "RaspberryBigSkill",
	SpecialCountCastBuff = "SpecialCountCastBuff",
	InjuryBank = "InjuryBank",
	ConsumeBuffAddBuffContinueChannel = "ConsumeBuffAddBuffContinueChannel",
	BeAttackAccrualFixAttr = "BeAttackAccrualFixAttr",
	StorageDamage = "StorageDamage",
	NuoDiKaCastChannel = "NuoDiKaCastChannel",
	Dream = "Dream",
	ModifyAttrByBuffLayer = "ModifyAttrByBuffLayer",
	SpecialCountContinueChannelBuff = "SpecialCountContinueChannelBuff",
	ChangeComposeCardSkill = "ChangeComposeCardSkill",
	UseSkillHasBuffCond = "UseSkillHasBuffCond",
	Raspberry = "Raspberry",
	SkillLevelJudgeAdd = "SkillLevelJudgeAdd",
	None = "None"
}
var_0_0.BuffFeatureMap = {
	[var_0_0.BuffType_Dizzy] = true,
	[var_0_0.BuffType_Charm] = true,
	[var_0_0.BuffType_Petrified] = true,
	[var_0_0.BuffType_Sleep] = true,
	[var_0_0.BuffType_Frozen] = true,
	[var_0_0.BuffType_Disarm] = true,
	[var_0_0.BuffType_Forbid] = true,
	[var_0_0.BuffType_Seal] = true,
	[var_0_0.BuffType_Dot] = true,
	[var_0_0.BuffType_Immunity] = true,
	[var_0_0.BuffType_Freeze] = true,
	[var_0_0.BuffType_CastChannel] = true
}
var_0_0.BuffPriorityTypeDict = {
	[var_0_0.BuffType_Freeze] = 5,
	[var_0_0.BuffType_Immunity] = 4,
	[var_0_0.BuffType_Dizzy] = 3,
	[var_0_0.BuffType_Charm] = 3,
	[var_0_0.BuffType_Petrified] = 2,
	[var_0_0.BuffType_Sleep] = 1,
	[var_0_0.BuffType_Frozen] = 2
}
var_0_0.CardLockPriorityDict = {
	[var_0_0.BuffType_CastChannel] = 4,
	[var_0_0.BuffType_Dizzy] = 3,
	[var_0_0.BuffType_Charm] = 3,
	[var_0_0.BuffType_Petrified] = 2,
	[var_0_0.BuffType_Sleep] = 1,
	[var_0_0.BuffType_Frozen] = 2,
	[var_0_0.BuffType_Disarm] = 0,
	[var_0_0.BuffType_Forbid] = 0,
	[var_0_0.BuffType_Seal] = 0
}
var_0_0.FightSpecialTipsType = {
	Addition = 2,
	Special = 1
}
var_0_0.FightConstId = {
	TechnicCriticalRatio = 11,
	TechnicTargetLevelRatio = 14,
	TechnicCriticalDamageRatio = 12,
	TechnicCorrectConst = 13
}
var_0_0.DirectDamageType = -1
var_0_0.FightBuffType = {
	GoodBuff = 2,
	BadBuff = 1,
	NormalBuff = 3
}
var_0_0.BuffTypeList = {
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
var_0_0.FightStatType = {
	DataView = 1,
	SkillView = 2
}
var_0_0.AtkRenderOrderIgnore = {
	[60111] = {
		[var_0_0.EntitySide.MySide] = {
			5
		}
	}
}
var_0_0.DeadEffectType = {
	NoEffect = 1,
	NormalEffect = 0,
	Abjqr4 = 3,
	ZaoWu = 2
}
var_0_0.DissolveType = {
	Player = 1,
	Abjqr4 = 4,
	Monster = 2,
	ZaoWu = 3
}
var_0_0.IndicatorId = {
	Id4140004 = 4140004,
	Progress_500M = 31,
	NewSeasonScoreOffset = 163,
	Season1_2 = 3,
	Season = 1,
	V1a4_BossRush_ig_ScoreTips = 4,
	NewSeasonScore = 162,
	FightSucc = 2,
	PaTaScore = 165,
	Id6202 = 6202,
	Id6201 = 6201,
	BossInfiniteHPCount = 5,
	TowerDeep = 166,
	Act1_6DungeonBoss = 161,
	DoomsdayClock = 10001,
	Id6181 = 6181,
	Id6182 = 6182
}
var_0_0.AppearTimelineSkillId = -111
var_0_0.SkillTargetType = {
	All = 4,
	Single = 1,
	Side = 3,
	Multi = 2
}
var_0_0.SkillLineColor = {
	Yellow = 2,
	Red = 1
}
var_0_0.ClothSkillType = {
	AssassinBigSkill = 5,
	HeroUpgrade = 1,
	Contract = 3,
	EzioBigSkill = 4,
	ClothSkill = 0,
	Rouge = 2
}
var_0_0.CardType = {
	SUPPORT_NORMAL = 2,
	USE_ACT_POINT = 5,
	SKILL3 = 6,
	ROUGE_SP = 1,
	SUPPORT_EX = 3,
	NONE = 0
}
var_0_0.PowerType = {
	Energy = 2,
	Act191Boss = 7,
	Alert = 6,
	AssistBoss = 4,
	PlayerFinisherSkill = 5,
	SurvivalDot = 8,
	Stress = 3,
	Power = 1
}
var_0_0.ClothSkillPerformanceType = {
	Rouge = 1,
	ToughBattle = 2,
	Normal = 0
}
var_0_0.ExIndexForRouge = {
	Coin = 1,
	Magic = 2,
	SupportHeroSkill = 4,
	MagicLimit = 3
}
var_0_0.PerformanceTime = {
	CardLevelChange = 1.3,
	DouQuQuXianHouShou = 3.6,
	CardAConvertCardB = 1.2
}
var_0_0.CacheProtoType = {
	Fight = 1,
	Round = 2
}
var_0_0.FightActType = {
	Sp = 2,
	Season2 = 3,
	Act174 = 4,
	Normal = 1
}
var_0_0.CardInfoStatus = {
	STATUS_NONE = 0,
	STATUS_PLAYSETGRAY = 1
}
var_0_0.BuffActId = {
	ExSkillNoConsumption = 514,
	RealDamageKill = 1028,
	LockHpMax = 1013,
	NoUseCardEnergyRecordByRound = 1016,
	ExPointCantAdd = 603,
	ConsumeBuffAddBuffContinueChannel = 1031
}
var_0_0.ExPointState = {
	Server = 2,
	Client = 3,
	ServerFull = 4,
	Stored = 7,
	UsingUnique = 5,
	Lock = 6,
	Empty = 1
}
var_0_0.CardRankChangeFail = {
	DownFail = "0",
	UpFail = "1"
}
var_0_0.Resistance = {
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
var_0_0.ToughnessToResistance = {
	[var_0_0.Resistance.controlResilience] = {
		var_0_0.Resistance.dizzy,
		var_0_0.Resistance.sleep,
		var_0_0.Resistance.petrified,
		var_0_0.Resistance.frozen,
		var_0_0.Resistance.disarm,
		var_0_0.Resistance.forbid,
		var_0_0.Resistance.seal,
		var_0_0.Resistance.cantGetExskill,
		var_0_0.Resistance.charm
	},
	[var_0_0.Resistance.delExPointResilience] = {
		var_0_0.Resistance.delExPoint
	},
	[var_0_0.Resistance.stressUpResilience] = {
		var_0_0.Resistance.stressUp
	}
}
var_0_0.ResistanceKeyToSpAttributeMoField = {
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
var_0_0.DeadPerformanceMaxNum = 8
var_0_0.StressBehaviour = {
	Resolute = 4,
	BaseResolute = 7,
	Positive = 1,
	BaseReduce = 6,
	BaseAdd = 5,
	Negative = 2,
	BaseMeltdown = 8,
	Meltdown = 3
}
var_0_0.StressBehaviourString = {
	[var_0_0.StressBehaviour.Positive] = "positive",
	[var_0_0.StressBehaviour.Negative] = "negative",
	[var_0_0.StressBehaviour.Resolute] = "resolute",
	[var_0_0.StressBehaviour.Meltdown] = "meltdown",
	[var_0_0.StressBehaviour.BaseAdd] = "baseAdd",
	[var_0_0.StressBehaviour.BaseReduce] = "baseReduce",
	[var_0_0.StressBehaviour.BaseResolute] = "baseResolute",
	[var_0_0.StressBehaviour.BaseMeltdown] = "baseMeltdown"
}
var_0_0.StressBehaviourConstId = {
	[var_0_0.StressBehaviour.Positive] = 6,
	[var_0_0.StressBehaviour.Negative] = 7,
	[var_0_0.StressBehaviour.Resolute] = 8,
	[var_0_0.StressBehaviour.Meltdown] = 9
}
var_0_0.Status = {
	Positive = 1,
	Negative = 2
}
var_0_0.StressThreshold = {
	[var_0_0.Status.Positive] = 24,
	[var_0_0.Status.Negative] = 50
}
var_0_0.MonsterId2StressThresholdDict = {
	[900042101] = {
		[var_0_0.Status.Positive] = 39,
		[var_0_0.Status.Negative] = 60
	},
	[900042102] = {
		[var_0_0.Status.Positive] = 39,
		[var_0_0.Status.Negative] = 60
	}
}
var_0_0.BuffType = {
	LayerMasterHalo = 1,
	LayerSalveHalo = 2,
	Normal = 0
}
var_0_0.IdentityType = {
	BattleTag = "battleTag",
	HeroId = "id",
	HeroType = "heroType",
	Base = "base",
	Career = "career",
	Custom = "custom"
}
var_0_0.EnemyActionStatus = {
	Lock = 3,
	NotOpen = 0,
	Select = 2,
	Normal = 1
}
var_0_0.EntityStatus = {
	Dying = 1,
	Dead = 2,
	Normal = 0
}
var_0_0.EntityType = {
	Character = 1,
	Act191Boss = 8,
	Player = 3,
	AssistBoss = 5,
	ASFDEmitter = 6,
	Vorpalith = 7,
	Monster = 2
}
var_0_0.ConditionTarget = {
	Self = 103
}
var_0_0.ConditionType = {
	HasBuffId = "HasBuffId"
}
var_0_0.ASFDUnit = {
	Explosion = 3,
	Emitter = 1,
	Missile = 2,
	Born = 4
}
var_0_0.ASFDFlyPath = {
	Default = 1,
	StraightLine = 2
}
var_0_0.ASFDType = {
	Normal = 1
}
var_0_0.ASFDEffect = {
	Fission = 2,
	Normal = 1
}
var_0_0.ASFDReplyRule = {
	HasSkin = 1,
	HasBuffActId = 2
}
var_0_0.CardShowType = {
	Default = 0,
	HandCard = 1,
	BossAction = 4,
	Deck = 5,
	PlayCard = 3,
	Operation = 2
}
var_0_0.CardColor = {
	Blue = 1,
	Both = 3,
	Red = 2,
	None = 0
}
var_0_0.LYCardAreaWidthOffset = 45
var_0_0.LYPlayCardAreaOffset = 74
var_0_0.LYCardWaitAreaScale = 1.5
var_0_0.CardIconId = {
	PreDelete = 99999999
}
var_0_0.MagicCircleUIType = {
	Electric = 1,
	Normal = 0
}
var_0_0.MagicCircleUIType2Name = {
	[var_0_0.MagicCircleUIType.Normal] = "shuzhenitem",
	[var_0_0.MagicCircleUIType.Electric] = "electricmagiccircle"
}
var_0_0.ExPointType = {
	Common = 0,
	Belief = 1,
	NoExpoint = 999,
	Synchronization = 2,
	Adrenaline = 3
}
var_0_0.ExPointTypeFeature = {
	[var_0_0.ExPointType.Common] = {
		moveAddExpoint = true,
		combineAddExpoint = true,
		playAddExpoint = true
	},
	[var_0_0.ExPointType.Belief] = {
		moveAddExpoint = false,
		combineAddExpoint = false,
		playAddExpoint = false
	},
	[var_0_0.ExPointType.Synchronization] = {
		moveAddExpoint = false,
		combineAddExpoint = false,
		playAddExpoint = false
	},
	[var_0_0.ExPointType.Adrenaline] = {
		moveAddExpoint = false,
		combineAddExpoint = false,
		playAddExpoint = false
	},
	[var_0_0.ExPointType.NoExpoint] = {
		moveAddExpoint = false,
		combineAddExpoint = false,
		playAddExpoint = false
	}
}
var_0_0.BuffDeleteReason = {
	Overflow = 1
}
var_0_0.MultiHpType = {
	Default = 1,
	Tower500M = 2
}
var_0_0.ProgressId = {
	Progress_5 = 5,
	Progress_500M = 7,
	Progress_6 = 6
}
var_0_0.HeroId = {
	ALF = 3113
}
var_0_0.EntityCreateStage = {
	Init = 1,
	None = 0
}

return var_0_0
