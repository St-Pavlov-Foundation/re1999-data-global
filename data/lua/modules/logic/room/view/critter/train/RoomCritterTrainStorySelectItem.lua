module("modules.logic.room.view.critter.train.RoomCritterTrainStorySelectItem", package.seeall)

slot0 = class("RoomCritterTrainStorySelectItem")

function slot0.init(slot0, slot1, slot2)
	slot0.go = gohelper.cloneInPlace(slot1, string.format("selectItem%s", slot2))

	gohelper.setActive(slot0.go, false)

	slot0._gobgdark = gohelper.findChild(slot0.go, "bgdark")
	slot0._imageicon = gohelper.findChildImage(slot0.go, "bgdark/icon")
	slot0._txtcontentdark = gohelper.findChildText(slot0.go, "bgdark/txtcontentdark")
	slot0._txtnum = gohelper.findChildText(slot0.go, "bgdark/#txt_num")
	slot0._btnselect = gohelper.findChildButtonWithAudio(slot0.go, "btnselect")
	slot0._golvup = gohelper.findChild(slot0.go, "go_lvup")
	slot0._txtlvup = gohelper.findChildText(slot0.go, "go_lvup/txt_lvup")
	slot0._goup = gohelper.findChild(slot0.go, "go_up")

	gohelper.setActive(slot0._golvup, false)
	slot0:_addEvents()
end

function slot0._addEvents(slot0)
	slot0._btnselect:AddClickListener(slot0._btnselectOnClick, slot0)
end

function slot0._removeEvents(slot0)
	slot0._btnselect:RemoveClickListener()
end

function slot0.show(slot0, slot1, slot2, slot3)
	slot0._optionId = slot1
	slot0._attributeMO = slot2.trainInfo:getEventOptionMOByOptionId(slot3, slot1).addAttriButes[1]
	slot0._attributeInfo = slot2:getAttributeInfoByType(slot0._attributeMO.attributeId)
	slot0._addAttributeValue = slot2.trainInfo:getAddAttributeValue(slot0._attributeMO.attributeId)
	slot0._attributeCo = CritterConfig.instance:getCritterAttributeCfg(slot0._attributeMO.attributeId)
	slot0._critterMo = slot2
	slot0._eventId = slot3

	gohelper.setActive(slot0.go, true)
	slot0:_refreshItem()
end

function slot0._btnselectOnClick(slot0)
	slot2 = string.splitToNumber(CritterConfig.instance:getCritterTrainEventCfg(slot0._eventId).cost, "#")

	if CurrencyModel.instance:getCurrency(slot2[2]).quantity < slot2[3] then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterTrainCurrencyInsufficiency, MsgBoxEnum.BoxType.Yes_No, slot0._onSelectFinished, nil, , slot0, nil, , CurrencyConfig.instance:getCurrencyCo(slot2[2]).name)
	else
		slot0:_onSelectFinished()
	end
end

function slot0._onSelectFinished(slot0)
	RoomController.instance:dispatchEvent(RoomEvent.CritterTrainAttributeSelected, slot0._attributeCo.id, slot0._optionId)
end

function slot0._refreshItem(slot0)
	ZProj.TweenHelper.KillByObj(slot0.go)
	ZProj.TweenHelper.DOFadeCanvasGroup(slot0.go, 0, 1, 0.6)

	slot0._txtcontentdark.text = slot0._attributeCo.name

	UISpriteSetMgr.instance:setCritterSprite(slot0._imageicon, slot0._attributeCo.icon)

	slot0._txtnum.text = "+" .. string.format("%.02f", slot0._attributeMO.value)
	slot1 = false

	if CritterConfig.instance:getCritterHeroPreferenceCfg(slot0._critterMo.trainInfo.heroId).effectAttribute == slot0._attributeMO.attributeId then
		slot1 = true
	end

	gohelper.setActive(slot0._goup, slot1)

	slot3 = slot0._attributeInfo.value + slot0._addAttributeValue

	gohelper.setActive(slot0._golvup, CritterConfig.instance:getCritterAttributeLevelCfgByValue(slot3).level < CritterConfig.instance:getCritterAttributeLevelCfgByValue(slot0._attributeMO.value + slot3).level)
end

function slot0.destroy(slot0)
	slot0:_removeEvents()
	ZProj.TweenHelper.KillByObj(slot0.go)
end

return slot0
