module("modules.logic.dungeon.view.monster.DungeonMonsterItem", package.seeall)

slot0 = class("DungeonMonsterItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btncategoryOnClick(slot0)
	slot0._view:selectCell(slot0._index, true)
end

function slot0._editableInitView(slot0)
	slot0._singleImage = gohelper.findChildImage(slot0.viewGO, "image")
	slot0._quality = gohelper.findChildImage(slot0.viewGO, "quality")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._singleImage.gameObject)
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._btncategoryOnClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if FightConfig.instance:getSkinCO(slot0._mo.config.skinId) and slot2.headIcon or nil then
		gohelper.getSingleImage(slot0._singleImage.gameObject):LoadImage(ResUrl.monsterHeadIcon(slot3))
	end

	UISpriteSetMgr.instance:setCommonSprite(slot0._quality, "bp_quality_01")
end

function slot0.onSelect(slot0, slot1)
	if slot1 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMonster, slot0._mo.config)
	end

	slot0._goselected:SetActive(slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
