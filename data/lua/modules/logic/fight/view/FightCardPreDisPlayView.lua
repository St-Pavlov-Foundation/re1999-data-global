module("modules.logic.fight.view.FightCardPreDisPlayView", package.seeall)

local var_0_0 = class("FightCardPreDisPlayView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._viewClick = gohelper.getClickWithDefaultAudio(arg_1_0.viewGO)
	arg_1_0._scrollViewObj = gohelper.findChild(arg_1_0.viewGO, "#scroll_handcards")
	arg_1_0._cardRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_handcards/Viewport/handcards")
	arg_1_0._skillRoot = gohelper.findChild(arg_1_0.viewGO, "Skill")
	arg_1_0._skillNameText = gohelper.findChildText(arg_1_0.viewGO, "Skill/#txt_SkillName")
	arg_1_0._skillDesText = gohelper.findChildText(arg_1_0.viewGO, "Skill/Scroll View/Viewport/#txt_SkillDescr")
	arg_1_0._imageSkillBg = gohelper.findChild(arg_1_0.viewGO, "Skill/image_SkillBG")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._viewClick, arg_2_0._onBtnClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onBtnClose(arg_5_0)
	if arg_5_0._showSkillDesPart then
		arg_5_0:_cancelSelect()

		return
	end

	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._anchor = Vector2.New(1, 0.5)

	gohelper.setActive(arg_6_0._skillRoot, false)
	NavigateMgr.instance:addEscape(arg_6_0.viewContainer.viewName, arg_6_0._onBtnClose, arg_6_0)

	arg_6_0._cardDataList = arg_6_0.viewParam

	arg_6_0:_refreshUI()
end

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = "ui/viewres/fight/fightcarditem.prefab"

	arg_7_0:com_loadAsset(var_7_0, arg_7_0._onLoadFinish)
end

function var_0_0._onLoadFinish(arg_8_0, arg_8_1)
	arg_8_0._cardWidth = 180
	arg_8_0._halfCardWidth = arg_8_0._cardWidth / 2
	arg_8_0._cardDistance = arg_8_0._cardWidth + 40
	arg_8_0._scrollWidth = recthelper.getWidth(arg_8_0._scrollViewObj.transform)
	arg_8_0._halfScrollWidth = arg_8_0._scrollWidth / 2

	local var_8_0 = arg_8_1:GetResource()

	if #arg_8_0._cardDataList > 5 then
		arg_8_0._posX = -120
	else
		arg_8_0._posX = -arg_8_0._halfScrollWidth + (#arg_8_0._cardDataList - 1) * arg_8_0._cardDistance / 2
	end

	arg_8_0._cardObjList = arg_8_0:getUserDataTb_()

	arg_8_0:com_createObjList(arg_8_0._onItemShow, arg_8_0._cardDataList, arg_8_0._cardRoot, var_8_0)
	recthelper.setWidth(arg_8_0._cardRoot.transform, -arg_8_0._posX - arg_8_0._halfCardWidth)
end

function var_0_0._onItemShow(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_1.transform

	var_9_0.anchorMin = arg_9_0._anchor
	var_9_0.anchorMax = arg_9_0._anchor

	recthelper.setAnchorX(var_9_0, arg_9_0._posX)

	arg_9_0._posX = arg_9_0._posX - arg_9_0._cardDistance

	MonoHelper.addNoUpdateLuaComOnceToGo(arg_9_1, FightViewCardItem):updateItem(arg_9_2.uid, arg_9_2.skillId, arg_9_2)

	local var_9_1 = gohelper.getClickWithDefaultAudio(arg_9_1)

	arg_9_0:addClickCb(var_9_1, arg_9_0._onCardClick, arg_9_0, arg_9_3)
	table.insert(arg_9_0._cardObjList, arg_9_1)
end

function var_0_0._onCardClick(arg_10_0, arg_10_1)
	if arg_10_0._curSelectIndex == arg_10_1 then
		return
	end

	arg_10_0:_releaseTween()

	if arg_10_0._curSelectIndex then
		arg_10_0:_cancelSelect()
	end

	arg_10_0._showSkillDesPart = true

	gohelper.setActive(arg_10_0._skillRoot, true)

	arg_10_0._curSelectIndex = arg_10_1
	arg_10_0._curSelectCardInfo = arg_10_0._cardDataList[arg_10_1]

	arg_10_0:_showSkillDes()

	local var_10_0 = arg_10_0._cardObjList[arg_10_1].transform

	table.insert(arg_10_0._tween, ZProj.TweenHelper.DOAnchorPosY(var_10_0, 27, 0.1))
	table.insert(arg_10_0._tween, ZProj.TweenHelper.DOScale(var_10_0, 1.2, 1.2, 1, 0.1))

	local var_10_1 = recthelper.rectToRelativeAnchorPos(var_10_0.position, arg_10_0._scrollViewObj.transform).x
	local var_10_2 = var_10_1 - arg_10_0._halfCardWidth
	local var_10_3 = var_10_1 + arg_10_0._halfCardWidth

	if var_10_2 < -arg_10_0._halfScrollWidth then
		local var_10_4 = var_10_2 + arg_10_0._halfScrollWidth

		recthelper.setAnchorX(arg_10_0._cardRoot.transform, recthelper.getAnchorX(arg_10_0._cardRoot.transform) - var_10_4 + 20)
	end

	if var_10_3 > arg_10_0._halfScrollWidth then
		local var_10_5 = var_10_3 - arg_10_0._halfScrollWidth

		recthelper.setAnchorX(arg_10_0._cardRoot.transform, recthelper.getAnchorX(arg_10_0._cardRoot.transform) - var_10_5 - 20)
	end
end

function var_0_0._releaseTween(arg_11_0)
	if arg_11_0._tween then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._tween) do
			ZProj.TweenHelper.KillById(iter_11_1)
		end
	end

	arg_11_0._tween = {}
end

function var_0_0._cancelSelect(arg_12_0)
	if arg_12_0._curSelectIndex then
		gohelper.setActive(arg_12_0._skillRoot, false)
		arg_12_0:_releaseTween()
		table.insert(arg_12_0._tween, ZProj.TweenHelper.DOAnchorPosY(arg_12_0._cardObjList[arg_12_0._curSelectIndex].transform, 0, 0.1))
		table.insert(arg_12_0._tween, ZProj.TweenHelper.DOScale(arg_12_0._cardObjList[arg_12_0._curSelectIndex].transform, 1, 1, 1, 0.1))

		arg_12_0._curSelectIndex = nil
		arg_12_0._showSkillDesPart = false
	end
end

function var_0_0._showSkillDes(arg_13_0)
	local var_13_0 = lua_skill.configDict[arg_13_0._curSelectCardInfo.skillId]

	arg_13_0._skillNameText.text = var_13_0.name
	arg_13_0._skillDesText.text = FightConfig.instance:getEntitySkillDesc(arg_13_0._curSelectCardInfo.uid, var_13_0)

	if arg_13_0._skillDesText.preferredHeight > 80 then
		recthelper.setHeight(arg_13_0._imageSkillBg.transform, 270)
	else
		recthelper.setHeight(arg_13_0._imageSkillBg.transform, 200)
	end
end

function var_0_0.onClose(arg_14_0)
	arg_14_0:_releaseTween()
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
