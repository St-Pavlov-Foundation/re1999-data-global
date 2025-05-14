module("modules.logic.room.view.critter.summon.RoomCritterUISpine", package.seeall)

local var_0_0 = class("RoomCritterUISpine", LuaCompBase)

function var_0_0.Create(arg_1_0)
	local var_1_0

	return (MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0))
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
end

function var_0_0._getSpine(arg_3_0)
	if not arg_3_0._spine then
		arg_3_0._spine = GuiSpine.Create(arg_3_0._go)
	end

	return arg_3_0._spine
end

function var_0_0.resetTransform(arg_4_0)
	if not arg_4_0._spine then
		return
	end

	local var_4_0 = arg_4_0._spine._spineGo

	if gohelper.isNil(var_4_0) then
		return
	end

	recthelper.setAnchor(var_4_0.transform, 0, 0)
	transformhelper.setLocalScale(var_4_0.transform, 1, 1, 1)
end

function var_0_0.setResPath(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_1:getSkinId()
	local var_5_1 = RoomResHelper.getCritterUIPath(var_5_0)

	arg_5_0._curModel = arg_5_0:_getSpine()

	arg_5_0._curModel:setHeroId(arg_5_1.id)
	arg_5_0._curModel:showModel()
	arg_5_0._curModel:setResPath(var_5_1, function()
		arg_5_0:resetTransform()

		if arg_5_2 then
			arg_5_2(arg_5_3)
		end
	end, arg_5_0, true)
end

function var_0_0.stopVoice(arg_7_0)
	if arg_7_0._spine then
		arg_7_0._spine:stopVoice()
	end
end

function var_0_0.onDestroyView(arg_8_0)
	if arg_8_0._spine then
		arg_8_0._spine:stopVoice()

		arg_8_0._spine = nil
	end
end

return var_0_0
