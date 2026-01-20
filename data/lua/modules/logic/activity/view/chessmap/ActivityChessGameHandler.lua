-- chunkname: @modules/logic/activity/view/chessmap/ActivityChessGameHandler.lua

module("modules.logic.activity.view.chessmap.ActivityChessGameHandler", package.seeall)

local ActivityChessGameHandler = class("ActivityChessGameHandler", BaseView)

function ActivityChessGameHandler:init(viewObj)
	self._viewObj = viewObj
end

function ActivityChessGameHandler:drawBaseTile(x, y)
	local tileData = ActivityChessGameModel.instance:getBaseTile(x, y)
	local tileObj = self._viewObj:getBaseTile(x, y)

	if tileData == ActivityChessEnum.TileBaseType.Normal then
		gohelper.setActive(tileObj.imageTile.gameObject, true)
		UISpriteSetMgr.instance:setActivityChessMapSprite(tileObj.imageTile, "img_di")
	else
		gohelper.setActive(tileObj.imageTile.gameObject, false)
	end
end

function ActivityChessGameHandler.sortBaseTile(baseTiles)
	local tileSortList = {}

	for _, tileList in pairs(baseTiles) do
		for _, tileObj in pairs(tileList) do
			table.insert(tileSortList, tileObj)
		end
	end

	table.sort(tileSortList, ActivityChessGameHandler.sortTile)

	for i, tileObj in ipairs(tileSortList) do
		tileObj.rect:SetSiblingIndex(i)
	end
end

function ActivityChessGameHandler.sortTile(a, b)
	return a.anchorY > b.anchorY
end

function ActivityChessGameHandler.sortInteractObjects(avatars)
	if not avatars then
		return
	end

	table.sort(avatars, ActivityChessGameHandler.sortObjects)

	for i, avatar in ipairs(avatars) do
		avatar.rect:SetSiblingIndex(i)
	end
end

function ActivityChessGameHandler.sortObjects(a, b)
	local aAnchorY = a.anchorY or 9999999
	local bAnchorY = b.anchorY or 9999999

	if aAnchorY ~= bAnchorY then
		return a.anchorY > b.anchorY
	else
		return (a.order or 0) < (b.order or 0)
	end
end

function ActivityChessGameHandler:dispose()
	self._viewObj = nil
end

return ActivityChessGameHandler
