﻿module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicChapterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicChapterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity2_4MusicChapterView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_left"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
