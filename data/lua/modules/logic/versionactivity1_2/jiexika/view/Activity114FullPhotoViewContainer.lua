module("modules.logic.versionactivity1_2.jiexika.view.Activity114FullPhotoViewContainer", package.seeall)

slot0 = class("Activity114FullPhotoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Activity114FullPhotoView.New(slot0.viewParam)
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
