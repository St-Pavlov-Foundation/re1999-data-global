module("modules.logic.gm.model.GMFightShowState", package.seeall)

local var_0_0 = _M

var_0_0.clothSkill = true
var_0_0.Desc_clothSkill = "维尔汀的技能"
var_0_0.topRightPause = true
var_0_0.Desc_topRightPause = "暂停退出按钮"
var_0_0.topRightRound = true
var_0_0.Desc_topRightRound = "轮次回合计数"
var_0_0.monsterSelect = true
var_0_0.Desc_monsterSelect = "技能集火图标"
var_0_0.handCardRestrain = true
var_0_0.Desc_handCardRestrain = "手牌克制标签"
var_0_0.bottomEnemyRound = true
var_0_0.Desc_bottomEnemyRound = "敌方回合提示"
var_0_0.topLeftTotal = true
var_0_0.Desc_topLeftTotal = "总的伤害计算"
var_0_0.bossHp = true
var_0_0.Desc_bossHp = "Boss血条"
var_0_0.leftMonster = true
var_0_0.Desc_leftMonster = "怪物剩余数量"
var_0_0.cards = true
var_0_0.Desc_cards = "手牌区出牌区"
var_0_0.enemyOp = true
var_0_0.Desc_enemyOp = "敌方头顶卡牌"
var_0_0.screenTouchEffect = true
var_0_0.Desc_screenTouchEffect = "屏幕触摸特效"
var_0_0.roundSpecialView = true
var_0_0.Desc_roundSpecialView = "入场战斗弹窗"
var_0_0.playSkillDes = true
var_0_0.Desc_playSkillDes = "技能卡描述"
var_0_0._descList = {
	{
		valueKey = "clothSkill"
	},
	{
		valueKey = "topRightPause"
	},
	{
		valueKey = "topRightRound"
	},
	{
		valueKey = "monsterSelect"
	},
	{
		valueKey = "handCardRestrain"
	},
	{
		valueKey = "bottomEnemyRound"
	},
	{
		valueKey = "topLeftTotal"
	},
	{
		valueKey = "bossHp"
	},
	{
		valueKey = "leftMonster"
	},
	{
		valueKey = "cards"
	},
	{
		valueKey = "enemyOp"
	},
	{
		valueKey = "screenTouchEffect"
	},
	{
		valueKey = "roundSpecialView"
	},
	{
		valueKey = "playSkillDes"
	}
}

function var_0_0.getList()
	for iter_1_0, iter_1_1 in ipairs(var_0_0._descList) do
		if not iter_1_1.id then
			iter_1_1.id = iter_1_0
			iter_1_1.desc = var_0_0["Desc_" .. iter_1_1.valueKey]
		end
	end

	return var_0_0._descList
end

function var_0_0.getStatus(arg_2_0)
	return var_0_0[arg_2_0]
end

function var_0_0.setStatus(arg_3_0, arg_3_1)
	var_0_0[arg_3_0] = arg_3_1
end

return var_0_0
