module("modules.logic.fight.view.FightCardDeckView", package.seeall)

slot0 = class("FightCardDeckView", BaseViewExtended)

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
	slot0:addEventCb(FightController.instance, FightEvent.GetFightCardDeckInfoReply, slot0._onGetFightCardDeckInfoReply, slot0)
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

slot0.SelectType = {
	CardBox = 1,
	PreCard = 2
}

function slot0.onOpen(slot0)
	slot0._cardItemDic = {}
	slot0._selectType = slot0.viewParam and slot0.viewParam.selectType or uv0.SelectType.CardBox

	slot0:_refreshBtn()
	slot0:_refreshBtnState()
	slot0:com_loadAsset("ui/viewres/fight/fightcarditem.prefab", slot0._onCardLoadFinish)
end

function slot0._startRefreshUI(slot0)
	slot0:addClickCb(slot0._btnCardBox, slot0._onCardBoxClick, slot0)
	slot0:addClickCb(slot0._btnCardPre, slot0._onCardPreClick, slot0)
	slot0:_refreshUI()
end

function slot0._onCardBoxClick(slot0)
	slot0._selectType = uv0.SelectType.CardBox

	slot0:_refreshUI()
	slot0:_refreshBtnState()
end

function slot0._onCardPreClick(slot0)
	slot0._selectType = uv0.SelectType.PreCard

	slot0:_refreshUI()
	slot0:_refreshBtnState()
end

function slot0._onCardLoadFinish(slot0, slot1)
	gohelper.clone(slot1:GetResource(), gohelper.findChild(slot0._cardItem, "card"), "card")
	gohelper.setActive(gohelper.findChild(slot0._cardItem, "select"), false)
	slot0:_startRefreshUI()
end

function slot0._onGetFightCardDeckInfoReply(slot0, slot1)
	slot0._boxList = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.deckInfos) do
		slot8 = FightCardInfoMO.New()

		slot8:init(slot7)

		if not slot2[slot8.uid] then
			slot2[slot9] = {}
		end

		if not slot10[slot8.skillId] then
			slot10[slot11] = {
				{},
				{}
			}
		end

		if slot8.tempCard then
			table.insert(slot10[slot11][1], slot8)
		else
			table.insert(slot10[slot11][2], slot8)
		end
	end

	for slot6, slot7 in pairs(slot2) do
		for slot11, slot12 in pairs(slot7) do
			if #slot12[1] > 0 then
				table.insert(slot0._boxList, {
					skillId = slot11,
					tempCard = true,
					entityId = slot6,
					num = #slot12[1]
				})
			end

			if #slot12[2] > 0 then
				table.insert(slot0._boxList, {
					skillId = slot11,
					entityId = slot6,
					num = #slot12[2]
				})
			end
		end
	end

	if slot0._selectType == uv0.SelectType.CardBox then
		slot0:_refreshCardBox()
	end
end

function slot0._refreshUI(slot0)
	if slot0._selectType == uv0.SelectType.CardBox then
		if slot0._boxList then
			slot0:_refreshCardBox()
		else
			FightRpc.instance:sendGetFightCardDeckInfoRequest(FightRpc.DeckInfoRequestType.MySide)
		end
	else
		slot0:_refreshPreCard()
	end
end

function slot0.sortCardBox(slot0, slot1)
	if not FightDataHelper.entityMgr:getById(slot0.entityId) and FightDataHelper.entityMgr:getById(slot1.entityId) then
		return true
	elseif slot2 and not slot3 then
		return false
	elseif not slot2 and not slot3 then
		return slot0.skillId < slot1.skillId
	elseif slot2.position < slot3.position then
		return true
	elseif slot5 < slot4 then
		return false
	elseif slot0.skillId == slot1.skillId then
		if slot0.tempCard and not slot1.tempCard then
			return true
		elseif not slot0.tempCard and slot1.tempCard then
			return false
		else
			return slot0.skillId < slot1.skillId
		end
	else
		return slot0.skillId < slot1.skillId
	end
end

function slot0._refreshCardBox(slot0)
	table.sort(slot0._boxList, uv0.sortCardBox)
	slot0:com_createObjList(slot0._onCardItemShow, slot0._boxList, slot0._cardRoot, slot0._cardItem)

	if #slot0._boxList == 0 then
		slot0._nameText.text = ""
		slot0._skillText.text = ""
	end

	if #slot0._boxList > 6 then
		recthelper.setHeight(slot0._cardMask, 480)
	else
		recthelper.setHeight(slot0._cardMask, 320)
	end
end

function slot0._refreshPreCard(slot0)
	slot0:com_createObjList(slot0._onCardItemShow, slot0._preCardList, slot0._cardRoot, slot0._cardItem)

	if #slot0._preCardList == 0 then
		slot0._nameText.text = ""
		slot0._skillText.text = ""
	end

	if #slot0._preCardList > 6 then
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

	if slot0._selectType == uv0.SelectType.CardBox then
		slot5:showCount(slot2.num)
	end

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
	gohelper.setActive(slot0._cardBoxSelect, slot0._selectType == uv0.SelectType.CardBox)
	gohelper.setActive(slot0._cardBoxUnselect, slot0._selectType ~= uv0.SelectType.CardBox)
	gohelper.setActive(slot0._cardPreSelect, slot0._selectType == uv0.SelectType.PreCard)
	gohelper.setActive(slot0._cardPreUnselect, slot0._selectType ~= uv0.SelectType.PreCard)
end

function slot0._refreshBtn(slot0)
	slot0._preCardList = FightHelper.getNextRoundGetCardList()

	gohelper.setActive(slot0._btnCardPre.gameObject, #slot0._preCardList > 0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
