module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallInfoView", package.seeall)

local var_0_0 = class("AutoChessMallInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goTopRight = gohelper.findChild(arg_1_0.viewGO, "#go_TopRight")
	arg_1_0._txtCoin = gohelper.findChildText(arg_1_0.viewGO, "#go_TopRight/price/#txt_Coin")
	arg_1_0._goCardRoot = gohelper.findChild(arg_1_0.viewGO, "#go_CardRoot")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Left")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Right")
	arg_1_0._txtPage = gohelper.findChildText(arg_1_0.viewGO, "#txt_Page")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnLeftOnClick(arg_5_0)
	arg_5_0.curIndex = arg_5_0.curIndex - 1

	arg_5_0:refreshMallUI()
end

function var_0_0._btnRightOnClick(arg_6_0)
	arg_6_0.curIndex = arg_6_0.curIndex + 1

	arg_6_0:refreshMallUI()
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = arg_7_0:getResInst(AutoChessStrEnum.ResPath.ChessCard, arg_7_0._goCardRoot)

	arg_7_0.card = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0, AutoChessCard, arg_7_0)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	if not arg_9_0.viewParam then
		return
	end

	local var_9_0 = AutoChessModel.instance:getChessMo()

	arg_9_0._txtCoin.text = var_9_0.svrMall.coin

	if arg_9_0.viewParam.mall then
		arg_9_0.mall = arg_9_0.viewParam.mall
		arg_9_0.mallItems = arg_9_0.mall.items
		arg_9_0.itemUId = arg_9_0.viewParam.itemUId

		for iter_9_0, iter_9_1 in ipairs(arg_9_0.mallItems) do
			if iter_9_1.uid == arg_9_0.itemUId then
				arg_9_0.curIndex = iter_9_0
			end
		end

		arg_9_0.maxCnt = #arg_9_0.mallItems

		arg_9_0:refreshMallUI()
	else
		arg_9_0:refreshChessUI()
	end

	arg_9_0:addEventCb(AutoChessController.instance, AutoChessEvent.BuyChessReply, arg_9_0.closeThis, arg_9_0)
	arg_9_0:addEventCb(AutoChessController.instance, AutoChessEvent.BuildReply, arg_9_0.closeThis, arg_9_0)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.refreshChessUI(arg_12_0)
	gohelper.setActive(arg_12_0._btnLeft, false)
	gohelper.setActive(arg_12_0._btnRight, false)
	gohelper.setActive(arg_12_0._txtPage, false)

	local var_12_0 = arg_12_0.viewParam.chessEntity

	gohelper.setActive(arg_12_0._goTopRight, var_12_0.teamType == AutoChessEnum.TeamType.Player)

	local var_12_1 = {
		type = AutoChessCard.ShowType.Sell,
		entity = var_12_0
	}

	arg_12_0.card:setData(var_12_1)
end

function var_0_0.refreshMallUI(arg_13_0)
	gohelper.setActive(arg_13_0._btnLeft, arg_13_0.curIndex > 1)
	gohelper.setActive(arg_13_0._btnRight, arg_13_0.curIndex < arg_13_0.maxCnt)

	arg_13_0._txtPage.text = string.format("%d/%d", arg_13_0.curIndex, arg_13_0.maxCnt)

	local var_13_0 = arg_13_0.mallItems[arg_13_0.curIndex]
	local var_13_1 = {
		type = AutoChessCard.ShowType.Buy,
		mallId = arg_13_0.mall.mallId,
		data = var_13_0
	}

	arg_13_0.card:setData(var_13_1)
end

return var_0_0
