module("modules.logic.prototest.view.ProtoTestFileView", package.seeall)

local var_0_0 = class("ProtoTestFileView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnSave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel_storage/Panel_newFile/Btn_save")
	arg_1_0._btnRefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel_storage/Panel_oprator/Btn_refresh")
	arg_1_0._btnOpenFolder = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel_storage/Panel_oprator/Btn_openFolder")
	arg_1_0._inputFileName = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "Panel_storage/Panel_newFile/Field_newcaseroot")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSave:AddClickListener(arg_2_0._onClickBtnSave, arg_2_0)
	arg_2_0._btnRefresh:AddClickListener(arg_2_0._onClickBtnRefresh, arg_2_0)
	arg_2_0._btnOpenFolder:AddClickListener(arg_2_0._onClickBtnOpenFolder, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnSave:RemoveClickListener()
	arg_3_0._btnRefresh:RemoveClickListener()
	arg_3_0._btnOpenFolder:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	return
end

function var_0_0._onClickBtnSave(arg_5_0)
	local var_5_0 = arg_5_0._inputFileName:GetText()

	if ProtoTestMgr.instance:isRecording() then
		GameFacade.showToast(ToastEnum.ProtoModifyNotString)
	elseif string.nilorempty(var_5_0) then
		GameFacade.showToast(ToastEnum.ProtoModifyIsEmpty)
	elseif SLFramework.FileHelper.IsFileExists(ProtoFileHelper.getFullPathByFileName(var_5_0)) then
		GameFacade.showToast(ToastEnum.ProtoModifyIsFileExists)
	else
		local var_5_1 = ProtoTestCaseModel.instance:getList()

		ProtoTestMgr.instance:saveToFile(var_5_0, var_5_1)
		ProtoTestFileModel.instance:refreshFileList()
	end
end

function var_0_0._onClickBtnRefresh(arg_6_0)
	ProtoTestFileModel.instance:refreshFileList()
end

function var_0_0._onClickBtnOpenFolder(arg_7_0)
	ZProj.OpenSelectFileWindow.OpenExplorer(ProtoFileHelper.DirPath)
end

return var_0_0
