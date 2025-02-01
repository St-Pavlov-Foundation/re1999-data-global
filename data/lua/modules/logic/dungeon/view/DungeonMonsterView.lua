module("modules.logic.dungeon.view.DungeonMonsterView", package.seeall)

slot0 = class("DungeonMonsterView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagequality = gohelper.findChildImage(slot0.viewGO, "desc/#simage_quality")
	slot0._simageicon = gohelper.findChildImage(slot0.viewGO, "desc/#simage_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "desc/#txt_name")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "desc/#txt_desc")
	slot0._simagecareericon = gohelper.findChildImage(slot0.viewGO, "desc/#simage_careericon")
	slot0._scrollmonster = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_monster")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "content_prefab/#go_selected")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnbackOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	DungeonMonsterListModel.instance:setMonsterList(slot0.viewParam.monsterDisplayList)
	slot0.viewContainer:getScrollView():setSelect(DungeonMonsterListModel.instance.initSelectMO)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeMonster, slot0._onChangeMonster, slot0)
end

function slot0.onClose(slot0)
end

function slot0._onChangeMonster(slot0, slot1)
	slot0._txtname.text = slot1.name
	slot0._txtdesc.text = slot1.des

	UISpriteSetMgr.instance:setCommonSprite(slot0._simagecareericon, "lssx_" .. tostring(slot1.career))

	if FightConfig.instance:getSkinCO(slot1.skinId) and slot2.headIcon or nil then
		gohelper.getSingleImage(slot0._simageicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(slot3))
	end

	UISpriteSetMgr.instance:setCommonSprite(slot0._simagequality, "bp_quality_01")
end

function slot0.onDestroyView(slot0)
end

return slot0
