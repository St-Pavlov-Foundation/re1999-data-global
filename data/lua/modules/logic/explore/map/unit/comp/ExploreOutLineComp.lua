module("modules.logic.explore.map.unit.comp.ExploreOutLineComp", package.seeall)

local var_0_0 = class("ExploreOutLineComp", LuaCompBase)
local var_0_1 = Color(0.7529, 0.6831, 0.1721, 1)
local var_0_2 = Color.white
local var_0_3 = Color.black
local var_0_4 = 0.5
local var_0_5 = 0.3
local var_0_6 = 3

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unit = arg_1_1
end

function var_0_0.setup(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._renderers = arg_2_1:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)
	arg_2_0._iconHangPoint = gohelper.findChild(arg_2_1, "msts_icon")

	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, arg_2_0.setCameraPos, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, arg_2_0.setCameraPos, arg_2_0)

	local var_2_0 = lua_explore_unit.configDict[arg_2_0.unit:getUnitType()]

	if not var_2_0 then
		return
	end

	local var_2_1 = arg_2_0.unit.mo.isStrong and var_2_0.icon2 or var_2_0.icon

	if not string.nilorempty(var_2_1) then
		arg_2_0._iconPath = "explore/common/sprite/prefabs/" .. var_2_1 .. ".prefab"
	end
end

function var_0_0.setCameraPos(arg_3_0)
	if not arg_3_0.go or arg_3_0._renderers.Length <= 0 then
		return
	end

	if arg_3_0._isOutLight then
		local var_3_0 = arg_3_0._renderers[0].isVisible

		if var_3_0 ~= arg_3_0._isMarkOutLight then
			if var_3_0 then
				arg_3_0._isMarkOutLight = true

				ExploreMapModel.instance:changeOutlineNum(1)

				for iter_3_0 = 0, arg_3_0._renderers.Length - 1 do
					arg_3_0._renderers[iter_3_0].renderingLayerMask = ExploreHelper.setBit(arg_3_0._renderers[iter_3_0].renderingLayerMask, var_0_6, true)
				end
			else
				arg_3_0._isMarkOutLight = false

				ExploreMapModel.instance:changeOutlineNum(-1)

				for iter_3_1 = 0, arg_3_0._renderers.Length - 1 do
					arg_3_0._renderers[iter_3_1].renderingLayerMask = ExploreHelper.setBit(arg_3_0._renderers[iter_3_1].renderingLayerMask, var_0_6, false)
				end
			end
		end
	elseif not arg_3_0._isOutLight and arg_3_0._tweenId and not arg_3_0._renderers[0].isVisible then
		ZProj.TweenHelper.KillById(arg_3_0._tweenId, true)

		arg_3_0._tweenId = nil

		TaskDispatcher.cancelTask(arg_3_0._delayTweenClear, arg_3_0)
	end
end

function var_0_0.setOutLight(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = arg_4_0.unit:isCustomShowOutLine()

	if (var_4_1 or arg_4_1 and arg_4_0._iconPath) and arg_4_0._iconHangPoint then
		if not arg_4_0._iconLoader then
			arg_4_0._iconLoader = PrefabInstantiate.Create(arg_4_0._iconHangPoint)
		end

		local var_4_2 = var_4_1 or arg_4_0._iconPath

		if var_4_2 ~= arg_4_0._iconLoader:getPath() then
			arg_4_0._iconLoader:dispose()
			arg_4_0._iconLoader:startLoad(var_4_2)
		end
	elseif arg_4_0._iconLoader then
		arg_4_0._iconLoader:dispose()

		arg_4_0._iconLoader = nil
	end

	if not arg_4_0._isOutLight == not arg_4_1 then
		return
	end

	arg_4_0._isOutLight = arg_4_1

	if arg_4_0._tweenId then
		ZProj.TweenHelper.KillById(arg_4_0._tweenId, true)
	end

	local var_4_3 = false

	if arg_4_0._renderers.Length > 0 then
		var_4_3 = ExploreHelper.getDistance(arg_4_0.unit.nodePos, ExploreController.instance:getMap():getHeroPos()) <= 3 and true or arg_4_0._renderers[0].isVisible
	end

	if not var_4_3 then
		if arg_4_0._isMarkOutLight then
			arg_4_0._isMarkOutLight = false

			ExploreMapModel.instance:changeOutlineNum(-1)

			for iter_4_0 = 0, arg_4_0._renderers.Length - 1 do
				arg_4_0._renderers[iter_4_0].renderingLayerMask = ExploreHelper.setBit(arg_4_0._renderers[iter_4_0].renderingLayerMask, var_0_6, false)
			end
		end

		arg_4_0._isOutLight = false

		return
	end

	for iter_4_1 = 0, arg_4_0._renderers.Length - 1 do
		arg_4_0._renderers[iter_4_1].renderingLayerMask = ExploreHelper.setBit(arg_4_0._renderers[iter_4_1].renderingLayerMask, var_0_6, true)
	end

	if not arg_4_0._isMarkOutLight then
		arg_4_0._isMarkOutLight = true

		ExploreMapModel.instance:changeOutlineNum(1)
	end

	TaskDispatcher.cancelTask(arg_4_0._delayTweenClear, arg_4_0)

	if arg_4_1 then
		arg_4_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_4_0._nowLerpValue or 0, 1, var_0_4, arg_4_0.tweenColor, nil, arg_4_0)
	else
		TaskDispatcher.runDelay(arg_4_0._delayTweenClear, arg_4_0, 0.05)
	end
end

function var_0_0._delayTweenClear(arg_5_0)
	arg_5_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_5_0._nowLerpValue or 1, 0, var_0_5, arg_5_0.tweenColor, arg_5_0.outLineEnd, arg_5_0)
end

function var_0_0.tweenColor(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.unit.mo.isStrong and var_0_1 or var_0_2

	for iter_6_0 = 0, arg_6_0._renderers.Length - 1 do
		local var_6_1 = arg_6_0._renderers[iter_6_0]

		if not tolua.isnull(var_6_1) then
			arg_6_0._reuseValue = MaterialUtil.getLerpValue("Color", var_0_3, var_6_0, arg_6_1, arg_6_0._reuseValue)

			MaterialUtil.setPropValue(var_6_1.material, "_OutlineColor", "Color", arg_6_0._reuseValue)
		end
	end

	arg_6_0._nowLerpValue = arg_6_1
end

function var_0_0.outLineEnd(arg_7_0)
	for iter_7_0 = 0, arg_7_0._renderers.Length - 1 do
		local var_7_0 = arg_7_0._renderers[iter_7_0]

		if not tolua.isnull(var_7_0) then
			var_7_0.renderingLayerMask = ExploreHelper.setBit(var_7_0.renderingLayerMask, var_0_6, false)
		end
	end

	if arg_7_0._isMarkOutLight then
		arg_7_0._isMarkOutLight = false

		ExploreMapModel.instance:changeOutlineNum(-1)
	end
end

function var_0_0.clear(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayTweenClear, arg_8_0)

	arg_8_0._nowLerpValue = 0

	if arg_8_0._isMarkOutLight then
		ExploreMapModel.instance:changeOutlineNum(-1)

		arg_8_0._isMarkOutLight = false
	end

	if arg_8_0._iconLoader then
		arg_8_0._iconLoader:dispose()

		arg_8_0._iconLoader = nil
	end

	if arg_8_0._tweenId then
		ZProj.TweenHelper.KillById(arg_8_0._tweenId)

		arg_8_0._tweenId = nil
	end

	arg_8_0._renderers = nil
	arg_8_0._iconHangPoint = nil
	arg_8_0._iconPath = nil
	arg_8_0._isOutLight = false

	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, arg_8_0.setCameraPos, arg_8_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, arg_8_0.setCameraPos, arg_8_0)
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0:clear()
end

return var_0_0
