module("modules.logic.fight.entity.comp.skill.FightTLEventSpineMaterial", package.seeall)

local var_0_0 = class("FightTLEventSpineMaterial", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_3[1]

	arg_1_0._matName = arg_1_3[2]
	arg_1_0._transitName = arg_1_3[3]
	arg_1_0._transitType = arg_1_3[4]

	local var_1_1 = arg_1_3[5]
	local var_1_2 = tonumber(arg_1_3[6])

	arg_1_0._targetEntitys = nil

	if var_1_0 == "1" then
		arg_1_0._targetEntitys = {}

		table.insert(arg_1_0._targetEntitys, FightHelper.getEntity(arg_1_1.fromId))
	elseif var_1_0 == "2" then
		arg_1_0._targetEntitys = FightHelper.getSkillTargetEntitys(arg_1_1)
	elseif not string.nilorempty(var_1_0) then
		local var_1_3 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_1_4 = arg_1_1.stepUid .. "_" .. var_1_0
		local var_1_5 = var_1_3:getUnit(SceneTag.UnitNpc, var_1_4)

		if var_1_5 then
			arg_1_0._targetEntitys = {}

			table.insert(arg_1_0._targetEntitys, var_1_5)
		else
			logError("找不到实体, id: " .. tostring(var_1_0))

			return
		end
	end

	local var_1_6 = not string.nilorempty(arg_1_0._matName) and FightSpineMatPool.getMat(arg_1_0._matName)
	local var_1_7 = not string.nilorempty(arg_1_0._transitName)
	local var_1_8 = MaterialUtil.getPropValueFromStr(arg_1_0._transitType, var_1_1)

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._targetEntitys) do
		if var_1_6 then
			iter_1_1.spineRenderer:replaceSpineMat(var_1_6)
			FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, iter_1_1.id, iter_1_1.spineRenderer:getReplaceMat())
		end
	end

	if var_1_2 > 0 then
		local var_1_9 = {}
		local var_1_10 = {}
		local var_1_11 = {}

		for iter_1_2, iter_1_3 in ipairs(arg_1_0._targetEntitys) do
			local var_1_12 = iter_1_3.spineRenderer:getReplaceMat()
			local var_1_13 = MaterialUtil.getPropValueFromMat(var_1_12, arg_1_0._transitName, arg_1_0._transitType)

			var_1_10[iter_1_3.id] = var_1_13
			var_1_9[iter_1_3.id] = var_1_12
		end

		arg_1_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_1_2, function(arg_2_0)
			for iter_2_0, iter_2_1 in ipairs(arg_1_0._targetEntitys) do
				local var_2_0 = var_1_10[iter_2_1.id]
				local var_2_1 = var_1_9[iter_2_1.id]

				var_1_11[iter_2_1.id] = MaterialUtil.getLerpValue(arg_1_0._transitType, var_2_0, var_1_8, arg_2_0, var_1_11[iter_2_1.id])

				MaterialUtil.setPropValue(var_2_1, arg_1_0._transitName, arg_1_0._transitType, var_1_11[iter_2_1.id])
			end
		end, nil, nil, nil, EaseType.Linear)
	elseif var_1_7 then
		for iter_1_4, iter_1_5 in ipairs(arg_1_0._targetEntitys) do
			local var_1_14 = iter_1_5.spineRenderer:getReplaceMat()

			MaterialUtil.setPropValue(var_1_14, arg_1_0._transitName, arg_1_0._transitType, var_1_8)
		end
	end
end

function var_0_0.onTrackEnd(arg_3_0)
	arg_3_0:_clear()
end

function var_0_0._clear(arg_4_0)
	if arg_4_0._tweenId then
		ZProj.TweenHelper.KillById(arg_4_0._tweenId)

		arg_4_0._tweenId = nil
	end
end

function var_0_0.onDestructor(arg_5_0)
	arg_5_0:_clear()
end

return var_0_0
