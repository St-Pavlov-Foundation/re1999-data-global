module("modules.logic.bossrush.view.V1a4_BossRushViewRule", package.seeall)

slot0 = class("V1a4_BossRushViewRule", WeekWalkEnemyInfoViewRule)

function slot0.onInitView(slot0)
	if not slot0.viewContainer:diffRootChild(slot0) then
		uv0.super.onInitView(slot0)
	end

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

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

function slot0._btnadditionRuleOnClick(slot0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		offSet = {
			-180,
			0
		},
		ruleList = slot0._ruleList,
		closeCb = slot0._btncloseruleOnClick,
		closeCbObj = slot0
	})

	if slot0._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
	end
end

return slot0
