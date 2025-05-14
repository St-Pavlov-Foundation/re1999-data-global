module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateChessBoardItem", package.seeall)

local var_0_0 = class("EliminateChessBoardItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tr = arg_1_1.transform
	arg_1_0._img_chessBoard = gohelper.findChildImage(arg_1_0._go, "image")
end

function var_0_0.initData(arg_2_0, arg_2_1)
	arg_2_0._data = arg_2_1

	if arg_2_0._data then
		local var_2_0 = (arg_2_0._data.x - 1) * EliminateEnum.ChessWidth
		local var_2_1 = (arg_2_0._data.y - 1) * EliminateEnum.ChessHeight
		local var_2_2 = EliminateConfig.instance:getChessBoardIconPath(arg_2_0._data:getChessBoardType())
		local var_2_3 = not string.nilorempty(var_2_2)

		recthelper.setSize(arg_2_0._tr, EliminateEnum.ChessWidth, EliminateEnum.ChessHeight)

		if var_2_3 then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_2_0._img_chessBoard, var_2_2, false)
		end

		gohelper.setActiveCanvasGroup(arg_2_0._go, var_2_3)
		transformhelper.setLocalPosXY(arg_2_0._tr, var_2_0, var_2_1)
	end
end

function var_0_0.clear(arg_3_0)
	arg_3_0._data = nil
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0:clear()
	var_0_0.super.onDestroy(arg_4_0)
end

return var_0_0
