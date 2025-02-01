module("modules.logic.fight.view.FightAttributeTipView", package.seeall)

slot0 = class("FightAttributeTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._goattributetipcontent = gohelper.findChild(slot0.viewGO, "main/bg/content")
	slot0.attrList = {
		"attack",
		"technic",
		"defense",
		"mdefense"
	}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._onReceiveEntityInfoReply(slot0, slot1)
	slot0._proto = slot1

	if not slot0._proto.entityInfo then
		slot0:closeThis()

		return
	end

	slot0.isCharacter = slot0.viewParam.isCharacter
	slot0.attrMO = slot0.viewParam.mo

	if slot0.isCharacter then
		gohelper.CreateObjList(slot0, slot0._onAttributeTipShow, slot0.viewParam.data, slot0._goattributetipcontent)
	else
		gohelper.CreateObjList(slot0, slot0._onMonsterAttrItemShow, slot2, slot0._goattributetipcontent)
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, slot0._onReceiveEntityInfoReply, slot0)
	FightRpc.instance:sendEntityInfoRequest(slot0.viewParam.entityMO.id)
end

function slot0._onAttributeTipShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot7 = HeroConfig.instance:getHeroAttributeCO(slot2.id)

	UISpriteSetMgr.instance:setCommonSprite(slot4:Find("icon"):GetComponent(gohelper.Type_Image), "icon_att_" .. slot7.id)

	slot8 = slot4:Find("num"):GetComponent(gohelper.Type_TextMesh)

	gohelper.setActive(slot8.gameObject, true)

	slot9 = slot0._proto.entityInfo.baseAttr[slot0.attrList[slot3]]
	slot8.text = slot9
	slot4:Find("name"):GetComponent(gohelper.Type_TextMesh).text = slot7.name

	return

	slot4:Find("add"):GetComponent(gohelper.Type_TextMesh).text = slot0:_getAddValueStr(slot9, slot0._proto.entityInfo.attr[slot0.attrList[slot3]])
end

function slot0._getAddValueStr(slot0, slot1, slot2)
	if slot2 - slot1 >= 0 then
		return "+" .. slot3
	end

	return slot3
end

function slot0._onMonsterAttrItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot7 = HeroConfig.instance:getHeroAttributeCO(slot2.id)
	slot4:Find("name"):GetComponent(gohelper.Type_TextMesh).text = slot7.name

	UISpriteSetMgr.instance:setCommonSprite(slot4:Find("icon"):GetComponent(gohelper.Type_Image), "icon_att_" .. slot7.id)

	slot8 = slot4:Find("num"):GetComponent(gohelper.Type_TextMesh)
	slot9 = slot4:Find("add"):GetComponent(gohelper.Type_TextMesh)

	if slot0.isCharacter then
		gohelper.setActive(slot8.gameObject, true)
		gohelper.setActive(slot9.gameObject, true)
		gohelper.setActive(slot4:Find("rate"):GetComponent(gohelper.Type_Image).gameObject, false)

		slot8.text = slot0.attrMo[slot0.attrList[slot3]]
		slot9.text = slot0:_getAddValueStr(slot0._proto.entityInfo.baseAttr[slot0.attrList[slot3]], slot0._proto.entityInfo.attr[slot0.attrList[slot3]])
	else
		gohelper.setActive(slot8.gameObject, false)
		gohelper.setActive(slot9.gameObject, false)
		gohelper.setActive(slot10.gameObject, true)
		UISpriteSetMgr.instance:setCommonSprite(slot10, "sx_" .. slot2.value, true)
	end
end

return slot0
