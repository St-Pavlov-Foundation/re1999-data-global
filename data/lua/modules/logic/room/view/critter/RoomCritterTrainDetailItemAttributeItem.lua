module("modules.logic.room.view.critter.RoomCritterTrainDetailItemAttributeItem", package.seeall)

slot0 = class("RoomCritterTrainDetailItemAttributeItem")

function slot0.init(slot0, slot1)
	slot0.go = gohelper.cloneInPlace(slot1)

	gohelper.setActive(slot0.go, true)

	slot0._imageicon = gohelper.findChildImage(slot0.go, "#image_icon")
	slot0._goiconup = gohelper.findChild(slot0.go, "#txt_name/iconup")
	slot0._txtname = gohelper.findChildText(slot0.go, "#txt_name")
	slot0._goratelevel = gohelper.findChild(slot0.go, "go_ratelevel")
	slot0._txtratelevel = gohelper.findChildText(slot0.go, "go_ratelevel/#txt_level")
	slot0._imagelvprogress = gohelper.findChildImage(slot0.go, "go_ratelevel/ProgressBg/#simage_levelBarValue")
	slot0._imagelvbar = gohelper.findChildImage(slot0.go, "go_ratelevel/ProgressBg/#bar_add")
	slot0._godetail = gohelper.findChild(slot0.go, "go_detail")
	slot0._txtnum = gohelper.findChildText(slot0.go, "go_detail/#txt_num")
	slot0._imagedetailprogress = gohelper.findChildImage(slot0.go, "go_detail/ProgressBg/#simage_totalBarValue")
	slot0._imagedetailbar = gohelper.findChildImage(slot0.go, "go_detail/ProgressBg/#bar_add")
	slot0._imagelvbar.fillAmount = 0
	slot0._imagedetailbar.fillAmount = 0

	slot0:_addEvents()
end

function slot0._addEvents(slot0)
end

function slot0._removeEvents(slot0)
end

function slot0.hideItem(slot0)
	gohelper.setActive(slot0.go, true)
end

function slot0.getAttributeId(slot0)
	return slot0._attributeMO.attributeId
end

function slot0.setShowLv(slot0, slot1)
	slot0._showLv = slot1
end

function slot0.refresh(slot0, slot1, slot2)
	slot0._attributeMO = slot1
	slot0._critterMO = slot2
	slot3 = 0

	if slot0._attributeMO.attributeId == CritterEnum.AttributeType.Efficiency then
		slot3 = slot0._critterMO.efficiency
	elseif slot0._attributeMO.attributeId == CritterEnum.AttributeType.Patience then
		slot3 = slot0._critterMO.patience
	elseif slot0._attributeMO.attributeId == CritterEnum.AttributeType.Lucky then
		slot3 = slot0._critterMO.lucky
	end

	slot0._attributeBaseValue = slot3 + slot0._critterMO.trainInfo:getAddAttributeValue(slot0._attributeMO.attributeId)
	slot0._trainHeroMO = slot2 and RoomTrainHeroListModel.instance:getById(slot2.trainInfo.heroId)
	slot0._heroAddIncrRate = 0

	if slot0._trainHeroMO and slot0._trainHeroMO:chcekPrefernectCritterId(slot0._critterMO:getDefineId()) and slot0._trainHeroMO.critterHeroConfig and slot1 and slot1.attributeId == slot4.effectAttribute then
		slot0._heroAddIncrRate = slot4.addIncrRate
	end

	gohelper.setActive(slot0.go, true)
	slot0:refreshUI()
end

slot1 = {
	"#5D8FB3",
	"#6A4B8E",
	"#BAA64D",
	"#BA7841",
	"#E57A3A"
}

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._godetail, not slot0._showLv)
	gohelper.setActive(slot0._goratelevel, slot0._showLv)

	if not slot0._attributeMO then
		return
	end

	if slot0._attributeMO:getIsAddition() or slot0._heroAddIncrRate > 0 then
		slot0._txtnum.text = string.format("%d<color=#65B96F>(+%.02f/h)</color>", math.floor(math.min(slot0._attributeBaseValue, CritterConfig.instance:getCritterAttributeMax())), slot0._critterMO:getAddValuePerHourByType(slot0._attributeMO.attributeId))
	else
		slot0._txtnum.text = string.format("%d(+%.02f/h)", math.floor(slot2), slot1)
	end

	slot5 = CritterConfig.instance:getCritterAttributeLevelCfg(CritterConfig.instance:getCritterAttributeLevelCfgByValue(slot0._attributeBaseValue).level + 1) and (slot0._attributeBaseValue - slot3.minValue) / (slot4.minValue - slot3.minValue) or 1
	slot0._imagedetailprogress.fillAmount = slot5

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagedetailprogress, uv0[slot3.level])
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagedetailbar, uv0[slot3.level])

	slot0._txtratelevel.text = slot3.name
	slot0._imagelvprogress.fillAmount = slot5

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagelvprogress, uv0[slot3.level])
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagelvbar, uv0[slot3.level])
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtratelevel, uv0[slot3.level])

	if slot0._txtname then
		slot0._txtname.text = slot0._attributeMO:getName()
	end

	if slot0._imageicon and not string.nilorempty(slot0._attributeMO:getIcon()) then
		UISpriteSetMgr.instance:setCritterSprite(slot0._imageicon, slot0._attributeMO:getIcon())
	end

	gohelper.setActive(slot0._goiconup, slot0._attributeMO:getIsAddition() or slot0._heroAddIncrRate > 0)
end

function slot0.playNoLevelUp(slot0)
	slot0._addAttr = false
	slot0._startValue = CritterConfig.instance:getCritterAttributeLevelCfg(CritterConfig.instance:getCritterAttributeLevelCfgByValue(slot0._attributeBaseValue).level + 1) and (slot0._attributeBaseValue - slot1.minValue) / (slot2.minValue - slot1.minValue) or 1
	slot0._endValue = slot0._startValue
	slot0._txtnum.text = math.min(slot0._attributeBaseValue, CritterConfig.instance:getCritterAttributeMax())

	TaskDispatcher.runDelay(slot0._detailFinished, slot0, 1.5)
end

function slot0.playBarAdd(slot0, slot1, slot2)
	gohelper.setActive(slot0._imagelvbar.gameObject, slot1)
	gohelper.setActive(slot0._imagedetailbar.gameObject, slot1)

	if slot1 then
		slot0._addAttributeMO = slot2
		slot7 = CritterConfig.instance:getCritterAttributeLevelCfg(CritterConfig.instance:getCritterAttributeLevelCfgByValue(slot0._attributeBaseValue).level + 1) and (slot0._attributeBaseValue + RoomTrainCritterModel.instance:getSelectOptionCount(slot2.attributeId) * slot0._addAttributeMO.value - slot5.minValue) / (slot6.minValue - slot5.minValue) or 1
		slot0._imagelvbar.fillAmount = slot7
		slot0._imagedetailbar.fillAmount = slot7
	else
		slot0._imagelvbar.fillAmount = 0
		slot0._imagedetailbar.fillAmount = 0
	end
end

function slot0.playLevelUp(slot0, slot1, slot2)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("attributelevelup")
	TaskDispatcher.cancelTask(slot0._detailFinished, slot0)

	slot0._addAttributeMO = slot1
	slot0._addAttr = true
	slot0._tweenEndAttrValue = slot0._attributeBaseValue + slot0._addAttributeMO.value
	slot0._tweenStartAttrValue = slot0._attributeBaseValue

	if slot2 == true then
		slot0._tweenEndAttrValue = slot0._attributeBaseValue
		slot0._tweenStartAttrValue = slot0._attributeBaseValue - slot0._addAttributeMO.value
		slot0._addAttributeMO = nil
	end

	slot0._endValue = CritterConfig.instance:getCritterAttributeLevelCfg(CritterConfig.instance:getCritterAttributeLevelCfgByValue(slot0._tweenStartAttrValue).level + 1) and (slot0._tweenEndAttrValue - slot3.minValue) / (slot4.minValue - slot3.minValue) or 1
	slot0._startValue = slot4 and (slot0._tweenStartAttrValue - slot3.minValue) / (slot4.minValue - slot3.minValue) or 1

	slot0:_clearTween()

	slot0._fillDetailTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, slot0._detailFillUpdate, slot0._detailFinished, slot0, nil, EaseType.Linear)
end

function slot0._detailFillUpdate(slot0, slot1)
	slot0._imagedetailprogress.fillAmount = slot0._startValue + slot1 * (slot0._endValue - slot0._startValue)
	slot0._txtnum.text = string.format("%.02f", math.min(slot0._tweenStartAttrValue + slot1 * (slot0._tweenEndAttrValue - slot0._tweenStartAttrValue), CritterConfig.instance:getCritterAttributeMax()))
end

function slot0._detailFinished(slot0)
	gohelper.setActive(slot0._godetail, false)
	gohelper.setActive(slot0._goratelevel, true)

	slot0._txtnum.text = math.min(slot0._attributeMO.value + (slot0._addAttributeMO and slot0._addAttributeMO.value or 0), CritterConfig.instance:getCritterAttributeMax())

	slot0:_clearTween()

	slot0._fillLvTweenId = ZProj.TweenHelper.DOTweenFloat(slot0._startValue, slot0._endValue, 1.5, slot0._lvFillUpdate, slot0._lvFinished, slot0, nil, EaseType.Linear)
end

function slot0._lvFillUpdate(slot0, slot1)
	slot0._imagelvprogress.fillAmount = slot1
end

function slot0._lvFinished(slot0)
	UIBlockMgr.instance:endBlock("attributelevelup")

	if slot0._addAttr then
		RoomController.instance:dispatchEvent(RoomEvent.CritterTrainLevelFinished)
	end
end

function slot0._clearTween(slot0)
	if slot0._fillDetailTweenId then
		ZProj.TweenHelper.KillById(slot0._fillDetailTweenId)

		slot0._fillDetailTweenId = nil
	end

	if slot0._fillLvTweenId then
		ZProj.TweenHelper.KillById(slot0._fillLvTweenId)

		slot0._fillLvTweenId = nil
	end
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0._detailFinished, slot0)
	slot0:_removeEvents()
	slot0:_clearTween()
end

return slot0
