module("modules.logic.room.view.critter.train.RoomCritterTrainStorySelectItem", package.seeall)

slot0 = class("RoomCritterTrainStorySelectItem")

function slot0.init(slot0, slot1, slot2)
	slot0.go = gohelper.cloneInPlace(slot1, string.format("selectItem%s", slot2))

	gohelper.setActive(slot0.go, false)

	slot0._btnselect = gohelper.findChildButtonWithAudio(slot0.go, "btnselect")
	slot0._goselectlight = gohelper.findChild(slot0.go, "btnselect/light")
	slot0._gobgdark = gohelper.findChild(slot0.go, "bgdark")
	slot0._imageicon = gohelper.findChildImage(slot0.go, "bgdark/icon")
	slot0._txtcontentdark = gohelper.findChildText(slot0.go, "bgdark/txtcontentdark")
	slot0._txtnum = gohelper.findChildText(slot0.go, "bgdark/#txt_num")
	slot0._golvup = gohelper.findChild(slot0.go, "go_lvup")
	slot0._txtlvup = gohelper.findChildText(slot0.go, "go_lvup/txt_lvup")
	slot0._goup = gohelper.findChild(slot0.go, "go_up")
	slot0._gonum = gohelper.findChild(slot0.go, "go_num")
	slot0._txtcountnum = gohelper.findChildText(slot0.go, "go_num/#txt_num")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.go, "btncancel")
	slot0._goselecteff = gohelper.findChild(slot0.go, "#selecteff")

	gohelper.setActive(slot0._golvup, false)
	gohelper.setActive(slot0._goselecteff, false)
	slot0:_addEvents()
end

function slot0._addEvents(slot0)
	slot0._btnselect:AddClickListener(slot0._btnselectOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
end

function slot0._removeEvents(slot0)
	slot0._btnselect:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
end

function slot0.show(slot0, slot1, slot2, slot3, slot4)
	slot0._optionId = slot1
	slot0._count = slot4
	slot0._attributeMO = slot2.trainInfo:getEventOptionMOByOptionId(slot3, slot1).addAttriButes[1]
	slot0._attributeInfo = slot2:getAttributeInfoByType(slot0._attributeMO.attributeId)
	slot0._addAttributeValue = slot2.trainInfo:getAddAttributeValue(slot0._attributeMO.attributeId)
	slot0._attributeCo = CritterConfig.instance:getCritterAttributeCfg(slot0._attributeMO.attributeId)
	slot0._critterMo = slot2
	slot0._eventId = slot3

	slot0:_refreshItem()
end

function slot0._btncancelOnClick(slot0)
	if RoomTrainCritterModel.instance:getSelectOptionCount(slot0._optionId) <= 0 then
		return
	end

	RoomController.instance:dispatchEvent(RoomEvent.CritterTrainAttributeCancel, slot0._attributeCo.id, slot0._optionId)
end

function slot0._btnselectOnClick(slot0)
	gohelper.setActive(slot0._goselecteff, false)
	TaskDispatcher.cancelTask(slot0._playSelectFinished, slot0)

	if RoomTrainCritterModel.instance:getSelectOptionLimitCount() <= 0 then
		return
	end

	if slot0._count and slot0._count < 1 then
		gohelper.setActive(slot0._goselecteff, true)
		TaskDispatcher.runDelay(slot0._playSelectFinished, slot0, 0.34)
	end

	RoomController.instance:dispatchEvent(RoomEvent.CritterTrainAttributeSelected, slot0._attributeCo.id, slot0._optionId)
end

function slot0._playSelectFinished(slot0)
	gohelper.setActive(slot0._goselecteff, false)
end

function slot0._refreshItem(slot0)
	gohelper.setActive(slot0._goselectlight, slot0._count and slot0._count > 0)
	gohelper.setActive(slot0._btncancel.gameObject, slot0._count and slot0._count > 0)
	ZProj.TweenHelper.KillByObj(slot0.go)

	if not slot0.go.activeSelf then
		gohelper.setActive(slot0.go, true)
		ZProj.TweenHelper.DOFadeCanvasGroup(slot0.go, 0, 1, 0.6)
	end

	slot0._txtcontentdark.text = slot0._attributeCo.name

	UISpriteSetMgr.instance:setCritterSprite(slot0._imageicon, slot0._attributeCo.icon)

	slot0._txtnum.text = string.format("+%.02f", slot0._attributeMO.value)

	gohelper.setActive(slot0._gonum, slot0._count and slot0._count > 0)

	slot0._txtcountnum.text = slot0._count or 0
	slot1 = false

	if CritterConfig.instance:getCritterHeroPreferenceCfg(slot0._critterMo.trainInfo.heroId).effectAttribute == slot0._attributeMO.attributeId then
		slot1 = true
	end

	gohelper.setActive(slot0._goup, slot1)

	slot3 = slot0._attributeInfo.value + slot0._addAttributeValue
	slot6 = CritterConfig.instance:getCritterAttributeLevelCfgByValue(RoomTrainCritterModel.instance:getSelectOptionCount(slot0._optionId) * slot0._attributeMO.value + slot3).level

	if CritterConfig.instance:getCritterAttributeLevelCfgByValue(slot3).level == CritterConfig.instance:getMaxCritterAttributeLevelCfg().level then
		slot0._txtnum.text = string.format("+%.02f(MAX)", slot0._attributeMO.value)
	end

	gohelper.setActive(slot0._golvup, slot4 < slot6)
end

function slot0.destroy(slot0)
	slot0:_removeEvents()
	TaskDispatcher.cancelTask(slot0._playSelectFinished, slot0)
	ZProj.TweenHelper.KillByObj(slot0.go)
end

return slot0
