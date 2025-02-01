module("modules.logic.seasonver.act123.model.Season123ShowHeroModel", package.seeall)

slot0 = class("Season123ShowHeroModel", ListScrollModel)

function slot0.release(slot0)
	slot0:clear()
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.activityId = slot1
	slot0.stage = slot2
	slot0.layer = slot3

	slot0:initHeroList()
end

function slot0.initHeroList(slot0)
	slot1 = {}
	slot2 = HeroModel.instance:getList()

	slot0:initLayerHeroList(slot1, slot0.layer)
	logNormal("hero list count : " .. tostring(#slot1))
	slot0:setList(slot1)
end

function slot0.initLayerHeroList(slot0, slot1, slot2)
	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return
	end

	if not slot3.stageMap[slot0.stage] then
		return
	end

	if not slot4.episodeMap[slot2] then
		return
	end

	for slot10, slot11 in ipairs(slot5.heroes) do
		if not HeroModel.instance:getById(slot11.heroUid) then
			slot13, slot14 = Season123Model.instance:getAssistData(slot0.activityId, slot0.stage)

			if slot14 and slot14.heroUid == slot11.heroUid then
				slot15 = Season123ShowHeroMO.New()

				slot15:init(slot13, slot14.heroUid, slot14.heroId, slot14.skin, slot11.hpRate, true)
				table.insert(slot1, slot15)
			end
		else
			slot13 = Season123ShowHeroMO.New()

			slot13:init(slot12, slot12.uid, slot12.heroId, slot12.skin, slot11.hpRate, false)
			table.insert(slot1, slot13)
		end
	end
end

function slot0.isFirstPlayHeroDieAnim(slot0, slot1)
	if string.split(PlayerPrefsHelper.getString(slot0:getPlayHeroDieAnimPrefKey(slot0.stage), ""), "|") and not LuaUtil.tableContains(slot4, slot1) then
		return true
	end
end

function slot0.setPlayedHeroDieAnim(slot0, slot1)
	if string.nilorempty(PlayerPrefsHelper.getString(slot0:getPlayHeroDieAnimPrefKey(slot0.stage), "")) then
		slot3 = slot1
	elseif string.split(slot3, "|") and not LuaUtil.tableContains(slot4, slot1) then
		slot3 = slot3 .. "|" .. slot1
	end

	PlayerPrefsHelper.setString(slot2, slot3)
end

function slot0.clearPlayHeroDieAnim(slot0, slot1)
	PlayerPrefsHelper.setString(slot0:getPlayHeroDieAnimPrefKey(slot1), "")
end

function slot0.getPlayHeroDieAnimPrefKey(slot0, slot1)
	return "Season123ShowHeroModel_PlayHeroDieAnim_" .. slot1
end

slot0.instance = slot0.New()

return slot0
