-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneMapBlock.lua

module("modules.logic.scene.survival.comp.SurvivalSceneMapBlock", package.seeall)

local SurvivalSceneMapBlock = class("SurvivalSceneMapBlock", BaseSceneComp)

function SurvivalSceneMapBlock:init()
	self:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
end

function SurvivalSceneMapBlock:_onPreloadFinish()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)

	self._sceneGo = self:getCurScene():getSceneContainerGO()
	self._blockRoot = gohelper.create3d(self._sceneGo, "BlockRoot")

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local dict = {}

	for k, v in pairs(sceneMo.blocks) do
		SurvivalHelper.instance:addNodeToDict(dict, v.pos)

		for _, vv in pairs(v.exPoints) do
			SurvivalHelper.instance:addNodeToDict(dict, vv)
		end
	end

	local mapCo = SurvivalMapModel.instance:getCurMapCo()

	self._allBlocks = {}

	for i, v in ipairs(mapCo.allBlocks) do
		local pos = v.pos

		if not SurvivalHelper.instance:getValueFromDict(sceneMo.allDestroyPos, pos) and not SurvivalHelper.instance:getValueFromDict(dict, pos) then
			local block = SurvivalBlockEntity.Create(v, self._blockRoot)

			if not self._allBlocks[pos.q] then
				self._allBlocks[pos.q] = {}
			end

			self._allBlocks[pos.q][pos.r] = block
		end
	end

	for _, v in ipairs(sceneMo.extraBlock) do
		local pos = v.pos

		if not SurvivalHelper.instance:getValueFromDict(sceneMo.allDestroyPos, pos) and not SurvivalHelper.instance:getValueFromDict(dict, pos) then
			local block = SurvivalExBlockEntity.Create(v, self._blockRoot)

			if not self._allBlocks[pos.q] then
				self._allBlocks[pos.q] = {}
			end

			self._allBlocks[pos.q][pos.r] = block

			mapCo:setWalkByUnitMo(v, true)
		end
	end

	self:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function SurvivalSceneMapBlock:addExBlock(mo)
	local block = SurvivalExBlockEntity.Create(mo, self._blockRoot)
	local pos = mo.pos

	if not self._allBlocks[pos.q] then
		self._allBlocks[pos.q] = {}
	end

	self._allBlocks[pos.q][pos.r] = block

	local mapCo = SurvivalMapModel.instance:getCurMapCo()

	mapCo:setWalkByUnitMo(mo, true)
end

function SurvivalSceneMapBlock:setBlockActive(pos, isActive)
	local block = self._allBlocks[pos.q] and self._allBlocks[pos.q][pos.r]

	if block then
		gohelper.setActive(block.go, isActive)
	end
end

function SurvivalSceneMapBlock:onSceneClose()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
	gohelper.destroy(self._blockRoot)

	self._blockRoot = nil
	self._sceneGo = nil
	self._allBlocks = {}
end

return SurvivalSceneMapBlock
