module("modules.logic.prototest.view.ProtoTestView", package.seeall)

local var_0_0 = class("ProtoTestView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._testCaseGO = gohelper.findChild(arg_1_0.viewGO, "Panel_testcase")
	arg_1_0._storageGO = gohelper.findChild(arg_1_0.viewGO, "Panel_storage")
	arg_1_0._testCasePosX, _ = recthelper.getAnchorX(arg_1_0._testCaseGO.transform)
	arg_1_0._testCaseRepoBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel_testcase/Panel_oprator/Btn_TestcaseRepo")
	arg_1_0._closeStorageBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel_storage/Panel_oprator/Btn_close")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._testCaseRepoBtn:AddClickListener(arg_2_0._onClickTestCaseRepoBtn, arg_2_0)
	arg_2_0._closeStorageBtn:AddClickListener(arg_2_0._onClickCloseStorageBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._testCaseRepoBtn:RemoveClickListener()
	arg_3_0._closeStorageBtn:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._testCaseGO, true)

	local var_4_0 = ProtoTestMgr.instance.isShowFiles

	gohelper.setActive(arg_4_0._testCaseRepoBtn.gameObject, not var_4_0)
	gohelper.setActive(arg_4_0._storageGO, var_4_0)
	recthelper.setAnchorX(arg_4_0._testCaseGO.transform, var_4_0 and arg_4_0._testCasePosX or 0)
end

function var_0_0._onClickTestCaseRepoBtn(arg_5_0)
	ProtoTestMgr.instance.isShowFiles = true

	ProtoTestFileModel.instance:refreshFileList()
	gohelper.setActive(arg_5_0._testCaseRepoBtn.gameObject, false)
	ZProj.TweenHelper.DOAnchorPosX(arg_5_0._testCaseGO.transform, arg_5_0._testCasePosX, 0.1, function()
		gohelper.setActive(arg_5_0._storageGO, true)
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_5_0._storageGO, 0, 1, 0.1)
	end)
end

function var_0_0._onClickCloseStorageBtn(arg_7_0)
	ProtoTestMgr.instance.isShowFiles = false

	ZProj.TweenHelper.DOFadeCanvasGroup(arg_7_0._storageGO, 1, 0, 0.1, function()
		gohelper.setActive(arg_7_0._storageGO, false)
		gohelper.setActive(arg_7_0._testCaseRepoBtn.gameObject, true)
		ZProj.TweenHelper.DOAnchorPosX(arg_7_0._testCaseGO.transform, 0, 0.1)
	end)
end

return var_0_0
