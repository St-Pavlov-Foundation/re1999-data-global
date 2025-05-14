module("modules.logic.playercard.view.PlayerCardLayoutView", package.seeall)

local var_0_0 = class("PlayerCardLayoutView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goCard = gohelper.findChild(arg_1_0.viewGO, "Card")
	arg_1_0.goPlayerInfo = gohelper.findChild(arg_1_0.goCard, "#go_playerinfo")
	arg_1_0.goAssit = gohelper.findChild(arg_1_0.goCard, "#go_assit")
	arg_1_0.goChapter = gohelper.findChild(arg_1_0.goCard, "#go_chapter")
	arg_1_0.goCardGroup = gohelper.findChild(arg_1_0.goCard, "#go_cardgroup")
	arg_1_0.goAchievement = gohelper.findChild(arg_1_0.goCard, "#go_achievement")

	arg_1_0:loadRight()
	arg_1_0:initRightLayout()

	arg_1_0.btnConfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0.animator = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnConfirm, arg_2_0.onClicConfirm, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.playCloseAnim(arg_4_0)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.CloseLayout)
	arg_4_0.animator:Play("close", arg_4_0.onCloseAnimDone, arg_4_0)
end

function var_0_0.onCloseAnimDone(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClicConfirm(arg_6_0)
	local var_6_0 = arg_6_0.rightLayout:getLayoutData()
	local var_6_1 = arg_6_0:getCardInfo()

	if var_6_1 then
		local var_6_2 = var_6_1:getSetting({
			[PlayerCardEnum.SettingKey.RightLayout] = var_6_0
		})

		PlayerCardRpc.instance:sendSetPlayerCardShowSettingRequest(var_6_2)
	end

	arg_6_0:playCloseAnim()
end

function var_0_0.initRightLayout(arg_7_0)
	arg_7_0.rightLayout = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0.goCard, PlayerCardLayout)

	local var_7_0 = {}

	table.insert(var_7_0, arg_7_0:getLayoutItem(arg_7_0.goAssit, PlayerCardEnum.RightLayout.Assit))
	table.insert(var_7_0, arg_7_0:getLayoutItem(arg_7_0.goChapter, PlayerCardEnum.RightLayout.Chapter))
	table.insert(var_7_0, arg_7_0:getLayoutItem(arg_7_0.goCardGroup, PlayerCardEnum.RightLayout.CardGroup, PlayerCardLayoutItemCardGroup, arg_7_0.cardGroupComp))
	table.insert(var_7_0, arg_7_0:getLayoutItem(arg_7_0.goAchievement, PlayerCardEnum.RightLayout.Achievement))
	arg_7_0.rightLayout:setLayoutList(var_7_0)
end

function var_0_0.getLayoutItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = {
		layoutKey = arg_8_2,
		viewRoot = arg_8_0.viewGO,
		layout = arg_8_0.rightLayout,
		cardComp = arg_8_4
	}

	arg_8_3 = arg_8_3 or PlayerCardLayoutItem

	return MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_1, arg_8_3, var_8_0)
end

function var_0_0.refreshLayout(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getLayoutData()

	arg_9_0.rightLayout:setEditMode(true)
	arg_9_0.rightLayout:setData(var_9_0)
end

function var_0_0.loadRight(arg_10_0)
	arg_10_0.compList = {}

	local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes

	arg_10_0:loadGO(arg_10_0.goPlayerInfo, PlayerCardPlayerInfo, var_10_0.infoview)
	arg_10_0:loadGO(arg_10_0.goAssit, PlayerCardAssit, var_10_0.assitview)
	arg_10_0:loadGO(arg_10_0.goChapter, PlayerCardChapter, var_10_0.chapterview)

	local var_10_1 = {
		itemRes = arg_10_0.viewContainer:getRes(var_10_0.achieveitem)
	}

	arg_10_0:loadGO(arg_10_0.goAchievement, PlayerCardAchievement, var_10_0.achieveview, var_10_1)

	local var_10_2 = {
		itemRes = arg_10_0.viewContainer:getRes(var_10_0.carditem)
	}

	arg_10_0.cardGroupComp = arg_10_0:loadGO(arg_10_0.goCardGroup, PlayerCardCardGroup, var_10_0.groupview, var_10_2)
end

function var_0_0.loadGO(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = gohelper.findChild(arg_11_1, "card")
	local var_11_1 = arg_11_0:getResInst(arg_11_3, var_11_0 or arg_11_1)

	gohelper.setAsFirstSibling(var_11_1)

	arg_11_4 = arg_11_4 or {}
	arg_11_4.compType = PlayerCardEnum.CompType.Layout

	local var_11_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1, arg_11_2, arg_11_4)

	table.insert(arg_11_0.compList, var_11_2)

	return var_11_2
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_updateParam()
	arg_12_0:refreshView()
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:_updateParam()
	arg_13_0:refreshView()
end

function var_0_0._updateParam(arg_14_0)
	arg_14_0.userId = arg_14_0.viewParam.userId
end

function var_0_0.getCardInfo(arg_15_0)
	return PlayerCardModel.instance:getCardInfo(arg_15_0.userId)
end

function var_0_0.refreshView(arg_16_0)
	local var_16_0 = arg_16_0:getCardInfo()

	arg_16_0:refreshCompList(var_16_0)
	arg_16_0:refreshLayout(var_16_0)
end

function var_0_0.refreshCompList(arg_17_0, arg_17_1)
	if not arg_17_0.compList then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.compList) do
		iter_17_1:refreshView(arg_17_1)
	end
end

function var_0_0.onClose(arg_18_0)
	return
end

return var_0_0
