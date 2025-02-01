module("modules.logic.bossrush.view.V1a4_BossRush_ResultPanelItem", package.seeall)

slot0 = class("V1a4_BossRush_ResultPanelItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "txt_Score")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._img = gohelper.findChildImage(slot0.viewGO, "")
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refresh()
end

function slot0.onSelect(slot0, slot1)
end

function slot0._refresh(slot0)
	slot1 = slot0._mo

	slot0:setDesc(BossRushConfig.instance:getScoreStr(slot1.stageRewardCO.rewardPointNum))
	slot0:setImgColor(slot1.isGray and BossRushEnum.Color.GRAY or BossRushEnum.Color.WHITE)
end

function slot0.setDesc(slot0, slot1)
	slot0._txtScore.text = slot1
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0._go, slot1)
end

function slot0.setImgColor(slot0, slot1)
	UIColorHelper.set(slot0._img, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
