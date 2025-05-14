module("modules.logic.room.entity.comp.RoomBuildingSummonComp", package.seeall)

local var_0_0 = class("RoomBuildingSummonComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummonAnim, arg_3_0._onStartSummonAnim, arg_3_0)
	arg_3_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onDragEnd, arg_3_0._onDragEnd, arg_3_0)
	arg_3_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, arg_3_0._onSummonSkip, arg_3_0)
	arg_3_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, arg_3_0._onCloseGetCritter, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummonAnim, arg_4_0._onStartSummonAnim, arg_4_0)
	arg_4_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onDragEnd, arg_4_0._onDragEnd, arg_4_0)
	arg_4_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, arg_4_0._onSummonSkip, arg_4_0)
	arg_4_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, arg_4_0._onCloseGetCritter, arg_4_0)
end

function var_0_0.onStart(arg_5_0)
	return
end

function var_0_0.getMO(arg_6_0)
	return arg_6_0.entity:getMO()
end

function var_0_0.getBuildingGOAnimatorPlayer(arg_7_0)
	if not arg_7_0._buildingGOAnimatorPlayer then
		arg_7_0._buildingGOAnimatorPlayer = SLFramework.AnimatorPlayer.Get(arg_7_0.entity:getBuildingGO())
	end

	return arg_7_0._buildingGOAnimatorPlayer
end

function var_0_0.getBuildingGOAnimator(arg_8_0)
	if not arg_8_0._buildingGOAnimator then
		arg_8_0._buildingGOAnimator = arg_8_0.entity:getBuildingGO():GetComponent(typeof(UnityEngine.Animator))
	end

	return arg_8_0._buildingGOAnimator
end

function var_0_0._onStartSummonAnim(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.mode

	arg_9_0.mode = var_9_0

	local var_9_1 = arg_9_0:getBuildingGOAnimatorPlayer()
	local var_9_2 = RoomSummonEnum.SummonMode[var_9_0].EntityAnimKey

	local function var_9_3()
		CritterSummonController.instance:onCanDrag()
	end

	if var_9_2 and var_9_1 then
		if var_9_0 == RoomSummonEnum.SummonType.Incubate then
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan2)
		end

		var_9_1:Play(var_9_2.operatePre, var_9_3, arg_9_0)
	else
		var_9_3()
	end
end

function var_0_0._onDragEnd(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getBuildingGOAnimatorPlayer()
	local var_11_1 = RoomSummonEnum.SummonMode[arg_11_1].EntityAnimKey

	local function var_11_2()
		CritterSummonController.instance:onFinishSummonAnim(arg_11_1)
	end

	if var_11_1 and var_11_0 then
		local function var_11_3()
			if var_11_0 then
				var_11_0:Play(var_11_1.rare[arg_11_2], var_11_2, arg_11_0)
			else
				var_11_2()
			end
		end

		var_11_0:Play(var_11_1.operateEnd, var_11_3, arg_11_0)
	else
		var_11_2()
	end
end

function var_0_0._onSummonSkip(arg_14_0)
	local var_14_0 = arg_14_0:getBuildingGOAnimator()
	local var_14_1 = RoomSummonEnum.SummonMode[arg_14_0.mode].EntityAnimKey

	var_14_0:Play(var_14_1.operateEnd, 0, 1)
end

function var_0_0._onCloseGetCritter(arg_15_0)
	if RoomSummonEnum.SummonType then
		for iter_15_0, iter_15_1 in pairs(RoomSummonEnum.SummonType) do
			if RoomSummonEnum.SummonMode[iter_15_1] then
				arg_15_0:_activeEggRoot(iter_15_1, false)
			end
		end
	end
end

function var_0_0._activeEggRoot(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:_getEggRoot(arg_16_1)

	if var_16_0 then
		gohelper.setActive(var_16_0, arg_16_2)
	end
end

function var_0_0._getEggRoot(arg_17_0, arg_17_1)
	local var_17_0 = RoomSummonEnum.SummonMode[arg_17_1].EggRoot

	if not arg_17_0._eggRoot then
		arg_17_0._eggRoot = arg_17_0:getUserDataTb_()
	end

	if var_17_0 then
		local var_17_1 = arg_17_0.entity:getBuildingGO()

		arg_17_0._eggRoot[arg_17_1] = gohelper.findChild(var_17_1, var_17_0)

		return arg_17_0._eggRoot[arg_17_1]
	end
end

return var_0_0
