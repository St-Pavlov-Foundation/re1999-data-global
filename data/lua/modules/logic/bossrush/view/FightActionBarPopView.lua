module("modules.logic.bossrush.view.FightActionBarPopView", package.seeall)

slot0 = class("FightActionBarPopView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._closeBtn = gohelper.findChildButton(slot0.viewGO, "#btn_close")
	slot0._content = gohelper.findChild(slot0.viewGO, "middle/#go_cardcontent")
	slot0._itemModel = gohelper.findChild(slot0.viewGO, "middle/#go_cardcontent/card")
	slot0._cardItem = gohelper.findChild(slot0.viewGO, "middle/#go_cardcontent/card/cardItem")
	slot0._cardRoot = gohelper.findChild(slot0.viewGO, "middle/#go_cardcontent/card/cardItem/root")
	slot0._skillName = gohelper.findChildText(slot0.viewGO, "bottom/skillname")
	slot0._skillDes = gohelper.findChildText(slot0.viewGO, "bottom/#scroll_txt/Viewport/Content/skilldesc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._closeBtn, slot0._onCloseBtn, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	SkillHelper.addHyperLinkClick(slot0._skillDes)

	slot0._skillName.text = ""
	slot0._skillDes.text = ""
end

function slot0._onCloseBtn(slot0)
	slot0:closeThis()
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.entityId = slot0.viewParam.entityId

	slot0:com_loadAsset("ui/viewres/fight/fightcarditem.prefab", slot0._onLoadFinish)
end

function slot0._onLoadFinish(slot0, slot1)
	gohelper.clone(slot1:GetResource(), slot0._cardRoot).name = "card"
	slot0._cardObjList = slot0:getUserDataTb_()
	slot0._cardCount = 0

	table.insert(slot0.viewParam.dataList, 1, 0)

	slot7 = slot0.viewParam.dataList
	slot8 = slot0._content

	slot0:com_createObjList(slot0._onItemShow, slot7, slot8, slot0._itemModel)

	for slot7, slot8 in ipairs(slot0._cardObjList) do
		if tonumber(slot8.name) ~= 0 then
			slot0:_onCardClick(slot8)

			break
		end
	end
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	if slot3 <= 1 then
		return
	end

	if slot0._cardCount >= 6 then
		gohelper.setActive(slot1, false)

		return
	end

	gohelper.setActive(slot1, true)

	gohelper.findChildText(slot1, "#go_select/#txt_round").text = FightModel.instance:getCurRoundId() + slot3 - 2
	gohelper.findChildText(slot1, "#go_unselect/#txt_round").text = FightModel.instance:getCurRoundId() + slot3 - 2

	table.insert(slot2, 1, 0)
	table.insert(slot2, 1, 0)
	slot0:com_createObjList(slot0._onCardItemShow, slot2, slot1, slot0._cardItem)
	gohelper.setActive(gohelper.findChild(slot1, "#go_select"), slot3 == 2)
	gohelper.setActive(gohelper.findChild(slot1, "#go_unselect"), slot3 ~= 2)
end

function slot0._onCardItemShow(slot0, slot1, slot2, slot3)
	if slot3 <= 2 then
		return
	end

	slot0._cardCount = slot0._cardCount + 1

	if slot0._cardCount > 6 then
		gohelper.setActive(slot1, false)

		return
	end

	gohelper.setActive(slot1, true)

	slot1.name = slot2.skillId
	slot5 = gohelper.findChild(slot1, "root/card")

	gohelper.setActive(gohelper.findChild(slot1, "chant"), slot2.isChannelSkill)

	gohelper.findChildText(slot1, "chant/round").text = slot2.round or 0

	gohelper.setActive(slot5, slot4 ~= 0)
	gohelper.setActive(gohelper.findChild(slot1, "empty"), slot4 == 0)

	slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot5, FightViewCardItem, FightEnum.CardShowType.BossAction)

	if slot4 ~= 0 then
		slot9:updateItem(slot0.viewParam.entityId, slot4)

		for slot14, slot15 in ipairs(slot9._lvImgComps) do
			SLFramework.UGUI.GuiHelper.SetColor(slot15, slot2.isChannelSkill and "#666666" or "#FFFFFF")
		end
	end

	slot0:addClickCb(gohelper.getClickWithDefaultAudio(slot1), slot0._onCardClick, slot0, slot1)
	table.insert(slot0._cardObjList, slot1)
end

function slot0._onCardClick(slot0, slot1)
	if tonumber(slot1.name) == 0 then
		return
	end

	if slot0._curSelectObj == slot1 then
		return
	end

	slot0._curSelectObj = slot1
	slot3 = lua_skill.configDict[slot2]

	for slot7, slot8 in ipairs(slot0._cardObjList) do
		slot9 = FightConfig.instance:isUniqueSkill(slot2)

		gohelper.setActive(gohelper.findChild(slot8, "select"), slot1 == slot8 and not slot9)
		gohelper.setActive(gohelper.findChild(slot8, "uniqueSelect"), slot1 == slot8 and slot9)
	end

	if slot3 then
		slot0._skillName.text = slot3.name
		slot0._skillDes.text = SkillHelper.getEntityDescBySkillCo(slot0.entityId, slot3, "#DB945B", "#5C86DA")
	else
		logError("技能表找不到id:" .. slot2)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
