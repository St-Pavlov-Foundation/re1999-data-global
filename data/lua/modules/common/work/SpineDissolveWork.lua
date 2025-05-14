module("modules.common.work.SpineDissolveWork", package.seeall)

local var_0_0 = class("SpineDissolveWork", BaseWork)
local var_0_1 = {
	[FightEnum.DissolveType.Player] = {
		duration = 1.67,
		path = FightPreloadOthersWork.die_player
	},
	[FightEnum.DissolveType.Monster] = {
		duration = 1.67,
		path = FightPreloadOthersWork.die_monster
	},
	[FightEnum.DissolveType.ZaoWu] = {
		duration = 1.67,
		path = "rolesbuff/die_zaowu.controller"
	},
	[FightEnum.DissolveType.Abjqr4] = {
		duration = 3,
		path = "rolesbuff/die_monster_670401_abjqr4.controller"
	}
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0.context = arg_1_1

	local var_1_0 = lua_skin_spine_action.configDict[arg_1_0.context.dissolveEntity:getMO().skin]
	local var_1_1 = var_1_0 and var_1_0.die and var_1_0.die.dieAnim

	if string.nilorempty(var_1_1) then
		arg_1_0:_playDissolve()
	else
		arg_1_0._ani_path = var_1_1
		arg_1_0._animationLoader = MultiAbLoader.New()

		arg_1_0._animationLoader:addPath(FightHelper.getEntityAniPath(var_1_1))
		arg_1_0._animationLoader:startLoad(arg_1_0._onAnimationLoaded, arg_1_0)
	end
end

function var_0_0._onAnimationLoaded(arg_2_0)
	local var_2_0 = arg_2_0._animationLoader:getFirstAssetItem():GetResource(ResUrl.getEntityAnim(arg_2_0._ani_path))

	var_2_0.legacy = true
	arg_2_0._animStateName = var_2_0.name
	arg_2_0._animCompList = {}

	local var_2_1 = arg_2_0.context.dissolveEntity
	local var_2_2 = gohelper.onceAddComponent(var_2_1.spine:getSpineGO(), typeof(UnityEngine.Animation))

	table.insert(arg_2_0._animCompList, var_2_2)

	var_2_2.enabled = true
	var_2_2.clip = var_2_0

	var_2_2:AddClip(var_2_0, arg_2_0._animStateName)

	local var_2_3 = var_2_2.this:get(arg_2_0._animStateName)

	if var_2_3 then
		var_2_3.speed = FightModel.instance:getSpeed()
	end

	var_2_2:Play()
	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, arg_2_0._onUpdateSpeed, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._afterPlayDissolve, arg_2_0, var_2_0.length / FightModel.instance:getSpeed())
end

function var_0_0._onUpdateSpeed(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._animCompList) do
		local var_3_0 = iter_3_1.this:get(arg_3_0._animStateName)

		if var_3_0 then
			var_3_0.speed = FightModel.instance:getSpeed()
		end
	end
end

function var_0_0._clearAnim(arg_4_0)
	if arg_4_0._animCompList then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._animCompList) do
			if not gohelper.isNil(iter_4_1) then
				if iter_4_1:GetClip(arg_4_0._animStateName) then
					iter_4_1:RemoveClip(arg_4_0._animStateName)
				end

				if iter_4_1.clip and iter_4_1.clip.name == arg_4_0._animStateName then
					iter_4_1.clip = nil
				end

				iter_4_1.enabled = false
			end
		end

		arg_4_0._animCompList = nil
	end
end

function var_0_0._playDissolve(arg_5_0)
	local var_5_0 = var_0_1[arg_5_0.context.dissolveType]
	local var_5_1 = var_5_0 and var_5_0.path

	if var_5_1 then
		local var_5_2 = FightPreloadController.instance:getFightAssetItem(var_5_1)

		if var_5_2 then
			arg_5_0:_reallyPlayDissolve(var_5_2)
		else
			arg_5_0._animatorLoader = MultiAbLoader.New()

			arg_5_0._animatorLoader:addPath(var_5_1)
			arg_5_0._animatorLoader:startLoad(arg_5_0._onAnimatorLoaded, arg_5_0)
		end
	else
		logError(arg_5_0.context.dissolveEntity:getMO():getEntityName() .. "没有配置死亡消融动画 type = " .. (arg_5_0.context.dissolveType or "nil"))
	end
end

function var_0_0._onAnimatorLoaded(arg_6_0)
	local var_6_0 = arg_6_0._animatorLoader:getFirstAssetItem()

	arg_6_0:_reallyPlayDissolve(var_6_0)
end

function var_0_0._reallyPlayDissolve(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.context.dissolveEntity and arg_7_0.context.dissolveEntity.spine and arg_7_0.context.dissolveEntity.spine:getSpineGO()

	if not var_7_0 then
		arg_7_0:_afterPlayDissolve()

		return
	end

	local var_7_1 = arg_7_1:GetResource()
	local var_7_2 = gohelper.onceAddComponent(var_7_0, typeof(UnityEngine.Animator))

	var_7_2.enabled = true
	var_7_2.runtimeAnimatorController = var_7_1
	var_7_2.speed = FightModel.instance:getSpeed()

	local var_7_3 = var_0_1[arg_7_0.context.dissolveType]
	local var_7_4 = var_7_3 and var_7_3.duration or 1.67

	TaskDispatcher.runDelay(arg_7_0._afterPlayDissolve, arg_7_0, var_7_4 / FightModel.instance:getSpeed())
end

function var_0_0._afterPlayDissolve(arg_8_0)
	arg_8_0:_clearAnim()
	arg_8_0:onDone(true)
end

function var_0_0.clearWork(arg_9_0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, arg_9_0._onUpdateSpeed, arg_9_0)
	arg_9_0:_clearAnim()
	TaskDispatcher.cancelTask(arg_9_0._afterPlayDissolve, arg_9_0)

	if arg_9_0._animationLoader then
		arg_9_0._animationLoader:dispose()

		arg_9_0._animationLoader = nil
	end

	if arg_9_0._animatorLoader then
		arg_9_0._animatorLoader:dispose()

		arg_9_0._animatorLoader = nil
	end
end

return var_0_0
