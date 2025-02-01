module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossInfoRuleView", package.seeall)

slot0 = class("VersionActivity1_6_BossInfoRuleView", WeekWalkEnemyInfoViewRule)

function slot0._addRuleItem(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot1.id)

	table.insert(slot0._childGoList, slot3)
	gohelper.setActive(slot3, true)

	slot4 = gohelper.findChildImage(slot3, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(slot4, "wz_" .. slot2)

	slot5 = gohelper.findChildImage(slot3, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(slot5, slot1.icon)

	slot4.maskable = true
	slot5.maskable = true
end

return slot0
