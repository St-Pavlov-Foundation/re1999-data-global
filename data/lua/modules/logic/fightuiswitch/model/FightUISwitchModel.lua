-- chunkname: @modules/logic/fightuiswitch/model/FightUISwitchModel.lua

module("modules.logic.fightuiswitch.model.FightUISwitchModel", package.seeall)

local FightUISwitchModel = class("FightUISwitchModel", BaseModel)

function FightUISwitchModel:onInit()
	self._curShowStyleClassify = FightUISwitchEnum.StyleClassify.FightCard
	self._curUseStyleId = nil
	self._curSelectStyleId = nil
end

function FightUISwitchModel:reInit()
	self._curShowStyleClassify = FightUISwitchEnum.StyleClassify.FightCard
	self._curUseStyleId = nil
	self._curSelectStyleId = nil
end

function FightUISwitchModel:isOpenFightUISwitchSystem()
	return true
end

function FightUISwitchModel:_getUseStyleDefaultId(type)
	local cos = FightUISwitchConfig.instance:getFightUIStyleCoList()

	if cos then
		for _, co in ipairs(cos) do
			if co.type == type and co.defaultUnlock == 1 then
				return co.id
			end
		end
	end
end

function FightUISwitchModel:initMo()
	self._styleMosClassifyList = {}
	self._styleMosList = {}

	local cos = FightUISwitchConfig.instance:getFightUIStyleCoList()

	if cos then
		for _, co in ipairs(cos) do
			local classify = co.type

			if not self._styleMosClassifyList[classify] then
				self._styleMosClassifyList[classify] = {}
			end

			local mo = FightUIStyleMo.New()

			mo:initMo(co, classify)
			table.insert(self._styleMosClassifyList[classify], mo)

			self._styleMosList[co.id] = mo

			if mo:isUse() then
				self:setSelectStyleId(classify, mo.id)
			end
		end
	end

	FightUISwitchListModel.instance:setMoList()
end

function FightUISwitchModel:getStyleMoListByClassify(classify)
	if not self._styleMosClassifyList then
		self:initMo()
	end

	return self._styleMosClassifyList[classify] or {}
end

function FightUISwitchModel:getStyleMoById(id)
	if not self._styleMosList then
		self:initMo()
	end

	return self._styleMosList[id]
end

function FightUISwitchModel:getCurStyleMo()
	local classify = self:getCurShowStyleClassify()
	local styleId = self:getSelectStyleId(classify)
	local mo = self:getStyleMoById(styleId)

	return mo
end

function FightUISwitchModel:setCurShowStyleClassify(classify)
	self._curShowStyleClassify = classify
end

function FightUISwitchModel:getCurShowStyleClassify()
	return self._curShowStyleClassify
end

function FightUISwitchModel:onSelect(mo)
	self:setSelectStyleId(mo.classify, mo.id)
	FightUISwitchListModel.instance:onSelect(mo.id, true)
	FightUISwitchController.instance:dispatchEvent(FightUISwitchEvent.SelectFightUIStyle, mo.classify, mo.id)
end

function FightUISwitchModel:getSelectStyleId(classify)
	if not self._curSelectStyleId then
		self._curSelectStyleId = {}
	end

	if not self._curSelectStyleId[classify] then
		self._curSelectStyleId[classify] = self:_getUseStyleDefaultId(classify)
	end

	return self._curSelectStyleId[classify]
end

function FightUISwitchModel:setSelectStyleId(classify, id)
	if not self._curSelectStyleId then
		self._curSelectStyleId = {}
	end

	self._curSelectStyleId[classify] = id
end

function FightUISwitchModel:_getCurUseStyleId(classify)
	if not self._curUseStyleId then
		self._curUseStyleId = {}
	end

	if not self._curUseStyleId[classify] then
		local defaultCardStyleId = self:_getUseStyleDefaultId(classify)
		local simpleProperty = FightUISwitchEnum.StyleClassifyInfo[classify].SimpleProperty
		local useStyle = PlayerModel.instance:getSimpleProperty(simpleProperty, defaultCardStyleId) or defaultCardStyleId

		self._curUseStyleId[classify] = tonumber(useStyle)
	end

	return self._curUseStyleId[classify]
end

function FightUISwitchModel:_setCurUseStyleId(classify, styleId)
	if self._curUseStyleId[classify] == styleId then
		return
	end

	self._curUseStyleId[classify] = styleId

	local simpleProperty = FightUISwitchEnum.StyleClassifyInfo[classify].SimpleProperty

	PlayerModel.instance:forceSetSimpleProperty(simpleProperty, tostring(styleId))
	PlayerRpc.instance:sendSetSimplePropertyRequest(simpleProperty, tostring(styleId))
	FightUISwitchController.instance:dispatchEvent(FightUISwitchEvent.UseFightUIStyle, classify, styleId)
end

function FightUISwitchModel:getStyleMoByItemId(itemId)
	local cos = FightUISwitchConfig.instance:getStyleCosByItemId(itemId)
	local styleCo = cos and cos[1]

	if styleCo then
		local mo = self:getStyleMoById(styleCo.id)

		return mo
	end
end

function FightUISwitchModel:getSceneRes(co, viewName)
	local showres = co.showres

	if viewName == ViewName.FightUISwitchSceneView then
		showres = showres .. "_big"
	end

	return showres
end

function FightUISwitchModel:getCurUseFightUICardStyleId()
	return self:_getCurUseStyleId(FightUISwitchEnum.StyleClassify.FightCard)
end

function FightUISwitchModel:getCurUseFightUIFloatStyleId()
	return self:_getCurUseStyleId(FightUISwitchEnum.StyleClassify.FightFloat)
end

function FightUISwitchModel:getCurUseStyleIdByClassify(classify)
	return self:_getCurUseStyleId(classify)
end

function FightUISwitchModel:useStyleId(classify, styleId)
	return self:_setCurUseStyleId(classify, styleId)
end

function FightUISwitchModel:useCurStyleId()
	local classify = self:getCurShowStyleClassify()
	local styleId = self:getSelectStyleId(classify)

	return self:_setCurUseStyleId(classify, styleId)
end

function FightUISwitchModel:isNewUnlockStyle()
	local newIds = self:getNewUnlockIds()

	return LuaUtil.tableNotEmpty(newIds)
end

function FightUISwitchModel:getNewUnlockIds()
	local newUnlockIds = {}

	if not self._styleMosList then
		self:initMo()
	end

	for _, mo in pairs(self._styleMosList) do
		if not mo:isDefault() and mo:isUnlock() then
			local key = self:getUnlockPrefsKey(mo.id)
			local isNewUnlock = GameUtil.playerPrefsGetNumberByUserId(key, 0)

			if isNewUnlock == 0 then
				if not newUnlockIds[mo.classify] then
					newUnlockIds[mo.classify] = {}
				end

				table.insert(newUnlockIds[mo.classify], mo.id)
			end
		end
	end

	return newUnlockIds
end

function FightUISwitchModel:cancelNewUnlockClassifyReddot(classify)
	local newIds = self:getNewUnlockIds()
	local ids = newIds[classify]

	if ids then
		for i, id in ipairs(ids) do
			local key = self:getUnlockPrefsKey(id)

			GameUtil.playerPrefsSetNumberByUserId(key, 1)
		end
	end
end

function FightUISwitchModel:getUnlockPrefsKey(styleId)
	return "FightUISwitchModel_unlockPrefsKey_" .. styleId
end

FightUISwitchModel.instance = FightUISwitchModel.New()

return FightUISwitchModel
