module("modules.logic.fight.view.FightCardDeckGMView", package.seeall)

local var_0_0 = class("FightCardDeckGMView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._click = gohelper.getClick(arg_1_0.viewGO)
	arg_1_0._btnCardBox = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "topTab/#btn_cardbox")
	arg_1_0._cardBoxSelect = gohelper.findChild(arg_1_0.viewGO, "topTab/#btn_cardbox/select")
	arg_1_0._cardBoxUnselect = gohelper.findChild(arg_1_0.viewGO, "topTab/#btn_cardbox/unselect")
	arg_1_0._btnCardPre = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "topTab/#btn_cardpre")
	arg_1_0._cardPreSelect = gohelper.findChild(arg_1_0.viewGO, "topTab/#btn_cardpre/select")
	arg_1_0._cardPreUnselect = gohelper.findChild(arg_1_0.viewGO, "topTab/#btn_cardpre/unselect")
	arg_1_0._cardRoot = gohelper.findChild(arg_1_0.viewGO, "layout/#scroll_card/Viewport/Content")
	arg_1_0._cardItem = gohelper.findChild(arg_1_0.viewGO, "layout/#scroll_card/Viewport/Content/#go_carditem")
	arg_1_0._nameText = gohelper.findChildText(arg_1_0.viewGO, "layout/#scroll_card/#txt_skillname")
	arg_1_0._skillText = gohelper.findChildText(arg_1_0.viewGO, "layout/#scroll_card/#scroll_skill/viewport/content/#txt_skilldec")
	arg_1_0._cardMask = gohelper.findChild(arg_1_0.viewGO, "layout/#scroll_card/Viewport").transform

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._click, arg_2_0._onViewClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._nameText.text = ""
	arg_4_0._skillText.text = ""
end

function var_0_0._onViewClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._proto = arg_6_0.viewParam
	arg_6_0._cardItemDic = {}

	arg_6_0:_refreshBtn()
	arg_6_0:_refreshBtnState()

	local var_6_0 = "ui/viewres/fight/fightcarditem.prefab"

	arg_6_0:com_loadAsset(var_6_0, arg_6_0._onCardLoadFinish)
end

function var_0_0._startRefreshUI(arg_7_0)
	arg_7_0:_refreshUI()
end

function var_0_0._onCardLoadFinish(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetResource()

	gohelper.clone(var_8_0, gohelper.findChild(arg_8_0._cardItem, "card"), "card")
	gohelper.setActive(gohelper.findChild(arg_8_0._cardItem, "select"), false)
	arg_8_0:_startRefreshUI()
end

function var_0_0._refreshUI(arg_9_0)
	arg_9_0._cardDataList = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._proto.deckInfos) do
		local var_9_0 = {
			entityId = iter_9_1.uid,
			skillId = iter_9_1.skillId,
			num = iter_9_1.num
		}

		table.insert(arg_9_0._cardDataList, var_9_0)
	end

	arg_9_0:com_createObjList(arg_9_0._onCardItemShow, arg_9_0._cardDataList, arg_9_0._cardRoot, arg_9_0._cardItem)

	if #arg_9_0._cardDataList == 0 then
		arg_9_0._nameText.text = ""
		arg_9_0._skillText.text = ""
	end

	if #arg_9_0._cardDataList > 6 then
		recthelper.setHeight(arg_9_0._cardMask, 480)
	else
		recthelper.setHeight(arg_9_0._cardMask, 320)
	end
end

function var_0_0._onCardItemShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	gohelper.setActive(arg_10_1, false)
	gohelper.setActive(arg_10_1, true)

	local var_10_0 = arg_10_1:GetInstanceID()
	local var_10_1 = arg_10_0._cardItemDic[var_10_0]

	if not var_10_1 then
		var_10_1 = arg_10_0:openSubView(FightCardDeckViewItem, arg_10_1)
		arg_10_0._cardItemDic[var_10_0] = var_10_1

		arg_10_0:addClickCb(gohelper.getClickWithDefaultAudio(gohelper.findChild(arg_10_1, "card")), arg_10_0._onCardItemClick, arg_10_0, var_10_0)
	end

	var_10_1:refreshItem(arg_10_2)

	if arg_10_3 == 1 then
		arg_10_0:_onCardItemClick(var_10_0)
	end
end

function var_0_0._onCardItemClick(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._cardItemDic[arg_11_1]

	if arg_11_0._curSelectItem then
		arg_11_0._curSelectItem:setSelect(false)
	end

	arg_11_0._curSelectItem = var_11_0

	arg_11_0._curSelectItem:setSelect(true)

	local var_11_1 = var_11_0._data
	local var_11_2 = var_11_1.skillId
	local var_11_3 = var_11_1.entityId
	local var_11_4 = lua_skill.configDict[var_11_2]

	arg_11_0._nameText.text = var_11_4.name
	arg_11_0._skillText.text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getEntitySkillDesc(var_11_3, var_11_4), "#c56131", "#7c93ad")
end

function var_0_0._refreshBtnState(arg_12_0)
	gohelper.setActive(arg_12_0._cardBoxSelect, true)
	gohelper.setActive(arg_12_0._cardBoxUnselect, false)
	gohelper.setActive(arg_12_0._cardPreSelect, false)
	gohelper.setActive(arg_12_0._cardPreUnselect, false)
end

function var_0_0._refreshBtn(arg_13_0)
	return
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
