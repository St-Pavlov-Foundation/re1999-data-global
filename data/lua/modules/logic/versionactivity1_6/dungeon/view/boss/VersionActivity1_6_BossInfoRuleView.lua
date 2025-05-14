module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossInfoRuleView", package.seeall)

local var_0_0 = class("VersionActivity1_6_BossInfoRuleView", WeekWalkEnemyInfoViewRule)

function var_0_0._addRuleItem(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = gohelper.clone(arg_1_0._goruletemp, arg_1_0._gorulelist, arg_1_1.id)

	table.insert(arg_1_0._childGoList, var_1_0)
	gohelper.setActive(var_1_0, true)

	local var_1_1 = gohelper.findChildImage(var_1_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_1_1, "wz_" .. arg_1_2)

	local var_1_2 = gohelper.findChildImage(var_1_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_1_2, arg_1_1.icon)

	var_1_1.maskable = true
	var_1_2.maskable = true
end

return var_0_0
