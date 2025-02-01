module("modules.logic.gm.view.fight.FightGmNameUIComp", package.seeall)

slot0 = class("FightGmNameUIComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

slot0.GmNameUIPath = "ui/viewres/gm/gmnameui.prefab"
slot0.SideAnchorY = {
	[FightEnum.EntitySide.MySide] = 93,
	[FightEnum.EntitySide.EnemySide] = 147
}

function slot0.init(slot0, slot1)
	slot0.goContainer = slot1
	slot0.loaded = false

	loadAbAsset(uv0.GmNameUIPath, true, slot0.onLoadDone, slot0)
end

function slot0.onLoadDone(slot0, slot1)
	slot0.assetItem = slot1

	slot0.assetItem:Retain()

	slot0.go = gohelper.clone(slot1:GetResource(), slot0.goContainer)
	slot0.labelText = gohelper.findChildText(slot0.go, "label")
	slot0.labelText.text = ""

	recthelper.setAnchorY(slot0.go.transform, uv0.SideAnchorY[slot0.entity:getMO().side] or 0)
	slot0:hide()

	slot0.loaded = true

	slot0:_startStatBuffType()
end

function slot0.show(slot0)
	gohelper.setActive(slot0.go, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.startStatBuffType(slot0, slot1)
	slot0.buffTypeId = slot1

	slot0:_startStatBuffType()
end

function slot0._startStatBuffType(slot0)
	if not slot0.loaded then
		return
	end

	if not slot0.buffTypeId then
		return
	end

	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0.refreshLabel, slot0)
	slot0:show()
	slot0:refreshLabel()
end

function slot0.stopStatBuffType(slot0)
	slot0.buffTypeId = nil

	slot0:hide()
	slot0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0.refreshLabel, slot0)
end

function slot0.refreshLabel(slot0)
	for slot7, slot8 in ipairs(slot0.entity:getMO():getBuffList()) do
		if slot8:getCO().typeId == slot0.buffTypeId then
			slot3 = 0 + 1
		end
	end

	slot0.labelText.text = string.format("%s : %s", slot0.buffTypeId, slot3)
end

function slot0.onDestroy(slot0)
	removeAssetLoadCb(uv0.GmNameUIPath, slot0.onLoadDone, slot0)

	slot0.entity = nil

	if slot0.assetItem then
		slot0.assetItem:Release()
	end
end

return slot0
