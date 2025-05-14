module("framework.luamono.MonoHelper", package.seeall)

return {
	addLuaComOnceToGo = function(arg_1_0, arg_1_1, arg_1_2)
		if gohelper.isNil(arg_1_0) then
			logError("MonoHelper.addLuaComOnceToGo, go can not be nil!")

			return nil
		end

		if not arg_1_1 then
			logError("MonoHelper.addLuaComOnceToGo, clsDefine can not be nil!")

			return nil
		end

		return SLFramework.LuaMonoTools.GetLuaComContainer(arg_1_0, LuaMonoContainer):addCompOnce(arg_1_1, arg_1_2)
	end,
	addNoUpdateLuaComOnceToGo = function(arg_2_0, arg_2_1, arg_2_2)
		if gohelper.isNil(arg_2_0) then
			logError("MonoHelper.addNoUpdateLuaComOnceToGo, go can not be nil!")

			return nil
		end

		if not arg_2_1 then
			logError("MonoHelper.addNoUpdateLuaComOnceToGo, clsDefine can not be nil!")

			return nil
		end

		return SLFramework.LuaMonoTools.GetLuaComContainer(arg_2_0, LuaNoUpdateMonoContainer):addCompOnce(arg_2_1, arg_2_2)
	end,
	getLuaComFromGo = function(arg_3_0, arg_3_1)
		if gohelper.isNil(arg_3_0) or not arg_3_1 then
			logError("MonoHelper.getLuaComFromGo, go and clsDefine can not be nil! ")

			return nil
		end

		local var_3_0 = SLFramework.LuaMonoTools.FindLuaComContainer(arg_3_0)

		if var_3_0 ~= nil then
			return var_3_0:getComp(arg_3_1)
		end

		return nil
	end,
	removeLuaComFromGo = function(arg_4_0, arg_4_1)
		if gohelper.isNil(arg_4_0) or not arg_4_1 then
			logError("MonoHelper.removeLuaComFromGo, go and clsDefine can not be nil! ")

			return nil
		end

		local var_4_0 = SLFramework.LuaMonoTools.FindLuaComContainer(arg_4_0)

		if var_4_0 ~= nil then
			var_4_0:removeCompByDefine(arg_4_1)
		end
	end,
	getLuaContainerInGo = function(arg_5_0)
		if gohelper.isNil(arg_5_0) then
			logError("MonoHelper.getLuaContainerInGo, go can not be nil!")

			return nil
		end

		return SLFramework.LuaMonoTools.FindLuaComContainer(arg_5_0)
	end
}
