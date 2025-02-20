module("modules.logic.fight.entity.mgr.FightNameMgr", package.seeall)

slot0 = class("FightNameMgr")

function slot0.ctor(slot0)
	slot0._hasReplaceNameBar = nil
	slot0._nameParent = nil
	slot0._fightNameUIList = nil
end

function slot0.init(slot0)
	slot0._nameParent = gohelper.create2d(slot0:getHudGO(), "NameBar")
	slot0._fightNameUIList = {}
end

function slot0.getHudGO(slot0)
	return ViewMgr.instance:getUILayer(UILayerName.Hud)
end

function slot0.dispose(slot0)
	slot0._hasReplaceNameBar = nil

	if slot0._nameParent then
		gohelper.destroy(slot0._nameParent)

		slot0._nameParent = nil
	end

	slot0._fightNameUIList = {}

	TaskDispatcher.cancelTask(slot0._delayAdujstUISibling, slot0)
end

function slot0.onRestartStage(slot0)
	slot0._fightNameUIList = {}

	TaskDispatcher.cancelTask(slot0._delayAdujstUISibling, slot0)
end

function slot0.getNameParent(slot0)
	return slot0._nameParent
end

function slot0.register(slot0, slot1)
	table.insert(slot0._fightNameUIList, slot1)
	TaskDispatcher.cancelTask(slot0._delayAdujstUISibling, slot0)
	TaskDispatcher.runDelay(slot0._delayAdujstUISibling, slot0, 1)
	slot0:_replaceNameBar()
end

function slot0.unregister(slot0, slot1)
	tabletool.removeValue(slot0._fightNameUIList, slot1)
end

function slot0._replaceNameBar(slot0)
	if slot0._hasReplaceNameBar or #slot0._fightNameUIList == 0 then
		return
	end

	if gohelper.isNil(slot0._fightNameUIList[1]:getUIGO()) then
		return
	end

	slot0._hasReplaceNameBar = true

	if gohelper.isNil(gohelper.findChild(slot2, "NameBar")) then
		return
	end

	slot5 = gohelper.clone(slot3, slot0:getHudGO(), "NameBar")

	if gohelper.isNil(slot0._nameParent) or gohelper.isNil(slot5) then
		return
	end

	for slot12 = slot0._nameParent.transform.childCount - 1, 0, -1 do
		if not gohelper.isNil(slot6:GetChild(slot12)) then
			slot13:SetParent(slot5.transform, false)
		end
	end

	gohelper.setSiblingAfter(slot5, slot0._nameParent)
	gohelper.destroy(slot0._nameParent)

	slot0._nameParent = slot5

	gohelper.setActive(slot0._nameParent, true)
end

function slot0._delayAdujstUISibling(slot0)
	slot0:_replaceNameBar()

	if #slot0._fightNameUIList <= 1 then
		return
	end

	function slot4(slot0, slot1)
		if slot0.entity.go.transform.position.z ~= slot1.entity.go.transform.position.z then
			return slot3.z < slot2.z
		elseif slot2.x ~= slot3.x then
			return math.abs(slot3.x) < math.abs(slot2.x)
		else
			return slot1.entity.id < slot0.entity.id
		end
	end

	table.sort(slot0._fightNameUIList, slot4)
	gohelper.setAsFirstSibling(slot0._fightNameUIList[1]:getGO())

	for slot4 = 2, #slot0._fightNameUIList do
		gohelper.setSiblingAfter(slot0._fightNameUIList[slot4]:getGO(), slot0._fightNameUIList[slot4 - 1]:getGO())
	end
end

slot0.instance = slot0.New()

return slot0
