-- chunkname: @modules/logic/survival/model/map/SurvivalLogMo.lua

module("modules.logic.survival.model.map.SurvivalLogMo", package.seeall)

local SurvivalLogMo = pureTable("SurvivalLogMo")
local LogType = {
	TeamHealth = 4,
	HeroHealth = 5,
	Item = 1,
	RoleLevelUp = 7,
	TaskChange = 3
}

function SurvivalLogMo:ctor()
	self.isNpcRecr = false
end

function SurvivalLogMo:init(data, colorDict)
	self.logStr = ""

	local arr = string.splitToNumber(data, "#") or {}

	if arr[1] == LogType.Item then
		local count = arr[3] or 0
		local bagType = arr[4] or SurvivalEnum.ItemSource.Map
		local itemCo = lua_survival_item.configDict[arr[2]]

		if itemCo then
			local type = itemCo.type

			if type == SurvivalEnum.ItemType.NPC then
				if count > 0 then
					self.isNpcRecr = arr[2]
					self.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_addnpc"), itemCo.name)
				else
					self.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_removenpc"), itemCo.name)
				end
			elseif type == SurvivalEnum.ItemType.Currency then
				if count > 0 then
					self.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_addcurrency"), itemCo.name, count)
				elseif bagType == SurvivalEnum.ItemSource.Map then
					self.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_removecurrency"), itemCo.name, -count)
				else
					self.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_removecurrency_shelter"), itemCo.name, -count)
				end
			else
				local itemName = itemCo.name

				colorDict = colorDict or SurvivalConst.ItemRareColor

				if colorDict[itemCo.rare] then
					itemName = string.format("<color=%s>%s</color>", colorDict[itemCo.rare], itemName)
				end

				if count > 0 then
					self.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_additem"), itemName, count)
				else
					self.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_removeitem"), itemName, -count)
				end
			end
		end
	elseif arr[1] == LogType.TaskChange then
		local moduleId = arr[2] or 0
		local taskId = arr[3] or 0
		local status = arr[4] or 1
		local taskCo = SurvivalConfig.instance:getTaskCo(moduleId, taskId)

		if taskCo then
			if status == 1 then
				self.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_taskbegin"), taskCo.desc)
			else
				self.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_taskfail"), taskCo.desc)
			end
		end
	elseif arr[1] == LogType.TeamHealth then
		local num = arr[2] or 0

		if num >= 0 then
			self.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_teamhealthadd"), num)
		else
			self.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_teamhealthsub"), -num)
		end
	elseif arr[1] == LogType.HeroHealth then
		local heroCo = lua_character.configDict[tonumber(arr[2])]
		local heroName = heroCo and heroCo.name or ""
		local num = arr[3] or 0

		if num >= 0 then
			self.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_herohealthadd"), heroName, num)
		else
			self.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_heaohealthsub"), heroName, -num)
		end
	elseif arr[1] == LogType.RoleLevelUp then
		local change = arr[2]

		self.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_rolelevelup"), change)
	end
end

function SurvivalLogMo:getLogStr()
	return self.logStr
end

return SurvivalLogMo
