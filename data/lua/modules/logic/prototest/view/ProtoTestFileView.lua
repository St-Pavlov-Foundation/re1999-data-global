module("modules.logic.prototest.view.ProtoTestFileView", package.seeall)

slot0 = class("ProtoTestFileView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnSave = gohelper.findChildButtonWithAudio(slot0.viewGO, "Panel_storage/Panel_newFile/Btn_save")
	slot0._btnRefresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "Panel_storage/Panel_oprator/Btn_refresh")
	slot0._btnOpenFolder = gohelper.findChildButtonWithAudio(slot0.viewGO, "Panel_storage/Panel_oprator/Btn_openFolder")
	slot0._inputFileName = gohelper.findChildTextMeshInputField(slot0.viewGO, "Panel_storage/Panel_newFile/Field_newcaseroot")
end

function slot0.addEvents(slot0)
	slot0._btnSave:AddClickListener(slot0._onClickBtnSave, slot0)
	slot0._btnRefresh:AddClickListener(slot0._onClickBtnRefresh, slot0)
	slot0._btnOpenFolder:AddClickListener(slot0._onClickBtnOpenFolder, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnSave:RemoveClickListener()
	slot0._btnRefresh:RemoveClickListener()
	slot0._btnOpenFolder:RemoveClickListener()
end

function slot0.onOpen(slot0)
end

function slot0._onClickBtnSave(slot0)
	slot1 = slot0._inputFileName:GetText()

	if ProtoTestMgr.instance:isRecording() then
		GameFacade.showToast(ToastEnum.ProtoModifyNotString)
	elseif string.nilorempty(slot1) then
		GameFacade.showToast(ToastEnum.ProtoModifyIsEmpty)
	elseif SLFramework.FileHelper.IsFileExists(ProtoFileHelper.getFullPathByFileName(slot1)) then
		GameFacade.showToast(ToastEnum.ProtoModifyIsFileExists)
	else
		ProtoTestMgr.instance:saveToFile(slot1, ProtoTestCaseModel.instance:getList())
		ProtoTestFileModel.instance:refreshFileList()
	end
end

function slot0._onClickBtnRefresh(slot0)
	ProtoTestFileModel.instance:refreshFileList()
end

function slot0._onClickBtnOpenFolder(slot0)
	ZProj.OpenSelectFileWindow.OpenExplorer(ProtoFileHelper.DirPath)
end

return slot0
