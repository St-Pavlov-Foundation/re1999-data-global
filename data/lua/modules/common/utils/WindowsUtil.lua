module("modules.common.utils.WindowsUtil", package.seeall)

return {
	getSelectFileContent = function(arg_1_0, arg_1_1)
		require("tolua.reflection")
		tolua.loadassembly("UnityEditor")

		local var_1_0 = System.Array.CreateInstance(typeof("System.Type"), 3)

		var_1_0[0] = typeof(System.String)
		var_1_0[1] = typeof(System.String)
		var_1_0[2] = typeof(System.String)

		local var_1_1 = tolua.gettypemethod(typeof("UnityEditor.EditorUtility"), "OpenFilePanel", var_1_0)
		local var_1_2 = SLFramework.FrameworkSettings.PersistentResRootDir

		SLFramework.FileHelper.EnsureDir(var_1_2)

		local var_1_3 = var_1_1:Call(arg_1_0, var_1_2, arg_1_1)
		local var_1_4

		if not string.nilorempty(var_1_3) then
			var_1_4 = SLFramework.FileHelper.ReadText(var_1_3)
		end

		var_1_1:Destroy()

		return var_1_4
	end,
	saveContentToFile = function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		require("tolua.reflection")
		tolua.loadassembly("UnityEditor")

		local var_2_0 = System.Array.CreateInstance(typeof("System.Type"), 4)

		var_2_0[0] = typeof(System.String)
		var_2_0[1] = typeof(System.String)
		var_2_0[2] = typeof(System.String)
		var_2_0[3] = typeof(System.String)

		local var_2_1 = tolua.gettypemethod(typeof("UnityEditor.EditorUtility"), "SaveFilePanel", var_2_0)
		local var_2_2 = SLFramework.FrameworkSettings.PersistentResRootDir

		SLFramework.FileHelper.EnsureDir(var_2_2)

		local var_2_3 = var_2_1:Call(arg_2_0, var_2_2, arg_2_2, arg_2_3)

		if not string.nilorempty(var_2_3) then
			SLFramework.FileHelper.WriteTextToPath(var_2_3, arg_2_1)
		end

		var_2_1:Destroy()
	end
}
