module("modules.logic.chessgame.game.scene.ChessGameHandler", package.seeall)

slot0 = class("ChessGameHandler", BaseView)

function slot0.init(slot0, slot1)
	slot0._viewObj = slot1
end

function slot0.drawBaseTile(slot0, slot1, slot2)
	slot4 = slot0._viewObj:getBaseTile(slot1, slot2)

	if ChessGameModel.instance:getBaseTile(slot1, slot2) == ChessGameEnum.TileBaseType.Normal then
		gohelper.setActive(slot4.imageTile.gameObject, true)
		UISpriteSetMgr.instance:setVa3ChessMapSprite(slot4.imageTile, "img_di")
	else
		gohelper.setActive(slot4.imageTile.gameObject, false)
	end
end

function slot0.sortBaseTile(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0) do
		for slot10, slot11 in pairs(slot6) do
			table.insert(slot1, slot11)
		end
	end

	slot5 = uv0.sortTile

	table.sort(slot1, slot5)

	for slot5, slot6 in ipairs(slot1) do
		slot6.rect:SetSiblingIndex(slot5)
	end
end

function slot0.sortTile(slot0, slot1)
	return slot1.anchorY < slot0.anchorY
end

function slot0.sortInteractObjects(slot0)
	if not slot0 then
		return
	end

	slot4 = uv0.sortObjects

	table.sort(slot0, slot4)

	for slot4, slot5 in ipairs(slot0) do
		slot5.rect:SetSiblingIndex(slot4)
	end
end

function slot0.sortObjects(slot0, slot1)
	if (slot0.anchorY or 9999999) ~= (slot1.anchorY or 9999999) then
		return slot1.anchorY < slot0.anchorY
	else
		return (slot0.order or 0) < (slot1.order or 0)
	end
end

function slot0.dispose(slot0)
	slot0._viewObj = nil
end

return slot0
