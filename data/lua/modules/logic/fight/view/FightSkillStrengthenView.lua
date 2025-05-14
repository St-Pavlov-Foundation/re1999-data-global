module("modules.logic.fight.view.FightSkillStrengthenView", package.seeall)

local var_0_0 = class("FightSkillStrengthenView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnObj = gohelper.findChild(arg_1_0.viewGO, "#btn_Strenthen")
	arg_1_0._btnConfirm = gohelper.getClickWithDefaultAudio(arg_1_0._btnObj)
	arg_1_0._scrollViewObj = gohelper.findChild(arg_1_0.viewGO, "#scroll_handcards")
	arg_1_0._cardRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_handcards/Viewport/handcards")
	arg_1_0._cardItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_handcards/Viewport/handcards/#go_item")
	arg_1_0._nameText = gohelper.findChildText(arg_1_0.viewGO, "CheckPoint/txt_CheckPointName")
	arg_1_0._desText = gohelper.findChildText(arg_1_0.viewGO, "CheckPoint/Scroll View/Viewport/#txt_Descr")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnConfirm, arg_2_0._onBtnConfirm, arg_2_0)
	FightController.instance:registerCallback(FightEvent.StartPlayClothSkill, arg_2_0._onStartPlayClothSkill, arg_2_0)
	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, arg_2_0._onRespUseClothSkillFail, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.StartPlayClothSkill, arg_3_0._onStartPlayClothSkill, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, arg_3_0._onRespUseClothSkillFail, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onStartPlayClothSkill(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._onRespUseClothSkillFail(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._onBtnConfirm(arg_7_0)
	if not arg_7_0:_canOperate() then
		arg_7_0:closeThis()

		return
	end

	if arg_7_0._confirmed then
		return
	end

	arg_7_0._confirmed = true

	local var_7_0 = arg_7_0._optionIdList[arg_7_0._curSelectIndex]

	FightRpc.instance:sendUseClothSkillRequest(arg_7_0._upgradeId, arg_7_0._entityId, var_7_0, FightEnum.ClothSkillType.HeroUpgrade)
end

function var_0_0.sort(arg_8_0, arg_8_1)
	return arg_8_0 < arg_8_1
end

function var_0_0._canOperate(arg_9_0)
	return FightModel.instance:getCurStage() == FightEnum.Stage.Card
end

function var_0_0._onBtnEsc(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	NavigateMgr.instance:addEscape(arg_11_0.viewContainer.viewName, arg_11_0._onBtnEsc, arg_11_0)

	local var_11_0 = table.remove(arg_11_0.viewParam, 1)

	if var_11_0 then
		arg_11_0._upgradeId = var_11_0.id
		arg_11_0._entityId = var_11_0.entityId
		arg_11_0._optionIdList = var_11_0.optionIds

		arg_11_0:_refreshUI()
	else
		arg_11_0:closeThis()
	end
end

function var_0_0._refreshUI(arg_12_0)
	local var_12_0 = "ui/viewres/fight/fightcarditem.prefab"

	arg_12_0:com_loadAsset(var_12_0, arg_12_0._onLoadFinish)
end

function var_0_0._onLoadFinish(arg_13_0, arg_13_1)
	arg_13_0._cardWidth = 180
	arg_13_0._halfCardWidth = arg_13_0._cardWidth / 2
	arg_13_0._cardDistance = arg_13_0._cardWidth + 40
	arg_13_0._scrollWidth = recthelper.getWidth(arg_13_0._scrollViewObj.transform)
	arg_13_0._halfScrollWidth = arg_13_0._scrollWidth / 2

	local var_13_0 = arg_13_1:GetResource()

	gohelper.clone(var_13_0, gohelper.findChild(arg_13_0._cardItem, "#go_carditem"), "card")

	if #arg_13_0._optionIdList > 5 then
		arg_13_0._posX = 120
	else
		arg_13_0._posX = -arg_13_0._halfScrollWidth - (#arg_13_0._optionIdList - 1) * arg_13_0._cardDistance / 2
	end

	arg_13_0._cardObjList = arg_13_0:getUserDataTb_()
	arg_13_0._skillList = {}

	arg_13_0:com_createObjList(arg_13_0._onItemShow, arg_13_0._optionIdList, arg_13_0._cardRoot, arg_13_0._cardItem)
	recthelper.setWidth(arg_13_0._cardRoot.transform, -arg_13_0._posX - arg_13_0._halfCardWidth + arg_13_0._cardDistance)
	arg_13_0:_onCardClick(1)
end

function var_0_0._onItemShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = lua_hero_upgrade_options.configDict[arg_14_2].showSkillId

	arg_14_0._skillList[arg_14_3] = var_14_0

	if not var_14_0 then
		gohelper.setActive(arg_14_1, false)

		return
	end

	local var_14_1 = arg_14_1.transform

	var_14_1.anchorMin = Vector2.New(1, 0.5)
	var_14_1.anchorMax = Vector2.New(1, 0.5)

	recthelper.setAnchorX(var_14_1, arg_14_0._posX)

	arg_14_0._posX = arg_14_0._posX + arg_14_0._cardDistance

	local var_14_2 = gohelper.findChild(arg_14_1, "#go_carditem/card")

	MonoHelper.addNoUpdateLuaComOnceToGo(var_14_2, FightViewCardItem):updateItem(arg_14_0._entityId, var_14_0)

	local var_14_3 = gohelper.getClickWithDefaultAudio(arg_14_1)

	arg_14_0:addClickCb(var_14_3, arg_14_0._onCardClick, arg_14_0, arg_14_3)
	table.insert(arg_14_0._cardObjList, arg_14_1)
end

function var_0_0._onCardClick(arg_15_0, arg_15_1)
	if arg_15_0._curSelectIndex == arg_15_1 then
		return
	end

	arg_15_0._curSelectIndex = arg_15_1

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._cardObjList) do
		local var_15_0 = gohelper.findChild(iter_15_1, "#go_Frame")

		gohelper.setActive(var_15_0, iter_15_0 == arg_15_0._curSelectIndex)
	end

	arg_15_0:_showSkillDes()

	local var_15_1 = arg_15_0._cardObjList[arg_15_1].transform
	local var_15_2 = recthelper.rectToRelativeAnchorPos(var_15_1.position, arg_15_0._scrollViewObj.transform).x
	local var_15_3 = var_15_2 - arg_15_0._halfCardWidth
	local var_15_4 = var_15_2 + arg_15_0._halfCardWidth

	if var_15_3 < -arg_15_0._halfScrollWidth then
		local var_15_5 = var_15_3 + arg_15_0._halfScrollWidth

		recthelper.setAnchorX(arg_15_0._cardRoot.transform, recthelper.getAnchorX(arg_15_0._cardRoot.transform) - var_15_5 + 20)
	end

	if var_15_4 > arg_15_0._halfScrollWidth then
		local var_15_6 = var_15_4 - arg_15_0._halfScrollWidth

		recthelper.setAnchorX(arg_15_0._cardRoot.transform, recthelper.getAnchorX(arg_15_0._cardRoot.transform) - var_15_6 - 20)
	end
end

function var_0_0._showSkillDes(arg_16_0)
	local var_16_0 = lua_hero_upgrade.configDict[arg_16_0._upgradeId]
	local var_16_1 = arg_16_0._optionIdList[arg_16_0._curSelectIndex]
	local var_16_2 = lua_hero_upgrade_options.configDict[var_16_1]

	arg_16_0._nameText.text = var_16_2.title

	local var_16_3, var_16_4 = SkillConfig.instance:getExSkillDesc(var_16_2, var_16_0.heroId)
	local var_16_5 = string.gsub(var_16_3, "▩(%d)%%s", var_16_4)
	local var_16_6 = HeroSkillModel.instance:formatDescWithColor(var_16_5)

	arg_16_0._desText.text = var_16_6
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
