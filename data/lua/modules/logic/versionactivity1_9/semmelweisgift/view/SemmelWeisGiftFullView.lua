module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftFullView", package.seeall)

slot0 = class("SemmelWeisGiftFullView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "Root/image_TimeBG/#txt_remainTime")
	slot0._btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Claim")
	slot0._goNormal = gohelper.findChild(slot0.viewGO, "Root/#btn_Claim/#go_Normal")
	slot0._goReceived = gohelper.findChild(slot0.viewGO, "Root/#btn_Claim/#go_Received")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClaim:AddClickListener(slot0._btnClaimOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClaim:RemoveClickListener()
end

function slot0._btnClaimOnClick(slot0)
	SemmelWeisGiftController.instance:receiveSemmelWeisGift(slot0.refreshCanGet, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:refresh()
end

function slot0.refresh(slot0)
	slot0:refreshCanGet()
	slot0:refreshRemainTime()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.refreshCanGet(slot0)
	slot1 = SemmelWeisGiftModel.instance:isShowRedDot()

	gohelper.setActive(slot0._goNormal, slot1)
	gohelper.setActive(slot0._goReceived, not slot1)
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremainTime.text = string.format(luaLang("remain"), ActivityModel.instance:getActMO(SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()):getRemainTimeStr3(false, true))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

return slot0
