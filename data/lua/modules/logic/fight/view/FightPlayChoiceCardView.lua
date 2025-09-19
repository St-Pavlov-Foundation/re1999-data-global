module("modules.logic.fight.view.FightPlayChoiceCardView", package.seeall)

local var_0_0 = class("FightPlayChoiceCardView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.maskClick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "Mask")
	arg_1_0.click = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_Coping/clickarea")
	arg_1_0.gridRoot = gohelper.findChild(arg_1_0.viewGO, "root/grid")
	arg_1_0._scrollViewObj = gohelper.findChild(arg_1_0.viewGO, "#scroll_handcards")
	arg_1_0._cardRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_handcards/Viewport/handcards")
	arg_1_0._cardItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_handcards/Viewport/handcards/#go_item")
	arg_1_0._nameText = gohelper.findChildText(arg_1_0.viewGO, "CheckPoint/txt_CheckPointName")
	arg_1_0._desText = gohelper.findChildText(arg_1_0.viewGO, "CheckPoint/Scroll View/Viewport/#txt_Descr")
	arg_1_0.titleText = gohelper.findChildText(arg_1_0.viewGO, "Title/txt_Title")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.click, arg_2_0.onBtnConfirm)
	arg_2_0:com_registClick(arg_2_0.maskClick, arg_2_0.closeThis)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.cardData = arg_5_0.viewParam.cardData
	arg_5_0.choiceConfig = arg_5_0.viewParam.config
	arg_5_0.callback = arg_5_0.viewParam.callback
	arg_5_0.handle = arg_5_0.viewParam.handle
	arg_5_0.entityId = arg_5_0.cardData.uid

	arg_5_0:com_loadAsset("ui/viewres/fight/fightcarditem.prefab", arg_5_0.onCardLoaded)

	local var_5_0 = lua_skill.configDict[arg_5_0.cardData.skillId]

	if var_5_0 then
		arg_5_0.titleText.text = var_5_0.name
	end
end

function var_0_0.onCardLoaded(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	arg_6_0._skillList = string.splitToNumber(arg_6_0.choiceConfig.choiceSkIlls, "#")
	arg_6_0._cardWidth = 180
	arg_6_0._halfCardWidth = arg_6_0._cardWidth / 2
	arg_6_0._cardDistance = arg_6_0._cardWidth + 40
	arg_6_0._scrollWidth = recthelper.getWidth(arg_6_0._scrollViewObj.transform)
	arg_6_0._halfScrollWidth = arg_6_0._scrollWidth / 2

	local var_6_0 = arg_6_2:GetResource()

	gohelper.clone(var_6_0, gohelper.findChild(arg_6_0._cardItem, "#go_carditem"), "card")

	if #arg_6_0._skillList > 5 then
		arg_6_0._posX = 120
	else
		arg_6_0._posX = -arg_6_0._halfScrollWidth - (#arg_6_0._skillList - 1) * arg_6_0._cardDistance / 2
	end

	arg_6_0._cardObjList = arg_6_0:getUserDataTb_()

	arg_6_0:com_createObjList(arg_6_0._onItemShow, arg_6_0._skillList, arg_6_0._cardRoot, arg_6_0._cardItem)
	recthelper.setWidth(arg_6_0._cardRoot.transform, -arg_6_0._posX - arg_6_0._halfCardWidth + arg_6_0._cardDistance)
	arg_6_0:_onCardClick(1)
end

function var_0_0._onItemShow(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_2
	local var_7_1 = arg_7_1.transform

	var_7_1.anchorMin = Vector2.one
	var_7_1.anchorMax = Vector2.one

	recthelper.setAnchorX(var_7_1, arg_7_0._posX)

	arg_7_0._posX = arg_7_0._posX + arg_7_0._cardDistance

	local var_7_2 = gohelper.findChild(arg_7_1, "#go_carditem/card")
	local var_7_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_2, FightViewCardItem)

	var_7_3:updateItem(arg_7_0.entityId, var_7_0)
	var_7_3:detectShowBlueStar()

	local var_7_4 = gohelper.getClickWithDefaultAudio(arg_7_1)

	arg_7_0:com_registClick(var_7_4, arg_7_0._onCardClick, arg_7_3)
	table.insert(arg_7_0._cardObjList, arg_7_1)
end

function var_0_0._onCardClick(arg_8_0, arg_8_1)
	if arg_8_0._curSelectIndex == arg_8_1 then
		return
	end

	arg_8_0._curSelectIndex = arg_8_1
	arg_8_0.curSkillId = arg_8_0._skillList[arg_8_1]

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._cardObjList) do
		local var_8_0 = gohelper.findChild(iter_8_1, "#go_Frame")

		gohelper.setActive(var_8_0, iter_8_0 == arg_8_0._curSelectIndex)
	end

	arg_8_0:_showSkillDes()

	local var_8_1 = arg_8_0._cardObjList[arg_8_1].transform
	local var_8_2 = recthelper.rectToRelativeAnchorPos(var_8_1.position, arg_8_0._scrollViewObj.transform).x
	local var_8_3 = var_8_2 - arg_8_0._halfCardWidth
	local var_8_4 = var_8_2 + arg_8_0._halfCardWidth

	if var_8_3 < -arg_8_0._halfScrollWidth then
		local var_8_5 = var_8_3 + arg_8_0._halfScrollWidth

		recthelper.setAnchorX(arg_8_0._cardRoot.transform, recthelper.getAnchorX(arg_8_0._cardRoot.transform) - var_8_5 + 20)
	end

	if var_8_4 > arg_8_0._halfScrollWidth then
		local var_8_6 = var_8_4 - arg_8_0._halfScrollWidth

		recthelper.setAnchorX(arg_8_0._cardRoot.transform, recthelper.getAnchorX(arg_8_0._cardRoot.transform) - var_8_6 - 20)
	end
end

function var_0_0._showSkillDes(arg_9_0)
	local var_9_0 = lua_skill.configDict[arg_9_0.curSkillId]

	if not var_9_0 then
		return
	end

	arg_9_0._nameText.text = var_9_0.name

	local var_9_1 = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getEntitySkillDesc(arg_9_0.entityId, var_9_0), "#c56131", "#7c93ad")

	arg_9_0._desText.text = var_9_1
end

function var_0_0.onBtnConfirm(arg_10_0)
	if not arg_10_0._curSelectIndex then
		arg_10_0:closeThis()

		return
	end

	local var_10_0 = arg_10_0.curSkillId
	local var_10_1 = FightDataHelper.operationDataMgr.curSelectEntityId
	local var_10_2 = lua_skill.configDict[var_10_0]
	local var_10_3 = FightDataHelper.entityMgr:getMyNormalList()
	local var_10_4 = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
	local var_10_5 = #var_10_3 + #var_10_4

	if var_10_2 and FightEnum.ShowLogicTargetView[var_10_2.logicTarget] and var_10_2.targetLimit == FightEnum.TargetLimit.MySide then
		if var_10_5 > 1 then
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				fromId = arg_10_0.cardData.uid,
				skillId = var_10_0,
				callback = arg_10_0._toPlayCard,
				callbackObj = arg_10_0
			})

			return
		end

		if var_10_5 == 1 then
			var_10_1 = var_10_3[1].id
		end
	end

	arg_10_0.callback(arg_10_0.handle, var_10_1, nil, var_10_0)
	arg_10_0:closeThis()
end

function var_0_0._toPlayCard(arg_11_0, arg_11_1)
	arg_11_0.callback(arg_11_0.handle, arg_11_1, nil, arg_11_0.curSkillId)
	arg_11_0:closeThis()
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
