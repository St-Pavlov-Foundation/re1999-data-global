module("modules.logic.playercard.view.PlayerCardView", package.seeall)

local var_0_0 = class("PlayerCardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goRight = gohelper.findChild(arg_1_0.viewGO, "Right")
	arg_1_0.btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_detail/#btn_click")
	arg_1_0.goPlayerInfo = gohelper.findChild(arg_1_0.goRight, "#go_playerinfo")
	arg_1_0.goAssit = gohelper.findChild(arg_1_0.goRight, "#go_assit")
	arg_1_0.goChapter = gohelper.findChild(arg_1_0.goRight, "#go_chapter")
	arg_1_0.goCardGroup = gohelper.findChild(arg_1_0.goRight, "#go_cardgroup")
	arg_1_0.goAchievement = gohelper.findChild(arg_1_0.goRight, "#go_achievement")

	arg_1_0:loadRight()
	arg_1_0:initRightLayout()

	arg_1_0.gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0.btnCloseTips = gohelper.findChildButtonWithAudio(arg_1_0.gotips, "#btn_close")
	arg_1_0.goTipsNode = gohelper.findChild(arg_1_0.gotips, "node")
	arg_1_0.btnLayout = gohelper.findChildButtonWithAudio(arg_1_0.goTipsNode, "#btn_layout")
	arg_1_0.btnChangeSkin = gohelper.findChildButtonWithAudio(arg_1_0.goTipsNode, "#btn_changeskin")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCloseTips, arg_2_0.onClickCloseTips, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnLayout, arg_2_0.onClickLayout, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnChangeSkin, arg_2_0.onClickChangeSkin, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnDetail, arg_2_0.onClickDetail, arg_2_0)
	arg_2_0:addEventCb(PlayerController.instance, PlayerEvent.PlayerbassinfoChange, arg_2_0.onPlayerBaseInfoChange, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, arg_2_0.refreshView, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ShowListBtn, arg_2_0.onShowListBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onShowListBtn(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0.gotips, true)

	local var_4_0 = arg_4_1.transform
	local var_4_1, var_4_2 = recthelper.rectToRelativeAnchorPos2(var_4_0.position, arg_4_0.gotips.transform)

	recthelper.setAnchor(arg_4_0.goTipsNode.transform, var_4_1 - 190, var_4_2 - 105)
end

function var_0_0.onClickCloseTips(arg_5_0)
	gohelper.setActive(arg_5_0.gotips, false)
end

function var_0_0.onClickLayout(arg_6_0)
	gohelper.setActive(arg_6_0.gotips, false)
	ViewMgr.instance:openView(ViewName.PlayerCardLayoutView, {
		userId = arg_6_0.userId
	})
end

function var_0_0.onClickChangeSkin(arg_7_0)
	gohelper.setActive(arg_7_0.gotips, false)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ShowTheme)
end

function var_0_0.onClickDetail(arg_8_0)
	local var_8_0 = arg_8_0:getCardInfo()

	if not var_8_0 then
		return
	end

	arg_8_0:closeThis()
	PlayerController.instance:openPlayerView(var_8_0:getPlayerInfo(), var_8_0:isSelf())
end

function var_0_0.initRightLayout(arg_9_0)
	arg_9_0.rightLayout = MonoHelper.addNoUpdateLuaComOnceToGo(arg_9_0.goRight, PlayerCardLayout)

	local var_9_0 = {}

	table.insert(var_9_0, arg_9_0:getLayoutItem(arg_9_0.goAssit, PlayerCardEnum.RightLayout.Assit))
	table.insert(var_9_0, arg_9_0:getLayoutItem(arg_9_0.goChapter, PlayerCardEnum.RightLayout.Chapter))
	table.insert(var_9_0, arg_9_0:getLayoutItem(arg_9_0.goCardGroup, PlayerCardEnum.RightLayout.CardGroup, PlayerCardLayoutItemCardGroup, arg_9_0.cardGroupComp))
	table.insert(var_9_0, arg_9_0:getLayoutItem(arg_9_0.goAchievement, PlayerCardEnum.RightLayout.Achievement))
	arg_9_0.rightLayout:setLayoutList(var_9_0)
end

function var_0_0.getLayoutItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = {
		layoutKey = arg_10_2,
		viewRoot = arg_10_0.viewGO,
		layout = arg_10_0.rightLayout,
		cardComp = arg_10_4
	}

	arg_10_3 = arg_10_3 or PlayerCardLayoutItem

	return MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_1, arg_10_3, var_10_0)
end

function var_0_0.refreshLayout(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getLayoutData()

	arg_11_0.rightLayout:setEditMode(false)
	arg_11_0.rightLayout:setData(var_11_0)
end

function var_0_0.loadRight(arg_12_0)
	arg_12_0.compList = {}

	local var_12_0 = arg_12_0.viewContainer:getSetting().otherRes

	arg_12_0:loadGO(arg_12_0.goPlayerInfo, PlayerCardPlayerInfo, var_12_0.infoview)
	arg_12_0:loadGO(arg_12_0.goAssit, PlayerCardAssit, var_12_0.assitview)
	arg_12_0:loadGO(arg_12_0.goChapter, PlayerCardChapter, var_12_0.chapterview)

	local var_12_1 = {
		itemRes = arg_12_0.viewContainer:getRes(var_12_0.achieveitem)
	}

	arg_12_0:loadGO(arg_12_0.goAchievement, PlayerCardAchievement, var_12_0.achieveview, var_12_1)

	local var_12_2 = {
		itemRes = arg_12_0.viewContainer:getRes(var_12_0.carditem)
	}

	arg_12_0.cardGroupComp = arg_12_0:loadGO(arg_12_0.goCardGroup, PlayerCardCardGroup, var_12_0.groupview, var_12_2)
end

function var_0_0.loadGO(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = gohelper.findChild(arg_13_1, "card")
	local var_13_1 = arg_13_0:getResInst(arg_13_3, var_13_0 or arg_13_1)

	gohelper.setAsFirstSibling(var_13_1)

	arg_13_4 = arg_13_4 or {}
	arg_13_4.compType = PlayerCardEnum.CompType.Normal

	local var_13_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_1, arg_13_2, arg_13_4)

	table.insert(arg_13_0.compList, var_13_2)

	return var_13_2
end

function var_0_0.onPlayerBaseInfoChange(arg_14_0, arg_14_1)
	if arg_14_1.userId == arg_14_0.userId then
		arg_14_0:refreshView()
	end
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:_updateParam()
	arg_15_0:refreshView()
end

function var_0_0.onUpdateParam(arg_16_0)
	arg_16_0:_updateParam()
	arg_16_0:refreshView()
end

function var_0_0._updateParam(arg_17_0)
	arg_17_0.userId = arg_17_0.viewParam.userId
end

function var_0_0.getCardInfo(arg_18_0)
	return PlayerCardModel.instance:getCardInfo(arg_18_0.userId)
end

function var_0_0.refreshView(arg_19_0)
	local var_19_0 = arg_19_0:getCardInfo()

	if not var_19_0 then
		return
	end

	arg_19_0:refreshCompList(var_19_0)
	arg_19_0:refreshLayout(var_19_0)
end

function var_0_0.refreshCompList(arg_20_0, arg_20_1)
	if not arg_20_0.compList then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.compList) do
		iter_20_1:refreshView(arg_20_1)
	end
end

function var_0_0.onClose(arg_21_0)
	return
end

return var_0_0
