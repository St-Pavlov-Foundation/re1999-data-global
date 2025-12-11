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

function var_0_0._onBtnEsc(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	NavigateMgr.instance:addEscape(arg_10_0.viewContainer.viewName, arg_10_0._onBtnEsc, arg_10_0)

	local var_10_0 = table.remove(arg_10_0.viewParam, 1)

	if var_10_0 then
		arg_10_0._upgradeId = var_10_0.id
		arg_10_0._entityId = var_10_0.entityId
		arg_10_0._optionIdList = var_10_0.optionIds

		arg_10_0:_refreshUI()
	else
		arg_10_0:closeThis()
	end
end

function var_0_0._refreshUI(arg_11_0)
	local var_11_0 = "ui/viewres/fight/fightcarditem.prefab"

	arg_11_0:com_loadAsset(var_11_0, arg_11_0._onLoadFinish)
end

function var_0_0._onLoadFinish(arg_12_0, arg_12_1)
	arg_12_0._cardWidth = 180
	arg_12_0._halfCardWidth = arg_12_0._cardWidth / 2
	arg_12_0._cardDistance = arg_12_0._cardWidth + 40
	arg_12_0._scrollWidth = recthelper.getWidth(arg_12_0._scrollViewObj.transform)
	arg_12_0._halfScrollWidth = arg_12_0._scrollWidth / 2

	local var_12_0 = arg_12_1:GetResource()

	gohelper.clone(var_12_0, gohelper.findChild(arg_12_0._cardItem, "#go_carditem"), "card")

	if #arg_12_0._optionIdList > 5 then
		arg_12_0._posX = 120
	else
		arg_12_0._posX = -arg_12_0._halfScrollWidth - (#arg_12_0._optionIdList - 1) * arg_12_0._cardDistance / 2
	end

	arg_12_0._cardObjList = arg_12_0:getUserDataTb_()
	arg_12_0._skillList = {}

	arg_12_0:com_createObjList(arg_12_0._onItemShow, arg_12_0._optionIdList, arg_12_0._cardRoot, arg_12_0._cardItem)
	recthelper.setWidth(arg_12_0._cardRoot.transform, -arg_12_0._posX - arg_12_0._halfCardWidth + arg_12_0._cardDistance)
	arg_12_0:_onCardClick(1)
end

function var_0_0._onItemShow(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = lua_hero_upgrade_options.configDict[arg_13_2].showSkillId

	arg_13_0._skillList[arg_13_3] = var_13_0

	if not var_13_0 then
		gohelper.setActive(arg_13_1, false)

		return
	end

	local var_13_1 = arg_13_1.transform

	var_13_1.anchorMin = Vector2.New(1, 0.5)
	var_13_1.anchorMax = Vector2.New(1, 0.5)

	recthelper.setAnchorX(var_13_1, arg_13_0._posX)

	arg_13_0._posX = arg_13_0._posX + arg_13_0._cardDistance

	local var_13_2 = gohelper.findChild(arg_13_1, "#go_carditem/card")

	MonoHelper.addNoUpdateLuaComOnceToGo(var_13_2, FightViewCardItem):updateItem(arg_13_0._entityId, var_13_0)

	local var_13_3 = gohelper.getClickWithDefaultAudio(arg_13_1)

	arg_13_0:addClickCb(var_13_3, arg_13_0._onCardClick, arg_13_0, arg_13_3)
	table.insert(arg_13_0._cardObjList, arg_13_1)
end

function var_0_0._onCardClick(arg_14_0, arg_14_1)
	if arg_14_0._curSelectIndex == arg_14_1 then
		return
	end

	arg_14_0._curSelectIndex = arg_14_1

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._cardObjList) do
		local var_14_0 = gohelper.findChild(iter_14_1, "#go_Frame")

		gohelper.setActive(var_14_0, iter_14_0 == arg_14_0._curSelectIndex)
	end

	arg_14_0:_showSkillDes()

	local var_14_1 = arg_14_0._cardObjList[arg_14_1].transform
	local var_14_2 = recthelper.rectToRelativeAnchorPos(var_14_1.position, arg_14_0._scrollViewObj.transform).x
	local var_14_3 = var_14_2 - arg_14_0._halfCardWidth
	local var_14_4 = var_14_2 + arg_14_0._halfCardWidth

	if var_14_3 < -arg_14_0._halfScrollWidth then
		local var_14_5 = var_14_3 + arg_14_0._halfScrollWidth

		recthelper.setAnchorX(arg_14_0._cardRoot.transform, recthelper.getAnchorX(arg_14_0._cardRoot.transform) - var_14_5 + 20)
	end

	if var_14_4 > arg_14_0._halfScrollWidth then
		local var_14_6 = var_14_4 - arg_14_0._halfScrollWidth

		recthelper.setAnchorX(arg_14_0._cardRoot.transform, recthelper.getAnchorX(arg_14_0._cardRoot.transform) - var_14_6 - 20)
	end
end

function var_0_0._showSkillDes(arg_15_0)
	local var_15_0 = lua_hero_upgrade.configDict[arg_15_0._upgradeId]
	local var_15_1 = arg_15_0._optionIdList[arg_15_0._curSelectIndex]
	local var_15_2 = lua_hero_upgrade_options.configDict[var_15_1]

	arg_15_0._nameText.text = var_15_2.title

	local var_15_3, var_15_4 = SkillConfig.instance:getExSkillDesc(var_15_2, var_15_0.heroId)
	local var_15_5 = string.gsub(var_15_3, "▩(%d)%%s", var_15_4)
	local var_15_6 = HeroSkillModel.instance:formatDescWithColor(var_15_5)

	arg_15_0._desText.text = var_15_6
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
