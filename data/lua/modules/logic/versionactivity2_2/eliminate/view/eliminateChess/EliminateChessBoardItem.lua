module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateChessBoardItem", package.seeall)

slot0 = class("EliminateChessBoardItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._tr = slot1.transform
	slot0._img_chessBoard = gohelper.findChildImage(slot0._go, "image")
end

function slot0.initData(slot0, slot1)
	slot0._data = slot1

	if slot0._data then
		slot2 = (slot0._data.x - 1) * EliminateEnum.ChessWidth
		slot3 = (slot0._data.y - 1) * EliminateEnum.ChessHeight

		recthelper.setSize(slot0._tr, EliminateEnum.ChessWidth, EliminateEnum.ChessHeight)

		if not string.nilorempty(EliminateConfig.instance:getChessBoardIconPath(slot0._data:getChessBoardType())) then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._img_chessBoard, slot4, false)
		end

		gohelper.setActiveCanvasGroup(slot0._go, slot5)
		transformhelper.setLocalPosXY(slot0._tr, slot2, slot3)
	end
end

function slot0.clear(slot0)
	slot0._data = nil
end

function slot0.onDestroy(slot0)
	slot0:clear()
	uv0.super.onDestroy(slot0)
end

return slot0
