module("modules.logic.prototest.view.ProtoTestView", package.seeall)

slot0 = class("ProtoTestView", BaseView)

function slot0.onInitView(slot0)
	slot0._testCaseGO = gohelper.findChild(slot0.viewGO, "Panel_testcase")
	slot0._storageGO = gohelper.findChild(slot0.viewGO, "Panel_storage")
	slot0._testCasePosX, _ = recthelper.getAnchorX(slot0._testCaseGO.transform)
	slot0._testCaseRepoBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "Panel_testcase/Panel_oprator/Btn_TestcaseRepo")
	slot0._closeStorageBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "Panel_storage/Panel_oprator/Btn_close")
end

function slot0.addEvents(slot0)
	slot0._testCaseRepoBtn:AddClickListener(slot0._onClickTestCaseRepoBtn, slot0)
	slot0._closeStorageBtn:AddClickListener(slot0._onClickCloseStorageBtn, slot0)
end

function slot0.removeEvents(slot0)
	slot0._testCaseRepoBtn:RemoveClickListener()
	slot0._closeStorageBtn:RemoveClickListener()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._testCaseGO, true)

	slot1 = ProtoTestMgr.instance.isShowFiles

	gohelper.setActive(slot0._testCaseRepoBtn.gameObject, not slot1)
	gohelper.setActive(slot0._storageGO, slot1)
	recthelper.setAnchorX(slot0._testCaseGO.transform, slot1 and slot0._testCasePosX or 0)
end

function slot0._onClickTestCaseRepoBtn(slot0)
	ProtoTestMgr.instance.isShowFiles = true

	ProtoTestFileModel.instance:refreshFileList()
	gohelper.setActive(slot0._testCaseRepoBtn.gameObject, false)
	ZProj.TweenHelper.DOAnchorPosX(slot0._testCaseGO.transform, slot0._testCasePosX, 0.1, function ()
		gohelper.setActive(uv0._storageGO, true)
		ZProj.TweenHelper.DOFadeCanvasGroup(uv0._storageGO, 0, 1, 0.1)
	end)
end

function slot0._onClickCloseStorageBtn(slot0)
	ProtoTestMgr.instance.isShowFiles = false

	ZProj.TweenHelper.DOFadeCanvasGroup(slot0._storageGO, 1, 0, 0.1, function ()
		gohelper.setActive(uv0._storageGO, false)
		gohelper.setActive(uv0._testCaseRepoBtn.gameObject, true)
		ZProj.TweenHelper.DOAnchorPosX(uv0._testCaseGO.transform, 0, 0.1)
	end)
end

return slot0
