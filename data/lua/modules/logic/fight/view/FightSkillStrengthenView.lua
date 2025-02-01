module("modules.logic.fight.view.FightSkillStrengthenView", package.seeall)

slot0 = class("FightSkillStrengthenView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._btnObj = gohelper.findChild(slot0.viewGO, "#btn_Strenthen")
	slot0._btnConfirm = gohelper.getClickWithDefaultAudio(slot0._btnObj)
	slot0._scrollViewObj = gohelper.findChild(slot0.viewGO, "#scroll_handcards")
	slot0._cardRoot = gohelper.findChild(slot0.viewGO, "#scroll_handcards/Viewport/handcards")
	slot0._cardItem = gohelper.findChild(slot0.viewGO, "#scroll_handcards/Viewport/handcards/#go_item")
	slot0._nameText = gohelper.findChildText(slot0.viewGO, "CheckPoint/txt_CheckPointName")
	slot0._desText = gohelper.findChildText(slot0.viewGO, "CheckPoint/Scroll View/Viewport/#txt_Descr")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnConfirm, slot0._onBtnConfirm, slot0)
	FightController.instance:registerCallback(FightEvent.StartPlayClothSkill, slot0._onStartPlayClothSkill, slot0)
	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, slot0._onRespUseClothSkillFail, slot0)
end

function slot0.removeEvents(slot0)
	FightController.instance:unregisterCallback(FightEvent.StartPlayClothSkill, slot0._onStartPlayClothSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, slot0._onRespUseClothSkillFail, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onStartPlayClothSkill(slot0)
	slot0:closeThis()
end

function slot0._onRespUseClothSkillFail(slot0)
	slot0:closeThis()
end

function slot0._onBtnConfirm(slot0)
	if not slot0:_canOperate() then
		slot0:closeThis()

		return
	end

	if slot0._confirmed then
		return
	end

	slot0._confirmed = true

	FightRpc.instance:sendUseClothSkillRequest(slot0._upgradeId, slot0._entityId, slot0._optionIdList[slot0._curSelectIndex], FightEnum.ClothSkillType.HeroUpgrade)
end

function slot0.sort(slot0, slot1)
	return slot0 < slot1
end

function slot0._canOperate(slot0)
	return FightModel.instance:getCurStage() == FightEnum.Stage.Card
end

function slot0._onBtnEsc(slot0)
end

function slot0.onOpen(slot0)
	NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._onBtnEsc, slot0)

	if table.remove(slot0.viewParam, 1) then
		slot0._upgradeId = slot1.id
		slot0._entityId = slot1.entityId
		slot0._optionIdList = slot1.optionIds

		slot0:_refreshUI()
	else
		slot0:closeThis()
	end
end

function slot0._refreshUI(slot0)
	slot0:com_loadAsset("ui/viewres/fight/fightcarditem.prefab", slot0._onLoadFinish)
end

function slot0._onLoadFinish(slot0, slot1)
	slot0._cardWidth = 180
	slot0._halfCardWidth = slot0._cardWidth / 2
	slot0._cardDistance = slot0._cardWidth + 40
	slot0._scrollWidth = recthelper.getWidth(slot0._scrollViewObj.transform)
	slot0._halfScrollWidth = slot0._scrollWidth / 2

	gohelper.clone(slot1:GetResource(), gohelper.findChild(slot0._cardItem, "#go_carditem"), "card")

	if #slot0._optionIdList > 5 then
		slot0._posX = 120
	else
		slot0._posX = -slot0._halfScrollWidth - (#slot0._optionIdList - 1) * slot0._cardDistance / 2
	end

	slot0._cardObjList = slot0:getUserDataTb_()
	slot0._skillList = {}

	slot0:com_createObjList(slot0._onItemShow, slot0._optionIdList, slot0._cardRoot, slot0._cardItem)
	recthelper.setWidth(slot0._cardRoot.transform, -slot0._posX - slot0._halfCardWidth + slot0._cardDistance)
	slot0:_onCardClick(1)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot5 = lua_hero_upgrade_options.configDict[slot2].showSkillId
	slot0._skillList[slot3] = slot5

	if not slot5 then
		gohelper.setActive(slot1, false)

		return
	end

	slot6 = slot1.transform
	slot6.anchorMin = Vector2.New(1, 0.5)
	slot6.anchorMax = Vector2.New(1, 0.5)

	recthelper.setAnchorX(slot6, slot0._posX)

	slot0._posX = slot0._posX + slot0._cardDistance

	MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot1, "#go_carditem/card"), FightViewCardItem):updateItem(slot0._entityId, slot5)
	slot0:addClickCb(gohelper.getClickWithDefaultAudio(slot1), slot0._onCardClick, slot0, slot3)
	table.insert(slot0._cardObjList, slot1)
end

function slot0._onCardClick(slot0, slot1)
	if slot0._curSelectIndex == slot1 then
		return
	end

	slot0._curSelectIndex = slot1

	for slot5, slot6 in ipairs(slot0._cardObjList) do
		gohelper.setActive(gohelper.findChild(slot6, "#go_Frame"), slot5 == slot0._curSelectIndex)
	end

	slot0:_showSkillDes()

	slot4 = recthelper.rectToRelativeAnchorPos(slot0._cardObjList[slot1].transform.position, slot0._scrollViewObj.transform).x
	slot6 = slot4 + slot0._halfCardWidth

	if slot4 - slot0._halfCardWidth < -slot0._halfScrollWidth then
		recthelper.setAnchorX(slot0._cardRoot.transform, recthelper.getAnchorX(slot0._cardRoot.transform) - (slot5 + slot0._halfScrollWidth) + 20)
	end

	if slot0._halfScrollWidth < slot6 then
		recthelper.setAnchorX(slot0._cardRoot.transform, recthelper.getAnchorX(slot0._cardRoot.transform) - (slot6 - slot0._halfScrollWidth) - 20)
	end
end

function slot0._showSkillDes(slot0)
	slot3 = lua_hero_upgrade_options.configDict[slot0._optionIdList[slot0._curSelectIndex]]
	slot0._nameText.text = slot3.title
	slot4, slot5 = SkillConfig.instance:getExSkillDesc(slot3, lua_hero_upgrade.configDict[slot0._upgradeId].heroId)
	slot0._desText.text = HeroSkillModel.instance:formatDescWithColor(string.gsub(slot4, "▩(%d)%%s", slot5))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
