module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorSortItem", package.seeall)

slot0 = class("DungeonPuzzleChangeColorSortItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0.id = slot2
	slot0._image = slot1:GetComponent(gohelper.Type_Image)
	slot0._txtname = gohelper.findChildText(slot1, "tiptxt")

	slot0:setItem()
end

function slot0.setItem(slot0)
	slot1 = DungeonConfig.instance:getDecryptChangeColorColorCo(slot0.id)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._image, slot1.colorvalue)

	slot0._txtname.text = slot1.name
end

function slot0.onDestroy(slot0)
	gohelper.destroy(slot0.go)
end

return slot0
