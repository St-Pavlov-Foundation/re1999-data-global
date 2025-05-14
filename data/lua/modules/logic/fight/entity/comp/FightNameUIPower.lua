module("modules.logic.fight.entity.comp.FightNameUIPower", package.seeall)

local var_0_0 = class("FightNameUIPower", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._parentView = arg_1_1
	arg_1_0._entity = arg_1_0._parentView.entity
	arg_1_0._powerId = arg_1_2
	arg_1_0._objList = arg_1_0:getUserDataTb_()
	arg_1_0._cloneComp = UICloneComponent.New()
	arg_1_0._point_ani_sequence = {}
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._energyRoot = gohelper.findChild(arg_2_0._parentView:getUIGO(), "layout/energy")
	arg_2_0._eneryItem = gohelper.findChild(arg_2_0._parentView:getUIGO(), "layout/energy/energyitem")

	arg_2_0:_correctObjCount()
	arg_2_0:_refreshUI()
	arg_2_0:addEventCb(FightController.instance, FightEvent.PowerMaxChange, arg_2_0._onPowerMaxChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.PowerChange, arg_2_0._onPowerChange, arg_2_0)
end

function var_0_0._getPowerData(arg_3_0)
	local var_3_0 = arg_3_0._entity:getMO()

	if var_3_0 then
		return (var_3_0:getPowerInfo(arg_3_0._powerId))
	end
end

function var_0_0._refreshUI(arg_4_0)
	local var_4_0 = arg_4_0:_getPowerData()

	if var_4_0 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._objList) do
			local var_4_1 = gohelper.findChild(iter_4_1, "light")

			gohelper.setActive(var_4_1, iter_4_0 <= var_4_0.num)
		end
	end
end

function var_0_0._onPowerMaxChange(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._entity.id == arg_5_1 and arg_5_0._powerId == arg_5_2 then
		arg_5_0:_correctObjCount()
		arg_5_0:_refreshUI()
	end
end

function var_0_0._onPowerChange(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0._entity.id == arg_6_1 and arg_6_0._powerId == arg_6_2 and arg_6_3 ~= arg_6_4 then
		table.insert(arg_6_0._point_ani_sequence, {
			arg_6_3,
			arg_6_4
		})

		if arg_6_0._pointPlayType == 1 and arg_6_3 < arg_6_4 then
			arg_6_0._change_ani_playing = nil
		elseif arg_6_0._pointPlayType == 2 and arg_6_4 < arg_6_3 then
			arg_6_0._change_ani_playing = nil
		end

		if not arg_6_0._change_ani_playing then
			arg_6_0:_playPointChangeAni()
		end
	end
end

local var_0_1 = "open"
local var_0_2 = "close"

function var_0_0._playPointChangeAni(arg_7_0)
	local var_7_0 = table.remove(arg_7_0._point_ani_sequence, 1)

	if var_7_0 then
		local var_7_1 = var_7_0[1]
		local var_7_2 = var_7_0[2]

		if arg_7_0._entity and arg_7_0._entity.id then
			if var_7_1 < var_7_2 then
				arg_7_0._pointPlayType = 1

				arg_7_0:_playAni(var_0_1, var_7_1, var_7_2)
			elseif var_7_2 < var_7_1 then
				arg_7_0._pointPlayType = 2

				arg_7_0:_playAni(var_0_2, var_7_1, var_7_2)
			end
		end
	else
		arg_7_0._change_ani_playing = false
		arg_7_0._pointPlayType = nil

		if arg_7_0._entity and arg_7_0._entity:getMO() then
			arg_7_0:_refreshUI()
		end
	end
end

local var_0_3 = {
	open = "energyitem_open",
	close = "energyitem_close"
}

function var_0_0._playAni(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0
	local var_8_1 = math.min(arg_8_2, arg_8_3)
	local var_8_2 = math.max(arg_8_2, arg_8_3)

	for iter_8_0 = var_8_1 + 1, var_8_2 do
		local var_8_3 = arg_8_0._objList[iter_8_0]

		if var_8_3 then
			local var_8_4 = gohelper.findChild(var_8_3, "light")

			gohelper.setActive(var_8_4, true)

			local var_8_5 = gohelper.onceAddComponent(var_8_3, typeof(UnityEngine.Animator))

			var_8_5:Play(arg_8_1, 0, 0)

			var_8_5.speed = FightModel.instance:getSpeed()
			arg_8_0._change_ani_playing = true
			var_8_0 = var_8_5
		end
	end

	local var_8_6 = GameUtil.getMotionDuration(var_8_0, var_0_3[arg_8_1])

	TaskDispatcher.runDelay(arg_8_0._playPointChangeAni, arg_8_0, var_8_6)
end

function var_0_0._correctObjCount(arg_9_0)
	local var_9_0 = arg_9_0:_getPowerData()

	if var_9_0 then
		gohelper.setActive(arg_9_0._energyRoot, true)
		arg_9_0._cloneComp:createObjList(arg_9_0, arg_9_0._onItemShow, var_9_0.max or 0, arg_9_0._energyRoot, arg_9_0._eneryItem)
	else
		gohelper.setActive(arg_9_0._energyRoot, false)
	end
end

function var_0_0._onItemShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	gohelper.onceAddComponent(arg_10_1, typeof(UnityEngine.Animator)):Play("idle", 0, 0)

	arg_10_0._objList[arg_10_3] = arg_10_0._objList[arg_10_3] or arg_10_1
end

function var_0_0.releaseSelf(arg_11_0)
	arg_11_0._cloneComp:releaseSelf()
	arg_11_0:__onDispose()
end

return var_0_0
