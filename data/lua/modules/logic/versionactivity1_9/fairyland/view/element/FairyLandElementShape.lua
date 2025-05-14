module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElementShape", package.seeall)

local var_0_0 = class("FairyLandElementShape", FairyLandElementBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.stateGoDict = {}

	for iter_1_0, iter_1_1 in pairs(FairyLandEnum.ShapeState) do
		local var_1_0 = gohelper.findChild(arg_1_0._go, tostring(iter_1_1))

		if not gohelper.isNil(var_1_0) then
			local var_1_1 = arg_1_0:getUserDataTb_()

			var_1_1.go = var_1_0
			var_1_1.rootGo = gohelper.findChild(var_1_0, "root")
			var_1_1.rootAnim = var_1_1.rootGo:GetComponent(typeof(UnityEngine.Animator))
			arg_1_0.stateGoDict[iter_1_1] = var_1_1
		end
	end

	local var_1_2 = arg_1_0:getState()

	for iter_1_2, iter_1_3 in pairs(arg_1_0.stateGoDict) do
		local var_1_3 = iter_1_2 == var_1_2

		gohelper.setActive(iter_1_3.go, var_1_3)
	end
end

function var_0_0.getClickGO(arg_2_0)
	return arg_2_0._go
end

function var_0_0.refresh(arg_3_0)
	local var_3_0 = arg_3_0:getState()

	for iter_3_0, iter_3_1 in pairs(arg_3_0.stateGoDict) do
		local var_3_1 = iter_3_0 == var_3_0

		gohelper.setActive(iter_3_1.go, var_3_1)

		if var_3_1 then
			iter_3_1.rootAnim:Play("open", 0, 0)
		end
	end
end

function var_0_0.getState(arg_4_0)
	local var_4_0 = arg_4_0:getElementId()

	if FairyLandModel.instance:isFinishElement(var_4_0) then
		return FairyLandEnum.ShapeState.Hide
	end

	local var_4_1 = var_4_0 - 1
	local var_4_2 = FairyLandConfig.instance:getElementConfig(var_4_1)

	if not var_4_2 then
		return FairyLandEnum.ShapeState.CanClick
	end

	local var_4_3 = FairyLandEnum.ConfigType2ElementType[var_4_2.type]
	local var_4_4 = arg_4_0._elements.elementDict[var_4_1]

	if var_4_3 == FairyLandEnum.ElementType.NPC then
		if var_4_4 then
			return FairyLandEnum.ShapeState.Hide
		end

		local var_4_5 = string.splitToNumber(var_4_2.puzzleId, "#")
		local var_4_6 = true

		for iter_4_0, iter_4_1 in ipairs(var_4_5) do
			var_4_6 = false

			local var_4_7 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(iter_4_1)

			if FairyLandModel.instance:isPassPuzzle(iter_4_1) and (var_4_7.storyTalkId == 0 or FairyLandModel.instance:isFinishDialog(var_4_7.storyTalkId)) then
				var_4_6 = true
			end

			if not var_4_6 then
				break
			end
		end

		if var_4_6 then
			return FairyLandEnum.ShapeState.CanClick
		else
			return FairyLandEnum.ShapeState.Hide
		end
	elseif var_4_4 then
		local var_4_8 = var_4_4:getState()

		if var_4_8 == FairyLandEnum.ShapeState.Hide then
			return FairyLandEnum.ShapeState.Hide
		end

		if var_4_8 == FairyLandEnum.ShapeState.CanClick then
			return FairyLandEnum.ShapeState.NextCanClick
		end

		if var_4_8 == FairyLandEnum.ShapeState.NextCanClick then
			return FairyLandEnum.ShapeState.LockClick
		end

		return FairyLandEnum.ShapeState.LockClick
	end

	return FairyLandEnum.ShapeState.CanClick
end

function var_0_0.onClick(arg_5_0)
	if arg_5_0:getState() == FairyLandEnum.ShapeState.CanClick and not arg_5_0._elements:isMoveing() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_symbol_click)
		arg_5_0:setFinish()
	end
end

function var_0_0.finish(arg_6_0)
	arg_6_0:onFinish()
end

function var_0_0.onFinish(arg_7_0)
	local var_7_0 = arg_7_0.stateGoDict[FairyLandEnum.ShapeState.CanClick]

	if var_7_0 then
		var_7_0.rootAnim:Play("click", 0, 0)
		TaskDispatcher.runDelay(arg_7_0._finishCallback, arg_7_0, 1)
	end

	FairyLandModel.instance:setPos(arg_7_0:getPos(), true)
	arg_7_0._elements:characterMove()
end

function var_0_0._finishCallback(arg_8_0)
	arg_8_0:onDestroy()
end

function var_0_0.onDestroyElement(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._finishCallback, arg_9_0)
end

return var_0_0
