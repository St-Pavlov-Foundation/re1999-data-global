module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorView", package.seeall)

local var_0_0 = class("DungeonPuzzleChangeColorView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._goshowboard = gohelper.findChild(arg_1_0.viewGO, "#go_showboard")
	arg_1_0._gofinalboard = gohelper.findChild(arg_1_0.viewGO, "#go_finalboard")
	arg_1_0._gointeractboard = gohelper.findChild(arg_1_0.viewGO, "#go_interactboard")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._gosort = gohelper.findChild(arg_1_0.viewGO, "#go_sort")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.viewGO, "#go_finish")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._btnresetOnClick(arg_4_0)
	arg_4_0:_reset()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goshowitem = gohelper.findChild(arg_5_0.viewGO, "#go_showboard/showitem")
	arg_5_0._gofinalitem = gohelper.findChild(arg_5_0.viewGO, "#go_finalboard/finalitem")
	arg_5_0._gointeractitem = gohelper.findChild(arg_5_0.viewGO, "#go_interactboard/interactitem")
	arg_5_0._gosortitem = gohelper.findChild(arg_5_0.viewGO, "#go_sort/sortitem")

	gohelper.setActive(arg_5_0._gofinished, false)

	arg_5_0._curTags = {}
	arg_5_0._finalTags = {}
	arg_5_0._showItems = {}
	arg_5_0._finalItems = {}
	arg_5_0._sortItems = {}
	arg_5_0._interactItems = {}
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("zqlm_bg4"))
	arg_7_0:_initTags()
	arg_7_0:_setFinalItem()
	arg_7_0:_setSortItem()
	arg_7_0:_setInteractItem()
	arg_7_0:_refreshShowItem()
	arg_7_0:addEventCb(DungeonPuzzleChangeColorController.instance, DungeonPuzzleEvent.InteractClick, arg_7_0._changeTags, arg_7_0)
end

function var_0_0._initTags(arg_8_0)
	local var_8_0 = DungeonConfig.instance:getDecryptChangeColorCo(arg_8_0.viewParam)

	arg_8_0._curTags = string.splitToNumber(var_8_0.initColors, "#")
	arg_8_0._finalTags = string.splitToNumber(var_8_0.finalColors, "#")
end

function var_0_0._isSuccess(arg_9_0)
	if #arg_9_0._curTags ~= #arg_9_0._finalTags then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._curTags) do
		if arg_9_0._finalTags[iter_9_0] ~= iter_9_1 then
			return false
		end
	end

	return true
end

function var_0_0._changeTags(arg_10_0, arg_10_1)
	local var_10_0 = DungeonConfig.instance:getDecryptChangeColorInteractCo(arg_10_1)
	local var_10_1 = DungeonConfig.instance:getDecryptChangeColorCo(arg_10_0.viewParam)
	local var_10_2 = string.splitToNumber(var_10_1.interactbtns, "#")
	local var_10_3 = string.split(var_10_0.interactvalue, "|")
	local var_10_4 = string.splitToNumber(var_10_3[2], "#")

	for iter_10_0, iter_10_1 in ipairs(var_10_4) do
		if arg_10_0._curTags[iter_10_1] + tonumber(var_10_3[1]) > #var_10_2 then
			arg_10_0._curTags[iter_10_1] = (arg_10_0._curTags[iter_10_1] + tonumber(var_10_3[1])) % (#var_10_2 + 1) + 1
		else
			arg_10_0._curTags[iter_10_1] = arg_10_0._curTags[iter_10_1] + tonumber(var_10_3[1])
		end
	end

	arg_10_0:_refreshShowItem()

	local var_10_5 = arg_10_0:_isSuccess()

	gohelper.setActive(arg_10_0._gofinished, var_10_5)
end

function var_0_0._reset(arg_11_0)
	local var_11_0 = DungeonConfig.instance:getDecryptChangeColorCo(arg_11_0.viewParam)

	arg_11_0._curTags = string.splitToNumber(var_11_0.initColors, "#")

	arg_11_0:_refreshShowItem()
end

function var_0_0._setFinalItem(arg_12_0)
	if arg_12_0._finalItems then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._finalItems) do
			iter_12_1:onDestroy()
		end
	end

	arg_12_0._finalItems = {}

	for iter_12_2 = 1, #arg_12_0._finalTags do
		local var_12_0 = gohelper.cloneInPlace(arg_12_0._gofinalitem)

		gohelper.setActive(var_12_0, true)

		local var_12_1 = DungeonPuzzleChangeColorFinalColorItem.New()

		var_12_1:init(var_12_0, arg_12_0._finalTags[iter_12_2])
		table.insert(arg_12_0._finalItems, var_12_1)
	end
end

function var_0_0._setSortItem(arg_13_0)
	if arg_13_0._sortItems then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._sortItems) do
			iter_13_1:onDestroy()
		end
	end

	arg_13_0._sortItems = {}

	local var_13_0 = string.splitToNumber(DungeonConfig.instance:getDecryptChangeColorCo(arg_13_0.viewParam).colorsort, "#")

	for iter_13_2 = 1, #var_13_0 do
		local var_13_1 = gohelper.cloneInPlace(arg_13_0._gosortitem)

		gohelper.setActive(var_13_1, true)

		local var_13_2 = DungeonPuzzleChangeColorSortItem.New()

		var_13_2:init(var_13_1, var_13_0[iter_13_2])
		table.insert(arg_13_0._sortItems, var_13_2)
	end
end

function var_0_0._setInteractItem(arg_14_0)
	if arg_14_0._interactItems then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._interactItems) do
			iter_14_1:onDestroy()
		end
	end

	arg_14_0._interactItems = {}

	local var_14_0 = string.splitToNumber(DungeonConfig.instance:getDecryptChangeColorCo(arg_14_0.viewParam).interactbtns, "#")

	for iter_14_2 = 1, #var_14_0 do
		local var_14_1 = gohelper.cloneInPlace(arg_14_0._gointeractitem)

		gohelper.setActive(var_14_1, true)

		local var_14_2 = DungeonPuzzleChangeColorInteractItem.New()

		var_14_2:init(var_14_1, var_14_0[iter_14_2])
		table.insert(arg_14_0._interactItems, var_14_2)
	end
end

function var_0_0._refreshShowItem(arg_15_0)
	if arg_15_0._showItems then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._showItems) do
			iter_15_1:onDestroy()
		end
	end

	arg_15_0._showItems = {}

	for iter_15_2 = 1, #arg_15_0._curTags do
		local var_15_0 = gohelper.cloneInPlace(arg_15_0._goshowitem)

		gohelper.setActive(var_15_0, true)

		local var_15_1 = DungeonPuzzleChangeColorShowColorItem.New()

		var_15_1:init(var_15_0, arg_15_0._curTags[iter_15_2])
		table.insert(arg_15_0._showItems, var_15_1)
	end
end

function var_0_0.onClose(arg_16_0)
	arg_16_0:removeEventCb(DungeonPuzzleChangeColorController.instance, DungeonPuzzleEvent.InteractClick, arg_16_0._changeTags, arg_16_0)
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg:UnLoadImage()

	if arg_17_0._finalItems then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._finalItems) do
			iter_17_1:onDestroy()
		end

		arg_17_0._finalItems = nil
	end

	if arg_17_0._sortItems then
		for iter_17_2, iter_17_3 in pairs(arg_17_0._sortItems) do
			iter_17_3:onDestroy()
		end

		arg_17_0._sortItems = nil
	end

	if arg_17_0._interactItems then
		for iter_17_4, iter_17_5 in pairs(arg_17_0._interactItems) do
			iter_17_5:onDestroy()
		end

		arg_17_0._interactItems = nil
	end

	if arg_17_0._showItems then
		for iter_17_6, iter_17_7 in pairs(arg_17_0._showItems) do
			iter_17_7:onDestroy()
		end

		arg_17_0._showItems = nil
	end
end

return var_0_0
