module("modules.logic.guide.view.GuideView", package.seeall)

slot0 = class("GuideView", BaseView)

function slot0.onInitView(slot0)
	if GMController.instance:getGMNode("guideview", slot0.viewGO) then
		slot0._btnJump = gohelper.findChildButtonWithAudio(slot1, "btnJump")
	end
end

function slot0.isOpenGM(slot0)
	return isDebugBuild and PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1) == 1
end

function slot0.onOpen(slot0)
	if slot0._btnJump then
		gohelper.setActive(slot0._btnJump.gameObject, slot0:isOpenGM())
	end
end

function slot0.addEvents(slot0)
	if slot0._btnJump then
		slot0._btnJump:AddClickListener(slot0._onClickBtnJump, slot0)
	end
end

function slot0.removeEvents(slot0)
	if slot0._btnJump then
		slot0._btnJump:RemoveClickListener()
	end
end

function slot0._onClickBtnJump(slot0)
	GuideModel.instance:onClickJumpGuides()

	slot2 = GuideModel.instance:getDoingGuideId() and GuideModel.instance:getById(slot1)

	logWarn(string.format("点击了指引跳过按钮！！！！！当前指引：%d_%d", slot1 or -1, slot2 and slot2.currStepId or -1))

	if slot1 == GuideController.FirstGuideId then
		DungeonFightController.instance:sendEndFightRequest(true)
	end

	GuideController.instance:oneKeyFinishGuides()
	GuideStepController.instance:clearStep()
end

return slot0
