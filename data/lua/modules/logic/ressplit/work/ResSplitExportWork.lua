module("modules.logic.ressplit.work.ResSplitExportWork", package.seeall)

local var_0_0 = class("ResSplitExportWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0.result = {}

	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "atlassrc/ui_modules/explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "ui/viewres/explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "singlebg/explore/", true)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, "atlassrc/ui_spriteset/explore/", true)
	arg_1_0:_filter(ResSplitEnum.Path)
	arg_1_0:_filter(ResSplitEnum.Folder)
	arg_1_0:_filter(ResSplitEnum.SinglebgFolder)
	arg_1_0:_filter(ResSplitEnum.AudioBank)
	arg_1_0:_filter(ResSplitEnum.CommonAudioBank)
	arg_1_0:_filter(ResSplitEnum.Video)
	arg_1_0:_filter(ResSplitEnum.AudioWem)
	arg_1_0:_filter(ResSplitEnum.InnerAudioWem)
	arg_1_0:_filter(ResSplitEnum.InnerRoomAB)
	arg_1_0:_filter(ResSplitEnum.OutRoomAB)
	arg_1_0:_filter(ResSplitEnum.OutSceneAB)
	arg_1_0:_filter(ResSplitEnum.InnerSceneAB)

	local var_1_0 = cjson.encode(arg_1_0.result)
	local var_1_1 = string.gsub(var_1_0, "\\/", "/")
	local var_1_2 = io.open(ResSplitEnum.ExportConfigPath, "w")

	var_1_2:write(tostring(var_1_1))
	var_1_2:close()
	arg_1_0:onDone(true)
	logNormal("ResSplit Done!")
end

function var_0_0._filter(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = ResSplitModel.instance:getExcludeDic(arg_2_1)

	if var_2_1 then
		for iter_2_0, iter_2_1 in pairs(var_2_1) do
			if iter_2_1 == true then
				local var_2_2 = SLFramework.FileHelper.GetFileName(iter_2_0, true)
				local var_2_3 = string.find(var_2_2, "%.")

				if iter_2_0 == "" or not var_2_3 or var_2_3 > 1 then
					var_2_0[iter_2_0] = true
				end
			end
		end

		arg_2_0.result[arg_2_1] = var_2_0
	end

	logNormal(arg_2_1, tabletool.len(var_2_0))
end

return var_0_0
