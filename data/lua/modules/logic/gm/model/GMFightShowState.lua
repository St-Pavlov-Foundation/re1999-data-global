module("modules.logic.gm.model.GMFightShowState", package.seeall)

slot0 = _M
slot0.clothSkill = true
slot0.Desc_clothSkill = "维尔汀的技能"
slot0.topRightPause = true
slot0.Desc_topRightPause = "暂停退出按钮"
slot0.topRightRound = true
slot0.Desc_topRightRound = "轮次回合计数"
slot0.monsterSelect = true
slot0.Desc_monsterSelect = "技能集火图标"
slot0.handCardRestrain = true
slot0.Desc_handCardRestrain = "手牌克制标签"
slot0.bottomEnemyRound = true
slot0.Desc_bottomEnemyRound = "敌方回合提示"
slot0.topLeftTotal = true
slot0.Desc_topLeftTotal = "总的伤害计算"
slot0.bossHp = true
slot0.Desc_bossHp = "Boss血条"
slot0.leftMonster = true
slot0.Desc_leftMonster = "怪物剩余数量"
slot0.cards = true
slot0.Desc_cards = "手牌区出牌区"
slot0.enemyOp = true
slot0.Desc_enemyOp = "敌方头顶卡牌"
slot0.screenTouchEffect = true
slot0.Desc_screenTouchEffect = "屏幕触摸特效"
slot0.roundSpecialView = true
slot0.Desc_roundSpecialView = "入场战斗弹窗"
slot0.playSkillDes = true
slot0.Desc_playSkillDes = "技能卡描述"
slot0._descList = {
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

function slot0.getList()
	for slot3, slot4 in ipairs(uv0._descList) do
		if not slot4.id then
			slot4.id = slot3
			slot4.desc = uv0["Desc_" .. slot4.valueKey]
		end
	end

	return uv0._descList
end

function slot0.getStatus(slot0)
	return uv0[slot0]
end

function slot0.setStatus(slot0, slot1)
	uv0[slot0] = slot1
end

return slot0
