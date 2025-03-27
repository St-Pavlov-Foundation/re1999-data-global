module("modules.logic.rouge.controller.RougeDLCController", package.seeall)

slot0 = class("RougeDLCController", BaseController)

function slot0.addDLC(slot0, slot1)
	if not slot0:checkCanUpdateVersion(slot1) then
		GameFacade.showToast(ToastEnum.CantUpdateVersion)

		return
	end

	RougeOutsideRpc.instance:sendRougeDLCSettingSaveRequest(RougeOutsideModel.instance:season(), slot0:_getTargetDLCs(slot1, true))
end

function slot0.removeDLC(slot0, slot1)
	if not slot0:checkCanUpdateVersion(slot1) then
		GameFacade.showToast(ToastEnum.CantUpdateVersion)

		return
	end

	RougeOutsideRpc.instance:sendRougeDLCSettingSaveRequest(RougeOutsideModel.instance:season(), slot0:_getTargetDLCs(slot1, false))
end

function slot0.checkCanUpdateVersion(slot0, slot1)
	if RougeModel.instance:inRouge() then
		return
	end

	if not lua_rouge_season.configDict[slot1] then
		logError(string.format("无法挂移除《%s》DLC,原因:DLC配置不存在", slot1))

		return
	end

	return true
end

function slot0._getTargetDLCs(slot0, slot1, slot2)
	if slot2 then
		table.insert(RougeDLCSelectListModel.instance:getCurSelectVersions(), slot1)
	else
		tabletool.removeValue(slot3, slot1)
	end

	table.sort(slot3)

	return slot3
end

slot0.instance = slot0.New()

return slot0
