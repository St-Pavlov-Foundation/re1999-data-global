module("modules.logic.rouge.define.RougeBaseDLCViewComp", package.seeall)

slot0 = class("RougeBaseDLCViewComp", BaseViewExtended)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._isImmediate = slot1
end

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	if slot0._isImmediate then
		slot0:addEventCb(RougeDLCController.instance, RougeEvent.UpdateRougeVersion, slot0._updateVersion, slot0)
	end
end

function slot0._updateVersion(slot0)
	slot0:killAllChildView()

	for slot6, slot7 in pairs(slot0:getVersions() or {}) do
		if _G[string.format("%s_%s_%s", slot0.viewName, slot0:getSeason(), slot7)] then
			slot10 = nil

			if slot9.ParentObjPath then
				slot10 = gohelper.findChild(slot0.viewGO, slot9.ParentObjPath)
			end

			slot0:openSubView(slot9, slot9.AssetUrl, slot10, slot0.viewParam)
		end
	end
end

function slot0.onOpen(slot0)
	slot0:_updateVersion()
end

function slot0.getSeason(slot0)
	return RougeOutsideModel.instance:season()
end

function slot0.getVersions(slot0)
	return RougeOutsideModel.instance:getRougeGameRecord() and slot1:getVersionIds()
end

return slot0
