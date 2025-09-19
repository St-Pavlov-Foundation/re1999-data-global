module("modules.logic.versionactivity2_8.common.VersionActivity2_8JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_8JumpHandleFunc")

function var_0_0.jumpTo12810(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[2]
	local var_1_1 = arg_1_1[3]

	table.insert(arg_1_0.waitOpenViewNames, ViewName.VersionActivity2_8EnterView)
	table.insert(arg_1_0.closeViewNames, ViewName.NuoDiKaTaskView)
	VersionActivity2_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if ViewMgr.instance:isOpen(ViewName.NuoDiKaLevelView) then
			local var_2_0 = {
				actId = var_1_0,
				episodeId = var_1_1
			}

			NuoDiKaController.instance:enterEpisode(var_2_0)
		else
			local var_2_1 = {
				actId = var_1_0,
				episodeId = var_1_1
			}

			NuoDiKaController.instance:enterLevelView(var_2_1)
		end
	end, nil, var_1_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12811(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1[2]
	local var_3_1 = arg_3_1[3]

	table.insert(arg_3_0.waitOpenViewNames, ViewName.VersionActivity2_8EnterView)
	table.insert(arg_3_0.closeViewNames, ViewName.MoLiDeErTaskView)
	VersionActivity2_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if ViewMgr.instance:isOpen(ViewName.MoLiDeErLevelView) then
			MoLiDeErController.instance:enterEpisode(var_3_0, var_3_1)
		else
			MoLiDeErController.instance:enterLevelView(var_3_0, var_3_1)
		end
	end, nil, var_3_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12806(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1[2]

	VersionActivity2_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_5_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12803(arg_6_0, arg_6_1)
	VersionActivity2_8DungeonController.instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

return var_0_0
