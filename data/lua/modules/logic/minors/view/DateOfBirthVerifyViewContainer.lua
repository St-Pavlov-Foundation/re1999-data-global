-- chunkname: @modules/logic/minors/view/DateOfBirthVerifyViewContainer.lua

module("modules.logic.minors.view.DateOfBirthVerifyViewContainer", package.seeall)

local DateOfBirthVerifyViewContainer = class("DateOfBirthVerifyViewContainer", BaseViewContainer)

function DateOfBirthVerifyViewContainer:buildViews()
	local views = {
		(DateOfBirthVerifyView.New())
	}

	return views
end

return DateOfBirthVerifyViewContainer
