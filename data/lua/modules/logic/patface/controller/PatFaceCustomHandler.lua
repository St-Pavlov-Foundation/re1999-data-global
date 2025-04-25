module("modules.logic.patface.controller.PatFaceCustomHandler", package.seeall)

return {
	activity142CheckCanPat = function (slot0)
		slot1 = false

		if Activity136Model.instance:isActivity136InOpen() then
			slot1 = not Activity136Model.instance:hasReceivedCharacter()
		end

		return slot1
	end,
	decalogPresentCheckCanPat = function (slot0)
		return DecalogPresentModel.instance:isShowRedDot()
	end,
	goldenMilletPresentCheckCanPat = function (slot0)
		return GoldenMilletPresentModel.instance:isShowRedDot()
	end,
	matildaGiftCheckCanPat = function (slot0)
		return V1a9_MatildaGiftModel.instance:isShowRedDot()
	end,
	semmelWeisGiftCheckCanPat = function (slot0)
		return SemmelWeisGiftModel.instance:isShowRedDot()
	end,
	bPSPViewCanPat = function (slot0)
		if BpModel.instance:isEnd() then
			return false
		end

		if not BpConfig.instance:getBpCO(BpModel.instance.id) or not slot1.isSp then
			return false
		end

		if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.BPSP, true) ~= ActivityEnum.ActivityStatus.Normal then
			return false
		end

		return BpModel.instance.firstShowSp
	end,
	bPViewCanPat = function (slot0)
		if BpModel.instance:isEnd() then
			return false
		end

		return BpModel.instance.firstShow and tonumber(PlayerPrefsHelper.getString(string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, "BPFace", PlayerModel.instance:getPlayinfo().userId), "")) ~= BpModel.instance.id
	end,
	limitDecorateCanPat = function (slot0)
		if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.LimitDecorate, true) == ActivityEnum.ActivityStatus.Normal then
			return uv0.checkIsFistShow(slot0)
		end
	end,
	decalogPresentPat = function (slot0)
		DecalogPresentController.instance:openDecalogPresentView(PatFaceConfig.instance:getPatFaceViewName(slot0))
	end,
	goldenMilletPresentPat = function (slot0)
		GoldenMilletPresentController.instance:openGoldenMilletPresentView()
	end,
	matildaGiftPat = function (slot0)
		V1a9_MatildaGiftController.instance:openMatildaGiftView()
	end,
	semmelWeisGiftPat = function (slot0)
		SemmelWeisGiftController.instance:openSemmelWeisGiftView()
	end,
	checkIsFistShow = function (slot0)
		return string.nilorempty(PlayerPrefsHelper.getString(string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, slot0, PlayerModel.instance:getPlayinfo().userId), ""))
	end,
	setHasShow = function (slot0)
		PlayerPrefsHelper.setString(string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, slot0, PlayerModel.instance:getPlayinfo().userId), "hasEnter")
	end
}
