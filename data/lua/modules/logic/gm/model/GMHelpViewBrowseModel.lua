module("modules.logic.gm.model.GMHelpViewBrowseModel", package.seeall)

slot0 = class("GMHelpViewBrowseModel", ListScrollModel)
slot0.tabModeEnum = {
	fightTechniqueGuide = 5,
	fightTechniqueView = 3,
	weekWalkRuleView = 6,
	helpView = 1,
	fightTechniqueTipView = 4,
	fightGuideView = 2
}

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)
end

function slot0.reInit(slot0)
end

function slot0.getCurrentTabMode(slot0)
	return slot0._currentTabMode
end

function slot0._getTabModeList(slot0, slot1)
	slot2 = {}

	if slot1 == uv0.tabModeEnum.helpView then
		slot2 = slot0:_getHelpViewList()
	elseif slot1 == uv0.tabModeEnum.fightGuideView then
		slot2 = slot0:_getFightGuideList()
	elseif slot1 == uv0.tabModeEnum.fightTechniqueView then
		slot2 = slot0:_getFightTechniqueList()
	elseif slot1 == uv0.tabModeEnum.fightTechniqueTipView then
		slot2 = slot0:_getFightTechniqueTipList()
	elseif slot1 == uv0.tabModeEnum.fightTechniqueGuide then
		slot2 = slot0:_getFightTechniqueGuideList()
	elseif slot1 == uv0.tabModeEnum.weekWalkRuleView then
		slot2 = slot0:_getWeekWalkRuleList()
	else
		logError("GMHelpViewBrowseModel错误，tabMode获取列表未定义：" .. slot1)
	end

	return slot2
end

function slot0.setListByTabMode(slot0, slot1)
	if slot0._currentTabMode and slot0._currentTabMode == slot1 then
		return
	end

	slot0._currentTabMode = slot1

	slot0:setList(slot0:_getTabModeList(slot1))
	slot0:onModelUpdate()
end

function slot0.setSearch(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0:_getTabModeList(slot0._currentTabMode)) do
		slot9 = true

		if not string.nilorempty(slot1) then
			slot9 = string.find(tostring(slot8.id), slot1) or string.find(slot8.icon, slot1)
		end

		if slot9 then
			table.insert(slot3, slot8)
		end
	end

	slot0:setList(slot3)
	slot0:onModelUpdate()
end

function slot0._getHelpViewList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_helppage.configList) do
		if not string.nilorempty(slot6.icon) then
			slot7 = nil

			if slot6.type == HelpEnum.HelpType.Normal then
				slot7 = ResUrl.getHelpItem(slot6.icon, slot6.isCn == 1)
			elseif slot6.type == HelpEnum.HelpType.VersionActivity then
				slot7 = ResUrl.getVersionActivityHelpItem(slot6.icon, slot6.isCn == 1)
			end

			if slot7 then
				if GameResMgr.IsFromEditorDir == false or SLFramework.FileHelper.IsFileExists(System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, slot7)) then
					table.insert(slot1, slot6)
				end
			end
		end
	end

	return slot1
end

function slot0._getFightGuideList(slot0)
	slot1 = {}

	slot0:_fillFightGuideListByDirPath(slot1, ResUrl.getFightGuideLangDir())
	slot0:_fillFightGuideListByDirPath(slot1, ResUrl.getFightGuideDir())

	return slot1
end

function slot0._fillFightGuideListByDirPath(slot0, slot1, slot2)
	if not SLFramework.FileHelper.GetDirFilePaths(slot2) then
		return
	end

	for slot7 = 0, slot3.Length - 1 do
		if slot3[slot7]:match(".+/([^/]+)%.png$") and slot9:match("%d+$") then
			table.insert(slot1, {
				id = tonumber(slot10),
				icon = slot9
			})
		end
	end
end

function slot0._getFightTechniqueList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_fight_technique.configList) do
		table.insert(slot1, {
			id = slot6.id,
			icon = slot6.picture1
		})
	end

	return slot1
end

function slot0._getFightTechniqueTipList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_fight_technique.configList) do
		if not string.nilorempty(slot6.picture2) then
			table.insert(slot1, {
				id = slot6.id,
				icon = slot6.picture2
			})
		end
	end

	return slot1
end

function slot0._getFightTechniqueGuideList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_monster_guide_focus.configList) do
		if not string.nilorempty(slot6.icon) then
			table.insert(slot1, {
				id = slot6.id,
				icon = slot6.icon,
				cfg = slot6
			})
		end
	end

	return slot1
end

function slot0._getWeekWalkRuleList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_weekwalk_rule.configList) do
		table.insert(slot1, {
			id = slot6.id,
			icon = slot6.icon
		})
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
