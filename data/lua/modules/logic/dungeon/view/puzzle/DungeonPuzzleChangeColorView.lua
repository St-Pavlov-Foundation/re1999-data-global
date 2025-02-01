module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorView", package.seeall)

slot0 = class("DungeonPuzzleChangeColorView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._goshowboard = gohelper.findChild(slot0.viewGO, "#go_showboard")
	slot0._gofinalboard = gohelper.findChild(slot0.viewGO, "#go_finalboard")
	slot0._gointeractboard = gohelper.findChild(slot0.viewGO, "#go_interactboard")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._gosort = gohelper.findChild(slot0.viewGO, "#go_sort")
	slot0._gofinished = gohelper.findChild(slot0.viewGO, "#go_finish")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreset:RemoveClickListener()
end

function slot0._btnresetOnClick(slot0)
	slot0:_reset()
end

function slot0._editableInitView(slot0)
	slot0._goshowitem = gohelper.findChild(slot0.viewGO, "#go_showboard/showitem")
	slot0._gofinalitem = gohelper.findChild(slot0.viewGO, "#go_finalboard/finalitem")
	slot0._gointeractitem = gohelper.findChild(slot0.viewGO, "#go_interactboard/interactitem")
	slot0._gosortitem = gohelper.findChild(slot0.viewGO, "#go_sort/sortitem")

	gohelper.setActive(slot0._gofinished, false)

	slot0._curTags = {}
	slot0._finalTags = {}
	slot0._showItems = {}
	slot0._finalItems = {}
	slot0._sortItems = {}
	slot0._interactItems = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("zqlm_bg4"))
	slot0:_initTags()
	slot0:_setFinalItem()
	slot0:_setSortItem()
	slot0:_setInteractItem()
	slot0:_refreshShowItem()
	slot0:addEventCb(DungeonPuzzleChangeColorController.instance, DungeonPuzzleEvent.InteractClick, slot0._changeTags, slot0)
end

function slot0._initTags(slot0)
	slot1 = DungeonConfig.instance:getDecryptChangeColorCo(slot0.viewParam)
	slot0._curTags = string.splitToNumber(slot1.initColors, "#")
	slot0._finalTags = string.splitToNumber(slot1.finalColors, "#")
end

function slot0._isSuccess(slot0)
	if #slot0._curTags ~= #slot0._finalTags then
		return false
	end

	for slot4, slot5 in ipairs(slot0._curTags) do
		if slot0._finalTags[slot4] ~= slot5 then
			return false
		end
	end

	return true
end

function slot0._changeTags(slot0, slot1)
	slot4 = string.splitToNumber(DungeonConfig.instance:getDecryptChangeColorCo(slot0.viewParam).interactbtns, "#")

	for slot10, slot11 in ipairs(string.splitToNumber(string.split(DungeonConfig.instance:getDecryptChangeColorInteractCo(slot1).interactvalue, "|")[2], "#")) do
		if slot0._curTags[slot11] + tonumber(slot5[1]) > #slot4 then
			slot0._curTags[slot11] = (slot0._curTags[slot11] + tonumber(slot5[1])) % (#slot4 + 1) + 1
		else
			slot0._curTags[slot11] = slot0._curTags[slot11] + tonumber(slot5[1])
		end
	end

	slot0:_refreshShowItem()
	gohelper.setActive(slot0._gofinished, slot0:_isSuccess())
end

function slot0._reset(slot0)
	slot0._curTags = string.splitToNumber(DungeonConfig.instance:getDecryptChangeColorCo(slot0.viewParam).initColors, "#")

	slot0:_refreshShowItem()
end

function slot0._setFinalItem(slot0)
	if slot0._finalItems then
		for slot4, slot5 in pairs(slot0._finalItems) do
			slot5:onDestroy()
		end
	end

	slot0._finalItems = {}

	for slot4 = 1, #slot0._finalTags do
		slot5 = gohelper.cloneInPlace(slot0._gofinalitem)

		gohelper.setActive(slot5, true)

		slot6 = DungeonPuzzleChangeColorFinalColorItem.New()

		slot6:init(slot5, slot0._finalTags[slot4])
		table.insert(slot0._finalItems, slot6)
	end
end

function slot0._setSortItem(slot0)
	if slot0._sortItems then
		for slot4, slot5 in pairs(slot0._sortItems) do
			slot5:onDestroy()
		end
	end

	slot0._sortItems = {}

	for slot5 = 1, #string.splitToNumber(DungeonConfig.instance:getDecryptChangeColorCo(slot0.viewParam).colorsort, "#") do
		slot6 = gohelper.cloneInPlace(slot0._gosortitem)

		gohelper.setActive(slot6, true)

		slot7 = DungeonPuzzleChangeColorSortItem.New()

		slot7:init(slot6, slot1[slot5])
		table.insert(slot0._sortItems, slot7)
	end
end

function slot0._setInteractItem(slot0)
	if slot0._interactItems then
		for slot4, slot5 in pairs(slot0._interactItems) do
			slot5:onDestroy()
		end
	end

	slot0._interactItems = {}

	for slot5 = 1, #string.splitToNumber(DungeonConfig.instance:getDecryptChangeColorCo(slot0.viewParam).interactbtns, "#") do
		slot6 = gohelper.cloneInPlace(slot0._gointeractitem)

		gohelper.setActive(slot6, true)

		slot7 = DungeonPuzzleChangeColorInteractItem.New()

		slot7:init(slot6, slot1[slot5])
		table.insert(slot0._interactItems, slot7)
	end
end

function slot0._refreshShowItem(slot0)
	if slot0._showItems then
		for slot4, slot5 in pairs(slot0._showItems) do
			slot5:onDestroy()
		end
	end

	slot0._showItems = {}

	for slot4 = 1, #slot0._curTags do
		slot5 = gohelper.cloneInPlace(slot0._goshowitem)

		gohelper.setActive(slot5, true)

		slot6 = DungeonPuzzleChangeColorShowColorItem.New()

		slot6:init(slot5, slot0._curTags[slot4])
		table.insert(slot0._showItems, slot6)
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(DungeonPuzzleChangeColorController.instance, DungeonPuzzleEvent.InteractClick, slot0._changeTags, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()

	if slot0._finalItems then
		for slot4, slot5 in pairs(slot0._finalItems) do
			slot5:onDestroy()
		end

		slot0._finalItems = nil
	end

	if slot0._sortItems then
		for slot4, slot5 in pairs(slot0._sortItems) do
			slot5:onDestroy()
		end

		slot0._sortItems = nil
	end

	if slot0._interactItems then
		for slot4, slot5 in pairs(slot0._interactItems) do
			slot5:onDestroy()
		end

		slot0._interactItems = nil
	end

	if slot0._showItems then
		for slot4, slot5 in pairs(slot0._showItems) do
			slot5:onDestroy()
		end

		slot0._showItems = nil
	end
end

return slot0
