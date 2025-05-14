module("modules.logic.chessgame.game.scene.ChessGameHandler", package.seeall)

local var_0_0 = class("ChessGameHandler", BaseView)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._viewObj = arg_1_1
end

function var_0_0.drawBaseTile(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = ChessGameModel.instance:getBaseTile(arg_2_1, arg_2_2)
	local var_2_1 = arg_2_0._viewObj:getBaseTile(arg_2_1, arg_2_2)

	if var_2_0 == ChessGameEnum.TileBaseType.Normal then
		gohelper.setActive(var_2_1.imageTile.gameObject, true)
		UISpriteSetMgr.instance:setVa3ChessMapSprite(var_2_1.imageTile, "img_di")
	else
		gohelper.setActive(var_2_1.imageTile.gameObject, false)
	end
end

function var_0_0.sortBaseTile(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			table.insert(var_3_0, iter_3_3)
		end
	end

	table.sort(var_3_0, var_0_0.sortTile)

	for iter_3_4, iter_3_5 in ipairs(var_3_0) do
		iter_3_5.rect:SetSiblingIndex(iter_3_4)
	end
end

function var_0_0.sortTile(arg_4_0, arg_4_1)
	return arg_4_0.anchorY > arg_4_1.anchorY
end

function var_0_0.sortInteractObjects(arg_5_0)
	if not arg_5_0 then
		return
	end

	table.sort(arg_5_0, var_0_0.sortObjects)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		iter_5_1.rect:SetSiblingIndex(iter_5_0)
	end
end

function var_0_0.sortObjects(arg_6_0, arg_6_1)
	if (arg_6_0.anchorY or 9999999) ~= (arg_6_1.anchorY or 9999999) then
		return arg_6_0.anchorY > arg_6_1.anchorY
	else
		return (arg_6_0.order or 0) < (arg_6_1.order or 0)
	end
end

function var_0_0.dispose(arg_7_0)
	arg_7_0._viewObj = nil
end

return var_0_0
