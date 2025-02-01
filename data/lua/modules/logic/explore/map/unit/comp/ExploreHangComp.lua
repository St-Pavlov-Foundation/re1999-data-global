module("modules.logic.explore.map.unit.comp.ExploreHangComp", package.seeall)

slot0 = class("ExploreHangComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.unit = slot1
	slot0.hangList = {}
end

function slot0.setup(slot0, slot1)
	slot0.go = slot1

	for slot5, slot6 in pairs(slot0.hangList) do
		slot0:addHang(slot5, slot6)
	end
end

function slot0.addHang(slot0, slot1, slot2)
	slot0.hangList[slot1] = slot2

	if slot0.go and gohelper.findChild(slot0.go, slot1) and PrefabInstantiate.Create(slot3):getPath() ~= slot2 then
		slot4:startLoad(slot2)
	end
end

function slot0.clear(slot0)
	slot0.go = nil
end

return slot0
