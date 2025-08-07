module("modules.logic.bossrush.view.FightActionBarPopView", package.seeall)

local var_0_0 = class("FightActionBarPopView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._closeBtn = gohelper.findChildButton(arg_1_0.viewGO, "#btn_close")
	arg_1_0._content = gohelper.findChild(arg_1_0.viewGO, "middle/#go_cardcontent")
	arg_1_0._itemModel = gohelper.findChild(arg_1_0.viewGO, "middle/#go_cardcontent/card")
	arg_1_0._cardItem = gohelper.findChild(arg_1_0.viewGO, "middle/#go_cardcontent/card/cardItem")
	arg_1_0._cardRoot = gohelper.findChild(arg_1_0.viewGO, "middle/#go_cardcontent/card/cardItem/root")
	arg_1_0._skillName = gohelper.findChildText(arg_1_0.viewGO, "bottom/skillname")
	arg_1_0._skillDes = gohelper.findChildText(arg_1_0.viewGO, "bottom/#scroll_txt/Viewport/Content/skilldesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._closeBtn, arg_2_0._onCloseBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	SkillHelper.addHyperLinkClick(arg_4_0._skillDes, arg_4_0.linkClickCallback, arg_4_0)

	arg_4_0._skillName.text = ""
	arg_4_0._skillDes.text = ""
end

function var_0_0.linkClickCallback(arg_5_0, arg_5_1)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(arg_5_1, Vector2.zero, CommonBuffTipEnum.Pivot.Center)
end

function var_0_0._onCloseBtn(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onRefreshViewParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.entityId = arg_8_0.viewParam.entityId

	local var_8_0 = "ui/viewres/fight/fightcarditem.prefab"

	arg_8_0:com_loadAsset(var_8_0, arg_8_0._onLoadFinish)
end

function var_0_0._onLoadFinish(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetResource()

	gohelper.clone(var_9_0, arg_9_0._cardRoot).name = "card"
	arg_9_0._cardObjList = arg_9_0:getUserDataTb_()
	arg_9_0._cardCount = 0

	table.insert(arg_9_0.viewParam.dataList, 1, 0)
	arg_9_0:com_createObjList(arg_9_0._onItemShow, arg_9_0.viewParam.dataList, arg_9_0._content, arg_9_0._itemModel)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._cardObjList) do
		if tonumber(iter_9_1.name) ~= 0 then
			arg_9_0:_onCardClick(iter_9_1)

			break
		end
	end
end

function var_0_0._onItemShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3 <= 1 then
		return
	end

	if arg_10_0._cardCount >= 6 then
		gohelper.setActive(arg_10_1, false)

		return
	end

	gohelper.setActive(arg_10_1, true)

	local var_10_0 = gohelper.findChildText(arg_10_1, "#go_select/#txt_round")
	local var_10_1 = gohelper.findChildText(arg_10_1, "#go_unselect/#txt_round")

	var_10_0.text = FightModel.instance:getCurRoundId() + arg_10_3 - 2
	var_10_1.text = FightModel.instance:getCurRoundId() + arg_10_3 - 2

	table.insert(arg_10_2, 1, 0)
	table.insert(arg_10_2, 1, 0)
	arg_10_0:com_createObjList(arg_10_0._onCardItemShow, arg_10_2, arg_10_1, arg_10_0._cardItem)

	local var_10_2 = gohelper.findChild(arg_10_1, "#go_select")
	local var_10_3 = gohelper.findChild(arg_10_1, "#go_unselect")

	gohelper.setActive(var_10_2, arg_10_3 == 2)
	gohelper.setActive(var_10_3, arg_10_3 ~= 2)
end

function var_0_0._onCardItemShow(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 <= 2 then
		return
	end

	arg_11_0._cardCount = arg_11_0._cardCount + 1

	if arg_11_0._cardCount > 6 then
		gohelper.setActive(arg_11_1, false)

		return
	end

	gohelper.setActive(arg_11_1, true)

	local var_11_0 = arg_11_2.skillId

	arg_11_1.name = var_11_0

	local var_11_1 = gohelper.findChild(arg_11_1, "root/card")
	local var_11_2 = gohelper.findChild(arg_11_1, "empty")
	local var_11_3 = gohelper.findChild(arg_11_1, "chant")
	local var_11_4 = gohelper.findChildText(arg_11_1, "chant/round")

	gohelper.setActive(var_11_3, arg_11_2.isChannelSkill)

	var_11_4.text = arg_11_2.round or 0

	gohelper.setActive(var_11_1, var_11_0 ~= 0)
	gohelper.setActive(var_11_2, var_11_0 == 0)

	local var_11_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1, FightViewCardItem, FightEnum.CardShowType.BossAction)

	if var_11_0 ~= 0 then
		var_11_5:updateItem(arg_11_0.viewParam.entityId, var_11_0)

		local var_11_6 = var_11_5._lvImgComps

		for iter_11_0, iter_11_1 in ipairs(var_11_6) do
			SLFramework.UGUI.GuiHelper.SetColor(iter_11_1, arg_11_2.isChannelSkill and "#666666" or "#FFFFFF")
		end
	end

	local var_11_7 = gohelper.getClickWithDefaultAudio(arg_11_1)

	arg_11_0:addClickCb(var_11_7, arg_11_0._onCardClick, arg_11_0, arg_11_1)
	table.insert(arg_11_0._cardObjList, arg_11_1)
end

function var_0_0._onCardClick(arg_12_0, arg_12_1)
	local var_12_0 = tonumber(arg_12_1.name)

	if var_12_0 == 0 then
		return
	end

	if arg_12_0._curSelectObj == arg_12_1 then
		return
	end

	arg_12_0._curSelectObj = arg_12_1

	local var_12_1 = lua_skill.configDict[var_12_0]

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._cardObjList) do
		local var_12_2 = FightCardDataHelper.isBigSkill(var_12_0)

		gohelper.setActive(gohelper.findChild(iter_12_1, "select"), arg_12_1 == iter_12_1 and not var_12_2)
		gohelper.setActive(gohelper.findChild(iter_12_1, "uniqueSelect"), arg_12_1 == iter_12_1 and var_12_2)
	end

	if var_12_1 then
		arg_12_0._skillName.text = var_12_1.name
		arg_12_0._skillDes.text = SkillHelper.getEntityDescBySkillCo(arg_12_0.entityId, var_12_1, "#DB945B", "#5C86DA")
	else
		logError("技能表找不到id:" .. var_12_0)
	end
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
