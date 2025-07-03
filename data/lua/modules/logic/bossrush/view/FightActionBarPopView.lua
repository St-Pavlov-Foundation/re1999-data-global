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
	SkillHelper.addHyperLinkClick(arg_4_0._skillDes)

	arg_4_0._skillName.text = ""
	arg_4_0._skillDes.text = ""
end

function var_0_0._onCloseBtn(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onRefreshViewParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.entityId = arg_7_0.viewParam.entityId

	local var_7_0 = "ui/viewres/fight/fightcarditem.prefab"

	arg_7_0:com_loadAsset(var_7_0, arg_7_0._onLoadFinish)
end

function var_0_0._onLoadFinish(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetResource()

	gohelper.clone(var_8_0, arg_8_0._cardRoot).name = "card"
	arg_8_0._cardObjList = arg_8_0:getUserDataTb_()
	arg_8_0._cardCount = 0

	table.insert(arg_8_0.viewParam.dataList, 1, 0)
	arg_8_0:com_createObjList(arg_8_0._onItemShow, arg_8_0.viewParam.dataList, arg_8_0._content, arg_8_0._itemModel)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._cardObjList) do
		if tonumber(iter_8_1.name) ~= 0 then
			arg_8_0:_onCardClick(iter_8_1)

			break
		end
	end
end

function var_0_0._onItemShow(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 <= 1 then
		return
	end

	if arg_9_0._cardCount >= 6 then
		gohelper.setActive(arg_9_1, false)

		return
	end

	gohelper.setActive(arg_9_1, true)

	local var_9_0 = gohelper.findChildText(arg_9_1, "#go_select/#txt_round")
	local var_9_1 = gohelper.findChildText(arg_9_1, "#go_unselect/#txt_round")

	var_9_0.text = FightModel.instance:getCurRoundId() + arg_9_3 - 2
	var_9_1.text = FightModel.instance:getCurRoundId() + arg_9_3 - 2

	table.insert(arg_9_2, 1, 0)
	table.insert(arg_9_2, 1, 0)
	arg_9_0:com_createObjList(arg_9_0._onCardItemShow, arg_9_2, arg_9_1, arg_9_0._cardItem)

	local var_9_2 = gohelper.findChild(arg_9_1, "#go_select")
	local var_9_3 = gohelper.findChild(arg_9_1, "#go_unselect")

	gohelper.setActive(var_9_2, arg_9_3 == 2)
	gohelper.setActive(var_9_3, arg_9_3 ~= 2)
end

function var_0_0._onCardItemShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3 <= 2 then
		return
	end

	arg_10_0._cardCount = arg_10_0._cardCount + 1

	if arg_10_0._cardCount > 6 then
		gohelper.setActive(arg_10_1, false)

		return
	end

	gohelper.setActive(arg_10_1, true)

	local var_10_0 = arg_10_2.skillId

	arg_10_1.name = var_10_0

	local var_10_1 = gohelper.findChild(arg_10_1, "root/card")
	local var_10_2 = gohelper.findChild(arg_10_1, "empty")
	local var_10_3 = gohelper.findChild(arg_10_1, "chant")
	local var_10_4 = gohelper.findChildText(arg_10_1, "chant/round")

	gohelper.setActive(var_10_3, arg_10_2.isChannelSkill)

	var_10_4.text = arg_10_2.round or 0

	gohelper.setActive(var_10_1, var_10_0 ~= 0)
	gohelper.setActive(var_10_2, var_10_0 == 0)

	local var_10_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_1, FightViewCardItem, FightEnum.CardShowType.BossAction)

	if var_10_0 ~= 0 then
		var_10_5:updateItem(arg_10_0.viewParam.entityId, var_10_0)

		local var_10_6 = var_10_5._lvImgComps

		for iter_10_0, iter_10_1 in ipairs(var_10_6) do
			SLFramework.UGUI.GuiHelper.SetColor(iter_10_1, arg_10_2.isChannelSkill and "#666666" or "#FFFFFF")
		end
	end

	local var_10_7 = gohelper.getClickWithDefaultAudio(arg_10_1)

	arg_10_0:addClickCb(var_10_7, arg_10_0._onCardClick, arg_10_0, arg_10_1)
	table.insert(arg_10_0._cardObjList, arg_10_1)
end

function var_0_0._onCardClick(arg_11_0, arg_11_1)
	local var_11_0 = tonumber(arg_11_1.name)

	if var_11_0 == 0 then
		return
	end

	if arg_11_0._curSelectObj == arg_11_1 then
		return
	end

	arg_11_0._curSelectObj = arg_11_1

	local var_11_1 = lua_skill.configDict[var_11_0]

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._cardObjList) do
		local var_11_2 = FightCardDataHelper.isBigSkill(var_11_0)

		gohelper.setActive(gohelper.findChild(iter_11_1, "select"), arg_11_1 == iter_11_1 and not var_11_2)
		gohelper.setActive(gohelper.findChild(iter_11_1, "uniqueSelect"), arg_11_1 == iter_11_1 and var_11_2)
	end

	if var_11_1 then
		arg_11_0._skillName.text = var_11_1.name
		arg_11_0._skillDes.text = SkillHelper.getEntityDescBySkillCo(arg_11_0.entityId, var_11_1, "#DB945B", "#5C86DA")
	else
		logError("技能表找不到id:" .. var_11_0)
	end
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
