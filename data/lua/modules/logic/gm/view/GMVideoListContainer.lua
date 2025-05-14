module("modules.logic.gm.view.GMVideoListContainer", package.seeall)

local var_0_0 = class("GMVideoListContainer", BaseViewContainer)

var_0_0.listModel = ListScrollModel.New()

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "rightviewport"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "rightviewport/item"
	var_1_0.cellClass = GMVideoListItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 2
	var_1_0.cellWidth = 500
	var_1_0.cellHeight = 90
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0

	local var_1_1 = {}

	table.insert(var_1_1, LuaListScrollView.New(var_0_0.listModel, var_1_0))

	return var_1_1
end

function var_0_0.onContainerInit(arg_2_0)
	arg_2_0._btnClose = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "btnClose")

	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	var_0_0.listModel:clear()

	local var_2_0 = {}

	if SLFramework.FrameworkSettings.IsEditor then
		local var_2_1 = SLFramework.FrameworkSettings.AssetRootDir .. "/videos/"
		local var_2_2 = SLFramework.FileHelper.GetDirFilePaths(var_2_1)
		local var_2_3 = var_2_2.Length

		for iter_2_0 = 0, var_2_3 - 1 do
			local var_2_4 = var_2_2[iter_2_0]

			if string.sub(var_2_4, -4) == ".mp4" then
				local var_2_5 = SLFramework.FileHelper.GetFileName(var_2_4, false)

				if not string.find(var_2_4, "Android") then
					table.insert(var_2_0, {
						video = var_2_5
					})
				end
			end
		end
	else
		local var_2_6 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/"
		local var_2_7 = SLFramework.FileHelper.GetDirFilePaths(var_2_6)

		if var_2_7 then
			for iter_2_1 = 0, var_2_7.Length - 1 do
				local var_2_8 = var_2_7[iter_2_1]

				if string.sub(var_2_8, -4) == ".mp4" then
					local var_2_9 = SLFramework.FileHelper.GetFileName(var_2_8, false)

					table.insert(var_2_0, {
						video = var_2_9
					})
				end
			end
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0.video < arg_3_1.video
	end)
	var_0_0.listModel:addList(var_2_0)
end

function var_0_0.onContainerDestroy(arg_4_0)
	arg_4_0._btnClose:RemoveClickListener()
end

function var_0_0.onContainerClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

return var_0_0
