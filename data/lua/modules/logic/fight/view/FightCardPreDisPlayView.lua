module("modules.logic.fight.view.FightCardPreDisPlayView", package.seeall)

slot0 = class("FightCardPreDisPlayView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._viewClick = gohelper.getClickWithDefaultAudio(slot0.viewGO)
	slot0._scrollViewObj = gohelper.findChild(slot0.viewGO, "#scroll_handcards")
	slot0._cardRoot = gohelper.findChild(slot0.viewGO, "#scroll_handcards/Viewport/handcards")
	slot0._skillRoot = gohelper.findChild(slot0.viewGO, "Skill")
	slot0._skillNameText = gohelper.findChildText(slot0.viewGO, "Skill/#txt_SkillName")
	slot0._skillDesText = gohelper.findChildText(slot0.viewGO, "Skill/Scroll View/Viewport/#txt_SkillDescr")
	slot0._imageSkillBg = gohelper.findChild(slot0.viewGO, "Skill/image_SkillBG")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._viewClick, slot0._onBtnClose, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onBtnClose(slot0)
	if slot0._showSkillDesPart then
		slot0:_cancelSelect()

		return
	end

	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0._anchor = Vector2.New(1, 0.5)

	gohelper.setActive(slot0._skillRoot, false)
	NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._onBtnClose, slot0)

	slot0._cardDataList = slot0.viewParam

	slot0:_refreshUI()
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
	slot2 = slot1:GetResource()

	if #slot0._cardDataList > 5 then
		slot0._posX = -120
	else
		slot0._posX = -slot0._halfScrollWidth + (#slot0._cardDataList - 1) * slot0._cardDistance / 2
	end

	slot0._cardObjList = slot0:getUserDataTb_()

	slot0:com_createObjList(slot0._onItemShow, slot0._cardDataList, slot0._cardRoot, slot2)
	recthelper.setWidth(slot0._cardRoot.transform, -slot0._posX - slot0._halfCardWidth)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot4.anchorMin = slot0._anchor
	slot4.anchorMax = slot0._anchor

	recthelper.setAnchorX(slot4, slot0._posX)

	slot0._posX = slot0._posX - slot0._cardDistance

	MonoHelper.addNoUpdateLuaComOnceToGo(slot1, FightViewCardItem):updateItem(slot2.uid, slot2.skillId, slot2)
	slot0:addClickCb(gohelper.getClickWithDefaultAudio(slot1), slot0._onCardClick, slot0, slot3)
	table.insert(slot0._cardObjList, slot1)
end

function slot0._onCardClick(slot0, slot1)
	if slot0._curSelectIndex == slot1 then
		return
	end

	slot0:_releaseTween()

	if slot0._curSelectIndex then
		slot0:_cancelSelect()
	end

	slot0._showSkillDesPart = true

	gohelper.setActive(slot0._skillRoot, true)

	slot0._curSelectIndex = slot1
	slot0._curSelectCardInfo = slot0._cardDataList[slot1]

	slot0:_showSkillDes()

	slot3 = slot0._cardObjList[slot1].transform

	table.insert(slot0._tween, ZProj.TweenHelper.DOAnchorPosY(slot3, 27, 0.1))
	table.insert(slot0._tween, ZProj.TweenHelper.DOScale(slot3, 1.2, 1.2, 1, 0.1))

	slot4 = recthelper.rectToRelativeAnchorPos(slot3.position, slot0._scrollViewObj.transform).x
	slot6 = slot4 + slot0._halfCardWidth

	if slot4 - slot0._halfCardWidth < -slot0._halfScrollWidth then
		recthelper.setAnchorX(slot0._cardRoot.transform, recthelper.getAnchorX(slot0._cardRoot.transform) - (slot5 + slot0._halfScrollWidth) + 20)
	end

	if slot0._halfScrollWidth < slot6 then
		recthelper.setAnchorX(slot0._cardRoot.transform, recthelper.getAnchorX(slot0._cardRoot.transform) - (slot6 - slot0._halfScrollWidth) - 20)
	end
end

function slot0._releaseTween(slot0)
	if slot0._tween then
		for slot4, slot5 in ipairs(slot0._tween) do
			ZProj.TweenHelper.KillById(slot5)
		end
	end

	slot0._tween = {}
end

function slot0._cancelSelect(slot0)
	if slot0._curSelectIndex then
		gohelper.setActive(slot0._skillRoot, false)
		slot0:_releaseTween()
		table.insert(slot0._tween, ZProj.TweenHelper.DOAnchorPosY(slot0._cardObjList[slot0._curSelectIndex].transform, 0, 0.1))
		table.insert(slot0._tween, ZProj.TweenHelper.DOScale(slot0._cardObjList[slot0._curSelectIndex].transform, 1, 1, 1, 0.1))

		slot0._curSelectIndex = nil
		slot0._showSkillDesPart = false
	end
end

function slot0._showSkillDes(slot0)
	slot1 = lua_skill.configDict[slot0._curSelectCardInfo.skillId]
	slot0._skillNameText.text = slot1.name
	slot0._skillDesText.text = FightConfig.instance:getEntitySkillDesc(slot0._curSelectCardInfo.uid, slot1)

	if slot0._skillDesText.preferredHeight > 80 then
		recthelper.setHeight(slot0._imageSkillBg.transform, 270)
	else
		recthelper.setHeight(slot0._imageSkillBg.transform, 200)
	end
end

function slot0.onClose(slot0)
	slot0:_releaseTween()
end

function slot0.onDestroyView(slot0)
end

return slot0
