module("modules.logic.versionactivity1_6.goldenmilletpresent.controller.GoldenMilletPresentController", package.seeall)

slot0 = class("GoldenMilletPresentController", BaseController)

function slot0.openGoldenMilletPresentView(slot0)
	if not GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(true) then
		return
	end

	Activity101Rpc.instance:sendGet101InfosRequest(GoldenMilletPresentModel.instance:getGoldenMilletPresentActId(), slot0._realOpenGoldenMilletPresentView, slot0)
end

function slot0._realOpenGoldenMilletPresentView(slot0)
	ViewMgr.instance:openView(ViewName.GoldenMilletPresentView, {
		isDisplayView = not GoldenMilletPresentModel.instance:isShowRedDot()
	})
end

function slot0.receiveGoldenMilletPresent(slot0, slot1, slot2)
	if not GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(true) then
		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGet(GoldenMilletPresentModel.instance:getGoldenMilletPresentActId(), GoldenMilletEnum.REWARD_INDEX) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(slot4, slot5, slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
