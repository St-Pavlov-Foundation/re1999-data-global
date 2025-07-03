module("modules.logic.fight.view.FightCardDeckView", package.seeall)

local var_0_0 = class("FightCardDeckView", BaseViewExtended)

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
	arg_2_0:addEventCb(FightController.instance, FightEvent.GetFightCardDeckInfoReply, arg_2_0._onGetFightCardDeckInfoReply, arg_2_0)
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

var_0_0.SelectType = {
	CardBox = 1,
	PreCard = 2
}

function var_0_0.onOpen(arg_6_0)
	arg_6_0._cardItemDic = {}
	arg_6_0._selectType = arg_6_0.viewParam and arg_6_0.viewParam.selectType or var_0_0.SelectType.CardBox

	arg_6_0:_refreshBtn()
	arg_6_0:_refreshBtnState()

	local var_6_0 = "ui/viewres/fight/fightcarditem.prefab"

	arg_6_0:com_loadAsset(var_6_0, arg_6_0._onCardLoadFinish)
end

function var_0_0._startRefreshUI(arg_7_0)
	arg_7_0:addClickCb(arg_7_0._btnCardBox, arg_7_0._onCardBoxClick, arg_7_0)
	arg_7_0:addClickCb(arg_7_0._btnCardPre, arg_7_0._onCardPreClick, arg_7_0)
	arg_7_0:_refreshUI()
end

function var_0_0._onCardBoxClick(arg_8_0)
	arg_8_0._selectType = var_0_0.SelectType.CardBox

	arg_8_0:_refreshUI()
	arg_8_0:_refreshBtnState()
end

function var_0_0._onCardPreClick(arg_9_0)
	arg_9_0._selectType = var_0_0.SelectType.PreCard

	arg_9_0:_refreshUI()
	arg_9_0:_refreshBtnState()
end

function var_0_0._onCardLoadFinish(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetResource()

	gohelper.clone(var_10_0, gohelper.findChild(arg_10_0._cardItem, "card"), "card")
	gohelper.setActive(gohelper.findChild(arg_10_0._cardItem, "select"), false)
	arg_10_0:_startRefreshUI()
end

function var_0_0._onGetFightCardDeckInfoReply(arg_11_0, arg_11_1)
	arg_11_0._boxList = {}

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.deckInfos) do
		local var_11_1 = FightCardInfoData.New(iter_11_1)
		local var_11_2 = var_11_1.uid
		local var_11_3 = var_11_0[var_11_2]

		if not var_11_3 then
			var_11_3 = {}
			var_11_0[var_11_2] = var_11_3
		end

		local var_11_4 = var_11_1.skillId

		if not var_11_3[var_11_4] then
			var_11_3[var_11_4] = {}
			var_11_3[var_11_4][1] = {}
			var_11_3[var_11_4][2] = {}
		end

		if var_11_1.tempCard then
			table.insert(var_11_3[var_11_4][1], var_11_1)
		else
			table.insert(var_11_3[var_11_4][2], var_11_1)
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_11_0) do
		for iter_11_4, iter_11_5 in pairs(iter_11_3) do
			if #iter_11_5[1] > 0 then
				local var_11_5 = {
					skillId = iter_11_4
				}

				var_11_5.tempCard = true
				var_11_5.entityId = iter_11_2
				var_11_5.num = #iter_11_5[1]

				table.insert(arg_11_0._boxList, var_11_5)
			end

			if #iter_11_5[2] > 0 then
				local var_11_6 = {
					skillId = iter_11_4,
					entityId = iter_11_2,
					num = #iter_11_5[2]
				}

				table.insert(arg_11_0._boxList, var_11_6)
			end
		end
	end

	if arg_11_0._selectType == var_0_0.SelectType.CardBox then
		arg_11_0:_refreshCardBox()
	end
end

function var_0_0._refreshUI(arg_12_0)
	if arg_12_0._selectType == var_0_0.SelectType.CardBox then
		if arg_12_0._boxList then
			arg_12_0:_refreshCardBox()
		else
			FightRpc.instance:sendGetFightCardDeckInfoRequest(FightRpc.DeckInfoRequestType.MySide)
		end
	else
		arg_12_0:_refreshPreCard()
	end
end

function var_0_0.sortCardBox(arg_13_0, arg_13_1)
	local var_13_0 = FightDataHelper.entityMgr:getById(arg_13_0.entityId)
	local var_13_1 = FightDataHelper.entityMgr:getById(arg_13_1.entityId)

	if not var_13_0 and var_13_1 then
		return true
	elseif var_13_0 and not var_13_1 then
		return false
	elseif not var_13_0 and not var_13_1 then
		return arg_13_0.skillId < arg_13_1.skillId
	else
		local var_13_2 = var_13_0.position
		local var_13_3 = var_13_1.position

		if var_13_2 < var_13_3 then
			return true
		elseif var_13_3 < var_13_2 then
			return false
		elseif arg_13_0.skillId == arg_13_1.skillId then
			if arg_13_0.tempCard and not arg_13_1.tempCard then
				return true
			elseif not arg_13_0.tempCard and arg_13_1.tempCard then
				return false
			else
				return arg_13_0.skillId < arg_13_1.skillId
			end
		else
			return arg_13_0.skillId < arg_13_1.skillId
		end
	end
end

function var_0_0._refreshCardBox(arg_14_0)
	table.sort(arg_14_0._boxList, var_0_0.sortCardBox)
	arg_14_0:com_createObjList(arg_14_0._onCardItemShow, arg_14_0._boxList, arg_14_0._cardRoot, arg_14_0._cardItem)

	if #arg_14_0._boxList == 0 then
		arg_14_0._nameText.text = ""
		arg_14_0._skillText.text = ""
	end

	if #arg_14_0._boxList > 6 then
		recthelper.setHeight(arg_14_0._cardMask, 480)
	else
		recthelper.setHeight(arg_14_0._cardMask, 320)
	end
end

function var_0_0._refreshPreCard(arg_15_0)
	arg_15_0:com_createObjList(arg_15_0._onCardItemShow, arg_15_0._preCardList, arg_15_0._cardRoot, arg_15_0._cardItem)

	if #arg_15_0._preCardList == 0 then
		arg_15_0._nameText.text = ""
		arg_15_0._skillText.text = ""
	end

	if #arg_15_0._preCardList > 6 then
		recthelper.setHeight(arg_15_0._cardMask, 480)
	else
		recthelper.setHeight(arg_15_0._cardMask, 320)
	end
end

function var_0_0._onCardItemShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	gohelper.setActive(arg_16_1, false)
	gohelper.setActive(arg_16_1, true)

	local var_16_0 = arg_16_1:GetInstanceID()
	local var_16_1 = arg_16_0._cardItemDic[var_16_0]

	if not var_16_1 then
		var_16_1 = arg_16_0:openSubView(FightCardDeckViewItem, arg_16_1)
		arg_16_0._cardItemDic[var_16_0] = var_16_1

		arg_16_0:addClickCb(gohelper.getClickWithDefaultAudio(gohelper.findChild(arg_16_1, "card")), arg_16_0._onCardItemClick, arg_16_0, var_16_0)
	end

	var_16_1:refreshItem(arg_16_2)

	if arg_16_0._selectType == var_0_0.SelectType.CardBox then
		var_16_1:showCount(arg_16_2.num)
	end

	if arg_16_3 == 1 then
		arg_16_0:_onCardItemClick(var_16_0)
	end
end

function var_0_0._onCardItemClick(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._cardItemDic[arg_17_1]

	if arg_17_0._curSelectItem then
		arg_17_0._curSelectItem:setSelect(false)
	end

	arg_17_0._curSelectItem = var_17_0

	arg_17_0._curSelectItem:setSelect(true)

	local var_17_1 = var_17_0._data
	local var_17_2 = var_17_1.skillId
	local var_17_3 = var_17_1.entityId
	local var_17_4 = lua_skill.configDict[var_17_2]

	arg_17_0._nameText.text = var_17_4.name
	arg_17_0._skillText.text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getEntitySkillDesc(var_17_3, var_17_4), "#c56131", "#7c93ad")
end

function var_0_0._refreshBtnState(arg_18_0)
	gohelper.setActive(arg_18_0._cardBoxSelect, arg_18_0._selectType == var_0_0.SelectType.CardBox)
	gohelper.setActive(arg_18_0._cardBoxUnselect, arg_18_0._selectType ~= var_0_0.SelectType.CardBox)
	gohelper.setActive(arg_18_0._cardPreSelect, arg_18_0._selectType == var_0_0.SelectType.PreCard)
	gohelper.setActive(arg_18_0._cardPreUnselect, arg_18_0._selectType ~= var_0_0.SelectType.PreCard)
end

function var_0_0._refreshBtn(arg_19_0)
	arg_19_0._preCardList = FightHelper.getNextRoundGetCardList()

	gohelper.setActive(arg_19_0._btnCardPre.gameObject, #arg_19_0._preCardList > 0)
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
