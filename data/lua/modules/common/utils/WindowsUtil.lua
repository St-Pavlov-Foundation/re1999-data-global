module("modules.common.utils.WindowsUtil", package.seeall)

return {
	getSelectFileContent = function (slot0, slot1)
		require("tolua.reflection")
		tolua.loadassembly("UnityEditor")

		slot2 = System.Array.CreateInstance(typeof("System.Type"), 3)
		slot2[0] = typeof(System.String)
		slot2[1] = typeof(System.String)
		slot2[2] = typeof(System.String)
		slot4 = SLFramework.FrameworkSettings.PersistentResRootDir

		SLFramework.FileHelper.EnsureDir(slot4)

		slot6 = nil

		if not string.nilorempty(tolua.gettypemethod(typeof("UnityEditor.EditorUtility"), "OpenFilePanel", slot2):Call(slot0, slot4, slot1)) then
			slot6 = SLFramework.FileHelper.ReadText(slot5)
		end

		slot3:Destroy()

		return slot6
	end,
	saveContentToFile = function (slot0, slot1, slot2, slot3)
		require("tolua.reflection")
		tolua.loadassembly("UnityEditor")

		slot4 = System.Array.CreateInstance(typeof("System.Type"), 4)
		slot4[0] = typeof(System.String)
		slot4[1] = typeof(System.String)
		slot4[2] = typeof(System.String)
		slot4[3] = typeof(System.String)
		slot6 = SLFramework.FrameworkSettings.PersistentResRootDir

		SLFramework.FileHelper.EnsureDir(slot6)

		if not string.nilorempty(tolua.gettypemethod(typeof("UnityEditor.EditorUtility"), "SaveFilePanel", slot4):Call(slot0, slot6, slot2, slot3)) then
			SLFramework.FileHelper.WriteTextToPath(slot7, slot1)
		end

		slot5:Destroy()
	end
}
