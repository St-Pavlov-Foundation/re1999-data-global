module("modules.logic.gm.controller.asset.AssetItemStatMgr", package.seeall)

slot0 = class("AssetItemStatMgr", BaseController)
slot1 = SLFramework.ResMgr.Instance

function slot0.start(slot0)
end

function slot0.initReflection()
	if uv0.initedRef then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	slot1 = System.Reflection.BindingFlags
	slot6 = tolua.getfield(tolua.findtype("SLFramework.ResMgr"), "assetCache", slot1.GetMask(slot1.Instance, slot1.NonPublic)):Get(uv1):GetEnumerator()

	while slot6:MoveNext() do
		slot7 = slot6.Current.Key

		logError(slot6.Current.Value.ReferenceCount)
	end
end

slot0.instance = slot0.New()

return slot0
