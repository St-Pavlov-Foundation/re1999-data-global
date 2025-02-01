module("modules.logic.scene.fight.preloadwork.FightPreloadCardWork", package.seeall)

slot0 = class("FightPreloadCardWork", BaseWork)
slot1 = {
	[9120110] = {
		"305613"
	},
	[9120111] = {
		"306011"
	},
	[9121002] = {
		"306110"
	},
	[9120103] = {
		"302310"
	}
}

function slot0.onStart(slot0, slot1)
	slot2 = {}

	if FightModel.instance:getCurRoundMO() and slot3.teamACards1 then
		for slot7, slot8 in ipairs(slot3.teamACards1) do
			if not tabletool.indexOf(slot2, ResUrl.getSkillIcon(lua_skill.configDict[slot8.skillId].icon)) then
				table.insert(slot2, slot10)
			end
		end
	end

	if uv0[FightModel.instance:getFightParam().battleId] then
		for slot9, slot10 in ipairs(slot5) do
			table.insert(slot2, ResUrl.getHeadIconSmall(slot10))
		end
	end

	slot0._loader = MultiAbLoader.New()

	slot0._loader:setPathList(slot2)
	slot0._loader:startLoad(slot0._onLoadFinish, slot0)
end

function slot0._onLoadFinish(slot0, slot1)
	for slot6, slot7 in ipairs(slot1:getAssetItemDict()) do
		slot0.context.callback(slot0.context.callbackObj, slot7)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
