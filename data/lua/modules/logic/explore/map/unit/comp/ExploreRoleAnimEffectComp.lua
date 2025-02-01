module("modules.logic.explore.map.unit.comp.ExploreRoleAnimEffectComp", package.seeall)

slot0 = class("ExploreRoleAnimEffectComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.unit = slot1
	slot0._effects = {}
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.setStatus(slot0, slot1)
	slot0._status = slot1

	if lua_explore_hero_effect.configDict[slot1] then
		for slot6 = 1, #slot2 do
			if slot2[slot6].audioId and slot2[slot6].audioId > 0 then
				AudioMgr.instance:trigger(slot2[slot6].audioId)
			end

			if not slot0._effects[slot6] then
				slot0._effects[slot6] = {
					go = UnityEngine.GameObject.New()
				}
				slot0._effects[slot6].loader = PrefabInstantiate.Create(slot0._effects[slot6].go)
			else
				gohelper.setActive(slot0._effects[slot6].go, true)
			end

			slot0._effects[slot6].loader:dispose()

			if not string.nilorempty(slot2[slot6].effectPath) then
				slot0._effects[slot6].path = slot2[slot6].hangPath

				slot0._effects[slot6].loader:startLoad(ResUrl.getExploreEffectPath(slot2[slot6].effectPath))

				slot7 = slot0.unit._displayTr

				if not string.nilorempty(slot0._effects[slot6].path) and slot0.unit._displayTr:Find(slot0._effects[slot6].path) then
					slot7 = slot8
				end

				slot0._effects[slot6].go.transform:SetParent(slot7, false)
			else
				gohelper.setActive(slot0._effects[slot6].go, false)
			end
		end

		for slot6 = #slot2 + 1, #slot0._effects do
			gohelper.setActive(slot0._effects[slot6].go, false)
		end
	else
		for slot6 = 1, #slot0._effects do
			gohelper.setActive(slot0._effects[slot6].go, false)
		end
	end
end

function slot0._releaseEffectGo(slot0)
	ResMgr.ReleaseObj(slot0._effectGo)

	slot0._effectGo = nil
	slot0._effectPath = nil
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in pairs(slot0._effects) do
		slot5.loader:dispose()
		gohelper.destroy(slot5.go)
	end

	slot0._effects = {}
end

return slot0
