-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUnitMoveWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUnitMoveWork", package.seeall)

local SurvivalUnitMoveWork = class("SurvivalUnitMoveWork", SurvivalStepBaseWork)
local moveReasonToFuncName = {
	[SurvivalEnum.PlayerMoveReason.Fly] = "flyTo",
	[SurvivalEnum.PlayerMoveReason.Transfer] = "transferTo",
	[SurvivalEnum.PlayerMoveReason.Tornado] = "tornadoTransfer",
	[SurvivalEnum.PlayerMoveReason.Swap] = "swapPos",
	[SurvivalEnum.PlayerMoveReason.Summon] = "summonPos",
	[SurvivalEnum.PlayerMoveReason.Rocket] = "rocketTo"
}

function SurvivalUnitMoveWork:onStart(context)
	if self.context.fastExecute then
		self:onDone(true)

		return
	end

	local entity = SurvivalMapHelper.instance:getEntity(self._stepMo.id)

	if entity then
		local reason = self._stepMo.paramInt[1] or 0
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local moveFunc = entity[moveReasonToFuncName[reason]] or entity.moveTo

		if self._stepMo.id == 0 then
			if reason ~= SurvivalEnum.PlayerMoveReason.Normal then
				if reason ~= SurvivalEnum.PlayerMoveReason.Back then
					SurvivalMapModel.instance:setMoveToTarget(nil)

					context.tryTrigger = true
				end
			else
				for k, unitMo in pairs(sceneMo.unitsById) do
					if not unitMo.fall and unitMo:isPointInWarming(self._stepMo.position) then
						SurvivalController.instance:dispatchEvent(SurvivalEvent.ShowUnitBubble, unitMo.id, 2, 0.2)
					end
				end
			end

			ViewMgr.instance:closeAllPopupViews()
			moveFunc(entity, self._stepMo.position, self._stepMo.dir, self._onMoveFinish, self)
		else
			if reason == SurvivalEnum.PlayerMoveReason.Normal then
				local unitMo = sceneMo.unitsById[self._stepMo.id]

				if unitMo and sceneMo:getBlockTypeByPos(unitMo.pos) == SurvivalEnum.UnitSubType.Miasma then
					SurvivalController.instance:dispatchEvent(SurvivalEvent.ShowUnitBubble, unitMo.id, 1, 0.2)
				end
			end

			local canShowAnim = ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMapMainView, {
				ViewName.SurvivalToastView,
				ViewName.SurvivalCommonTipsView,
				ViewName.GuideView,
				ViewName.GuideView2,
				ViewName.GuideStepEditor
			})

			moveFunc(entity, self._stepMo.position, self._stepMo.dir, canShowAnim and self._onMoveFinish, canShowAnim and self)

			if not canShowAnim then
				self:onDone(true)
			end
		end
	else
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local unitMo = sceneMo and sceneMo.unitsById[self._stepMo.id]

		if not unitMo then
			logError("找不到对应实体" .. self._stepMo.id)
		else
			sceneMo:onUnitUpdatePos(unitMo, self._stepMo.position)
		end

		self:onDone(true)
	end
end

function SurvivalUnitMoveWork:_onMoveFinish()
	if self._stepMo.id == 0 then
		local camera = SurvivalMapHelper.instance:getSceneCameraComp()

		if camera and camera:checkIsInMiasma() then
			self:doRotateCameraTween()

			return
		end
	end

	self:onDone(true)
end

function SurvivalUnitMoveWork:doRotateCameraTween()
	local moveTarget = SurvivalMapModel.instance:getTargetPos()

	if moveTarget ~= self._stepMo.position then
		SurvivalMapModel.instance:setMoveToTarget()
		SurvivalMapModel.instance:setShowTarget()
	end

	if SurvivalMapHelper.instance:tweenToHeroPosIfNeed(0.2) then
		TaskDispatcher.runDelay(self._playCameraRotate, self, 0.2)
	else
		self:_playCameraRotate()
	end
end

function SurvivalUnitMoveWork:_playCameraRotate()
	local camera = SurvivalMapHelper.instance:getSceneCameraComp()

	if camera then
		UIBlockHelper.instance:startBlock("SurvivalUnitMoveWork_playCameraRotate", SurvivalConst.CameraTraceTime)

		local isInMiasma = SurvivalMapModel.instance:isInMiasma()
		local dir = isInMiasma and math.random(5) or 0

		if dir > 2 then
			dir = dir - 6
		end

		camera:setRotate(dir * 60)
		TaskDispatcher.runDelay(self._delayOnDone, self, SurvivalConst.CameraTraceTime)
	else
		self:onDone(true)
	end
end

function SurvivalUnitMoveWork:_delayOnDone()
	self:onDone(true)
end

function SurvivalUnitMoveWork:clearWork()
	TaskDispatcher.cancelTask(self._playCameraRotate, self)
	TaskDispatcher.cancelTask(self._delayOnDone, self)
end

function SurvivalUnitMoveWork:getRunOrder(params, flow)
	if params.moveIdSet[self._stepMo.id] then
		params.beforeFlow = FlowParallel.New()

		flow:addWork(params.beforeFlow)

		params.moveIdSet = {}
	end

	if self._stepMo.id == 0 then
		params.haveHeroMove = true
	end

	params.moveIdSet[self._stepMo.id] = true

	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalUnitMoveWork
