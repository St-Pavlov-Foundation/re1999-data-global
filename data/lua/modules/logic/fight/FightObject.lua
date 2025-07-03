module("modules.logic.fight.FightObject", package.seeall)

local var_0_0 = class("FightObject")

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.onAwake(arg_2_0, ...)
	return
end

function var_0_0.releaseSelf(arg_3_0)
	return
end

function var_0_0.onDestructor(arg_4_0)
	if arg_4_0.COMPONENT_LIST then
		arg_4_0:disposeObjectList(arg_4_0.COMPONENT_LIST)

		arg_4_0.COMPONENT_LIST = nil
	end

	arg_4_0.INSTANTIATE_CLASS_LIST = nil
end

function var_0_0.onDestructorFinish(arg_5_0)
	return
end

function var_0_0.newClass(arg_6_0, arg_6_1, ...)
	if arg_6_0.IS_DISPOSED or arg_6_0.IS_RELEASING then
		logError("生命周期已经结束了,但是又调用注册类的方法,请检查代码,类名:" .. arg_6_0.__cname)
	end

	if not arg_6_0.INSTANTIATE_CLASS_LIST then
		arg_6_0.INSTANTIATE_CLASS_LIST = {}
	end

	local var_6_0 = arg_6_1.New(...)

	var_6_0.PARENT_ROOT_CLASS = arg_6_0

	table.insert(arg_6_0.INSTANTIATE_CLASS_LIST, var_6_0)

	return var_6_0
end

function var_0_0.addComponent(arg_7_0, arg_7_1)
	if arg_7_0.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用了添加组件的方法,请检查代码,类名:" .. arg_7_0.__cname)
	end

	if not arg_7_0.COMPONENT_LIST then
		arg_7_0.COMPONENT_LIST = {}
	end

	local var_7_0 = arg_7_1.New()

	var_7_0.PARENT_ROOT_CLASS = arg_7_0

	table.insert(arg_7_0.COMPONENT_LIST, var_7_0)

	return var_7_0
end

function var_0_0.removeComponent(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	arg_8_1:disposeSelf()
end

function var_0_0.disposeSelf(arg_9_0)
	if arg_9_0.IS_DISPOSED then
		return
	end

	arg_9_0.IS_DISPOSED = true

	local var_9_0 = arg_9_0.keyword_gameObject

	xpcall(arg_9_0.disposeSelfInternal, __G__TRACKBACK__, arg_9_0)

	if var_9_0 then
		gohelper.destroy(var_9_0)
	end
end

function var_0_0.ctor(arg_10_0, ...)
	arg_10_0:initializationInternal(arg_10_0.class, arg_10_0, ...)

	return arg_10_0:onAwake(...)
end

function var_0_0.initializationInternal(arg_11_0, arg_11_1, arg_11_2, ...)
	local var_11_0 = arg_11_1.super

	if var_11_0 then
		arg_11_0:initializationInternal(var_11_0, arg_11_2, ...)
	end

	local var_11_1 = rawget(arg_11_1, "onConstructor")

	if var_11_1 then
		return var_11_1(arg_11_2, ...)
	end
end

function var_0_0.disposeSelfInternal(arg_12_0)
	if not arg_12_0.IS_RELEASING then
		if arg_12_0.PARENT_ROOT_CLASS then
			arg_12_0.PARENT_ROOT_CLASS:clearDeadInstantiatedClass()
		end

		arg_12_0:markReleasing()
		arg_12_0:releaseChildRoot()
	end

	arg_12_0:releaseSelf()
	arg_12_0:destructorInternal(arg_12_0.class, arg_12_0)

	return arg_12_0:onDestructorFinish()
end

function var_0_0.clearDeadInstantiatedClass(arg_13_0)
	if arg_13_0.IS_DISPOSED then
		return
	end

	if arg_13_0.CLEARTIMER then
		return
	end

	arg_13_0.CLEARTIMER = arg_13_0:com_registRepeatTimer(arg_13_0.internalClearDeadInstantiatedClass, 1, 1)
end

function var_0_0.internalClearDeadInstantiatedClass(arg_14_0)
	if arg_14_0.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用了清除已经死亡的类的方法,请检查代码,类名:" .. arg_14_0.__cname)
	end

	arg_14_0.CLEARTIMER = nil

	local var_14_0 = arg_14_0.INSTANTIATE_CLASS_LIST

	if var_14_0 then
		for iter_14_0 = #var_14_0, 1, -1 do
			if var_14_0[iter_14_0].IS_DISPOSED then
				table.remove(var_14_0, iter_14_0)
			end
		end
	end
end

function var_0_0.markReleasing(arg_15_0)
	local var_15_0 = arg_15_0

	while var_15_0 do
		local var_15_1 = var_15_0.INSTANTIATE_CLASS_LIST

		if not var_15_0.IS_RELEASING then
			var_15_0.IS_RELEASING = 0
		end

		local var_15_2 = var_15_0.IS_RELEASING + 1
		local var_15_3 = var_15_1 and var_15_1[var_15_2]

		if not var_15_3 then
			if var_15_0 == arg_15_0 then
				return
			end

			var_15_0 = var_15_0.PARENT_ROOT_CLASS
		else
			var_15_0.IS_RELEASING = var_15_2

			if not var_15_3.IS_RELEASING then
				var_15_0 = var_15_3
			end
		end
	end
end

function var_0_0.releaseChildRoot(arg_16_0)
	local var_16_0 = arg_16_0

	while var_16_0 do
		local var_16_1 = var_16_0.INSTANTIATE_CLASS_LIST

		if not var_16_0.DISPOSEINDEX then
			var_16_0.DISPOSEINDEX = var_16_1 and #var_16_1 + 1 or 1
		end

		local var_16_2 = var_16_0.DISPOSEINDEX - 1
		local var_16_3 = var_16_1 and var_16_1[var_16_2]

		if not var_16_3 then
			if var_16_0 == arg_16_0 then
				return
			end

			if not var_16_0.IS_DISPOSED then
				var_16_0:disposeSelf()
			end

			var_16_0 = var_16_0.PARENT_ROOT_CLASS
		else
			var_16_0.DISPOSEINDEX = var_16_2

			if not var_16_3.DISPOSEINDEX then
				var_16_0 = var_16_3
			end
		end
	end
end

function var_0_0.destructorInternal(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = rawget(arg_17_1, "onDestructor")

	if var_17_0 then
		var_17_0(arg_17_2)
	end

	local var_17_1 = arg_17_1.super

	if var_17_1 then
		return arg_17_0:destructorInternal(var_17_1, arg_17_2)
	end
end

function var_0_0.disposeObjectList(arg_18_0, arg_18_1)
	for iter_18_0 = #arg_18_1, 1, -1 do
		local var_18_0 = arg_18_1[iter_18_0]

		if not var_18_0.IS_DISPOSED then
			var_18_0:disposeSelf()
		end
	end
end

return var_0_0
