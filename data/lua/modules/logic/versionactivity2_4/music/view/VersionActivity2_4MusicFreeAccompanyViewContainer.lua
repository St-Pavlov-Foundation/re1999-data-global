﻿module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeAccompanyViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeAccompanyViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity2_4MusicFreeAccompanyView.New())

	return var_1_0
end

return var_0_0
