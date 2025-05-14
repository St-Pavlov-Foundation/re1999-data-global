module("modules.logic.versionactivity1_2.jiexika.view.Activity114FullPhotoViewContainer", package.seeall)

local var_0_0 = class("Activity114FullPhotoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Activity114FullPhotoView.New(arg_1_0.viewParam)
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
