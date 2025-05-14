module("modules.logic.prototest.model.ProtoFileHelper", package.seeall)

local var_0_0 = _M

var_0_0.DirPath = SLFramework.FrameworkSettings.StreamingAssetsPath .. "/prototest/"

function var_0_0.getFullPathByFileName(arg_1_0)
	return var_0_0.DirPath .. arg_1_0 .. ".json"
end

return var_0_0
