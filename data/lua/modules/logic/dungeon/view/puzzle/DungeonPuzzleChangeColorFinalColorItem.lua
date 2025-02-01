module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorFinalColorItem", package.seeall)

slot0 = class("DungeonPuzzleChangeColorFinalColorItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0.id = slot2
	slot0._image = slot1:GetComponent(gohelper.Type_Image)

	slot0:setItem()
end

function slot0.setItem(slot0)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._image, DungeonConfig.instance:getDecryptChangeColorColorCo(slot0.id).colorvalue)
end

function slot0.onDestroy(slot0)
	gohelper.destroy(slot0.go)
end

return slot0
