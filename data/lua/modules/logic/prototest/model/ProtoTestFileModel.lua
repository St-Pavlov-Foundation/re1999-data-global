module("modules.logic.prototest.model.ProtoTestFileModel", package.seeall)

local var_0_0 = class("ProtoTestFileModel", ListScrollModel)

function var_0_0.refreshFileList(arg_1_0)
	SLFramework.FileHelper.EnsureDir(ProtoFileHelper.DirPath)

	local var_1_0 = SLFramework.FileHelper.GetDirFilePaths(ProtoFileHelper.DirPath)
	local var_1_1 = arg_1_0:getList()

	for iter_1_0 = 1, var_1_0.Length do
		local var_1_2 = var_1_0[iter_1_0 - 1]
		local var_1_3 = SLFramework.FileHelper.GetFileName(var_1_2, false)
		local var_1_4 = var_1_1[iter_1_0]

		if not var_1_4 then
			var_1_4 = ProtoTestFileMO.New()

			table.insert(var_1_1, var_1_4)
		end

		var_1_4.id = iter_1_0
		var_1_4.filePath = var_1_2
		var_1_4.fileName = var_1_3
	end

	arg_1_0:setList(var_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
