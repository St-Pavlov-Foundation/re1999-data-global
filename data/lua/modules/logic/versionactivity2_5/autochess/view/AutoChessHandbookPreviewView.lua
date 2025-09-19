module("modules.logic.versionactivity2_5.autochess.view.AutoChessHandbookPreviewView", package.seeall)

local var_0_0 = class("AutoChessHandbookPreviewView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goCardRoot = gohelper.findChild(arg_1_0.viewGO, "#go_View/Card/Viewport/#go_CardRoot")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0.onClickClose(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._chessCardItems = arg_5_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._chessId = arg_6_0.viewParam.chessId

	arg_6_0:createChessCardItems()
end

function var_0_0.createChessCardItems(arg_7_0)
	local var_7_0 = AutoChessConfig:getChessCfgById(arg_7_0._chessId)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = arg_7_0:getResInst(AutoChessStrEnum.ResPath.ChessCard, arg_7_0._goCardRoot, "card" .. iter_7_1.id)
		local var_7_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, AutoChessCard)
		local var_7_3 = {
			type = AutoChessCard.ShowType.HandBook,
			itemId = iter_7_1.id,
			star = iter_7_1.star,
			arrow = iter_7_0 < #var_7_0
		}

		arg_7_0._chessCardItems[#arg_7_0._chessCardItems + 1] = var_7_1

		var_7_2:setData(var_7_3)
	end
end

function var_0_0.clearChessCardItems(arg_8_0)
	if arg_8_0._chessCardItems then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._chessCardItems) do
			gohelper.destroy(iter_8_1)
		end
	end
end

function var_0_0.refreshMonsterInfoView(arg_9_0)
	return
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0:clearChessCardItems()
end

return var_0_0
