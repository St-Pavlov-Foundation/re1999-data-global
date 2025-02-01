module("modules.logic.prototest.model.ProtoFileHelper", package.seeall)

slot0 = _M
slot0.DirPath = SLFramework.FrameworkSettings.StreamingAssetsPath .. "/prototest/"

function slot0.getFullPathByFileName(slot0)
	return uv0.DirPath .. slot0 .. ".json"
end

return slot0
