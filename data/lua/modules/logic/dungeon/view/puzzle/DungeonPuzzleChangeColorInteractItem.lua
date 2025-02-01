module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorInteractItem", package.seeall)

slot0 = class("DungeonPuzzleChangeColorInteractItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0.id = slot2
	slot0._click = gohelper.getClickWithAudio(slot0.go)

	slot0._click:AddClickListener(slot0._onItemClick, slot0)

	slot0._txtDesc = gohelper.findChildText(slot0.go, "desc")

	slot0:setItem()
end

function slot0.setItem(slot0)
	slot0._txtDesc.text = DungeonConfig.instance:getDecryptChangeColorInteractCo(slot0.id).desc
end

function slot0._onItemClick(slot0)
	DungeonPuzzleChangeColorController.instance:dispatchEvent(DungeonPuzzleEvent.InteractClick, slot0.id)
end

function slot0.onDestroy(slot0)
	slot0._click:RemoveClickListener()
	gohelper.destroy(slot0.go)
end

return slot0
