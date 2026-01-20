-- chunkname: @modules/logic/survival/model/handbook/SurvivalHandbookMo.lua

module("modules.logic.survival.model.handbook.SurvivalHandbookMo", package.seeall)

local SurvivalHandbookMo = pureTable("SurvivalHandbookMo")

function SurvivalHandbookMo:setData(cfg)
	self.cfg = cfg
	self.id = cfg.id
	self.links = string.splitToNumber(cfg.link, "|")
	self.isUnlock = false
end

function SurvivalHandbookMo:setCellCfgId(cellCfgId)
	self.cellCfgId = cellCfgId

	self:updateSurvivalBagItemMo()
end

function SurvivalHandbookMo:getCellCfgId()
	return self.cellCfgId
end

function SurvivalHandbookMo:getRare()
	if self.isUnlock then
		local mo = self:getSurvivalBagItemMo()

		if mo then
			return mo:getRare()
		end
	end

	return 0
end

function SurvivalHandbookMo:setIsNew(value)
	self.isNew = value
end

function SurvivalHandbookMo:getType()
	return self.cfg.type
end

function SurvivalHandbookMo:getSubType()
	return self.cfg.subtype
end

function SurvivalHandbookMo:getName()
	return self.cfg.name
end

function SurvivalHandbookMo:getDesc()
	return self.cfg.desc
end

function SurvivalHandbookMo:isLinkGroup(groupId)
	for i, v in ipairs(self.links) do
		if v == groupId then
			return true
		end
	end
end

function SurvivalHandbookMo:setIsUnlock(value)
	self.isUnlock = value

	if self.survivalBagItemMo then
		self.survivalBagItemMo.isUnknown = not self.isUnlock
	end
end

function SurvivalHandbookMo:getSurvivalBagItemMo()
	if self.survivalBagItemMo == nil then
		self.survivalBagItemMo = SurvivalBagItemMo.New()

		self:updateSurvivalBagItemMo()
	end

	return self.survivalBagItemMo
end

function SurvivalHandbookMo:updateSurvivalBagItemMo()
	if not self.survivalBagItemMo then
		return
	end

	local cfgId = self:getCellCfgId()

	self.survivalBagItemMo:init({
		count = 1,
		id = cfgId
	})

	self.survivalBagItemMo.source = SurvivalEnum.ItemSource.None
	self.survivalBagItemMo.isUnknown = not self.isUnlock
end

function SurvivalHandbookMo:getEventShowId()
	if self.cfg.eventId > 0 then
		return self.cfg.eventId
	end
end

function SurvivalHandbookMo:getResultTitle()
	return self:getName()
end

function SurvivalHandbookMo:getResultDesc()
	local id = self:getCellCfgId()
	local cfg = lua_survival_end.configDict[id]

	return cfg.endDesc
end

function SurvivalHandbookMo:getResultImage()
	local id = self:getCellCfgId()
	local cfg = lua_survival_end.configDict[id]

	return cfg.endImg
end

return SurvivalHandbookMo
