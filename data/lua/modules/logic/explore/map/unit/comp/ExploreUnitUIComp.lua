module("modules.logic.explore.map.unit.comp.ExploreUnitUIComp", package.seeall)

slot0 = class("ExploreUnitUIComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.unit = slot1
	slot0.uiDict = {}
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.setup(slot0, slot1)
	for slot5, slot6 in pairs(slot0.uiDict) do
		slot6:setTarget(slot1)
	end
end

function slot0.addUI(slot0, slot1)
	if not slot0.uiDict[slot1.__cname] then
		slot0.uiDict[slot1.__cname] = slot1.New(slot0.unit)
	end

	return slot0.uiDict[slot1.__cname]
end

function slot0.removeUI(slot0, slot1)
	if slot0.uiDict[slot1.__cname] then
		slot0.uiDict[slot1.__cname]:tryDispose()

		slot0.uiDict[slot1.__cname] = nil
	end
end

function slot0.clear(slot0)
	if slot0.uiDict then
		for slot4, slot5 in pairs(slot0.uiDict) do
			slot5:setTarget(slot0.go)
		end
	end
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in pairs(slot0.uiDict) do
		slot5:tryDispose()
	end

	slot0.uiDict = nil
	slot0.unit = nil
	slot0.go = nil
end

return slot0
