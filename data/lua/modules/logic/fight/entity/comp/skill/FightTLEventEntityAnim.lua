module("modules.logic.fight.entity.comp.skill.FightTLEventEntityAnim", package.seeall)

local var_0_0 = class("FightTLEventEntityAnim", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_3[1]

	arg_1_0._targetEntitys = nil

	if var_1_0 == "1" then
		arg_1_0._targetEntitys = {}

		table.insert(arg_1_0._targetEntitys, FightHelper.getEntity(arg_1_1.fromId))
	elseif var_1_0 == "2" then
		arg_1_0._targetEntitys = FightHelper.getSkillTargetEntitys(arg_1_1)
	elseif var_1_0 == "3" then
		arg_1_0._targetEntitys = {}

		table.insert(arg_1_0._targetEntitys, FightHelper.getEntity(arg_1_1.toId))
	elseif var_1_0 == "4" then
		arg_1_0._targetEntitys = FightHelper.getSkillTargetEntitys(arg_1_1)

		tabletool.removeValue(arg_1_0._targetEntitys, FightHelper.getEntity(arg_1_1.fromId))
	elseif not string.nilorempty(var_1_0) then
		local var_1_1 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_1_2 = arg_1_1.stepUid .. "_" .. var_1_0
		local var_1_3 = var_1_1:getUnit(SceneTag.UnitNpc, var_1_2)

		if var_1_3 then
			arg_1_0._targetEntitys = {}

			table.insert(arg_1_0._targetEntitys, var_1_3)
		else
			logError("找不到实体, id: " .. tostring(var_1_2))

			return
		end
	end

	arg_1_0.setAnimEntityList = {}
	arg_1_0._ani_path = nil
	arg_1_0._leftPath = nil
	arg_1_0._rightPath = nil
	arg_1_0._loader = MultiAbLoader.New()
	arg_1_0._revertSpinePosAndColor = arg_1_3[5] == "1"

	local var_1_4 = arg_1_3[2]

	if not string.nilorempty(var_1_4) then
		arg_1_0._ani_path = var_1_4

		arg_1_0._loader:addPath(FightHelper.getEntityAniPath(var_1_4))
	end

	local var_1_5 = arg_1_3[3]

	if not string.nilorempty(var_1_5) then
		arg_1_0._leftPath = var_1_5

		arg_1_0._loader:addPath(FightHelper.getEntityAniPath(var_1_5))
	end

	local var_1_6 = arg_1_3[4]

	if not string.nilorempty(var_1_6) then
		arg_1_0._rightPath = var_1_6

		arg_1_0._loader:addPath(FightHelper.getEntityAniPath(var_1_6))
	end

	if #arg_1_0._loader._pathList > 0 then
		arg_1_0._loader:startLoad(arg_1_0._onLoaded, arg_1_0)
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:onDestructor()
end

function var_0_0._onLoaded(arg_3_0, arg_3_1)
	if not arg_3_0._targetEntitys then
		return
	end

	local var_3_0 = {}
	local var_3_1 = {}

	if arg_3_0._leftPath then
		local var_3_2 = arg_3_0._loader:getAssetItem(FightHelper.getEntityAniPath(arg_3_0._leftPath))

		if var_3_2 then
			local var_3_3 = var_3_2:GetResource(ResUrl.getEntityAnim(arg_3_0._leftPath))

			if var_3_3 then
				var_3_0[FightEnum.EntitySide.EnemySide] = var_3_3
				var_3_1[FightEnum.EntitySide.EnemySide] = arg_3_0._leftPath
				var_3_3.legacy = true
			end
		end
	end

	if arg_3_0._rightPath then
		local var_3_4 = arg_3_0._loader:getAssetItem(FightHelper.getEntityAniPath(arg_3_0._rightPath))

		if var_3_4 then
			local var_3_5 = var_3_4:GetResource(ResUrl.getEntityAnim(arg_3_0._rightPath))

			if var_3_5 then
				var_3_0[FightEnum.EntitySide.MySide] = var_3_5
				var_3_1[FightEnum.EntitySide.MySide] = arg_3_0._rightPath
				var_3_5.legacy = true
			end
		end
	end

	local var_3_6

	if arg_3_0._ani_path then
		local var_3_7 = arg_3_0._loader:getAssetItem(FightHelper.getEntityAniPath(arg_3_0._ani_path))

		if var_3_7 then
			var_3_6 = var_3_7:GetResource(ResUrl.getEntityAnim(arg_3_0._ani_path))

			if var_3_6 then
				var_3_6.legacy = true
			end
		end
	end

	arg_3_0._animStateName = {}
	arg_3_0._animCompList = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._targetEntitys) do
		if not tabletool.indexOf(arg_3_0.setAnimEntityList, iter_3_1.id) and iter_3_1.spine then
			local var_3_8 = iter_3_1.spine:getSpineGO()

			if var_3_8 then
				local var_3_9 = var_3_0[iter_3_1:getSide()] or var_3_6
				local var_3_10 = var_3_1[iter_3_1:getSide()] or arg_3_0._ani_path

				if var_3_9 then
					local var_3_11 = gohelper.onceAddComponent(var_3_8, typeof(UnityEngine.Animation))

					table.insert(arg_3_0._animCompList, var_3_11)
					table.insert(arg_3_0._animStateName, var_3_10)

					var_3_11.enabled = true
					var_3_11.clip = var_3_9

					var_3_11:AddClip(var_3_9, var_3_10)

					local var_3_12 = var_3_11.this:get(var_3_10)

					if var_3_12 then
						var_3_12.speed = FightModel.instance:getSpeed()
					end

					var_3_11:Play()
					table.insert(arg_3_0.setAnimEntityList, iter_3_1.id)
					FightController.instance:dispatchEvent(FightEvent.TimelinePlayEntityAni, iter_3_1.id, true)
				end
			else
				arg_3_0.waitSpineList = arg_3_0.waitSpineList or {}

				table.insert(arg_3_0.waitSpineList, iter_3_1.spine)
				FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_3_0.onSpineLoaded, arg_3_0)
			end
		end
	end

	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, arg_3_0._onUpdateSpeed, arg_3_0)
end

function var_0_0.onSpineLoaded(arg_4_0, arg_4_1)
	if not arg_4_0.waitSpineList then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.waitSpineList) do
		if iter_4_1 == arg_4_1 then
			arg_4_0:_onLoaded()
			table.remove(arg_4_0.waitSpineList, iter_4_0)

			break
		end
	end

	if #arg_4_0.waitSpineList < 1 then
		arg_4_0:clearWaitSpine()
	end
end

function var_0_0._onUpdateSpeed(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._animCompList) do
		local var_5_0 = iter_5_1.this:get(arg_5_0._animStateName[iter_5_0])

		if var_5_0 then
			var_5_0.speed = FightModel.instance:getSpeed()
		end
	end
end

function var_0_0.onDestructor(arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, arg_6_0._onUpdateSpeed, arg_6_0)
	arg_6_0:_clearLoader()
	arg_6_0:_clearAnim()
	arg_6_0:_resetEntitys()
	arg_6_0:clearWaitSpine()
end

function var_0_0._clearAnim(arg_7_0)
	if arg_7_0._animCompList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._animCompList) do
			if not gohelper.isNil(iter_7_1) then
				local var_7_0 = arg_7_0._animStateName[iter_7_0]

				if iter_7_1:GetClip(var_7_0) then
					iter_7_1:RemoveClip(var_7_0)
				end

				if iter_7_1.clip and iter_7_1.clip.name == var_7_0 then
					iter_7_1.clip = nil
				end

				iter_7_1.enabled = false
			end
		end

		tabletool.clear(arg_7_0._animCompList)

		arg_7_0._animCompList = nil
	end
end

function var_0_0._resetEntitys(arg_8_0)
	if arg_8_0._targetEntitys then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._targetEntitys) do
			local var_8_0 = iter_8_1.spine and iter_8_1.spine:getSpineGO()

			ZProj.CharacterSetVariantHelper.Disable(var_8_0)
			FightController.instance:dispatchEvent(FightEvent.TimelinePlayEntityAni, iter_8_1.id, false)

			if arg_8_0._revertSpinePosAndColor then
				transformhelper.setLocalPos(var_8_0.transform, 0, 0, 0)
			end
		end
	end

	arg_8_0._targetEntitys = nil
end

function var_0_0._clearLoader(arg_9_0)
	if arg_9_0._loader then
		arg_9_0._loader:dispose()

		arg_9_0._loader = nil
	end
end

function var_0_0.clearWaitSpine(arg_10_0)
	arg_10_0.waitSpineList = nil

	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_10_0.onSpineLoaded, arg_10_0)
end

return var_0_0
