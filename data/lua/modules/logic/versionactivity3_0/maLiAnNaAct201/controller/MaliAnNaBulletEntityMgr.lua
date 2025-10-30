module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.MaliAnNaBulletEntityMgr", package.seeall)

local var_0_0 = class("MaliAnNaBulletEntityMgr")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._parent = arg_1_1
	arg_1_0._bulletEffectEntityList = {}
end

local var_0_1 = 0

function var_0_0.getBulletEffectEntity(arg_2_0)
	if arg_2_0._parent == nil then
		return
	end

	local var_2_0 = gohelper.create2d(arg_2_0._parent, "bulletEffect")
	local var_2_1 = MonoHelper.addLuaComOnceToGo(var_2_0, MaLiAnNaBulletEntity)

	var_2_1:setOnlyId(var_0_1 + 1)

	var_0_1 = var_0_1 + 1
	arg_2_0._bulletEffectEntityList[var_2_1:getOnlyId()] = var_2_1

	return var_2_1
end

function var_0_0.update(arg_3_0, arg_3_1)
	if arg_3_0._bulletEffectEntityList == nil then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0._bulletEffectEntityList) do
		iter_3_1:onUpdate(arg_3_1)
	end
end

function var_0_0.releaseBulletEffectEntity(arg_4_0, arg_4_1)
	if arg_4_1 == nil then
		return
	end

	local var_4_0 = arg_4_1:getOnlyId()

	if arg_4_0._bulletEffectEntityList[var_4_0] then
		arg_4_0._bulletEffectEntityList[var_4_0]:onDestroy()

		arg_4_0._bulletEffectEntityList[var_4_0] = nil
	end
end

function var_0_0.clear(arg_5_0)
	if arg_5_0._bulletEffectEntityList ~= nil then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._bulletEffectEntityList) do
			if iter_5_1 then
				iter_5_1:onDestroy()
			end
		end
	end

	tabletool.clear(arg_5_0._bulletEffectEntityList)
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0:clear()

	arg_6_0._bulletEffectEntityList = nil

	if arg_6_0._parent then
		arg_6_0._parent = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
