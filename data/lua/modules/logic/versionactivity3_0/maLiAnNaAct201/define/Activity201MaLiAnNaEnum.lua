module("modules.logic.versionactivity3_0.maLiAnNaAct201.define.Activity201MaLiAnNaEnum", package.seeall)

local var_0_0 = _M

var_0_0.EpisodeStatus = {
	BeforeStory = 0,
	MapGame = 1,
	Finished = 3,
	AfterStory = 2
}
var_0_0.SoldierType = {
	hero = 1,
	soldier = 0
}
var_0_0.CampType = {
	Player = 1,
	Middle = 3,
	Enemy = 2
}
var_0_0.RoadType = {
	RailWay = 1,
	HighWay = 2
}
var_0_0.SoliderState = {
	Moving = 1,
	Attack = 2,
	AttackSlot = 6,
	StopMove = 5,
	InSlot = 3,
	Dead = 4
}
var_0_0.ConditionType = {
	gameOverAndWin = 4,
	gameStart = 3,
	occupySlot = 1,
	useSkill = 5,
	soldierHeroDead = 2
}
var_0_0.bulletHideRange = 10
var_0_0.defaultDragRange = 50
var_0_0.defaultHideRange = 30
var_0_0.defaultOffsetX = 0
var_0_0.defaultOffsetY = 0
var_0_0.defaultHideLineRange = 120
var_0_0.bulletDamage = 1
var_0_0.refreshViewInterval = 0.1
var_0_0.attackTime = 0.5
var_0_0.attackTime2 = 1
var_0_0.enemyLineShowTime = 1.5
var_0_0.MaLiAnNaSoliderEntityDefaultScale = 0.5
var_0_0.attackSlotTime = 0.1
var_0_0.SkillAction = {
	addSlotSolider = 1,
	killSolider = 1005,
	removeSlotSolider = 2,
	releaseBullet = 1003,
	moveSlotSolider = 4,
	pauseSlotGenerateSolider = 3,
	upSlotGenerateSoliderSpeed = 1001,
	enterSlotAddSolider = 1002,
	slotShield = 1004
}
var_0_0.SkillType = {
	passive = 1,
	active = 2
}
var_0_0.SkillOpt = {
	add = 1,
	delete = 0
}
var_0_0.SlotType = {
	trench = 2,
	bunker = 3,
	obstacle = 1,
	normal = 0
}
var_0_0.CampImageName = {
	[var_0_0.CampType.Player] = "v3a0_malianna_game_rolehead1",
	[var_0_0.CampType.Enemy] = "v3a0_malianna_game_rolehead2",
	[var_0_0.CampType.Middle] = "v3a0_malianna_game_rolehead3"
}
var_0_0.BulletEffect = {
	"ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_effectview.prefab"
}
var_0_0.SlotAIFuncType = {
	retreat = 3,
	attackRoad = 2,
	helpSlot = 4,
	attAckSlot = 1
}
var_0_0.AllSlotAIFuncType = {
	var_0_0.SlotAIFuncType.attAckSlot,
	var_0_0.SlotAIFuncType.attackRoad,
	var_0_0.SlotAIFuncType.retreat,
	var_0_0.SlotAIFuncType.helpSlot
}
var_0_0.soliderGenerateIdByCamp = {
	middleSolider = 13,
	enemySolider = 12,
	mySolider = 11
}
var_0_0.tipBgByCamp = {
	[var_0_0.CampType.Player] = "v3a0_malianna_game_tipbg5",
	[var_0_0.CampType.Enemy] = "v3a0_malianna_game_tipbg6"
}
var_0_0.tipIconByCamp = {
	[var_0_0.CampType.Player] = "v3a0_malianna_game_tipicon1",
	[var_0_0.CampType.Enemy] = "v3a0_malianna_game_tipicon2"
}
var_0_0.slotAnimName = {
	skill = "skill",
	my = "occupy_my",
	enemy = "occupy_enemy",
	help = "help",
	attack = "attck",
	middle = "idle",
	myIdle = "occupy_my_idle",
	enemyIdle = "occupy_enemy_idle"
}
var_0_0.resultType = {
	success = "成功",
	cancel = "主动返回",
	fail = "失败",
	reset = "重置"
}
var_0_0.FailResultType = {
	myHeroDead = "英雄剩余血量归零",
	timeOut = "计时超时",
	mySlotDead = "己方大本营被攻占"
}

return var_0_0
