module("modules.logic.fight.view.FightCardDeckGMView", package.seeall)

slot0 = class("FightCardDeckGMView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._click = gohelper.getClick(slot0.viewGO)
	slot0._btnCardBox = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "topTab/#btn_cardbox")
	slot0._cardBoxSelect = gohelper.findChild(slot0.viewGO, "topTab/#btn_cardbox/select")
	slot0._cardBoxUnselect = gohelper.findChild(slot0.viewGO, "topTab/#btn_cardbox/unselect")
	slot0._btnCardPre = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "topTab/#btn_cardpre")
	slot0._cardPreSelect = gohelper.findChild(slot0.viewGO, "topTab/#btn_cardpre/select")
	slot0._cardPreUnselect = gohelper.findChild(slot0.viewGO, "topTab/#btn_cardpre/unselect")
	slot0._cardRoot = gohelper.findChild(slot0.viewGO, "layout/#scroll_card/Viewport/Content")
	slot0._cardItem = gohelper.findChild(slot0.viewGO, "layout/#scroll_card/Viewport/Content/#go_carditem")
	slot0._nameText = gohelper.findChildText(slot0.viewGO, "layout/#scroll_card/#txt_skillname")
	slot0._skillText = gohelper.findChildText(slot0.viewGO, "layout/#scroll_card/#scroll_skill/viewport/content/#txt_skilldec")
	slot0._cardMask = gohelper.findChild(slot0.viewGO, "layout/#scroll_card/Viewport").transform

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._click, slot0._onViewClick, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._nameText.text = ""
	slot0._skillText.text = ""
end

function slot0._onViewClick(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0._proto = slot0.viewParam
	slot0._cardItemDic = {}

	slot0:_refreshBtn()
	slot0:_refreshBtnState()
	slot0:com_loadAsset("ui/viewres/fight/fightcarditem.prefab", slot0._onCardLoadFinish)
end

function slot0._startRefreshUI(slot0)
	slot0:_refreshUI()
end

function slot0._onCardLoadFinish(slot0, slot1)
	gohelper.clone(slot1:GetResource(), gohelper.findChild(slot0._cardItem, "card"), "card")
	gohelper.setActive(gohelper.findChild(slot0._cardItem, "select"), false)
	slot0:_startRefreshUI()
end

function slot0._refreshUI(slot0)
	slot0._cardDataList = {}

	for slot4, slot5 in ipairs(slot0._proto.deckInfos) do
		table.insert(slot0._cardDataList, {
			entityId = slot5.uid,
			skillId = slot5.skillId,
			num = slot5.num
		})
	end

	slot0:com_createObjList(slot0._onCardItemShow, slot0._cardDataList, slot0._cardRoot, slot0._cardItem)

	if #slot0._cardDataList == 0 then
		slot0._nameText.text = ""
		slot0._skillText.text = ""
	end

	if #slot0._cardDataList > 6 then
		recthelper.setHeight(slot0._cardMask, 480)
	else
		recthelper.setHeight(slot0._cardMask, 320)
	end
end

function slot0._onCardItemShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1, false)
	gohelper.setActive(slot1, true)

	if not slot0._cardItemDic[slot1:GetInstanceID()] then
		slot0._cardItemDic[slot4] = slot0:openSubView(FightCardDeckViewItem, slot1)

		slot0:addClickCb(gohelper.getClickWithDefaultAudio(gohelper.findChild(slot1, "card")), slot0._onCardItemClick, slot0, slot4)
	end

	slot5:refreshItem(slot2)

	if slot3 == 1 then
		slot0:_onCardItemClick(slot4)
	end
end

function slot0._onCardItemClick(slot0, slot1)
	slot2 = slot0._cardItemDic[slot1]

	if slot0._curSelectItem then
		slot0._curSelectItem:setSelect(false)
	end

	slot0._curSelectItem = slot2

	slot0._curSelectItem:setSelect(true)

	slot3 = slot2._data
	slot6 = lua_skill.configDict[slot3.skillId]
	slot0._nameText.text = slot6.name
	slot0._skillText.text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getEntitySkillDesc(slot3.entityId, slot6), "#c56131", "#7c93ad")
end

function slot0._refreshBtnState(slot0)
	gohelper.setActive(slot0._cardBoxSelect, true)
	gohelper.setActive(slot0._cardBoxUnselect, false)
	gohelper.setActive(slot0._cardPreSelect, false)
	gohelper.setActive(slot0._cardPreUnselect, false)
end

function slot0._refreshBtn(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
